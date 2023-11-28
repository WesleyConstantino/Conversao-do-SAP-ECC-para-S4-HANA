*---> 30/11/2023 - Migração S4 – PZ
*  SELECT kunnr kkber klimk knkli sauft skfor ssobl
*  INTO TABLE t_knkk
*  FROM knkk
*  FOR ALL ENTRIES IN t_knvv
*  WHERE kunnr = t_knvv-kunnr
*  AND kkber IN s_cli_kk.

  DATA: t_knkk_aux_19 TYPE STANDARD TABLE OF knkk, "#EC CI_USAGE_OK[2227014]
        w_condtab_19  TYPE hrcond,
        t_condtab_19  TYPE STANDARD TABLE OF hrcond.

  LOOP AT t_knvv INTO DATA(w_knvv_aux).
    w_condtab_19-field = 'KUNNR'.
    w_condtab_19-opera = 'EQ'.
    w_condtab_19-low   = w_knvv_aux-kunnr.
    APPEND w_condtab_19 TO t_condtab_19.
    CLEAR w_condtab_19.
  ENDLOOP.

  LOOP AT s_cli_kk INTO DATA(w_kkber_aux).
    w_condtab_19-field = 'KKBER'.
    w_condtab_19-opera = w_kkber_aux-option.
    w_condtab_19-low   = w_kkber_aux-low.
    w_condtab_19-high  = w_kkber_aux-high.
    APPEND w_condtab_19 TO t_condtab_19.
    CLEAR w_condtab_19.
  ENDLOOP.

  CALL FUNCTION 'ZFSD_SELECT_KNKK'
    TABLES
      t_condtab = t_condtab_19
      t_knkk    = t_knkk_aux_19.

  IF t_knkk_aux_19[] IS NOT INITIAL.
    MOVE-CORRESPONDING t_knkk_aux_19[] TO t_knkk[].
    sy-dbcnt = lines( t_knkk_aux_19 ).
    sy-subrc = 0.
  ELSE.
    sy-subrc = 4.
    sy-dbcnt = 0.
  ENDIF.
*<--- 30/11/2023 - Migração S4 – PZ
