*---> 22/09/2023 - Migração S4 – WS
*    SELECT belnr bukrs gjahr bschl hkont
*      FROM bseg
*      APPENDING TABLE itab_bseg
*      FOR ALL ENTRIES IN itab_cbt030
*      WHERE belnr EQ itab_cbt030-belnr
*        AND gjahr EQ itab_cbt030-ano
*        AND bukrs EQ itab_cbt030-gsberf
*        AND bschl IN ('01', '04').
          DATA: t_fields   TYPE fagl_t_field,
                t_bseg_aux TYPE TABLE OF bseg,
                w_itab_bseg LIKE LINE OF itab_bseg.

          t_fields = VALUE #( ( line = 'BUKRS' )
                              ( line = 'BELNR' )
                              ( line = 'GJAHR' )
                              ( line = 'BSCHL' )
                              ( line = 'HKONT' )
                              ).

          CALL FUNCTION 'FAGL_GET_BSEG_FOR_ALL_ENTRIES'
            EXPORTING
              it_for_all_entries = itab_cbt030
              i_where_clause     = |BUKRS = IT_FOR_ALL_ENTRIES-GSBERF AND BELNR = IT_FOR_ALL_ENTRIES-BELNR AND GJAHR = IT_FOR_ALL_ENTRIES-ANO|
              it_fieldlist       = t_fields
            IMPORTING
              et_bseg            = t_bseg_aux
            EXCEPTIONS
              not_found          = 1.

          DELETE t_bseg_aux WHERE  bschl NE '01' AND
                                   bschl NE '04' .

          IF sy-subrc = 0 AND lines( t_bseg_aux ) > 0.
            LOOP AT t_bseg_aux INTO DATA(w_bseg_aux).
              w_itab_bseg-BUKRS = w_bseg_aux-BUKRS.
              w_itab_bseg-BELNR = w_bseg_aux-BELNR.
              w_itab_bseg-GJAHR = w_bseg_aux-GJAHR.
              w_itab_bseg-BSCHL = w_bseg_aux-BSCHL.
              w_itab_bseg-HKONT = w_bseg_aux-HKONT.
              APPEND w_itab_bseg TO itab_bseg.
            ENDLOOP.
            sy-dbcnt = lines( t_bseg_aux ).
          ELSE.
            sy-subrc = 4.
            sy-dbcnt = 0.
          ENDIF.
*<--- 22/09/2023 - Migração S4 – WS
