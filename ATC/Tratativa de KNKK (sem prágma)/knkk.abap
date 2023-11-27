*--> 27/11/2023 - Migração S4 -WS
*  SELECT *
*    FROM knkk
*    INTO TABLE t_knkk
*     FOR ALL ENTRIES IN t_arq_aux
*   WHERE kkber = p_kkber AND
*         knkli = t_arq_aux-conta_credito.


        DATA: t_knkk_aux_68   TYPE STANDARD TABLE OF knkk, "#EC CI_USAGE_OK[2227014]'
              t_data_where_68 TYPE STANDARD TABLE OF zstsd_knkk_key,
              w_data_where_68 TYPE zstsd_knkk_key.

        LOOP AT t_arq_aux INTO DATA(w_for_all_54).
          w_data_where_68-kunnr = w_for_all_54-CONTA_CREDITO.
          APPEND w_data_where_68 TO t_data_where_68.
        ENDLOOP.

        IF t_data_where_68 IS NOT INITIAL.
          DELETE t_data_where_68 WHERE kkber NE p_kkber.
        ENDIF.

        CALL FUNCTION 'ZFSD_SELECT_KNKK'
          TABLES
            t_data_where = t_data_where_68
            t_knkk       = t_knkk_aux_68.

        IF t_knkk_aux_68[] IS NOT INITIAL.

          MOVE t_knkk_aux_68[] TO t_knkk[].
          sy-dbcnt = lines( t_knkk_aux_68 ).
          sy-subrc = 0.
        ELSE.
          sy-subrc = 4.
          sy-dbcnt = 0.
        ENDIF.
*--> 27/11/2023 - Migração S4 -WS
