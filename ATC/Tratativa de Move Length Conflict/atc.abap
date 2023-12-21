"40 > 18 = conv
"18 > 40 = pragma

* ---> S4 Migration - 28/08/23 - WS - Inicio            
*            ls_item_nf-codigo_do_produto               = zcl_assist_jda=>conv_material_output( ls_lin-matnr ).
            ls_item_nf-codigo_do_produto               = CONV #( zcl_assist_jda=>conv_material_output( ls_lin-matnr ) ) .
* ---> S4 Migration - 28/08/23 - WS - Fim   
