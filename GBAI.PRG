CLOSE ALL
CLEAR ALL
SET DELETED ON
SET EXCLUSIVE OFF
SELECT 0
USE \\192.168.10.160\MISD2\C04 ALIAS C04
SET ORDER TO 1
SELECT 0
USE \\192.168.10.160\MISD2\C06 ALIAS C06
SET ORDER TO 1
CREATE CURSOR GBAI( F02 C(5),F04 C(43),F03 D(8),F17 C(20))

SELECT C04.F02,C04.f03,C04.F04,C04.F17,C06.F03,C06.f04,C06.F05 FROM C04,C06 WHERE C04.F02$'C8152C4017C4032' AND C04.F10 >0 AND C06.F02=C04.F04 ORDER BY C04.F02,C04.F04,C06.f03 INTO CURSOR GBAI1
CUS='A'
STKNO='B'
SELECT GBAI1 
GO TOP 
DO WHILE !EOF()
   IF CUS+STKNO<>F02 + F04_A 
      SELECT GBAI
      APPEND BLANK
      REPLACE F02 WITH GBAI1.F02
      REPLACE F04 WITH GBAI1.F04_A      
      REPLACE F17 WITH GBAI1.F17
      CUS=F02
      STKNO=F04         
   ENDIF
   SELECT GBAI
   REPLACE F03 WITH GBAI1.F03_B
   SELECT GBAI1
   SKIP
ENDDO
SELECT GBAI
COPY TO H:\TKMIS\GBAI.DBF
CLOSE ALL