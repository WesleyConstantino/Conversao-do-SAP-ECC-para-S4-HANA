*    SELECT SINGLE belnr FROM bkpf INTO iv_belnr
*           WHERE awtyp  = 'VBRK'
*           AND   awkey  = iv_refkey.
*    IF sy-subrc = 0.
*      SELECT SINGLE zfbdt FROM bseg INTO iv_zfbdt
*           WHERE belnr = iv_belnr.
    DATA:   lt_bseg TYPE fagl_t_bseg.

 
    SELECT SINGLE bukrs, belnr, gjahr INTO @DATA(wa_bkpf)
       FROM bkpf
           WHERE awtyp  = 'VBRK'
           AND   awkey  = @iv_refkey.
    IF sy-subrc = 0.

      CALL FUNCTION 'FAGL_GET_BSEG'
        EXPORTING
          i_bukrs = wa_bkpf-bukrs
          i_belnr = wa_bkpf-belnr
          i_gjahr = wa_bkpf-gjahr
        IMPORTING
          et_bseg = lt_bseg
        EXCEPTIONS
          OTHERS  = 2.

      READ TABLE lt_bseg INTO DATA(wa_bseg) INDEX 1.

      IF sy-subrc EQ 0.
        iv_zfbdt = wa_bseg-zfbdt.
      ENDIF.
