"Para tratar a BAPI_ACC_DOCUMENT_POST, primeiro colocamos um pragma na frante do nome da BAPI, após isso, fazemos a conversão de campos com "CONV #( ... )", onde 
"for passado algum valor para a tabela que alimentará o parâmetro "currencyamount" da BAPI.
*****************************************************************************************************************************************************************
Ex:

....
IF es_cuenta_contable-tipo_movimiento = 'DB'.
* ---> S4 Migration - 26/07/2023 - WS - Inicio
*          currencyamount-amt_doccur = es_cuenta_contable-monto.          "<- Antes da tratativa.
          currencyamount-amt_doccur = CONV #( es_cuenta_contable-monto ). "<- Depois da tratativa.
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
....

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
          currencyamount = currencyamount  "<- Parâmetro "currencyamount" da BAPI
          return         = return.
