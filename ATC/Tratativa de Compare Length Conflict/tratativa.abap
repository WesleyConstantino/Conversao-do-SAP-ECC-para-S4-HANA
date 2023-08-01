"Compare length conflict:
"Temos que colocar pragma na comparação de tamanhos, onde o atc apontar.

"Ex:
  SELECT *
    FROM zstvx_vendas
    INTO TABLE lt_vendas
    WHERE gjahr = lv_date1(4)
    AND monat = lv_date1+4(2)
    AND matnr = i_matnr_n      "#EC CI_FLDEXT_OK[2215424]  *<--- 01/08/2023 - Migração S4 - WS
    AND werks = i_werks_n.
