  SELECT pernr
     INTO i_pernr
     FROM kbed
    WHERE aufpl EQ g_aufpl                             
      AND aplzl EQ g_aplzl                               
      AND pernr NE ''.
* ---> S4 Migration - 15/08/2023 - WS - Inicio     
     AND ( TYPKZ EQ 1
     OR  TYPKZ EQ 2
     OR  TYPKZ EQ 3 ).
* ---> S4 Migration - 15/08/2023 - WS - Fim
