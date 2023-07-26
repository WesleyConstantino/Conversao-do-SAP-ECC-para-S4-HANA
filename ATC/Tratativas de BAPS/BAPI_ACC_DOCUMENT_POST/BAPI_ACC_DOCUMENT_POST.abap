
IF es_cuenta_contable-tipo_movimiento = 'DB'.
* ---> S4 Migration - 26/07/2023 - WS - Inicio
*          currencyamount-amt_doccur = es_cuenta_contable-monto.
          currencyamount-amt_doccur = CONV #( es_cuenta_contable-monto ).
* <--- S4 Migration - 26/07/2023 - WS - Fim
        ELSE.
* ---> S4 Migration - 26/07/2023 - WS - Inicio
*          currencyamount-amt_doccur = es_cuenta_contable-monto * -1.
          currencyamount-amt_doccur = CONV #( es_cuenta_contable-monto * -1 ).
* <--- S4 Migration - 26/07/2023 - WS - Fim
        ENDIF.

        APPEND currencyamount.
        APPEND accountgl.
      ENDIF.


    IF p_test = '' AND vc_contabilizar = 'X'.
      CALL FUNCTION 'BAPI_ACC_DOCUMENT_POST'  "#EC CI_USAGE_OK[2628704]  * <--- S4 Migration - 26/07/2023 - WS
        EXPORTING
          documentheader = documentheader
        IMPORTING
          obj_type       = obj_type
          obj_key        = obj_key
          obj_sys        = obj_sys
        TABLES
          accountgl      = accountgl
          currencyamount = currencyamount
          return         = return.
