*<--- 16/01/2024 - Migração S4 - WS
*          SELECT bukrs gjahr belnr qsskz wrbtr
*            FROM bseg
*            INTO TABLE lt_bseg
*            FOR ALL ENTRIES IN lt_bkpf
*            WHERE bukrs = lt_bkpf-bukrs
*              AND gjahr = lt_bkpf-gjahr
*              AND belnr = lt_bkpf-belnr
*              AND qsskz IN ('CL','PL','RD','SL').

      DATA lt_bseg_1 TYPE TABLE OF bseg.

        CALL FUNCTION 'FAGL_GET_BSEG_FOR_ALL_ENTRIES'
          EXPORTING
            it_for_all_entries = lt_bkpf
            i_where_clause     = |BUKRS = IT_FOR_ALL_ENTRIES-BUKRS AND BELNR = IT_FOR_ALL_ENTRIES-BELNR AND GJAHR = IT_FOR_ALL_ENTRIES-GJAHR|
          IMPORTING
            et_bseg            = lt_bseg_1
          EXCEPTIONS
            not_found          = 1.

        IF sy-subrc = 0 AND lines( lt_bseg_1 ) > 0.
          DATA lr_qsskz TYPE RANGE OF bseg-qsskz.

            lr_qsskz = VALUE #( sign = 'I'
                      option = 'EQ'
                      ( low = 'CL' )
                      ( low = 'PL' )
                      ( low = 'RD' )
                      ( low = 'SL' ) ).

          DELETE lt_bseg_1 WHERE qsskz NOT IN lr_qsskz.
          MOVE-CORRESPONDING lt_bseg_1[] TO lt_bseg[].
        ENDIF.
*<--- 16/01/2024 - Migração S4 - WS
