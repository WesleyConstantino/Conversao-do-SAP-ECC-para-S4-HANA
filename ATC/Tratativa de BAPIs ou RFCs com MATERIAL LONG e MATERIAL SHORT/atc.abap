*---> 30/06/2023 - Migração S4 - JS
 
*    I_ORDER_ITEMS_IN-MATERIAL  =   V_MATERIAL.         " Material
 
    DATA(v_len) = strlen( V_MATERIAL ).
 
 
    IF v_len > 18.
 
      I_ORDER_ITEMS_IN-MATERIAL_long  =   V_MATERIAL.
 
    ELSE.
 
      I_ORDER_ITEMS_IN-MATERIAL       =   V_MATERIAL.
 
    ENDIF.
 
*<--- 30/06/2023 - Migração S4 - JS  
