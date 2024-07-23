"Vou insereir meu perform na linha 4883 ou 906


***************Exemplo não performatico:****************

*<--- 17/07/2024 - MG-14680  - UAT Mignow - WS * Início
PERFORM zf_corrige_campo_desc_confir.
*<--- 17/07/2024 - MG-14680  - UAT Mignow - WS * Fim

"...

*<--- 17/07/2024 - MG-14680  - UAT Mignow - WS * Início
FORM zf_corrige_campo_desc_confir.

DATA T_SAIDA_AUX TYPE TABLE OF Y_SAIDA.

"Move os dados da tabela T_SAIDA para a T_SAIDA_AUX.
"T_SAIDA_AUX = CORRESPONDING #( T_SAIDA ).
T_SAIDA_AUX[] =  T_SAIDA[].

REFRESH T_SAIDA.

LOOP AT T_SAIDA_AUX INTO DATA(W_SAIDA_AUX).

"Pega a descrição correta do campo MAKTX.
 SELECT SINGLE MAKTX
 FROM MAKT
 INTO @DATA(V_MAKTX)
" WHERE MATNR EQ @W_SAIDA_AUX-ITEM_MATNR AND
 WHERE MATNR EQ @W_SAIDA_AUX-ITEM_CONFIR AND
       SPRAS EQ @SY-LANGU.

"Limpa a descrição errada do campo DESC_CONFIR.
 CLEAR W_SAIDA_AUX-DESC_CONFIR.

"Passa a descrição correta para o campo DESC_CONFI.
 W_SAIDA_AUX-DESC_CONFIR = V_MAKTX. 

 APPEND W_SAIDA_AUX TO T_SAIDA.
 CLEAR: V_MAKTX,
        W_SAIDA_AUX.
ENDLOOP.

ENDFORM.

ENDFORM.
*<--- 17/07/2024 - MG-14680  - UAT Mignow - WS * Fim


*****************Exemplo performatico:*****************

*<--- 17/07/2024 - MG-14680  - UAT Mignow - WS * Início
PERFORM zf_corrige_campo_desc_confir.
*<--- 17/07/2024 - MG-14680  - UAT Mignow - WS * Fim

"...

*<--- 17/07/2024 - MG-14680  - UAT Mignow - WS * Início
FORM zf_corrige_campo_desc_confir.

  SELECT matnr,
         maktx
    FROM makt
    INTO TABLE @DATA(t_makt)
     FOR ALL ENTRIES IN t_saida
   WHERE matnr EQ t_saida-ITEM_CONFIR
     AND spras EQ sy-langu.

  LOOP AT t_saida ASSIGNING FIELD-SYMBOL(<fs_saida>).
    <fs_saida>-desc_confir = VALUE #( t_makt[ matnr = <fs_saida>-ITEM_CONFIR ]-maktx OPTIONAL ).
  ENDLOOP.

ENDFORM.
*<--- 17/07/2024 - MG-14680  - UAT Mignow - WS * Fim



*****************Exemplo performatico atualizado:*****************


***Declarações globais:
*<--- 23/07/2024 - MG-14680  - UAT Mignow - WS * Início
*Types
TYPES: BEGIN OF ty_matnr,
         matnr TYPE c LENGTH 18, 
       END OF ty_matnr.

*Tabelas e Workareas
DATA t_matnr TYPE TABLE OF ty_matnr WITH HEADER LINE.
*<--- 23/07/2024 - MG-14680  - UAT Mignow - WS * Fim


"...


*<--- 23/07/2024 - MG-14680  - UAT Mignow - WS * Início
PERFORM zf_corrige_campo_desc_confir.
*<--- 23/07/2024 - MG-14680  - UAT Mignow - WS * Fim


"...


*<--- 23/07/2024 - MG-14680  - UAT Mignow - WS * Início
FORM zf_corrige_campo_desc_confir.

"Converte o campo matnr para a seleção da makt
PERFORM zf_trata_matnr.

  SELECT matnr,
         maktx
    FROM makt
    INTO TABLE @DATA(t_makt)
     FOR ALL ENTRIES IN t_matnr
   WHERE matnr EQ t_matnr-matnr
     AND spras EQ sy-langu.

  LOOP AT t_saida ASSIGNING FIELD-SYMBOL(<fs_saida>).
    <fs_saida>-desc_confir = VALUE #( t_makt[ matnr = <fs_saida>-ITEM_CONFIR ]-maktx OPTIONAL ).
  ENDLOOP.

ENDFORM.
*<--- 23/07/2024 - MG-14680  - UAT Mignow - WS * Fim

"...


*<--- 23/07/2024 - MG-14680  - UAT Mignow - WS * Início
FORM zf_trata_matnr.

LOOP AT t_saida ASSIGNING FIELD-SYMBOL(<fs_saida>).
 
"Remove zeros à esquerda
 SHIFT fs_saida-ITEM_CONFIR LEFT DELETING LEADING '0'. 

"Faz a contagem de quantos zeros deverão ser adicionados
 DATA(v_times) = strlen( fs_saida-ITEM_CONFIR ).
 v_times = '18' - v_times.

"Adiciona os zeros
 DO v_times TIMES.
   CONCATENATE DATA(v_zeros) '0' INTO v_zeros.
 ENDDO.

"Concatena os zeros e o matnr
 fs_saida-ITEM_CONFIR = v_zeros && fs_saida-ITEM_CONFIR. 

"Passa o valor convertido para a linha
 t_matnr-matnr = fs_saida-ITEM_CONFIR.

"Apenda na tabela
 APPEND t_matnr.
 CLEAR v_matnr.

ENDLOOP.

ENDFORM.
*<--- 23/07/2024 - MG-14680  - UAT Mignow - WS * Fim
