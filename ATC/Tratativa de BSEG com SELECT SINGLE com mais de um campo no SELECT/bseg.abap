*WS - Migração Mignow - 02/07/24  
*  SELECT SINGLE bukrs
*                belnr
*                gjahr
*                buzei
*                esrnr
*                esrre
*    FROM bseg
*    INTO w_bseg
*    WHERE bukrs = w_bsik_man-bukrs AND
*          belnr = w_bsik_man-belnr AND
*          gjahr = w_bsik_man-gjahr AND
*          buzei = w_bsik_man-buzei.

DATA: lt_bseg TYPE fagl_t_bseg.

CALL FUNCTION 'FAGL_GET_BSEG'
EXPORTING
i_bukrs = w_bsik_man-bukrs
i_belnr = w_bsik_man-belnr
i_gjahr = w_bsik_man-gjahr
IMPORTING
et_bseg = lt_bseg
EXCEPTIONS
OTHERS = 2.

DELETE lt_bseg WHERE buzei <> w_bsik_man-buzei.

READ TABLE lt_bseg INTO DATA(wa_bseg) index 1.

IF sy-subrc EQ 0.
 w_bseg-bukrs = wa_bseg-bukrs.
 w_bseg-belnr = wa_bseg-belnr.
 w_bseg-gjahr = wa_bseg-gjahr.
 w_bseg-buzei = wa_bseg-buzei.
 w_bseg-esrnr = wa_bseg-esrnr.
 w_bseg-esrre = wa_bseg-esrre.
ENDIF. 
*WS - Migração Mignow - 02/07/24    
