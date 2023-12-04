*--> 04/12/2023 - Migração S4 -WS
*      SELECT kwert INTO xekpo-kwert
*                   FROM konv
*                   UP TO 1 ROWS
*                  WHERE knumv = komk-knumv
*                    AND kposn = komp-kposn
*                    AND kschl = 'ZICC'.
*      ENDSELECT.

      SELECT kwert UP TO 1 ROWS
        FROM v_konv_cds
        INTO xekpo-kwert
                  WHERE knumv = komk-knumv
                    AND kposn = komp-kposn
                    AND kschl = 'ZICC'.

      ENDSELECT.

*--> 04/12/2023 - Migração S4 -WS
