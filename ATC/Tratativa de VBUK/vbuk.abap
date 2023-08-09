* ---> S4 Migration - 09/08/2023 - WS - Inicio

*      SELECT SINGLE vbeln FROM vbuk INTO wa_livr-vbeln
*                  WHERE vbeln EQ wa_livr-vbeln
*                    AND wbstk NE 'C'
*                    AND wbstk NE 'B'.

      SELECT SINGLE vbeln FROM V_vbuk_S4 INTO @wa_livr-vbeln
                  WHERE vbeln EQ @wa_livr-vbeln
                    AND wbstk NE 'C'
                    AND wbstk NE 'B'.

* ---> S4 Migration - 09/08/2023 - WS - Fim
