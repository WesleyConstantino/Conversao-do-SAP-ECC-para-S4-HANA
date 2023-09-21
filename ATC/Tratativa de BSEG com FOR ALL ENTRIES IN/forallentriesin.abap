* <--- S4 Migration - 20/09/2023 - WS

*    SELECT bukrs belnr gjahr buzei bschl koart gsber mwskz dmbtr wrbtr
*      saknr hkont lifnr  werks ebeln ebelp bupla ktosl fwbas sgtxt shkzg
*      projk werks
* INTO TABLE t_bseg
* FROM bseg
*  FOR ALL ENTRIES IN t_bkpf
*WHERE bukrs  = t_bkpf-bukrs
*  AND belnr  = t_bkpf-belnr
*  AND gjahr  = t_bkpf-gjahr
*  AND gsber IN s_gsber
*  AND bupla IN s_bupla
*  AND hkont IN r_hkont_aux.

      DATA lt_bseg_1 TYPE TABLE OF bseg.

        CALL FUNCTION 'FAGL_GET_BSEG_FOR_ALL_ENTRIES'
          EXPORTING
            it_for_all_entries = t_bkpf
            i_where_clause     = |BUKRS = IT_FOR_ALL_ENTRIES-BUKRS AND BELNR = IT_FOR_ALL_ENTRIES-BELNR AND GJAHR = IT_FOR_ALL_ENTRIES-GJAHR|
          IMPORTING
            et_bseg            = lt_bseg_1
          EXCEPTIONS
            not_found          = 1.

        IF sy-subrc = 0 AND lines( lt_bseg_1 ) > 0.
          DELETE lt_bseg_1 WHERE gsber NOT IN s_gsber.
          DELETE lt_bseg_1 WHERE bupla NOT IN s_bupla.
          DELETE lt_bseg_1 WHERE hkont NOT IN r_hkont_aux.

          MOVE-CORRESPONDING lt_bseg_1[] TO t_bseg[].
        ENDIF.     

* <--- S4 Migration - 20/09/2023 - WS  
