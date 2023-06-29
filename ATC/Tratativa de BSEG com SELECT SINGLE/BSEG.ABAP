* ---> S4 Migration - 29/06/2023 - WS - Inicio

*    SELECT SINGLE gsber
*      INTO v_gsber
*      FROM bseg
*     WHERE bukrs = itab_with_item-bukrs    AND
*           belnr = itab_with_item-belnr    AND
*           gjahr = itab_with_item-gjahr    AND
*           hkont = itab_with_item-hkont.

    DATA lt_bseg_aux TYPE TABLE OF bseg.

      CALL FUNCTION 'FAGL_GET_BSEG'
        EXPORTING
          i_bukrs = itab_with_item-bukrs
          i_belnr = itab_with_item-belnr
          i_gjahr = itab_with_item-gjahr
        IMPORTING
          et_bseg = lt_bseg
        EXCEPTIONS
          OTHERS  = 2.

      READ TABLE lt_bseg_aux INTO DATA(ls_bseg_aux) INDEX 1.

      IF sy-subrc EQ 0.
        v_gsber = ls_bseg_aux-gsber.
      ENDIF.


* <--- S4 Migration - 29/06/2023 - WS - Fim
