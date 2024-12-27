*<---27/12/2024 - Migração S4 - WS
*        SELECT SINGLE periv
*          FROM t882g
*          INTO gs_t001-periv
*          WHERE rbukrs = gs_zscrelacngl-bukrs
*          AND rldnr = gs_zscrelacngl-rldnr.

  TYPES:
    tt_t882g TYPE STANDARD TABLE OF t882g WITH KEY rbukrs rldnr .
  DATA:
    lt_rbukrs    TYPE fagl_bukrs_tab,
    lt_rldnr_mf  TYPE FAGL_RLDNR_tab,
    ls_rbukrs    TYPE bukrs,
    ls_rldnr_mf  TYPE FAGL_RLDNR,
    lt_t882g_aux TYPE tt_t882g.

  cl_fins_acdoc_util=>get_t882g_emu(
    EXPORTING
    iv_rldnr  =  gs_zscrelacngl-rldnr
    iv_rbukrs =  gs_zscrelacngl-bukrs 
    IMPORTING         
      et_t882g  =  lt_t882g_aux   
  EXCEPTIONS
    not_found = 1
    others    = 2
  ).
  
  IF lt_t882g_aux   IS NOT INITIAL AND sy-subrc = 0.
      LOOP AT  lt_t882g_aux INTO DATA(ls_t882g_aux).
        gs_t001-periv = ls_t882g_aux-periv.
      ENDLOOP.
  ENDIF.
*<---27/12/2024 - Migração S4 - WS
