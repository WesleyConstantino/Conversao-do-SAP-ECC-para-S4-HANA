"Classe CL_NFE_LOGBR_TEXTS -> Método GET_INFADPROD

METHOD if_nfe_logbr_texts~get_infadprod.

    DATA lt_texts_data TYPE REF TO if_logbr_nf_texts_data.
    DATA lt_texts      TYPE logbr_nf_text_tt.
    DATA ls_text       TYPE logbr_nf_texts.

    lt_texts_data = mo_logbr_texts_da->read( iv_docnum ).
    lt_texts = lt_texts_data->get_text_table( ).

    SORT lt_texts BY type DESCENDING counter ASCENDING.

    LOOP AT lt_texts INTO ls_text WHERE ( type = mc_product_add_info OR type = mc_dangerous_goods ) AND itmnum = iv_itemnum.
      CONCATENATE rv_text ls_text-text INTO rv_text SEPARATED BY space.
    ENDLOOP.

    SHIFT rv_text LEFT DELETING LEADING space.

    rv_text = remove_special_characteres( rv_text ).

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""$"$\SE:(1) Classe CL_NFE_LOGBR_TEXTS, Interface IF_NFE_LOGBR_TEXTS, Método GET_INFADPROD, Fim                                                                A
*$*$-Start: (1)---------------------------------------------------------------------------------$*$*
ENHANCEMENT 1  Z_TAG_INFADPROD.    "active version
*---> TICKETS - 30/06/2025 - MG-25111  - WS - Begin

    DATA: lt_texts_aux TYPE logbr_nf_text_tt,
          wa_texts_aux LIKE LINE OF lt_texts_aux,
          lv_itmnum    TYPE c LENGTH 10.

    APPEND LINES OF lt_texts TO lt_texts_aux.
    SORT lt_texts_aux BY itmnum.
    DELETE ADJACENT DUPLICATES FROM lt_texts_aux COMPARING itmnum.
    lv_itmnum = lines( lt_texts_aux ).
    READ TABLE lt_texts_aux INDEX 1 INTO wa_texts_aux.

    DO lv_itmnum TIMES.
    DELETE lt_texts_aux WHERE itmnum = wa_texts_aux-itmnum.

    LOOP AT lt_texts INTO ls_text WHERE ( type = 'P' ) AND itmnum = wa_texts_aux-itmnum.
      CONCATENATE rv_text ls_text-text INTO rv_text SEPARATED BY space.
    ENDLOOP.

    SHIFT rv_text LEFT DELETING LEADING space.
    rv_text = remove_special_characteres( rv_text ).

    READ TABLE lt_texts_aux INDEX 1 INTO wa_texts_aux.
    ENDDO.

*---> TICKETS - 30/06/2025 - MG-25111  - WS - End

ENDENHANCEMENT.
*$*$-End:   (1)---------------------------------------------------------------------------------$*$*
  ENDMETHOD.
