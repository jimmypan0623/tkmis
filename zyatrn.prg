CLOSE ALL
CLEAR 
*!*	SELECT 0
*!*	USE ZYAC02
*!*	SET ORDER TO 1
SELECT 0
USE ZYAC01
SET ORDER TO 1
*!*	GO TOP
*!*	DO WHILE !EOF()
*!*	   SELECT ZYAC02
*!*	   SEEK ZYAC01.F01_Z
*!*	   IF FOUND()
*!*	      DO WHILE ZYAC02.F01_Z=ZYAC01.F01_Z
*!*	         REPLACE F01 WITH ZYAC01.F01
*!*	         SKIP
*!*	      ENDDO
*!*	   ENDIF
*!*	   SELECT ZYAC01
*!*	   SKIP
*!*	ENDDO
*!*	SELECT 0
*!*	USE ZYAC02RPT
*!*	SET ORDER TO 1
SELECT 0
USE ZYAC01RPT
SET ORDER TO 1
*!*	GO TOP
*!*	DO WHILE !EOF()
*!*	   SELECT ZYAC02RPT
*!*	   SEEK ZYAC01RPT.F01_A
*!*	   IF FOUND()
*!*	      DO WHILE ZYAC02RPT.F01_Z=ZYAC01RPT.F01_A
*!*	         REPLACE F01 WITH ZYAC01RPT.F01_B
*!*	         SKIP
*!*	      ENDDO
*!*	   ENDIF
*!*	   SELECT ZYAC01RPT
*!*	   SKIP
*!*	ENDDO
SELECT 0
USE \\192.168.10.200\MIS\MIS\TKDATA\P04 ALIAS P04
SET ORDER TO 1
SELECT 0
USE \\192.168.10.200\MIS\MIS\TKDATA\D07 ALIAS D07
SET ORDER TO 4
SELECT 0
USE ZYAD07
GO TOP
DO WHILE !EOF()
   SELECT D07
   SEEK ZYAD07.F01+ZYAD07.F02
   IF FOUND()
      DO WHILE F01+F02=ZYAD07.F01+ZYAD07.F02
         REPLACE F16 WITH IIF(SEEK(ZYAD07.F16,'ZYAC01RPT'),ZYAC01RPT.f01_b,IIF(SEEK(ZYAD07.F16,'ZYAC01'),ZYAC01.f01,'')) 
         REPLACE F07 WITH LEFT(F07,6)+'Z'+SUBSTR(F07,8,13)
         SKIP
      ENDDO   
   ENDIF
   SELECT P04
   SEEK ZYAD07.F01+ZYAD07.F02
        REPLACE F14 WITH IIF(SEEK(ZYAD07.F16,'ZYAC01RPT'),ZYAC01RPT.f01_b,IIF(SEEK(ZYAD07.F16,'ZYAC01'),ZYAC01.f01,'')) 
        REPLACE F11 WITH LEFT(F11,6)+'Z'+SUBSTR(F11,8,13)
   IF FOUND()
   ENDIF
   SELECT ZYAD07
   SKIP
ENDDO
CLOSE ALL


