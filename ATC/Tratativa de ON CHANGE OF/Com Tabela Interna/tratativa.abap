"Sempre fazer o SORT antes do loop.

*---> 06/07/2023 - Migração S4 - WS
  SORT tl_0013 BY seqnum.
*<--- 06/07/2023 - Migração S4 - WS

 LOOP AT tl_0013.
    ON CHANGE OF tl_0013-seqnum.
