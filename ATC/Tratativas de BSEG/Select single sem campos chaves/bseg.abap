"Exemplo 1:

* ---> S4 Migration - 27/09/2023 - DL - Inicio
*        SELECT SINGLE bukrs
*                      belnr
*                      gjahr
*                      buzei
*          FROM bseg
*          INTO  w_bseg
*          WHERE vbeln EQ w_i_doc-nfat.

    TYPES: BEGIN OF ty_param,
             vbeln TYPE bseg-vbeln,
           END OF ty_param.


    DATA: lt_bseg_aux TYPE TABLE OF bseg,
          lt_fields   TYPE fagl_t_field,
          lt_param    TYPE TABLE OF ty_param.

    lt_fields = VALUE #( ( line = 'BUKRS' )
                         ( line = 'BELNR' )
                         ( line = 'GJAHR' )
                         ( line = 'BUZEI' ) ).

    APPEND INITIAL LINE TO lt_param ASSIGNING FIELD-SYMBOL(<fs_param>).
<fs_param>-vbeln = w_i_doc-nfat.



    CALL FUNCTION 'FAGL_GET_BSEG_FOR_ALL_ENTRIES'
      EXPORTING
        it_for_all_entries = lt_param
        i_where_clause     = |VBELN = IT_FOR_ALL_ENTRIES-VBELN|
        it_fieldlist       = lt_fields
      IMPORTING
        et_bseg            = lt_bseg_aux
      EXCEPTIONS
        not_found          = 1
    invalid_call     = 2
    others         = 3.


    IF sy-subrc IS INITIAL AND lines( lt_bseg_aux ) > 0.
      READ TABLE lt_bseg_aux INTO DATA(w_bseg_aux) INDEX 1.
      IF sy-subrc = 0.
        w_bseg-bukrs = w_bseg_aux-bukrs.
        w_bseg-belnr = w_bseg_aux-belnr.
        w_bseg-gjahr = w_bseg_aux-gjahr.
        w_bseg-buzei = w_bseg_aux-buzei.
      ENDIF.
    ENDIF.
* <--- S4 Migration - 27/09/2023 - DL - Fim

*...........................................................................................................................*
"Exemplo 2: 

*<--- 16/01/2024 - Migração S4 - WS
*            SELECT SINGLE buzei
*              FROM bseg
*              INTO lv_buzei
*             WHERE bukrs EQ ls_bkpf-bukrs
*               AND belnr EQ ls_bkpf-belnr
*               AND gjahr EQ ls_bkpf-gjahr
*               AND koart EQ 'K'.

    TYPES: BEGIN OF ty_param,
             bukrs TYPE bseg-bukrs,
             belnr TYPE bseg-belnr,
             gjahr TYPE bseg-gjahr,
             koart TYPE bseg-koart,
           END OF ty_param.


    DATA: lt_bseg_aux TYPE TABLE OF bseg,
          lt_fields   TYPE fagl_t_field,
          lt_param    TYPE TABLE OF ty_param.

    lt_fields = VALUE #( ( line = 'BUZEI' ) ).

    APPEND INITIAL LINE TO lt_param ASSIGNING FIELD-SYMBOL(<fs_param>).
<fs_param>-bukrs = ls_bkpf-bukrs.
<fs_param>-belnr = ls_bkpf-belnr.
<fs_param>-gjahr = ls_bkpf-gjahr.
<fs_param>-koart = 'K'..



    CALL FUNCTION 'FAGL_GET_BSEG_FOR_ALL_ENTRIES'
      EXPORTING
        it_for_all_entries = lt_param
        i_where_clause     = |BUZEI = IT_FOR_ALL_ENTRIES-BUZEI|
        it_fieldlist       = lt_fields
      IMPORTING
        et_bseg            = lt_bseg_aux
      EXCEPTIONS
        not_found          = 1
    invalid_call     = 2
    others         = 3.


    IF sy-subrc IS INITIAL AND lines( lt_bseg_aux ) > 0.
      READ TABLE lt_bseg_aux INTO DATA(w_bseg_aux) INDEX 1.
      IF sy-subrc = 0.
        lv_buzei = w_bseg_aux-buzei.
      ENDIF.
    ENDIF.
*<--- 16/01/2024 - Migração S4 - WS
