CLEAR ALL
SET TALK OFF
SET EXCL OFF
SET DELE ON
SET CENT OFF
SET SAFE OFF
SET DECIMALS TO 6
SET REPROCESS TO 1
_SCREEN.CAPTION=''
_SCREEN.CONTROLBOX=.F.
ZOOM WIND SCREEN MIN
CLEAR ALL
CLOS DATA ALL
CLOS TABL ALL
SET TALK OFF
SET EXCL OFF
SET DELE ON
SET CENT OFF
SET SAFE OFF
SET DECIMALS TO 6
SET ENGINEBEHAVIOR 70 
SET REPORTBEHAVIOR 80
SET REPROCESS TO 1
_SCREEN.CAPTION=''
_SCREEN.CONTROLBOX=.F.
ZOOM WINDOW  SCREEN MAX
HIDE WINDOW SCREEN
DEACTIVATE WIND SCREEN
SET SYSMENU OFF
SET STATUS BAR OFF
SET MULTILOCKS ON
DECLARE _FPRESET IN msvcrt20.dll 
CAPSLOCK(.T.)

SET DATE TO YMD
************************
SELE 0
USE A26
X_CHK = .F.
DO WHIL ! EOF()
    X_CHECK = TRIM(F08)
    X_OK = &X_CHECK
    REPL F03 WITH IIF(X_OK,'  ','“')
    IF ! X_OK
      X_CHK = .T.
    ENDI
    X_NAME = TRIM(F01)
    DO CASE
      CASE F04 = 'C'
        X_VAL = LEFT(F06,MAX(F05,1))
      CASE F04 = 'N'
        X_VAL = VAL(F06)
      CASE F04 = 'L'
        X_VAL = ( F06='Y' )
    ENDC 
    PUBLIC &X_NAME
    &X_NAME = X_VAL
    IF X_NAME = 'INT_000'
    	&X_NAME = ALLTRIM(&X_NAME)
    ENDI
    SKIP
ENDD
*
DO CASE
    CASE X_CHK            && FJMIS 秈╰参Τ岿粇
	       	ERROR("╰参把计岿粇叫⒃⒇⒁⒆⑾⒄穝砞﹚磅︽穨 ! ")
	    CLOS DATA
    	QUIT
    CASE X_CHK            && FJDIAG 秈╰参Τ岿粇
	        ERROR("╰参把计岿粇叫穝砞﹚磅︽⒃⒇③⒆⑨ ! ")
	    CLOS DATA
 	    RETU
    OTHE
ENDC

SELE A26
USE
*****************************
 
IF !USED('C20')
   SELECT 0
   USE C20
ELSE
   SELECT C20
ENDIF
SET ORDER TO 1

IF !USED('B01')
    SELECT 0
    USE B01
ELSE
   SELECT B01
ENDIF
SET ORDER TO 1

PUBLIC UKEF
UKEF=30000
 
 
DO FORM jsonb01

PROCEDURE INVHEAD