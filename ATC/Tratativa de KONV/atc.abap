*--> 02/03/2023 - Migração S4 -WS
*SELECT * FROM konv INTO TABLE gt_konv
*WHERE knumv = zvbdka-knumv
*AND kbetr <> 0
*AND kschl <> 'MWST'
*AND kschl <> 'ZWST'
*AND kinak <> 'A'. " do not print non active prices.

SELECT * FROM v_konv INTO TABLE @data(lt_konv)
WHERE knumv = zvbdka-knumv
AND kbetr <> 0
AND kschl <> 'MWST'
AND kschl <> 'ZWST'
AND kinak <> 'A'. " do not print non active prices.

move-corresponding lt_konv[] to gt_konv[].

*<-- 02/03/2023 - Migração S4 -WS
