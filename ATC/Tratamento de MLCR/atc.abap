*Exemplo 1:

* ---> S4 Migration -05.07.2024 20:24:10 - AG
*  SELECT belnr kjahr  salk3 stprs_old
*           INTO TABLE t_mlcr
*           FROM mlcr
*           FOR ALL ENTRIES IN t_mlit
*           WHERE belnr  EQ t_mlit-belnr
*           AND   kjahr  IN s_bdatj
*           AND   waers  EQ 'BRL'.

    DATA: lt_mlcr     TYPE TABLE OF mlcr,
          lt_mlhd     TYPE TABLE OF mlhd,
          lt_mlmst    TYPE TABLE OF mlmst,
          lt_mlit_aux TYPE TABLE OF mlit,
          lt_mlpp     TYPE TABLE OF mlpp,
          lt_mlppf    TYPE TABLE OF mlppf,
          lt_mlcrf    TYPE TABLE OF mlcrf,
          lt_mlcrp    TYPE TABLE OF mlcrp,
          lt_result   TYPE TABLE OF mlcr.

    DATA: ls_mlit TYPE mlit,
          wa_mlcr TYPE mlcr.

    LOOP AT t_mlit INTO ls_mlit.
      REFRESH: lt_mlcr, lt_mlhd, lt_mlmst, lt_mlit_aux, lt_mlpp, lt_mlppf, lt_mlcrf, lt_mlcrp.

      CALL FUNCTION 'CKML_F_DOCUMENT_READ_MLXX'
        EXPORTING
          i_belnr     = ls_mlit-belnr
          i_kjahr     = ls_mlit-kjahr
        TABLES
          t_mlhd      = lt_mlhd
          t_mlmst     = lt_mlmst
          t_mlit      = lt_mlit_aux
          t_mlpp      = lt_mlpp
          t_mlppf     = lt_mlppf
          t_mlcr      = lt_mlcr
          t_mlcrf     = lt_mlcrf
          t_mlcrp     = lt_mlcrp
        EXCEPTIONS
          no_document = 1.

      IF sy-subrc = 0.
        DELETE lt_mlcr WHERE waers NE 'BRL'.

        LOOP AT lt_mlcr INTO wa_mlcr.
          APPEND wa_mlcr TO lt_result.
        ENDLOOP.
      ENDIF.
    ENDLOOP.
* <--- S4 Migration -05.07.2024 20:24:10 - AG


*...........................................................................*


*Exemplo 2:

*<---03/01/2025 - Migração S4 - WS
*  select * from mlcd into table lt_mlcd
*    where kalnr = v_kalnr
*    and bdatj   = lh_bdatj
*    and poper   = lh_poper
*    and untper  = lh_untper
*    and  ( ptyp = 'BF' or ptyp = 'BU' or ptyp = 'BL' )
*    and   categ ne 'AB'
*    and   curtp = lh_curtp.

    DATA: lt_kalnr1 TYPE ckmv0_matobj_tbl,
          lt_mlcd   TYPE ckmcd_t_mlcd,
          wa_kalnr1 TYPE ckmv0_matobj_str.

    wa_kalnr1-kalnr = v_kalnr.
    APPEND wa_kalnr1 TO lt_kalnr1.

    CALL FUNCTION 'Z_MLDOC_MLCD'
      EXPORTING
        i_from_bdatj = lh_bdatj
        i_from_poper = lh_poper
*       I_TO_BDATJ   = "Utilizar caso tenha itervalo de periodo
*       I_TO_POPER   = "Utilizar caso tenha itervalo de periodo
       I_UNTPER     =  lh_untper
        i_curtp      = lh_curtp
        it_kalnr     = lt_kalnr1
      IMPORTING
        ot_mlcd      = lt_mlcd.

    IF lt_mlcd IS NOT INITIAL.
      DELETE lt_mlcd WHERE ptyp NE 'BF' or ptyp NE 'BU' or ptyp NE 'BL'.
      DELETE lt_mlcd WHERE categ EQ 'AB'.
      MOVE lt_mlcd TO lt_mlcd.
    ENDIF.
*<---03/01/2025 - Migração S4 - WS



*...........................................................................*


*Exemplo 3:


*<---03/01/2025 - Migração S4 - WS
*    select * from mlcd appending table lt_mlcd4
*      where kalnr  eq lf_mat_sum-kalnr_mat
*        and bvalt  eq lf_mat_list-kalnr_bal
*        and bdatj  eq lh_bdatj
*        and poper  eq lh_poper
*        and untper eq lh_untper
*        and categ  ne 'AB'
*        and curtp  eq lh_curtp.

    DATA: lt_kalnr1 TYPE ckmv0_matobj_tbl,
          lt_mlcd   TYPE ckmcd_t_mlcd,
          wa_kalnr1 TYPE ckmv0_matobj_str,
          ls_mlcd4  TYPE mlcd.

    wa_kalnr1-kalnr = lf_mat_sum-kalnr_mat.
    APPEND wa_kalnr1 TO lt_kalnr1.

    CALL FUNCTION 'Z_MLDOC_MLCD'
      EXPORTING
        i_from_bdatj = lh_bdatj
        i_from_poper = lh_poper
*       I_TO_BDATJ   = "Utilizar caso tenha itervalo de periodo
*       I_TO_POPER   = "Utilizar caso tenha itervalo de periodo
        i_untper     = lh_untper
        i_curtp      = lh_curtp
        it_kalnr     = lt_kalnr1
      IMPORTING
        ot_mlcd      = lt_mlcd.

    IF lt_mlcd IS NOT INITIAL.
      DELETE lt_mlcd WHERE bvalt NE lf_mat_list-kalnr_bal.
      DELETE lt_mlcd WHERE categ EQ 'AB'.

      LOOP AT lt_mlcd INTO DATA(ls_mlcd).
        CLEAR ls_mlcd4.
        MOVE-CORRESPONDING ls_mlcd TO ls_mlcd4.
        APPEND ls_mlcd4 TO lt_mlcd4.
      ENDLOOP.
    ENDIF.
*<---03/01/2025 - Migração S4 - WS
