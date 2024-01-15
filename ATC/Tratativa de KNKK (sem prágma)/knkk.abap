*---> S4 Migration - 18/07/2023 - JS
*SELECT KUNNR KLIMK SKFOR CTLPC
*INTO TABLE I_KNKK
*FROM KNKK FOR ALL ENTRIES T_KNA1
*WHERE KUNNR = T_KNA1-KUNNR
*AND   KKBER = 'CR01'. 

  DATA: lt_knkk       TYPE STANDARD TABLE OF knkk,  "#ECCI_USAGE_OK[2227014]
        lt_data_where TYPE STANDARD TABLE OF zknkk_key,
        wa_data_where TYPE zknkk_key. 

  LOOP AT T_KNA1.
   wa_data_where-kunnr = T_KNA1-KUNNR.
   wa_data_where-kkber = 'CR01'.
   APPEND wa_data_where TO lt_data_where.
  ENDLOOP. 

  CALL FUNCTION 'Z_FROM_TO_KNKK'
    TABLES
      t_data_where = lt_data_where
      t_knkk       = lt_knkk. 

  if lt_knkk[] IS not INITIAL.
    move-corresponding lt_knkk[] to I_KNKK[].
  endif.

*<--- S4 Migration - 18/07/2023 - JS
