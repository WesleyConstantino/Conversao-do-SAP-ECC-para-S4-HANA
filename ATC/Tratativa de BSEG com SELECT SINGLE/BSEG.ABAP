* <--- S4 Migration - 20/09/2023 - WS

*    SELECT SINGLE fdgrp FROM bseg
*                 INTO v_fdgrv2
*                 WHERE bukrs EQ bukrs AND
*                       belnr EQ belnr AND
*                       gjahr EQ gjahr AND
*                       fdgrp NE ''.

DATA: lt_bseg_x TYPE fagl_t_bseg.

CALL FUNCTION 'FAGL_GET_BSEG'
EXPORTING
i_bukrs = bukrs
i_belnr = belnr
i_gjahr = gjahr
IMPORTING
et_bseg = lt_bseg_x
EXCEPTIONS
OTHERS = 2.

DELETE lt_bseg_x WHERE fdgrp EQ ''.

READ TABLE lt_bseg_x INTO DATA(wa_bseg_x) index 1.

IF sy-subrc EQ 0.
 v_fdgrv2 = wa_bseg_x-fdgrp.
ENDIF.

* <--- S4 Migration - 20/09/2023 - WS
