*<--- MIG-NOW AUTOMATION - S4 MIGRATION – BEGIN
*      SELECT kunnr kkber knkli
*      FROM knkk
*      INTO TABLE t_knkk
*      FOR ALL ENTRIES IN t_kna1
*      WHERE kunnr EQ t_kna1-kunnr
*      AND kkber IN r_kkber.

        DATA: t_knkk_aux_19 TYPE STANDARD TABLE OF knkk, "#EC CI_USAGE_OK[2227014]
              w_condtab_19  TYPE hrcond,
              t_condtab_19  TYPE STANDARD TABLE OF hrcond.

        LOOP AT t_kna1 INTO DATA(w_kna1_aux).
          w_condtab_19-field = 'KUNNR'.
          w_condtab_19-opera = 'EQ'.
          w_condtab_19-low   = w_kna1_aux-KUNNR.
          APPEND w_condtab_19 TO t_condtab_19.
          CLEAR w_condtab_19.
        ENDLOOP.

        LOOP AT r_kkber INTO DATA(w_kkber_aux).
          w_condtab_19-field = 'KKBER'.
          w_condtab_19-opera = w_kkber_aux-OPTION.
          w_condtab_19-low   = w_kkber_aux-LOW.
          w_condtab_19-HIGH  = w_kkber_aux-HIGH.
          APPEND w_condtab_19 TO t_condtab_19.
          CLEAR w_condtab_19.
        ENDLOOP.

        CALL FUNCTION 'ZFSD_SELECT_KNKK'
          TABLES
             t_condtab   = t_condtab_19
             t_knkk      = t_knkk_aux_19.

        IF t_knkk_aux_19[] IS NOT INITIAL.
          MOVE-CORRESPONDING t_knkk_aux_19[] TO t_knkk[].
          sy-dbcnt = lines( t_knkk_aux_19 ).
          sy-subrc = 0.
        ELSE.
          sy-subrc = 4.
          sy-dbcnt = 0.
        ENDIF.
*<--- MIG-NOW AUTOMATION - S4 MIGRATION – END
