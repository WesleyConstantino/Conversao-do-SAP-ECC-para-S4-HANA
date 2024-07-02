*Apenas desconsideramos o comando CLIENT SPECIFIED:

*WS - Migração Mignow - 02/07/24
*  SELECT mandt bukrs belnr gjahr buzei shkzg dmbtr sgtxt kostl hkont
*   FROM bseg
*    CLIENT SPECIFIED
*   INTO TABLE t_tempbseg
*   FOR ALL ENTRIES IN t_tempbkpf
*   WHERE mandt IN s_client
*    AND bukrs = t_tempbkpf-bukrs
*    AND gjahr = t_tempbkpf-gjahr
*    AND belnr = t_tempbkpf-belnr .

      DATA lt_bseg TYPE TABLE OF bseg.

        CALL FUNCTION 'FAGL_GET_BSEG_FOR_ALL_ENTRIES'
          EXPORTING
            it_for_all_entries = t_tempbkpf
            i_where_clause     = |BUKRS = IT_FOR_ALL_ENTRIES-BUKRS AND BELNR = IT_FOR_ALL_ENTRIES-BELNR AND GJAHR = IT_FOR_ALL_ENTRIES-GJAHR|
          IMPORTING
            et_bseg            = lt_bseg
          EXCEPTIONS
            not_found          = 1.

        IF sy-subrc = 0 AND lines( lt_bseg ) > 0.
          DELETE lt_bseg WHERE mandt NOT IN s_client.

          MOVE-CORRESPONDING lt_bseg[] TO t_tempbseg[].
        ENDIF.
*WS - Migração Mignow - 02/07/24
