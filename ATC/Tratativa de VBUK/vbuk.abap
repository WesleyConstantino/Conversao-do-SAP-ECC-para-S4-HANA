* ---> S4 Migration - 09/08/2023 - WS - Inicio

*  SELECT SINGLE wbstk FROM vbuk INTO ex_fin_livr
*              WHERE vbeln EQ im_vbeln.

  SELECT SINGLE wbstk FROM V_vbuk_S4 INTO @ex_fin_livr
              WHERE vbeln EQ @im_vbeln.

* ---> S4 Migration - 09/08/2023 - WS - Fim
