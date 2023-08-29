*******************************************************************
"Exemplo 1:

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




*******************************************************************
"Exemplo 2:

* ---> S4 Migration - 29/08/23 - WS

    "Seleciona o status da remessa
*    SELECT SINGLE vbeln
*                  kostk
*                  lvstk
*      INTO wa_status
*      FROM vbuk
*      WHERE vbeln = p_remessa.

    SELECT SINGLE vbeln,
                  kostk,
                  lvstk
      INTO @wa_status
      FROM V_vbuk_S4
      WHERE vbeln = @p_remessa.

