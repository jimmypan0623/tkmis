CLEAR ALL
CLOSE ALL
CREATE CURSOR YEARSTOCK (F01 C(43),F02 N(11),F03 D(8),F37 N(11,6),F39 N(14,2),F10 C(60),F17 C(17))
TMPYEAR='2019'
SELECT 0
USE B01
SET ORDER TO 1
SELECT 0
USE B1A
SET ORDER TO 1
SELECT 0
USE B11
SET ORDER TO 1
SELECT 0
USE D10
SET ORDER TO 4
SELECT B11
SET FILTER TO F01='I000 '
GO TOP 
DO WHILE !EOF()
   SELECT D10
   SEEK B11.F03
   IF FOUND()
      IF LEFT(DTOS(F03),4)=TMPYEAR
         SELECT YEARSTOCK
         APPEND BLANK
         REPLACE F01 WITH B11.F03
         REPLACE F02 WITH F02+B11.F04
         REPLACE F03 WITH D10.F03
         REPLACE F37 WITH IIF(SEEK(F01,'B01'),B01.F37,0)
         REPLACE F39 WITH ROUND(F37*F02,2)
         REPLACE F10 WITH IIF(SEEK('I000 '+F01,'B1A'),B1A.F10,'')
         REPLACE F17 WITH IIF(SEEK('I000 '+F01,'B1A'),B1A.F17,'')         
      ENDIF
   ENDIF
   SELECT B11
   SKIP
   
ENDDO
SELECT YEARSTOCK
GO TOP
BROW
CLOSE ALL
CLEAR ALL