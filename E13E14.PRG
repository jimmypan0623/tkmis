CLEAR ALL
CLOSE ALL
SET EXCLUSIVE OFF
SET DELETED ON
*E13='E13201706'&&+LEFT(DTOS(DATE()),6)   &&完工月報表
*E14='E14201706'&&+LEFT(DTOS(DATE()),6)   &&耗損月報表
MTH=LEFT(DTOS(DATE()),6)
 
E13='\\192.168.10.213\TKDATA\E13'+MTH
E14='\\192.168.10.213\TKDATA\E14'+MTH
E11='\\192.168.10.160\MISD2\E11'
E03='\\192.168.10.160\MISD2\E03'
CREATE CURSOR E13E14 (製令號碼 C(12),完成品號 C(43),完工單號 C(10),完工數量 N(11),未扣料號 C(43),未扣數量 N(16,4))


IF !USED('&E03')
   SELECT 0
   USE (E03) ALIAS E03
ELSE
   SELECT E03
ENDIF
SET ORDER TO 1
IF !USED('&E11')
   SELECT 0
   USE (E11) ALIAS E11
ELSE
   SELECT E11
ENDIF
SET FILTER TO F18<>'2'
SET ORDER TO 1      
 
IF !USED('&E14')
   SELE 0
   USE (E14) ALIA E14  
ELSE
   SELE E14
ENDIF
SET ORDER TO 2
IF !USED('&E13')
   SELE 0
   USE (E13) ALIA E13  
ELSE
   SELE E13
ENDIF
SET ORDER TO 2 
SET FILTER TO F08=.T.
GO TOP
DO WHILE !EOF()
   SELECT E11
   SEEK E13.F01
   IF FOUND()
      DO WHILE E11.F01=E13.F01     
         IF E11.F18='1'
            SELECT E14
            SEEK E13.F01+E13.F04+E11.F11+E11.F04
            IF !FOUND()
               SELECT E13E14
               APPEND BLANK
               REPLACE 製令號碼 WITH E13.F01
               REPLACE 完成品號 WITH IIF(SEEK(E13.F01,'E03'),E03.F01,'')
               REPLACE 完工單號 WITH E13.F04
               REPLACE 完工數量 WITH E13.F05
               REPLACE 未扣料號 WITH E11.F04
               REPLACE 未扣數量 WITH ROUND(E11.F06*E13.F05*(1+E11.F20/100),4)
            ENDIF
         ENDIF         
         SELECT E11
         SKIP
      ENDDO
   ENDIF
   SELECT E13
   SKIP
ENDDO
SELECT E13E14
BROWSE
CLEAR ALL
CLOSE ALL
SET DEFAULT TO H:\TKMIS
