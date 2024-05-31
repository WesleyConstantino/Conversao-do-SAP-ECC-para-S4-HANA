*WS - UAT Mignow - MG-13754 - 29/05/24
*    SELECT COUNT(*)
*      FROM bseg
*      INTO lv_count
*     WHERE bukrs  IN s_bukrs
*       AND gjahr  IN s_gjahr
*       AND belnr  IN s_belnr.

"Types para entrar no For All Entries
   TYPES: BEGIN OF for_all_entries_type,
               belnr TYPE bseg-belnr,
             END OF for_all_entries_type.

      DATA: lt_for_all_entries TYPE TABLE OF for_all_entries_type.
      DATA: ls_for_all_entries LIKE LINE OF lt_for_all_entries.

*Carrega os dados da tabela interna lt_for_all_entries
      READ TABLE s_belnr INTO ls_for_all_entries.
        ls_for_all_entries-belnr = s_belnr-low.
        APPEND ls_for_all_entries TO lt_for_all_entries.
        CLEAR: ls_for_all_entries.

       ls_for_all_entries-belnr = s_belnr-high.
       APPEND ls_for_all_entries TO lt_for_all_entries.
       CLEAR: ls_for_all_entries.

*Trata quando a option do range for BT
       IF s_belnr-option EQ 'BT'.

        DATA v_times TYPE c LENGTH 10.
        v_times = s_belnr-high - s_belnr-low.
        ls_for_all_entries-belnr = s_belnr-low.
        DO v_times TIMES.
          ls_for_all_entries-belnr = ls_for_all_entries-belnr + 1.
          APPEND ls_for_all_entries TO lt_for_all_entries.
        ENDDO.
        CLEAR: ls_for_all_entries.
       ENDIF.

       SORT lt_for_all_entries[].
       DELETE ADJACENT DUPLICATES FROM lt_for_all_entries[].

      DATA lt_bseg TYPE TABLE OF bseg.

      CALL FUNCTION 'FAGL_GET_BSEG_FOR_ALL_ENTRIES'
        EXPORTING
          it_for_all_entries = lt_for_all_entries
          i_where_clause     = |BELNR = IT_FOR_ALL_ENTRIES-BELNR|
        IMPORTING
          et_bseg            = lt_bseg
        EXCEPTIONS
          not_found          = 1.

      IF sy-subrc = 0 AND lines( lt_bseg ) > 0.
       DELETE lt_bseg WHERE gjahr NOT IN s_gjahr.
       DELETE lt_bseg WHERE bukrs NOT IN s_bukrs.
       DELETE lt_bseg WHERE belnr NOT IN s_belnr.

        MOVE-CORRESPONDING lt_bseg[] TO gw_bseg[].
*Faz a contagem de linhas "SELECT CONUT(*)"
        lv_count = LINES( gw_bseg ).
        CLEAR: gw_bseg, lt_for_all_entries.

      ENDIF.
*WS - UAT Mignow - MG-13754 - 29/05/24
