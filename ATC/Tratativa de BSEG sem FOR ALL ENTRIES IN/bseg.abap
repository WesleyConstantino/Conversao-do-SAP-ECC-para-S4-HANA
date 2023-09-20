* <--- S4 Migration - 20/09/2023 - WS 
      
*      SELECT bukrs belnr gjahr buzei hkont wrbtr valut umskz koart
*        INTO TABLE l_t_bseg
*        FROM bseg
*        WHERE bukrs EQ <lfs_bkpf>-bukrs
*          AND belnr EQ <lfs_bkpf>-belnr
*          AND gjahr EQ <lfs_bkpf>-gjahr
*          AND buzei BETWEEN '000' AND '999'.

DATA lt_bseg TYPE TABLE OF bseg.
        
CALL FUNCTION 'FAGL_GET_BSEG'
EXPORTING
i_bukrs = <lfs_bkpf>-bukrs
i_belnr = <lfs_bkpf>-belnr
i_gjahr = <lfs_bkpf>-gjahr
IMPORTING
et_bseg = lt_bseg
EXCEPTIONS
OTHERS = 2.

DELETE lt_bseg WHERE buzei NOT BETWEEN '000' AND '999'.

IF sy-subrc EQ 0.
 MOVE-CORRESPONDING lt_bseg[] TO l_t_bseg[].
ENDIF.

* <--- S4 Migration - 20/09/2023 - WS 
