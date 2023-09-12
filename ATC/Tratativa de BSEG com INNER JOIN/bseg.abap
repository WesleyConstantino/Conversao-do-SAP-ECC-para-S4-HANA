* ---> S4 Migration - 12/09/2023 - WS

*    SELECT bseg~bukrs,
*           bseg~vertn,
*           bseg~valut,
*           bseg~bschl,
*           bseg~hkont,
*           bseg~sgtxt,
*           bkpf~tcode,
*           bseg~dmbtr
*      FROM bseg
*     INNER JOIN bkpf ON bkpf~bukrs = bseg~bukrs AND
*                        bkpf~belnr = bseg~belnr AND
*                        bkpf~gjahr = bseg~gjahr
*       FOR ALL ENTRIES IN @tg_vtbfha
*     WHERE bseg~bukrs = @tg_vtbfha-bukrs
*       AND bseg~vertn = @tg_vtbfha-rfha
*       AND bseg~valut = @p_dtlan
*       AND bkpf~tcode IN ('TPM1', 'TPM18')
*      INTO TABLE @tg_dados.

    DATA: lt_bseg_1 TYPE TABLE OF bseg,
          wa_dados  LIKE LINE OF tg_dados.

    CALL FUNCTION 'FAGL_GET_BSEG_FOR_ALL_ENTRIES'
      EXPORTING
        it_for_all_entries = tg_vtbfha
        i_where_clause     = |BUKRS = IT_FOR_ALL_ENTRIES-BUKRS AND VERTN = IT_FOR_ALL_ENTRIES-RFHA|
      IMPORTING
        et_bseg            = lt_bseg_1
      EXCEPTIONS
        not_found          = 1.


    DELETE lt_bseg_1 WHERE valut NE p_dtlan.

    IF sy-subrc = 0 AND lines( lt_bseg_1 ) > 0.

      SELECT tcode,
             bukrs,
             belnr,
             gjahr
        FROM bkpf
        INTO TABLE @DATA(t_bkpf_aux)
        FOR ALL ENTRIES IN @lt_bseg_1
        WHERE bukrs EQ @lt_bseg_1-bukrs AND
              belnr EQ @lt_bseg_1-belnr AND
              gjahr EQ @lt_bseg_1-gjahr AND
              tcode IN ('TPM1', 'TPM18').

      LOOP AT lt_bseg_1 INTO DATA(wa_bseg_1).
        READ TABLE t_bkpf_aux INTO DATA(wa_bkpf_aux) WITH KEY bukrs = wa_bseg_1-bukrs
                                                              belnr = wa_bseg_1-belnr
                                                              gjahr = wa_bseg_1-gjahr.

        IF sy-subrc EQ 0.
          wa_dados-bukrs = wa_bseg_1-bukrs.
          wa_dados-vertn = wa_bseg_1-vertn.
          wa_dados-valut = wa_bseg_1-valut.
          wa_dados-bschl = wa_bseg_1-bschl.
          wa_dados-hkont = wa_bseg_1-hkont.
          wa_dados-sgtxt = wa_bseg_1-sgtxt.
          wa_dados-tcode = wa_bkpf_aux-tcode.
          wa_dados-dmbtr = wa_bseg_1-dmbtr.

          APPEND wa_dados TO tg_dados.
       endif.
        ENDLOOP.
      ENDIF.

* ---> S4 Migration - 12/09/2023 - WS
