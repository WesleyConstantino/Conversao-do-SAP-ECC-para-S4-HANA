*---> S4 Migration - 04/05/2023 - JV
* SELECT ZBD1T UP TO 1 ROWS
* INTO t_partidas-zbd1t
* FROM bseg
* WHERE bukrs = t_partidas-bukrs
* AND belnr = t_partidas-belnr
* AND gjahr = t_partidas-gjahr
* AND buzei = t_partidas-buzei.
* ENDSELECT.

"Declara uma tabela interna com os types da tabela da bseg.
DATA: lt_bseg TYPE fagl_t_bseg.
"Chama a função colocando os campos do exporting tal como os do where
 dentro do select e a tabela interna criada como de saída.
CALL FUNCTION 'FAGL_GET_BSEG'
EXPORTING
i_bukrs = t_partidas-bukrs
i_belnr = t_partidas-belnr
i_gjahr = t_partidas-gjahr
i_buzei = t_partidas-buzei
IMPORTING
et_bseg = lt_bseg
EXCEPTIONS
OTHERS = 2.
"Como só tem uma linha, faz um read table da tabela interna
 para uma work area declarada na linha com index 1 e depois
  move os dados correspondentes da linha para a tabela do INTO TABLE.
READ TABLE lt_bseg INTO DATA(wa_bseg) index 1.
IF sy-subrc EQ 0.
t_partidas-zbd1t = wa_bseg-zbd1t.
ENDIF.
* <--- S4 Migration - 04/05/2023 - JV
