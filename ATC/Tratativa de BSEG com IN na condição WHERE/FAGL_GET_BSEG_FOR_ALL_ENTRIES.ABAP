* ---> S4 Migration - 30/06/2023 - WS - Inicio

*        SELECT bukrs
*               belnr
*               gjahr
*               buzei
*               zuonr
*               hkont
*               dmbtr
*               bschl
*               werks
*               bupla
*               lifnr
*          INTO TABLE itab_sap_bseg
*          FROM bseg
*         WHERE bukrs  = itab_sap_bkpf-bukrs
*           AND belnr  = itab_sap_bkpf-belnr
*           AND gjahr  = itab_sap_bkpf-gjahr
****           AND hkont IN itab_conta
****           AND bschl IN ('40', '50').

        DATA lt_bseg TYPE TABLE OF bseg.

        CALL FUNCTION 'FAGL_GET_BSEG_FOR_ALL_ENTRIES'
          EXPORTING
            it_for_all_entries = itab_sap_bkpf
            i_where_clause     = |BUKRS = IT_FOR_ALL_ENTRIES-BUKRS AND BELNR = IT_FOR_ALL_ENTRIES-BELNR AND GJAHR = IT_FOR_ALL_ENTRIES-GJAHR|
          IMPORTING
            et_bseg            = lt_bseg
          EXCEPTIONS
            not_found          = 1.


        IF sy-subrc = 0 AND lines( lt_bseg ) > 0.
          DELETE lt_bseg WHERE hkont NOT IN itab_conta.
          DELETE lt_bseg WHERE bschl NE '40' AND bschl NE '50'.

          MOVE-CORRESPONDING lt_bseg[] TO itab_sap_bseg[].
        ENDIF.
* <--- S4 Migration - 30/06/2023 - WS - Fim
