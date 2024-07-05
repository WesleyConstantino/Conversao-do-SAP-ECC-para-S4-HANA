
* Exemplo 1 ..........................................................................................*

*WS - Migração Mignow - 03/07/24
*  SELECT kokrs
*         kstar
*         datbi
*         katyp
*    FROM cskb
*    INTO TABLE it_cskb
*     FOR ALL ENTRIES IN it_csku
*   WHERE kokrs = 'LOG'         AND
*         kstar = it_csku-kstar AND
*         datbi >= sy-datum     AND
*         datab <= sy-datum.

    DATA: lt_returns  TYPE TABLE OF bapiret2,
          ls_coeldes TYPE bapi1030_ceoutputlist,
          wa_cskb TYPE cskb,
          wa_cskb_fae TYPE cskb.

    LOOP AT it_csku INTO wa_cskb_fae.

      clear: lt_returns[], ls_coeldes.

      CALL FUNCTION 'K_COSTELEM_BAPI_GETDETAIL'
        EXPORTING
          costelement       = wa_cskb_fae-kstar
          keydate           = sy-datum
        IMPORTING
          costelementdetail = ls_coeldes
        TABLES
          return            = lt_returns.

      READ TABLE lt_returns TRANSPORTING NO FIELDS WITH KEY type = 'E'.
      IF sy-subrc = 0.
      ELSE.
        wa_cskb-kokrs = wa_cskb_fae-kokrs.
        wa_cskb-kstar = wa_cskb_fae-kstar.
        wa_cskb-datbi = ls_coeldes-valid_to.
        wa_cskb-katyp = ls_coeldes-celem_category.
        APPEND wa_cskb TO it_cskb.
        CLEAR wa_cskb.
      ENDIF.
    ENDLOOP.

    DELETE it_cskb WHERE kokrs NE 'LOG'.
    DELETE it_cskb WHERE datbi < sy-datum.
    DELETE it_cskb WHERE datab > sy-datum.
*WS - Migração Mignow - 03/07/24




* Exemplo 2 ..........................................................................................*

*---> S4 Migration - 02/05/2023 - DG
*    SELECT kokrs
*           kstar
*           datbi
*           katyp
*      FROM cskb
*      INTO TABLE lt_cskb
*      FOR ALL ENTRIES IN lt_cskb_fae
*     WHERE kokrs = lt_cskb_fae-kokrs
*       AND kstar = lt_cskb_fae-kstar.

    DATA: lt_returns  TYPE TABLE OF bapiret2,
          ls_coeldes TYPE bapi1030_ceoutputlist.
    LOOP AT lt_cskb_fae INTO DATA(wa_cskb_fae).

      clear: lt_returns[], ls_coeldes.

      CALL FUNCTION 'K_COSTELEM_BAPI_GETDETAIL'
        EXPORTING
          controllingarea   = wa_cskb_fae-kokrs
          costelement       = wa_cskb_fae-kstar
          keydate           = sy-datum
        IMPORTING
          costelementdetail = ls_coeldes
        TABLES
          return            = lt_returns.

      READ TABLE lt_returns TRANSPORTING NO FIELDS WITH KEY type = 'E'.
      IF sy-subrc = 0.
      ELSE.
        wa_cskb-kokrs = wa_cskb_fae-kokrs.
        wa_cskb-kstar = wa_cskb_fae-kstar.
        wa_cskb-datbi = ls_coeldes-valid_to.
        wa_cskb-katyp = ls_coeldes-celem_category.
        APPEND wa_cskb TO lt_cskb.
      ENDIF.
    ENDLOOP.
*<--- S4 Migration - 02/05/2023 - DG

