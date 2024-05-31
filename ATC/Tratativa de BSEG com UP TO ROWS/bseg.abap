*WS - UAT Mignow - MG-13754 - 29/05/24
*      SELECT *
*        FROM bseg
*        UP TO p_qtd ROWS
*        INTO TABLE gw_bseg
*       WHERE bukrs  IN s_bukrs
*         AND gjahr  IN s_gjahr
*         AND belnr  IN s_belnr.

*      DATA: lt_bseg TYPE fagl_t_bseg,

*Carrega os dados da tabela interna lt_for_all_entries
      READ TABLE s_belnr INTO ls_for_all_entries.
        ls_for_all_entries-belnr = s_belnr-low.
        APPEND ls_for_all_entries TO lt_for_all_entries.
        CLEAR: ls_for_all_entries.

       ls_for_all_entries-belnr = s_belnr-high.
       APPEND ls_for_all_entries TO lt_for_all_entries.
       CLEAR: ls_for_all_entries.

       SORT lt_for_all_entries[].
       DELETE ADJACENT DUPLICATES FROM lt_for_all_entries[].

      CALL FUNCTION 'FAGL_GET_BSEG_FOR_ALL_ENTRIES'
        EXPORTING
          it_for_all_entries = lt_for_all_entries
          i_where_clause     = |BELNR = IT_FOR_ALL_ENTRIES-BELNR|
        IMPORTING
          et_bseg            = lt_bseg
        EXCEPTIONS
          not_found          = 1.

      IF sy-subrc = 0 AND lt_bseg IS NOT INITIAL.
       DATA: lv_tabix TYPE cats_tabix.

       DELETE lt_bseg WHERE gjahr NOT IN s_gjahr.
       DELETE lt_bseg WHERE bukrs NOT IN s_bukrs.
       DELETE lt_bseg WHERE belnr NOT IN s_belnr.

*DO com a quantidade de vezes do UP TO ROWS
        DO p_qtd TIMES.
          ADD 1 TO lv_tabix.

          READ TABLE lt_bseg INTO DATA(lw_bseg) INDEX lv_tabix.
          IF sy-subrc = 0.
            APPEND lw_bseg TO gw_bseg.
            CLEAR lw_bseg.
          ENDIF.

*Condição para sair do loop quando o número de registros for menor que o UP TO ROWS
          IF lines( lt_bseg ) < lv_tabix.
            EXIT.
          ENDIF.
        ENDDO.
      ENDIF.

      CLEAR: gw_bseg, lt_for_all_entries.

*---> S4 MIGRATION 03/04/2024 - MA
