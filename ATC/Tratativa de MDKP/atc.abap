
*Exemplo 1 ...................................................................................*

*WS - Migração Mignow - 03/07/24
*  SELECT dtart
*         matnr
*         plwrk
*         plscn
*         dsdat
*    FROM mdkp
*    INTO TABLE it_mdkp
*    FOR ALL ENTRIES IN it_mara
*    WHERE dtart = 'MD'          AND
*          matnr = it_mara-matnr AND
*          plwrk IN r_centros    AND
*          beskz = 'E'.

  SELECT matnr
    FROM marc
    INTO TABLE @DATA(lt_marc)
    FOR ALL ENTRIES IN @it_mara
    WHERE matnr = @it_mara-matnr AND
          beskz = 'E'.

  IF lt_marc[] IS NOT INITIAL.

    DATA: lt_matnr_werks TYPE pph_matnr_werks_berid_tab,
          lt_mt61d       TYPE pph_mt61d_tab.

    lt_matnr_werks = VALUE #( FOR wa IN lt_marc ( matnr = wa-matnr ) ).

    CALL FUNCTION 'MD_MDPSX_READ_API'
      EXPORTING
        it_matnr_werks_berid = lt_matnr_werks
      IMPORTING
        et_mt61d
       = lt_mt61d.
    MOVE-CORRESPONDING lt_mt61d[] TO it_mdkp[].

  ENDIF.
*WS - Migração Mignow - 03/07/24


*Exemplo 2 ...................................................................................*

*---> 27/02/2024 - Migração S4 – BM
*  SELECT *
*    INTO TABLE t_mdkp
*    FROM mdkp
*   WHERE
*      dtart EQ c_md
*  AND matnr IN s_matnr
*  AND plwrk EQ p_plwrk
*  AND plscn EQ 000.

  SELECT * FROM marc INTO TABLE @DATA(lt_marc)
    WHERE matnr IN @s_matnr
      AND werks EQ @p_plwrk.

  IF lt_marc[] IS NOT INITIAL.

    DATA: lt_matnr_werks TYPE pph_matnr_werks_berid_tab,
          lt_mt61d       TYPE pph_mt61d_tab.

    lt_matnr_werks = VALUE #( FOR wa IN lt_marc ( matnr = wa-matnr werks = wa-werks ) ).

    CALL FUNCTION 'MD_MDPSX_READ_API'
      EXPORTING
        it_matnr_werks_berid = lt_matnr_werks
      IMPORTING
        et_mt61d             = lt_mt61d.

    MOVE-CORRESPONDING lt_mt61d[] TO t_mdkp[].
  ENDIF.
*<--- 27/02/2024 - Migração S4 – BM


*Exemplo 3 ...................................................................................*
"Usar esta exemplo para os casos em que a MARC possuir todos os campos selecionados no select.

*---> 10/11/2023 - Migração S4 – DG
*       SELECT SINGLE dismm
*         FROM mdkp
*         INTO v_dismm_0182
*         WHERE matnr = mdba-matnr AND
*               plwrk = mdba-werks.

       SELECT SINGLE dismm
         FROM marc
         INTO v_dismm_0182
         WHERE matnr = mdba-matnr AND
               werks = mdba-werks.

*<--- 10/11/2023 - Migração S4 – DG

