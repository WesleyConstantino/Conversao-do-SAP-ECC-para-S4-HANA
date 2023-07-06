"Sempre fazer o SORT antes do loop.

*---> 06/07/2023 - Migração S4 - WS
  SORT tl_0013 BY seqnum.
*<--- 06/07/2023 - Migração S4 - WS

 LOOP AT tl_0013.
    ON CHANGE OF tl_0013-seqnum.


***********************************************************************************************
"Outro tipo de caso:

*---> 06/07/2023 - Migração S4 - WS
  SORT lt_mbew BY matnr.
*<--- 06/07/2023 - Migração S4 - WS

  LOOP AT lt_mbew INTO mbew.
  ...
    ON CHANGE OF mbew-matnr.
      PERFORM read_mara USING mbew-matnr werks mbew-bwkey.
    ENDON.
