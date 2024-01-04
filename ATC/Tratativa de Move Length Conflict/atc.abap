"para um campo MENOR usar o CONV.
"para  um campo MAIOR usar PRAGMA.

"40 = 18 = pragma 
"18 = 40 = conv

"Ex:
"po_item-material      = w_config_cte-matnr.
"    18                                    40  CONV
*******************************************************
"po_item-material      = w_config_cte-matnr.
"    35                                    40  CONV
*******************************************************

* ---> S4 Migration - 28/08/23 - WS - Inicio            
*            ls_item_nf-codigo_do_produto               = zcl_assist_jda=>conv_material_output( ls_lin-matnr ).
            ls_item_nf-codigo_do_produto               = CONV #( zcl_assist_jda=>conv_material_output( ls_lin-matnr ) ) .
* ---> S4 Migration - 28/08/23 - WS - Fim   
