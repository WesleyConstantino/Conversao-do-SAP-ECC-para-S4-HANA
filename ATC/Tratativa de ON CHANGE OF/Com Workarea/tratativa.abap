*---> 06/07/2023 - Migração S4 - WS
  SORT tw_saida BY posnr.
*<--- 06/07/2023 - Migração S4 - WS

 LOOP AT tw_saida INTO w_saida.

... 

  ON CHANGE OF w_saida-txt50 OR w_saida-posnr.
        PERFORM add_anln1_line USING     w_saida
                                         l_txttipo_key
                                CHANGING l_anln1_key.
  ENDON.
