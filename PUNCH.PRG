****祘Α嘿 S16对戈锣json郎
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

**CREATE CURSOR TD4 (F01 C(10))
**INDEX ON F01 TAG TD4
**SET ORDER TO 1
IF !USED('A26')
   SELECT 0
   USE A26
ELSE 
   SELECT A26
ENDIF
SET ORDER TO 1      
SEEK 'INT_012'
IF FOUND()
   INT_012=VAL(F06)
ELSE
  INT_012=2   
ENDIF
IF INT_012=1
   SET DATE TO TAIWAN
ELSE
   SET DATE TO YMD
ENDIF   

SET ORDER TO 1      
IF !USED('A23')
   SELECT 0
   USE A23
ELSE 
   SELECT A23
ENDIF
SET ORDER TO 1
C10='C10'+LEFT(DTOS(DATE()),6)
C101='C101'+LEFT(DTOS(DATE()),6)
IF !USED('&C10')
   SELE 0
   USE (C10) ALIA C10
ELSE
   SELE C10
ENDIF
SET ORDER TO 1    

IF !USED('S18')
   SELECT 0
   USE S18
ELSE 
   SELECT S18
ENDIF
SET ORDER TO 1   
S16='S16'+LEFT(DTOS(DATE()),6)
S161='S161'+LEFT(DTOS(DATE()),6)
IF !USED('&S16')
   SELE 0
   USE (S16) ALIA S16
ELSE
   SELE S16
ENDIF
SET ORDER TO 1        
DO FORM PUNCH
****************************
FUNCTION PRSNT_STATE
   PARAMETERS A,B,C,D,SB_NO
   COND='ら对'
   IF (A AND B)=.T.
      COND='ぱ对'
   ELSE
     IF A=.T.
        COND='と对'
     ENDIF
     IF B=.T.
        COND='と对'
     ENDIF
   ENDIF
   IF ( C AND D)=.T.
      COND='ぱ'+IIF(SEEK(SB_NO,'S18'),S18.F08,'    ')
   ELSE
      IF C=.T.
        COND='と'+IIF(SEEK(SB_NO,'S18'),S18.F08,'    ')
      ENDIF
      IF D=.T.
        COND='と'+IIF(SEEK(SB_NO,'S18'),S18.F08,'    ')
      ENDIF
   ENDIF
   RETURN COND