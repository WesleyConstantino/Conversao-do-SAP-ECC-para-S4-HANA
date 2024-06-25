* ---> S4 Migration - 02/04/2024 - FV
*    CALL TRANSACTION 'XK02'
*      USING gw_bdcdata
*      MODE lv_mode
*      UPDATE lv_save
*      MESSAGES INTO gw_bdcmsg.

    DATA: lt_bdc    TYPE bdcdata_tab,
            lt_bdcmsg1 TYPE tab_bdcmsgcoll,
            wa_lfa1   type lfa1.

      DATA: lo_migbp TYPE REF TO ZCL_MIGBP.

      lt_bdc = CONV #( gw_bdcdata[] ).

      CREATE OBJECT lo_migbp
        EXPORTING
          im_test    = abap_false
          im_tcode   = 'BP'
          it_bdcdata = lt_bdc.

      CALL METHOD lo_migbp->mt_bp_process_old_shdb(
        CHANGING
          ct_bdcmsg = lt_bdcmsg1 ).

      CALL METHOD lo_migbp->mt_bp_process_data( CHANGING ct_bdcmsg = lt_bdcmsg1 ).

      gw_bdcmsg = CONV #( lt_bdcmsg1[] ).

* <--- S4 Migration - 02/04/2024 – FV
