* ---> S4 Migration - 17/07/2023 - WS - Inicio

*BUSCA NA BSEG OS REGISTRO DE DEBITO E CREDITO PARA O NUM. DO DOCUMENTO INFORMADO.
*  CLEAR: IT_BSEG, WA_BSEG.
*  SELECT BUKRS BELNR GJAHR HKONT DMBTR BSCHL HBKID
*    INTO TABLE IT_BSEG
*    FROM BSEG
*    WHERE BUKRS IN S_BUKRS
*      AND BELNR IN S_BELNR
*      AND GJAHR IN S_GJAHR
*      AND ( BSCHL = C_40
*         OR BSCHL = C_50 ).

  DATA lt_bseg TYPE TABLE OF bseg.

  CALL FUNCTION 'FAGL_GET_BSEG_FOR_ALL_ENTRIES'
    EXPORTING
      i_where_clause = |BUKRS = S_BUKRS BELNR = S_BELNR AND GJAHR = S_GJAHR|
    IMPORTING
      et_bseg        = lt_bseg
    EXCEPTIONS
      not_found      = 1.

  IF sy-subrc = 0 AND lines( lt_bseg ) > 0.
    DELETE lt_bseg WHERE bschl NE c_40 OR bschl NE c_50.

    MOVE-CORRESPONDING lt_bseg[] TO it_bseg[].
  ENDIF.

* <--- S4 Migration - 17/07/2023 - WS - Fim
