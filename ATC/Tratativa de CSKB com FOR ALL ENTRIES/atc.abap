*<---30/12/2024 - Migração S4 - WS
*  select * from cskb
*   into table gh_cskb
*    for all entries in gh_flext
*    where KSTAR =  gh_flext-cost_elem.

  DATA: lt_returns TYPE TABLE OF bapiret2,
        ls_coeldes TYPE bapi1030_ceoutputlist,
        wa_cskb    LIKE LINE OF gh_cskb.

  LOOP AT gh_flext INTO DATA(wa_gh_flext).
    CLEAR: lt_returns[], ls_coeldes.

    CALL FUNCTION 'K_COSTELEM_BAPI_GETDETAIL'
      EXPORTING
        costelement       = wa_gh_flext-cost_elem
        keydate           = sy-datum
      IMPORTING
        costelementdetail = ls_coeldes
      TABLES
        return            = lt_returns.

    READ TABLE lt_returns TRANSPORTING NO FIELDS WITH KEY type = 'E'.
    IF sy-subrc = 0.
    ELSE.
      wa_cskb-kstar = ls_coeldes-cost_elem.
      wa_cskb-datab = ls_coeldes-valid_from.
      wa_cskb-datbi = ls_coeldes-valid_to.
      wa_cskb-katyp = ls_coeldes-celem_category.
      wa_cskb-eigen = ls_coeldes-celem_attribute.
      wa_cskb-mgefl = ls_coeldes-record_quantity.
*      wa_cskb-meinh = ls_coeldes-unit_of_measure.
*      wa_cskb-meinh_iso =  ls_coeldes-unit_of_measure_iso.
      wa_cskb-kostl = ls_coeldes-default_costcenter.
      wa_cskb-aufnr = ls_coeldes-default_order.
*      wa_cskb-jv_recind = ls_coeldes-jv_rec_ind.
*      wa_cskb-ktext = ls_coeldes-name.
*      wa_cskb-kltxt = ls_coeldes-descript.
*      wa_cskb-co_kaint = ls_coeldes-celem_class.
*      wa_cskb-fkber_short = ls_coeldes-func_area.
*      wa_cskb-fkber = ls_coeldes-func_area_long.
      APPEND wa_cskb TO gh_cskb.
    ENDIF.
  ENDLOOP.
