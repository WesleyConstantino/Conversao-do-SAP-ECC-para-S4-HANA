"Para o caso de Semantically incompatible change of existing functionality com a função MD_STOCK_REQUIREMENTS_LIST_API, é necessário usar
"a função MD_MRP_AREA_GET para pegar o berid.

*IMPORTANTE: para casos não mapeados, devo consultar a nota mensionada em cada objeto no ATC.

*Passo 1: comentar a função MD_STOCK_REQUIREMENTS_LIST_API, como abaixo:
*WS - Migração Mignow - 03/06/24      
*      CALL FUNCTION 'MD_STOCK_REQUIREMENTS_LIST_API'
*        EXPORTING
*          matnr                    = ls_mara-matnr
*          werks                    = p_werks
*        TABLES
*          mdpsx                    = it_mdps
*        EXCEPTIONS
*          material_plant_not_found = 1
*          plant_not_found          = 2
*          OTHERS                   = 3.

*Chamar a função MD_MRP_AREA_GET passando o matnr e werks. 
   DATA: ls_mdlv TYPE mdlv.  "Criar ls_mdlv para receber o berid
   CALL FUNCTION 'MD_MRP_AREA_GET'
     EXPORTING
       i_matnr          = ls_mara-matnr
       i_werks          = p_werks
     IMPORTING
       e_db_mdlv        = ls_mdlv  "recebe o berid
     EXCEPTIONS
       wrong_parameters = 1
       OTHERS           = 2.

"Faço a chamada da função MD_STOCK_REQUIREMENTS_LIST_API passando o berid e colocando o prágma
   CALL FUNCTION 'MD_STOCK_REQUIREMENTS_LIST_API'  "#EC CI_USAGE_OK[2227532]
     EXPORTING
       matnr                    = ls_mara-matnr
       werks                    = p_werks
       berid                    = ls_mdlv-berid  "Passo o campo berid
     TABLES
       mdpsx                    = it_mdps
     EXCEPTIONS
       material_plant_not_found = 1
       plant_not_found          = 2
       OTHERS                   = 3.
*WS - Migração Mignow - 03/06/24 
