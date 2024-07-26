"Passo 1: entrei na função e peguei o tipo da estrutura:
*WS - Migração Mignow - 25/07/24
  DATA lt_docstruct_aux TYPE TABLE OF BAPI_DOC_STPOX.
  lt_docstruct_aux = CORRESPONDING #( lt_docstruct ).
*WS - Migração Mignow - 25/07/24

CALL FUNCTION 'BAPI_DOCUMENT_GETLATEST2'
  EXPORTING
    documenttype               = ls_docs-DOKAR
    documentnumber             = ls_docs-DOKNR
    documentpart               = ls_docs-DOKTL
    documentversion            = ls_docs-DOKVR
*   MULTILEVELEXPLOSION        = 'X'
*   DOCBOMCHANGENUMBER         = ' '
*   DOCBOMVALIDFROM            = SY-DATUM
*   DOCBOMREVISIONLEVEL        = ' '
    LOADLATEST                 = ' '
    LOADLATESTRELEASED         = 'X'
    SEARCH_NEW_MAINDOC         = 'X'
*   GETDOCDATA                 = ' '
*   GETOBJECTLINKS             = ' '
*   GETDOCDESCRIPTIONS         = ' '
*   GETLONGTEXTS               = ' '
*   GETSTATUSLOG               = ' '
*    GETDOCFILES                = 'X'
*   GETCOMPONENTS              = ' '
*   GETCLASSIFICATION          =
*   GETSTRUCTURES              =
*   GETWHEREUSED               =
*   SORTF_EXCLUDE              = ' '
*   SORTF_STOP_EXPL            = ' '
*   EXPL_DOCS_ONLY_ONCE        = 'X'
*   STOP_ON_FIRST_ERROR        = ' '
  IMPORTING
    RETURN                     = gs_return
    NEWVERSION                 = lc_version
  tables

"Passo 2: voltei no programa que faz a chamada da função, criei uma estrutura auxiliar com o mesmo tipo da estrutura da função e passei o valor da estrutura 
"nativa para ela, fazendo uma conversão:
*WS - Migração Mignow - 25/07/24
*    docstructure               = lt_docstruct
    docstructure               =  lt_docstruct_aux
*WS - Migração Mignow - 25/07/24
*   CHANGEDVERSIONS            =
*   STATUSLIST                 =
*   DOCUMENTDATA               =
*   OBJECTLINKS                =
*   DOCUMENTDESCRIPTIONS       =
*   LONGTEXTS                  =
*   STATUSLOG                  =
*    DOCUMENTFILES              = lt_documentfiles
*   COMPONENTS                 =
*   ALL_RETURNS                =
*   CHARACTERISTICVALUES       =
*   CLASSALLOCATIONS           =
*   DOCUMENTSTRUCTURES         =
*   WHEREUSEDLISTS             =
          .

Passo 4: fora da chamada da função, passei o valor da estrutura auxiliar para a 
estrutura principal:
*WS - Migração Mignow - 25/07/24
  lt_docstruct = CORRESPONDING #( lt_docstruct_aux ).
*WS - Migração Mignow - 25/07/24
