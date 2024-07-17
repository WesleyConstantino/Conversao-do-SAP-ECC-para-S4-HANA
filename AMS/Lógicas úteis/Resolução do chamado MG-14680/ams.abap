"Vou insereir meu perform na linha 4883 ou 906
*<--- 17/07/2024 - MG-14680  - UAT Mignow - WS * Início
PERFORM zf_corrige_campo_desc_confir.
*<--- 17/07/2024 - MG-14680  - UAT Mignow - WS * Fim

"...

*<--- 17/07/2024 - MG-14680  - UAT Mignow - WS * Início
FORM zf_corrige_campo_desc_confir.

T_SAIDA_AUX TYPE TABLE OF Y_SAIDA.

"Move os dados da tabela T_SAIDA para a T_SAIDA_AUX.
"T_SAIDA_AUX = CORRESPONDING #( T_SAIDA ).
T_SAIDA_AUX[] =  T_SAIDA[].

REFRESH T_SAIDA.

LOOP A T_SAIDA_AUX INTO DATA(W_SAIDA_AUX).

"Pega a descrição correta do campo MAKTX.
 SELECT SINGLE MAKTX
 FROM MAKT
 INTO @DATA(V_MAKTX)
 WHERE MATNR EQ W_SAIDA_AUX-ITEM_MATNR AND
       SPRAS EQ SY-LANGU.

"Limpa a descrição errada do campo DESC_CONFIR.
 CLEAR W_SAIDA_AUX-DESC_CONFIR.

"Passa a descrição correta para o campo DESC_CONFI.
 W_SAIDA_AUX-DESC_CONFIR = V_MAKTX. 

 APPEND W_SAIDA_AUX TO T_SAIDA.
 CLEAR: V_MAKTX,
        W_SAIDA_AUX.
ENDLOOP.

ENDFORM.
*<--- 17/07/2024 - MG-14680  - UAT Mignow - WS * Fim
