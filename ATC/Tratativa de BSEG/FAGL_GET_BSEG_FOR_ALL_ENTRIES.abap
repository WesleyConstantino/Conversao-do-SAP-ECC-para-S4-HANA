* ---> S4 Migration - 29/06/2023 - WS - Inicio

"    SELECT   werks
"    INTO   v_werks
"    FROM   bseg
"    WHERE   bukrs = itab_with_item-bukrs    AND
"            belnr = itab_with_item-belnr    AND
"            gjahr = itab_with_item-gjahr    AND
"            werks <> '    '.
"    ENDSELECT.

DATA lt_bseg TYPE TABLE OF bseg.

CALL FUNCTION 'FAGL_GET_BSEG_FOR_ALL_ENTRIES'
  EXPORTING
    it_for_all_entries = itab_with_item
    i_where_clause     = |BUKRS = IT_FOR_ALL_ENTRIES-BUKRS AND BELNR = IT_FOR_ALL_ENTRIES-BELNR AND GJAHR = IT_FOR_ALL_ENTRIES-GJAHR|
  IMPORTING
    et_bseg            = lt_bseg
  EXCEPTIONS
    not_found          = 1.
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    DELETE lt_bseg WHERE WERKS EQ ' '.

  LOOP AT lt_bseg INTO data(ls_bseg).
    v_werks = ls_bseg-werks.
  ENDLOOP.

* <--- S4 Migration - 29/06/2023 - WS - Fim
