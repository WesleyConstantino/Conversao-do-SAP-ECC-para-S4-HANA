*Solução: subistir a tabela j_1bbranch pela p_businessplac (nos selectis). Quando for declaração, apenas inserir prágma.

"Ex SELECTS:

*---> 11/04/2024 - Migração S4 - RJ
*  SELECT *
*    FROM j_1bbranch
*    INTO ls_j_1bbranch
*    UP TO 1 ROWS
*    WHERE bukrs      EQ iv_bukrs
*      AND cgc_branch EQ iv_nrinsc+8(4).
*  ENDSELECT.
    SELECT *
    FROM p_businessplace UP TO 1 ROWS
    INTO CORRESPONDING FIELDS OF @ls_j_1bbranch
    WHERE bukrs      EQ @iv_bukrs
      AND cgc_branch EQ @iv_nrinsc+8(4).
  ENDSELECT.
*<--- 11/04/2024 - Migração S4 - RJ


*---> 12/04/2024 - Migração S4 - RJ
*  SELECT COUNT( * )
*    FROM j_1bbranch
*   WHERE bukrs EQ iv_bukrs.

  SELECT COUNT( * )
    FROM p_businessplace
    WHERE bukrs EQ @iv_bukrs.
*<--- 12/04/2024 - Migração S4 - RJ

"Ex prágma:

  DATA:  w_j1bbranch TYPE j_1bbranch.  "#EC CI_USAGE_OK[3404390]
