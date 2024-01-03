"O Type-Conflict ocorre normalmente por diferença de tamanho de variáveis ou campos, resolvemos isso igualando o tamanho da variável do
"nosso programa com o tamanho do parâmetro da função. 

******************************************************
"Como tratar:
"para um campo MENOR usar o CONV.
"para  um campo MAIOR usar PRAGMA.

"40 = 18 = conv
"18 = 40 = pragma

"Ex:
"po_item-material      = w_config_cte-matnr.
"    18                                    40  CONV
*******************************************************
"po_item-material      = w_config_cte-matnr.
"    35                                    40  CONV
*******************************************************
*******************************************************


"Exemplo 1:

*--> 28/09/2023 - Migração S4 -WS
DATA l_objectkey TYPE OBJKY.
l_objectkey = CONV #( v_objectkey ).            
*--> 28/09/2023 - Migração S4 -WS            

            CALL FUNCTION 'ZFDM_BLOQUEIO_ANEXO'
              EXPORTING
                code_trans = sy-tcode
                obj_lig    = w_ztbdm_doc_liga-obj_lig
*--> 28/09/2023 - Migração S4 -WS                  
*                objectkey  = v_objectkey
                objectkey  = l_objectkey
*--> 28/09/2023 - Migração S4 -WS                  
              EXCEPTIONS
                bloquear   = 1.



"Exemplo 2:

    CALL FUNCTION 'DOKUMENTE_ZU_OBJEKT'
      EXPORTING
*--> 28/09/2023 - Migração S4 -WS
*        key           = c_key
        key           = CONV DRAD-OBJKY( c_key )
*--> 28/09/2023 - Migração S4 -WS
        objekt        = 'QINF'
*       MANDT         = SY-MANDT
      TABLES
        doktab        = g_doktab
      EXCEPTIONS
        kein_dokument = 1.
