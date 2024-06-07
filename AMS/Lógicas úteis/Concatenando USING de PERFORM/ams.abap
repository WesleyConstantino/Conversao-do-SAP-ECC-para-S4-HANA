"Concatenando USING de PERFORM:

" LOOP AT t_lfm1.
*<--- 06/06/2024 -  MG-14023 - UAT Mignow - WS
    v_tabix = sy-tabix.
*<--- 06/06/2024 -  MG-14023 - UAT Mignow - WS

...

*<--- 06/06/2024 -  MG-14023 - UAT Mignow - WS
    DATA(v_tabix_string) = CONV string( v_tabix ).

    CONCATENATE 'LFM1-EKORG' '(' v_tabix_string ')' INTO DATA(v_lfm1_ekorg).
    CONCATENATE 'LFM1-WAERS' '(' v_tabix_string ')' INTO DATA(v_lfm1_waers).
    CONCATENATE 'LFM1-ZTERM' '(' v_tabix_string ')' INTO DATA(v_lfm1_zterm).
    CONCATENATE 'LFM1-INCO1' '(' v_tabix_string ')' INTO DATA(v_lfm1_inco1).
    CONCATENATE 'LFM1-KALSK' '(' v_tabix_string ')' INTO DATA(v_lfm1_kalsk).
    CONCATENATE 'LFM1-MEPRF' '(' v_tabix_string ')' INTO DATA(v_lfm1_meprf).
    CONCATENATE 'LFM1-VERKF' '(' v_tabix_string ')' INTO DATA(v_lfm1_verkf).
    CONCATENATE 'LFM1-TELF1' '(' v_tabix_string ')' INTO DATA(v_lfm1_telf1).
    CONCATENATE 'LFM1-WEBRE' '(' v_tabix_string ')' INTO DATA(v_lfm1_webre).
    CONCATENATE 'LFM1-LFABC' '(' v_tabix_string ')' INTO DATA(v_lfm1_lfabc).
    CONCATENATE 'LFM1-EXPVZ' '(' v_tabix_string ')' INTO DATA(v_lfm1_expvz).
    CONCATENATE 'LFM1-ZOLLA' '(' v_tabix_string ')' INTO DATA(v_lfm1_zolla).
    CONCATENATE 'LFM1-KZABS' '(' v_tabix_string ')' INTO DATA(v_lfm1_kzabs).
    CONCATENATE 'LFM1-KZAUT' '(' v_tabix_string ')' INTO DATA(v_lfm1_kzaut).
    CONCATENATE 'LFM1-PAPRF' '(' v_tabix_string ')' INTO DATA(v_lfm1_paprf).
    CONCATENATE 'LFM1-XNBWY' '(' v_tabix_string ')' INTO DATA(v_lfm1_xnbwy).
    CONCATENATE 'LFM1-NRGEW' '(' v_tabix_string ')' INTO DATA(v_lfm1_nrgew).
    CONCATENATE 'LFM1-AGREL' '(' v_tabix_string ')' INTO DATA(v_lfm1_agrel).
    CONCATENATE 'LFM1-LEBRE' '(' v_tabix_string ')' INTO DATA(v_lfm1_lebre).
    CONCATENATE 'LFM1-VSBED' '(' v_tabix_string ')' INTO DATA(v_lfm1_vsbed).
    CONCATENATE 'LFM1-EKGRP' '(' v_tabix_string ')' INTO DATA(v_lfm1_ekgrp).
    CONCATENATE 'LFM1-PLIFZ' '(' v_tabix_string ')' INTO DATA(v_lfm1_plifz).
    CONCATENATE 'LFM1-MEGRU' '(' v_tabix_string ')' INTO DATA(v_lfm1_megru).
    CONCATENATE 'LFM1-RDPRF' '(' v_tabix_string ')' INTO DATA(v_lfm1_rdprf).
    CONCATENATE 'LFM1-LIBES' '(' v_tabix_string ')' INTO DATA(v_lfm1_libes).
    CONCATENATE 'LFM1-INCO2' '(' v_tabix_string ')' INTO DATA(v_lfm1_inco2).

    PERFORM zf_preenche_bdcdata_new USING:
    ' ' v_lfm1_ekorg w_fornecedor-ekorg,
    ' ' v_lfm1_waers t_lfm1-waers,
    ' ' v_lfm1_zterm t_lfm1-zterm,
    ' ' v_lfm1_inco1 t_lfm1-inco1,
    ' ' v_lfm1_kalsk t_lfm1-kalsk,
    ' ' v_lfm1_meprf t_lfm1-meprf,
    ' ' v_lfm1_verkf t_lfm1-verkf,
    ' ' v_lfm1_telf1 t_lfm1-telf1_dc,
    ' ' v_lfm1_webre t_lfm1-webre,
    ' ' v_lfm1_lfabc t_lfm1-lfabc,
    ' ' v_lfm1_expvz t_lfm1-expvz,
    ' ' v_lfm1_zolla t_lfm1-zolla,
    ' ' v_lfm1_kzabs t_lfm1-kzabs,
    ' ' v_lfm1_kzaut t_lfm1-kzaut,
    ' ' v_lfm1_paprf t_lfm1-paprf,
    ' ' v_lfm1_xnbwy t_lfm1-xnbwy,
    ' ' v_lfm1_nrgew t_lfm1-nrgew,
    ' ' v_lfm1_agrel t_lfm1-agrel,
    ' ' v_lfm1_lebre t_lfm1-lebre,
    ' ' v_lfm1_vsbed t_lfm1-vsbed,
    ' ' v_lfm1_ekgrp t_lfm1-ekgrp,
    ' ' v_lfm1_plifz t_lfm1-plifz,
    ' ' v_lfm1_megru t_lfm1-megru,
    ' ' v_lfm1_rdprf t_lfm1-rdprf,
    ' ' v_lfm1_libes t_lfm1-libes,
    ' ' v_lfm1_inco2 t_lfm1-inco2.

