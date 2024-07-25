"Para tratar a BAPI_ACC_DOCUMENT_CHECK, primeiro colocamos um pragma na frante do nome da BAPI, após isso, fazemos a conversão de campos com "CONV #( ... )", onde 
"for passado algum valor para a tabela que alimentará o parâmetro "currencyamount" da BAPI.
*****************************************************************************************************************************************************************

*OBS: antigamente era feito um CONV como abaixo. Hoje em dia não é mais necessário. Tratamos esse erro somente com prágma.
* ---> S4 Migration - 26/07/2023 - WS - Inicio
      currencyamount-itemno_acc = CONV #( item_pos ).
      currencyamount-currency = CONV #( es_esquemas-cod_moneda ).
* ---> S4 Migration - 26/07/2023 - WS - Fim

  ....
 
      CALL FUNCTION 'BAPI_ACC_DOCUMENT_CHECK'     "#EC CI_USAGE_OK[2628704]   * ---> S4 Migration - 26/07/2023 - WS 
        EXPORTING
          documentheader = documentheader
        TABLES
          accountgl      = accountgl
          currencyamount = currencyamount
          return         = return.


*OBS: em caso de dois tipos de erros diferentes em 1 programa apontando para a mesma bapi. Usar os prágmas descritos nos dois erros e colocar os prágmas
"um debaixo do outro.
