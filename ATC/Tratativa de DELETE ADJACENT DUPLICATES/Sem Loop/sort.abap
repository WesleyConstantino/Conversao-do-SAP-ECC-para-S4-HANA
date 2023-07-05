"Explicação: Sempre que tiver DELETE ADJACENT DUPLICATES, colocar um SORT como abaixo:

 SELECT * INTO TABLE it_dre_c FROM zgl015_dre_est04.
      
*---> 04/07/2023 - Migração S4 - WS
    SORT it_dre_c BY ktopl saknr kosar.
*<--- 04/07/2023 - Migração S4 - WS
      
    PERFORM mostra_texto USING 'Pesquisa: DRE - Lucro'.
    SELECT * INTO TABLE it_dre_l FROM zgl015_dre_est05.
      
*---> 04/07/2023 - Migração S4 - WS
    SORT it_dre_l BY ktopl saknr kokrs prctr.
*<--- 04/07/2023 - Migração S4 - WS
      
    PERFORM mostra_texto USING 'Pesquisa: DRE - G. Mercadoria'.
    SELECT * INTO TABLE it_dre_m FROM zgl015_dre_est06.
      
*---> 04/07/2023 - Migração S4 - WS
    SORT it_dre_m BY ktopl saknr matkl.
*<--- 04/07/2023 - Migração S4 - WS
      
    DELETE ADJACENT DUPLICATES FROM it_dre_c COMPARING ktopl saknr kosar. "#EC CI_SORTED
    DELETE ADJACENT DUPLICATES FROM it_dre_l COMPARING ktopl saknr kokrs prctr. "#EC CI_SORTED
    DELETE ADJACENT DUPLICATES FROM it_dre_m COMPARING ktopl saknr matkl. "#EC CI_SORTED
