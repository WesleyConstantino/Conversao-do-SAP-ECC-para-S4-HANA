* ---> S4 Migration -05.07.2024 19:30:29 - AG
*    SELECT belnr kjahr matnr kalnr psart ptyp kategorie
*           INTO TABLE t_mlit
*           FROM mlit
*           FOR ALL ENTRIES IN it_mlcd
*           WHERE kalnr     = it_mlcd-kalnr
*            AND  kjahr     IN s_bdatj
*            AND  bwkey     IN s_bwkey.

    DATA: lt_mlit TYPE TABLE OF mlit.

    SELECT *
      FROM mldoc
      INTO TABLE @DATA(t_mldoc)
      FOR ALL ENTRIES IN @it_mlcd
        WHERE kjahr IN @s_bdatj AND
              kalnr = @it_mlcd-kalnr.

    IF sy-subrc IS INITIAL.

      CALL FUNCTION 'ML4H_MLDOC_TO_OLD'
        IMPORTING
          et_mlit  = lt_mlit
        CHANGING
          ct_mldoc = t_mldoc.

      DELETE lt_mlit WHERE bwkey NOT IN s_bwkey.

      MOVE-CORRESPONDING lt_mlit[] TO t_mlit[].
    ENDIF.
* <--- S4 Migration -05.07.2024 19:30:29 - AG
