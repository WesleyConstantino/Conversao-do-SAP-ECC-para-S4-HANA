*---> MIG-NOW AUTOMATION - S4 MIGRATION – BEGIN
    "SELECT SINGLE CTLPC FROM KNKK
    "INTO L_CTLPC_AUX
    "WHERE KKBER EQ I_V_KKBER
    "AND KUNNR EQ L_KNKLI_SPE.

    DATA: t_knkk_aux_114   TYPE STANDARD TABLE OF knkk, "#EC CI_USAGE_OK[2227014]'
          t_data_where_114 TYPE STANDARD TABLE OF zstsd_knkk_key,
          w_data_where_114 TYPE zstsd_knkk_key.

    w_data_where_114-kkber = i_v_kkber.
    w_data_where_114-kunnr = l_knkli_spe.
    APPEND w_data_where_114 TO t_data_where_114.

    CALL FUNCTION 'ZFSD_SELECT_KNKK'
      TABLES
        t_data_where = t_data_where_114
        t_knkk       = t_knkk_aux_114.

    IF t_knkk_aux_114[] IS NOT INITIAL.
      READ TABLE t_knkk_aux_114 INTO DATA(w_knkk_aux_628) INDEX 1.
      l_ctlpc_aux = w_knkk_aux_628-ctlpc.
      sy-subrc = 0.
    ELSE.
      sy-subrc = 4.
      sy-dbcnt = 0.
    ENDIF.
*<--- MIG-NOW AUTOMATION - S4 MIGRATION – END
