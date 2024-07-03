*---> S4 Migration - 04/05/2023 - JV
* SELECT ZBD1T UP TO 1 ROWS
* INTO t_partidas-zbd1t
* FROM bseg
* WHERE bukrs = t_partidas-bukrs
* AND belnr = t_partidas-belnr
* AND gjahr = t_partidas-gjahr
* AND buzei = t_partidas-buzei.
* ENDSELECT.

DATA: lt_bseg TYPE fagl_t_bseg.

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

READ TABLE lt_bseg INTO DATA(wa_bseg) index 1.
IF sy-subrc EQ 0.
t_partidas-zbd1t = wa_bseg-zbd1t.
ENDIF.
* <--- S4 Migration - 04/05/2023 - JV
