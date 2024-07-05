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
