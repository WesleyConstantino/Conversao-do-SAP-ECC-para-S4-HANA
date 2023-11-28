*--> 28/11/2023 - Migração S4 - WS
*    SELECT kunnr, kkber, ctlpc
*    FROM knkk
*    INTO TABLE @DATA(t_knkk_aux)
*    FOR ALL ENTRIES IN @t_ss_estabel
*    WHERE kunnr EQ @t_ss_estabel-kunnr
*    AND kkber IN @s_kkber[]
*    AND ctlpc IN @r_ctlpc[].


        DATA: t_knkk_aux_19 TYPE STANDARD TABLE OF knkk, "#EC CI_USAGE_OK[2227014]
              t_knkk_aux    TYPE STANDARD TABLE OF knkk, "#EC CI_USAGE_OK[2227014]
              w_condtab_19  TYPE hrcond,
              t_condtab_19  TYPE STANDARD TABLE OF hrcond.

        LOOP AT t_ss_estabel INTO DATA(w_ss_estabel_aux).
          w_condtab_19-field = 'KUNNR'.
          w_condtab_19-opera = 'EQ'.
          w_condtab_19-low   = w_ss_estabel_aux-KUNNR.
          APPEND w_condtab_19 TO t_condtab_19.
          CLEAR w_condtab_19.
        ENDLOOP.

        LOOP AT s_kkber INTO DATA(w_kkber_aux).
          w_condtab_19-field = 'KKBER'.
          w_condtab_19-opera = w_kkber_aux-option.
          w_condtab_19-low   = w_kkber_aux-low.
          w_condtab_19-high  = w_kkber_aux-high.
          APPEND w_condtab_19 TO t_condtab_19.
          CLEAR w_condtab_19.
        ENDLOOP.

        LOOP AT r_ctlpc INTO DATA(w_ctlpc_aux).
          w_condtab_19-field = 'CTLPC'.
          w_condtab_19-opera = w_ctlpc_aux-OPTION.
          w_condtab_19-low   = w_ctlpc_aux-LOW.
          w_condtab_19-HIGH  = w_ctlpc_aux-HIGH.
          APPEND w_condtab_19 TO t_condtab_19.
          CLEAR w_condtab_19.
        ENDLOOP.

        CALL FUNCTION 'ZFSD_SELECT_KNKK'
          TABLES
             t_condtab   = t_condtab_19
             t_knkk      = t_knkk_aux_19.

        IF t_knkk_aux_19[] IS NOT INITIAL.
          MOVE t_knkk_aux_19[] TO t_knkk_aux.
          sy-dbcnt = lines( t_knkk_aux_19 ).
          sy-subrc = 0.
        ELSE.
          sy-subrc = 4.
          sy-dbcnt = 0.
        ENDIF.
*--> 28/11/2023 - Migração S4 - WS
