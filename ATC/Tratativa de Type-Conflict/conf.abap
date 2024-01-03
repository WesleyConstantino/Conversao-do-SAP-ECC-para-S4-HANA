"O Type-Conflict ocorre normalmente por diferença de tamanho de variáveis ou campos, resolvemos isso igualando o tamanho da variável do
"nosso programa com o tamanho do parâmetro da função. 

*******************************************
"Como tratar:
"Mover valor do maior para o menor CONV() 
"Mover valor do menor para o maior PRAGMA
********************************************


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
