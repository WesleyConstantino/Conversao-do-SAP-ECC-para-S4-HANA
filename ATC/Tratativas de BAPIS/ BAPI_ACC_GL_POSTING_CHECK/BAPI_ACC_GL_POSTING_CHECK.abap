"Para tratar a BAPI_ACC_GL_POSTING_CHECK, primeiro colocamos um pragma na frante do nome da BAPI, após isso, fazemos a conversão de campos com "CONV #( ... )", onde 
"for passado algum valor para a tabela que alimentará o parâmetro "currencyamount" da BAPI.
*****************************************************************************************************************************************************************

* ---> S4 Migration - 26/07/2023 - WS - Inicio
*    es_currencyamount-itemno_acc = '2'.
     es_currencyamount-itemno_acc = CONV #( '2' ).
*    es_currencyamount-currency   = cc_colones .
     es_currencyamount-currency   = CONV #( cc_colones ).
*    es_currencyamount-amt_doccur = - p_montoml.
     es_currencyamount-amt_doccur = CONV #( - p_montoml ).
*    es_currencyamount-curr_type  = '10'.
     es_currencyamount-curr_type  = CONV #( '10' ).
* ---> S4 Migration - 26/07/2023 - WS - Fim

  ....
 
    CALL FUNCTION 'BAPI_ACC_GL_POSTING_CHECK'  "#EC CI_USAGE_OK[2628704]
      EXPORTING
        documentheader = es_documentheader
      TABLES
        accountgl      = ti_accountgl
        currencyamount = ti_currencyamount
        return         = ti_return.
