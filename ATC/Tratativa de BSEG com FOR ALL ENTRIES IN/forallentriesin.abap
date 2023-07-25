**---> 25/07/2023 - Migração S4 - WS

*        SELECT *
*          FROM bseg
*          INTO CORRESPONDING FIELDS OF TABLE lt_bseg
*          FOR ALL ENTRIES IN lt_bsid
*          WHERE bukrs =  lt_bsid-bukrs AND
*                belnr =  lt_bsid-belnr AND
*                gjahr =  lt_bsid-gjahr AND
*                hkont IN  lr_hkont AND
*                koart = 'D'.    "Se devuelve el asiento de Deudor

      DATA lt_bseg_1 TYPE TABLE OF bseg.

        CALL FUNCTION 'FAGL_GET_BSEG_FOR_ALL_ENTRIES'
          EXPORTING
            it_for_all_entries = lt_bsid
            i_where_clause     = |BUKRS = IT_FOR_ALL_ENTRIES-BUKRS AND BELNR = IT_FOR_ALL_ENTRIES-BELNR AND GJAHR = IT_FOR_ALL_ENTRIES-GJAHR|
          IMPORTING
            et_bseg            = lt_bseg_1
          EXCEPTIONS
            not_found          = 1.


        IF sy-subrc = 0 AND lines( lt_bseg_1 ) > 0.
          DELETE lt_bseg_1 WHERE hkont NOT IN lr_hkont.
          DELETE lt_bseg_1 WHERE koart NE 'D'.

          MOVE-CORRESPONDING lt_bseg_1[] TO lt_bseg[].
        ENDIF.

**<--- 25/07/2023 - Migração S4 - WS