** Dados de compra
*    PERFORM zf_preenche_bdcdata USING:
*    'X' 'SAPMF02K' '0310',
*    ' ' 'BDC_OKCODE' '/00',
*    ' ' 'BDC_CURSOR' 'LFM1-LIBES',
*    ' ' 'LFM1-WAERS' t_lfm1-waers,
*    ' ' 'LFM1-ZTERM' t_lfm1-zterm,
*    ' ' 'LFM1-INCO1' t_lfm1-inco1,
*    ' ' 'LFM1-KALSK' t_lfm1-kalsk,
*    ' ' 'LFM1-MEPRF' t_lfm1-meprf,
*    ' ' 'LFM1-VERKF' t_lfm1-verkf,
** Inicio da Alteração - 1626 – T3RICARDOB – 26/04/06
** ' ' 'LFM1-TELF1' t_lfm1-telf1,
*    ' ' 'LFM1-TELF1' t_lfm1-telf1_dc,
** Final da Alteração - 1626 – T3RICARDOB – 26/04/06
*    ' ' 'LFM1-WEBRE' t_lfm1-webre,
*    ' ' 'LFM1-LFABC' t_lfm1-lfabc,
*    ' ' 'LFM1-EXPVZ' t_lfm1-expvz,
*    ' ' 'LFM1-ZOLLA' t_lfm1-zolla,
*    ' ' 'LFM1-KZABS' t_lfm1-kzabs,
*    ' ' 'LFM1-KZAUT' t_lfm1-kzaut,
*    ' ' 'LFM1-PAPRF' t_lfm1-paprf,
*    ' ' 'LFM1-XNBWY' t_lfm1-xnbwy,
*    ' ' 'LFM1-NRGEW' t_lfm1-nrgew,
*    ' ' 'LFM1-AGREL' t_lfm1-agrel,
*    ' ' 'LFM1-LEBRE' t_lfm1-lebre,
*    ' ' 'LFM1-VSBED' t_lfm1-vsbed,
*    ' ' 'LFM1-EKGRP' t_lfm1-ekgrp,
*    ' ' 'LFM1-PLIFZ' t_lfm1-plifz,
*    ' ' 'LFM1-MEGRU' t_lfm1-megru,
*    ' ' 'LFM1-RDPRF' t_lfm1-rdprf,
*    ' ' 'LFM1-LIBES' t_lfm1-libes,
*    ' ' 'LFM1-INCO2' t_lfm1-inco2.
*<--- 06/06/2024 -  MG-14023 - UAT Mignow - WS

...
...
...

FORM zf_preenche_bdcdata_new USING l_start TYPE any
                                   l_name  TYPE any
                                   l_value TYPE any.

  CLEAR t_bdc.
  MOVE l_start TO t_bdc-dynbegin.
  IF l_start = c_x.
    MOVE:
      l_name  TO t_bdc-program,
      l_value TO t_bdc-dynpro.
  ELSE.
    MOVE:
      l_name  TO t_bdc-fnam,
      l_value TO t_bdc-fval.
  ENDIF.
  APPEND t_bdc.

ENDFORM.
