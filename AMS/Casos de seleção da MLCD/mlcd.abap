"Em casos de seleção da tabela MLCD, devemos continuar usando o select original para selecionar os períodos antes do ECC ser convertido para o S/4.
"já para os períodos após isso, devemos usar a função da MIG Z_MLDOC_MLCD. Isso se dá porque a mlcd só possui os registros da época do ECC, enquanto a
"função Z_MLDOC_MLCD só traz registros a partir da data de criação do ambiente S/4 para um determinado cliiente.

*Exemplo de solução: use a transação STVARV para criar um parâmetro com o período desejado e use-o como condição:
*---> TICKETS - 29/07/2025 -MG-25825 - WS - Begin
     SELECT SINGLE low
       FROM tvarvc
       INTO @DATA(lv_tvarv_data)
       WHERE name EQ 'Z_DATA_CORTE_MLCD'.

     CONCATENATE ano periodo INTO DATA(lv_ano_e_periodo).

     IF lv_tvarv_data <= lv_ano_e_periodo.
*---> TICKETS - 29/07/2025 -MG-25825 - WS - End

      SELECT a~kalnr a~bdatj a~poper a~untper a~categ b~flg_zugang a~ptyp c~ktext
             a~bvalt a~lbkum a~meins a~salk3 a~estprd a~estkdm a~mstprd a~mstkdm
        FROM mlcd AS a
        LEFT OUTER JOIN ckmlmv009 AS b
        ON a~ptyp = b~ptyp
        INNER JOIN ckmlmv009t AS c
        ON b~ptyp = c~ptyp
        INTO TABLE t_mlcd
        FOR ALL ENTRIES IN t_kalnr
        WHERE a~kalnr = t_kalnr-kalnr
          AND a~bdatj = ano
          AND a~poper = periodo
          AND a~curtp = '10'
          AND c~spras = sy-langu.
*---> TICKETS - 29/07/2025 -MG-25825 - WS - Begin
     ELSE.

      DATA: lt_mlcd1  TYPE ckmcd_t_mlcd,
            lt_kalnr TYPE ckmv0_matobj_tbl,
            ls_kalnr LIKE LINE OF lt_kalnr.

      LOOP AT t_kalnr INTO ls_kalnr.
        APPEND ls_kalnr-kalnr TO lt_kalnr.
      ENDLOOP.

      CALL FUNCTION 'Z_MLDOC_MLCD'
        EXPORTING
          i_from_bdatj = ano
          i_from_poper = periodo
          i_curtp      = '10'
          it_kalnr     = lt_kalnr
        IMPORTING
          ot_mlcd      = lt_mlcd1.

      IF lt_mlcd1[] IS NOT INITIAL.
        SELECT ptyp, flg_zugang
          FROM ckmlmv009
          FOR ALL ENTRIES IN @lt_mlcd1
          WHERE ptyp = @lt_mlcd1-ptyp
          INTO TABLE @DATA(lt_ckmlmv009).

        SELECT ptyp, ktext
          FROM ckmlmv009t
          FOR ALL ENTRIES IN @lt_mlcd1
          WHERE ptyp = @lt_mlcd1-ptyp
          AND spras = @sy-langu
          INTO TABLE @DATA(lt_ckmlmv009t).
      ENDIF.

    LOOP AT lt_mlcd1 INTO DATA(ls_mlcd1).
      READ TABLE lt_ckmlmv009 INTO DATA(ls_ckmlmv009) WITH KEY ptyp = ls_mlcd1-ptyp.
      IF sy-subrc = 0.
       READ TABLE lt_ckmlmv009t INTO DATA(ls_ckmlmv009t) WITH KEY ptyp = ls_ckmlmv009-ptyp.
      ENDIF.

        APPEND VALUE #(
               kalnr       = ls_mlcd1-kalnr
               bdatj       = ls_mlcd1-bdatj
               poper       = ls_mlcd1-poper
               untper      = ls_mlcd1-untper
               categ       = ls_mlcd1-categ
               flg_zugang  = ls_ckmlmv009-flg_zugang
               ptyp        = ls_mlcd1-ptyp
               ktext       = ls_ckmlmv009t-ktext
               bvalt       = ls_mlcd1-bvalt
               lbkum       = ls_mlcd1-lbkum
               meins       = ls_mlcd1-meins
               salk3       = ls_mlcd1-salk3
               estprd      = ls_mlcd1-estprd
               estkdm      = ls_mlcd1-estkdm
               mstprd      = ls_mlcd1-mstprd
               mstkdm      = ls_mlcd1-mstkdm
         ) TO t_mlcd.
      ENDLOOP.
     ENDIF.
*---> TICKETS - 29/07/2025 -MG-25825 - WS - End
