* <--- S4 Migration - 20/09/2023 - WS

*        SELECT bukrs belnr gjahr buzei bschl koart gsber mwskz dmbtr
*             wrbtr saknr hkont lifnr werks ebeln ebelp bupla ktosl fwbas
*             sgtxt shkzg projk
*            APPENDING TABLE t_bseg
*            FROM bseg
*            FOR ALL ENTRIES IN t_bkpf
*           WHERE bukrs  = t_bkpf-bukrs
*             AND belnr  = t_bkpf-belnr
*             AND gjahr  = t_bkpf-gjahr
*             AND gsber IN s_gsber
*             AND mwskz IN s_mwskz
*             AND bupla = ''
*             AND hkont IN r_hkont_aux.

"Cria-se um types da tabela do into table do select e outra do tipo da bseg para ser usada no programa.
TYPES: BEGIN OF ty_bseg,
        bukrs  LIKE bseg-bukrs,
        belnr  LIKE bseg-belnr,
        gjahr  LIKE bseg-gjahr,
        buzei  LIKE bseg-buzei,
        bschl  LIKE bseg-bschl,
        koart  LIKE bseg-koart,
        gsber  LIKE bseg-gsber,
        mwskz  LIKE bseg-mwskz,
        dmbtr  LIKE bseg-dmbtr,
        wrbtr  LIKE bseg-wrbtr,
        saknr  LIKE bseg-saknr,
        hkont  LIKE bseg-hkont,
        lifnr  LIKE bseg-lifnr,
        werks  TYPE werks_d,
        ebeln  LIKE bseg-ebeln,
        ebelp  LIKE bseg-ebelp,
        bupla  LIKE bseg-bupla,
        ktosl  LIKE bseg-ktosl,
        fwbas  LIKE bseg-fwbas,
        sgtxt  LIKE bseg-sgtxt,
        shkzg  LIKE bseg-shkzg,
        projk  LIKE bseg-projk,
        awkey  LIKE bkpf-awkey,
        nfnum  LIKE j_1bnfdoc-nfnum,
        series LIKE j_1bnfdoc-series,
        belnr2 LIKE j_1bnfdoc-belnr,
      END OF ty_bseg.

"Declara uma tabela interna com os types da tabela do into table do select e outra do tipo da bseg para ser usada no programa.
DATA lt_bseg2 TYPE TABLE OF bseg.
DATA lt_bseg3 TYPE TABLE OF ty_bseg.

"Determina que os valores da tabela interna lt_fields usada na função terá o valor dos campos que aparecem no select. Orientamos a usar a mesma sequência usada no select.
DATA lt_fields TYPE fagl_t_field.

lt_fields = VALUE #( ( line = 'BUKRS' )
( line = 'BUKRS' )    
( line = 'BELNR' )
( line = 'GJAHR' )
( line = 'BUZEI' )
( line = 'BSCHL' )
( line = 'KOART' )
( line = 'GSBER' )
( line = 'MWSKZ' )
( line = 'DMBTR' )
( line = 'WRBTR' )
( line = 'SAKNR' )
( line = 'HKONT' )
( line = 'LIFNR' )
( line = 'WERKS' )
( line = 'EBELN' )
( line = 'EBELP' )
( line = 'BUPLA' )
( line = 'KTOSL' )
( line = 'FWBAS' )
( line = 'SGTXT' )
( line = 'SHKZG' )
( line = 'PROJK' ) ).

"Chama a função do for all entries colocando a tabela do for all entries como entrada e uma tabela interna para a saída. Neste exemplo observamos que o campo belnr tem nomenclatura diferente belnr_rem.
CALL FUNCTION 'fagl_get_bseg_for_all_entries'
EXPORTING
it_for_all_entries = t_bkpf
i_where_clause = |bukrs = it_for_all_entries-bukrs and belnr = it_for_all_entries-belnr and gjahr = it_for_all_entries-gjahr|
it_fieldlist = lt_fields
IMPORTING
et_bseg = lt_bseg2
EXCEPTIONS
not_found = 1.

"Deleta os dados da tabela interna dos campos que não estão na função, 
"escrevendo o oposto do que está na cláusula where.
DELETE lt_bseg2 WHERE gsber NOT IN s_gsber.
DELETE lt_bseg2 WHERE mwskz NOT IN s_mwskz.
DELETE lt_bseg2 WHERE bupla NE ''.
DELETE lt_bseg2 WHERE hkont NOT IN r_hkont_aux.

"Move os dados dos campos correspondentes da tabela interna
"criada na função para uma outra tabela interna e depois
"apenda as linhas dessa tabela na tabela do into table do select.
IF sy-subrc = 0 AND lines( lt_bseg2 ) > 0.

lt_bseg3 = CORRESPONDING #( lt_bseg2 ).
APPEND LINES OF lt_bseg3 TO t_bseg.

ELSE.
sy-subrc = 4.
sy-dbcnt = 0.
ENDIF.
          
* <--- S4 Migration - 20/09/2023 - WS       
