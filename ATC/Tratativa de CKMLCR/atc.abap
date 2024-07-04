
*Forma nova (substituir pela CDS View ZCDSML_TOT): .............................................................

*WS - Migração Mignow - 03/07/24
*      SELECT SINGLE stprs stprs
*        INTO (vl_pvprs, vl_stprs)
*        FROM ckmlcr
*        WHERE kalnr = vl_kaln1 AND
*              bdatj = vl_bdatj AND
*              poper = vl_poper AND
*              untper = 0 AND
*              curtp = '40'.

      SELECT SINGLE stprs stprs
        INTO (vl_pvprs, vl_stprs)
        FROM ZCDSML_TOT
        WHERE kalnr = vl_kaln1 AND
              bdatj = vl_bdatj AND
              poper = vl_poper AND
              untper = 0 AND
              curtp = '40'.
*WS - Migração Mignow - 03/07/24



*Forma antiga: .............................................................................................

*---> 212/09/2023 - Migração S4 - FTM
  DATA: t_kalnr_s4  TYPE ckmv0_matobj_tbl,
        t_ckmlcr_s4 TYPE TABLE OF ckmlcr.
*<--- 22/09/2023 - Migração S4 - FTM


*---> 22/09/2023 - Migração S4 - FTM
* SELECT SINGLE kalnr bdatj poper curtp peinh stprs pvprs
* FROM ckmlcr INTO wa_ckmlcr
* WHERE kalnr = wa_numcalccusto-kalnr
* AND bdatj = vg_anopd
* AND poper = vg_poperpd
* AND curtp = c_10.

        APPEND INITIAL LINE TO t_kalnr_s4 ASSIGNING FIELD-SYMBOL(<f_kalnr_s4>).
        IF <f_kalnr_s4> IS ASSIGNED.
          <f_kalnr_s4>-kalnr = wa_numcalccusto-kalnr.
        ENDIF.

        IF t_kalnr_s4[] IS NOT INITIAL.

          FREE: t_ckmlcr_s4[].
          CALL FUNCTION 'CKMS_PERIOD_READ_WITH_ITAB'
            EXPORTING
              i_bdatj_1               = vg_ano
              i_poper_1               = vg_poper
            TABLES
              t_kalnr                 = t_kalnr_s4
              t_ckmlcr                = t_ckmlcr_s4
            EXCEPTIONS
              no_data_found           = 1
              input_data_inconsistent = 2
              buffer_inconsistent     = 3
              OTHERS                  = 4.
          IF sy-subrc EQ 0.
            DELETE t_ckmlcr_s4 WHERE curtp NE c_10.
            READ TABLE t_ckmlcr_s4 INTO DATA(w_ckmlcr_s4) INDEX 1.
            IF sy-subrc EQ 0.
              MOVE-CORRESPONDING w_ckmlcr_s4 TO wa_ckmlcr.
            ENDIF.
          ENDIF.

        ENDIF.
*<--- 22/09/2023 - Migração S4 - FTM
