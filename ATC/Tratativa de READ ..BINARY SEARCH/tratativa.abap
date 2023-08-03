*---> 03/08/2023 - Migração S4 - WS
    SORT sauf_tab BY safnr.
*<--- 03/08/2023 - Migração S4 - WS

READ TABLE sauf_tab WITH KEY safnr = kbed_tab-safnr
                 BINARY SEARCH TRANSPORTING NO FIELDS.
