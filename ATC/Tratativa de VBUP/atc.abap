* ---> S4 Migration - 29/08/23 - WS
 
*  Select single * from vbup
*       into corresponding fields of yvbup
*       where vbeln = xvbap-vbeln and
*             posnr = xvbap-posnr.

  Select single * from V_VBUP_S4
       into corresponding fields of @yvbup
       where vbeln = @xvbap-vbeln and
             posnr = @xvbap-posnr.

* ---> S4 Migration - 29/08/23 - WS
