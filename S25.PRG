**程式名稱:S25.年度出缺勤查詢(德通)
SET EXCL OFF
CLOSE ALL
CLEAR 
PRG_NO='S25'
AREA1='S25_TEMP'
FLG='0'
FCH=''
CHK=''
HK=''
IF !USED('A01')	&&操作人員資料設定
   SELECT  0
   USE A01
ELSE 
   SELECT  A01
ENDIF
SET ORDER TO A01    
IF !USED('A23')	&&月份檔
    SELE 0
    USE A23
ELSE 
   SELE A23
ENDIF
SET ORDER TO A231   
IF !USED('A02')	&&權限設定檔
   SELECT  0
   USE A02 INDE A02
ELSE
   SELECT  A02
ENDIF
SET ORDER TO A021      
SEEK SYS_OPER+'S25'   
IF !USED('S0A')  &&年度缺勤紀錄檔 
   SELECT  0
   USE S0A 
ELSE
   SELECT  S0A
ENDIF
SET ORDER TO S0A1 
IF !USED('S0B')  &&年假記錄檔 
   SELECT  0
   USE S0B 
ELSE
   SELECT  S0B
ENDIF
SET ORDER TO S0B1 
IF !USED('S05')  &&人事薪資基本檔
   SELECT  0
   USE S05 
ELSE
   SELECT  S05
ENDIF
SET ORDER TO S051 
IF !USED('S14')  &&年度出勤紀錄檔
   SELECT  0
   USE S14 
ELSE
   SELECT  S14
ENDIF
SET ORDER TO S141 
CREATE CURSOR S25_TEMP;
 (F01 C(4),F02 C(8),F03 C(8),F04 N(3),F05 N(5,1),F06 N(5,1),F07 N(5,1),F08 N(5,1),F09 N(8,1),F10 N(8,1),;
  F11 N(3),F12 N(3),F13 N(3),F14 N(3),F15 N(3),F16 N(3),F17 N(3),F18 N(3),F19 N(3),F20 N(3),F21 N(3),F22 N(3),;
  F31 N(3),F32 N(3),F33 N(3),F34 N(3),F35 N(3),F36 N(3),F37 N(3),F38 N(3),F39 N(3),F40 N(3),F41 N(3),F42 N(3),F51 N(4),F52 N(4))
INDE ON F01 TAG S25_TEMP1
INDE ON F02 TAG S25_TEMP2
SELECT S25_TEMP
SET ORDER TO S25_TEMP1
*****先帶入S14.年度出勤紀錄檔
SELECT F01,F02 FROM S14 WHERE LEFT(DTOS(F08),4) = LEFT(DTOS(DATE()),4) GROUP BY F01 ORDER BY F01 INTO CURSOR S14_TEMP
SELECT S14_TEMP
GO TOP
DO WHILE !EOF()
   IF INDEXSEEK(S14_TEMP.F01,.T.,'S05','S051') = .T. AND EMPTY(S05.F02) = .F. AND EMPTY(S05.F06) = .F.
      SELECT S25_TEMP
      APPEND BLANK 
      REPLACE S25_TEMP.F01 WITH S14_TEMP.F01		&&員工編號
      REPLACE S25_TEMP.F02 WITH S05.F02				&&員工姓名
      REPLACE S25_TEMP.F03 WITH S05.F06				&&部門名稱
   ELSE
      IF INDEXSEEK(S14_TEMP.F02,.T.,'S05','S052') = .T. AND EMPTY(S05.F02) = .F. AND EMPTY(S05.F06) = .F.
         SELECT S25_TEMP
         APPEND BLANK 
         REPLACE S25_TEMP.F01 WITH S05.F01			&&員工編號
         REPLACE S25_TEMP.F02 WITH S05.F02			&&員工姓名
         REPLACE S25_TEMP.F03 WITH S05.F06			&&部門名稱          
      ENDIF
   ENDIF   
   SELECT S14_TEMP
   SKIP
ENDDO
SELECT S14_TEMP
USE
SELECT S05
SET ORDER TO S051
****
SELECT * FROM S14 WHERE LEFT(DTOS(F08),4) = LEFT(DTOS(DATE()),4) ORDER BY F01,F08 INTO CURSOR S14_TEMP
SELECT S14_TEMP
GO TOP
DO WHILE !EOF()
       SELECT S25_TEMP
       SEEK S14_TEMP.F01
       IF FOUND()
            DO CASE 
                   CASE MONTH(S14_TEMP.F08) = 1
                              REPLACE S25_TEMP.F11 WITH S14_TEMP.F05		&&遲到
                              REPLACE S25_TEMP.F31 WITH S14_TEMP.F06		&&早退
                   CASE MONTH(S14_TEMP.F08) = 2
                              REPLACE S25_TEMP.F12 WITH S14_TEMP.F05
                              REPLACE S25_TEMP.F32 WITH S14_TEMP.F06
                   CASE MONTH(S14_TEMP.F08) = 3
                              REPLACE S25_TEMP.F13 WITH S14_TEMP.F05
                              REPLACE S25_TEMP.F33 WITH S14_TEMP.F06
                   CASE MONTH(S14_TEMP.F08) = 4
                              REPLACE S25_TEMP.F14 WITH S14_TEMP.F05
                              REPLACE S25_TEMP.F34 WITH S14_TEMP.F06
                   CASE MONTH(S14_TEMP.F08) = 5
                              REPLACE S25_TEMP.F15 WITH S14_TEMP.F05
                              REPLACE S25_TEMP.F35 WITH S14_TEMP.F06
                   CASE MONTH(S14_TEMP.F08) = 6
                              REPLACE S25_TEMP.F16 WITH S14_TEMP.F05
                              REPLACE S25_TEMP.F36 WITH S14_TEMP.F06
                   CASE MONTH(S14_TEMP.F08) = 7
                              REPLACE S25_TEMP.F17 WITH S14_TEMP.F05
                              REPLACE S25_TEMP.F37 WITH S14_TEMP.F06
                   CASE MONTH(S14_TEMP.F08) = 8
                              REPLACE S25_TEMP.F18 WITH S14_TEMP.F05
                              REPLACE S25_TEMP.F38 WITH S14_TEMP.F06
                   CASE MONTH(S14_TEMP.F08) = 9
                              REPLACE S25_TEMP.F19 WITH S14_TEMP.F05
                              REPLACE S25_TEMP.F39 WITH S14_TEMP.F06
                   CASE MONTH(S14_TEMP.F08) = 10
                              REPLACE S25_TEMP.F20 WITH S14_TEMP.F05
                              REPLACE S25_TEMP.F40 WITH S14_TEMP.F06
                   CASE MONTH(S14_TEMP.F08) = 11
                              REPLACE S25_TEMP.F21 WITH S14_TEMP.F05
                              REPLACE S25_TEMP.F41 WITH S14_TEMP.F06           
                   CASE MONTH(S14_TEMP.F08) = 12
                              REPLACE S25_TEMP.F22 WITH S14_TEMP.F05
                              REPLACE S25_TEMP.F42 WITH S14_TEMP.F06                                                                                                                                                                                                                                                                                                                               
            ENDCASE
            REPLACE S25_TEMP.F09 WITH S25_TEMP.F09 + S14_TEMP.F09	&&平日加班累計(小時)
            REPLACE S25_TEMP.F10 WITH S25_TEMP.F10 + S14_TEMP.F10	&&假日加班累計(小時)
       ENDIF
       SELECT S14_TEMP
       SKIP
ENDDO
SELECT S14_TEMP
USE
****帶入缺勤S0A.年度缺勤紀錄檔 
SELECT * FROM S0A WHERE LEFT(DTOS(F08),4) = LEFT(DTOS(DATE()),4) ORDER BY F01,F08 INTO CURSOR S0A_TEMP
SELECT S0A_TEMP
GO TOP
DO WHILE !EOF()
       SELECT S25_TEMP
       SEEK S0A_TEMP.F01
       IF FOUND()
           DO CASE 
                  CASE S0A_TEMP.F05 ='A1'		&&年假
                             REPLACE S25_TEMP.F05 WITH S25_TEMP.F05 + S0A_TEMP.F07 
                  CASE S0A_TEMP.F05 ='A3'		&&事假
                  	     REPLACE S25_TEMP.F06 WITH S25_TEMP.F06 + S0A_TEMP.F07 
                  CASE S0A_TEMP.F05 ='A4'		&&病假
                  	     REPLACE S25_TEMP.F07 WITH S25_TEMP.F07 + S0A_TEMP.F07 
                  CASE S0A_TEMP.F05 ='A8'		&&公假
                  	     REPLACE S25_TEMP.F08 WITH S25_TEMP.F08 + S0A_TEMP.F07 
           ENDCASE     
       ENDIF
       SELECT S0A_TEMP
       SKIP
ENDDO
SELECT S0A_TEMP
USE
****帶入缺勤S0B.年假記錄檔 
SELECT S25_TEMP
GO TOP
DO WHILE !EOF()
       SELECT S0B
       SEEK S25_TEMP.F01 + LEFT(DTOS(DATE()),4)
       IF FOUND()
           REPLACE S25_TEMP.F04 WITH S0B.F04	&&可休年假
       ELSE
           SELECT S05
           SEEK S25_TEMP.F01
           IF FOUND()
                REPLACE S25_TEMP.F04 WITH S05.F11	&&可休年假
           ENDIF
       ENDIF
       REPLACE S25_TEMP.F51 WITH S25_TEMP.F11 + S25_TEMP.F12 + S25_TEMP.F13 + S25_TEMP.F14 + S25_TEMP.F15 + S25_TEMP.F16 + ;
       							      S25_TEMP.F17 + S25_TEMP.F18 + S25_TEMP.F19 + S25_TEMP.F20 + S25_TEMP.F21 + S25_TEMP.F22 		&&遲到累計(分)
       REPLACE S25_TEMP.F52 WITH S25_TEMP.F31 + S25_TEMP.F32 + S25_TEMP.F33 + S25_TEMP.F34 + S25_TEMP.F35 + S25_TEMP.F36 + ;
       							      S25_TEMP.F37 + S25_TEMP.F38 + S25_TEMP.F39 + S25_TEMP.F40 + S25_TEMP.F41 + S25_TEMP.F42 		&&早退累計(分)       							      
       SELECT S25_TEMP
       SKIP
ENDDO
SELECT S25_TEMP
SET ORDER TO S25_TEMP1
GO TOP
*********
S25FORM=CREATEOBJECT("TKS25")
S25FORM.SHOW  
DEFINE CLASS TKS25 AS FORM
  CAPTION='S25.年度出缺勤查詢(德通)'
*!*	  AUTOCENTER=.T.
  CONTROLBOX=.F.
  BORDERSTYLE=1  
  MAXBUTTON=.F.
  MINBUTTON=.F.
  MOVABLE=.F.
  CLOSABLE=.F.
  CONTROLCOUNT=57
  FONTSIZE=INT_015*9
  HEIGHT=INT_015*550
  SHOWTIPS=.T.
  SHOWWINDOW=1
  WIDTH=INT_015*793
  WINDOWTYPE=1
  ADD OBJECT KEY_LIST AS KEY_LIST WITH;
      WIDTH=INT_015*125,;
      AUTOCENTER=.T.
  ADD OBJECT MTH_LIST AS MTH_LIST WITH;
     WIDTH=INT_015*65,;
      AUTOCENTER=.T.             
 ADD OBJECT SHAPE_GIRD AS SHAPE WITH;
       TOP=INT_015*33,;
       LEFT=INT_015*5,;
       HEIGHT=INT_015*501,;
       WIDTH=INT_015*787,;
       SPECIALEFFECT=0,;
       NAME='SHAPE_GIRD'                  
  ADD OBJECT LINE01 AS LINE WITH;     
      VISIBLE=.T.,;
      LEFT=INT_015*219,;
      TOP=INT_015*35,;
      HEIGHT=INT_015*25,;
      WIDTH=INT_015*0,;
      NAME='LINE01'         
  ADD OBJECT LABEL01 AS LABEL WITH;     
      VISIBLE=.T.,;
      LEFT=INT_015*230,;
      TOP=INT_015*41,;
      AUTOSIZE=.T.,;
      FONTSIZE=INT_015*10,;
      CAPTION='請  假  日  數  累  計',;       
      NAME='LABEL01'          
  ADD OBJECT LINE02 AS LINE WITH;     
      VISIBLE=.T.,;
      LEFT=INT_015*341,;
      TOP=INT_015*35,;
      HEIGHT=INT_015*25,;
      WIDTH=INT_015*0,;
      NAME='LINE02'                    
  ADD OBJECT LABEL02 AS LABEL WITH;     
      VISIBLE=.T.,;
      LEFT=INT_015*350,;
      TOP=INT_015*41,;
      AUTOSIZE=.T.,;
      FONTSIZE=INT_015*10,;
      CAPTION='每月  遲到 ／ 早退  統計 (單位：分)',;   
      NAME='LABEL02'                   
  ADD OBJECT GRID1 AS GRID1 WITH;
      TOP=INT_015*60,;
      COLUMNCOUNT=24,;            
      RECORDSOURCE='S25_TEMP',; 
      HEIGHT=INT_015*470,;     
      WIDTH=INT_015*780,;      
      COLUMN1.NAME='COLUMN1',;
      COLUMN2.NAME='COLUMN2',;
      COLUMN3.NAME='COLUMN3',; 
      COLUMN4.NAME='COLUMN4',; 
      COLUMN5.NAME='COLUMN5',;             
      COLUMN6.NAME='COLUMN6',;       
      COLUMN7.NAME='COLUMN7',;       
      COLUMN8.NAME='COLUMN8',;
      COLUMN9.NAME='COLUMN9',;   
      COLUMN10.NAME='COLUMN10',;
      COLUMN11.NAME='COLUMN11',; 
      COLUMN12.NAME='COLUMN12',;
      COLUMN13.NAME='COLUMN13',;
      COLUMN14.NAME='COLUMN14',;
      COLUMN15.NAME='COLUMN15',;
      COLUMN16.NAME='COLUMN16',;
      COLUMN17.NAME='COLUMN17',;
      COLUMN18.NAME='COLUMN18',;
      COLUMN19.NAME='COLUMN19',;
      COLUMN20.NAME='COLUMN20',;
      COLUMN21.NAME='COLUMN21',;
      COLUMN22.NAME='COLUMN22',;
      COLUMN23.NAME='COLUMN23',;
      COLUMN24.NAME='COLUMN24'
   ADD OBJECT CMDGROUP AS CMDGROUP WITH;
      TOP=INT_015*0,;
      LEFT=INT_015*205,;
      ENABLED=.T.,;
      VISIBLE=.T.            
  ADD OBJECT ORPGROUP AS ORPGROUP WITH;      
      TOP=INT_015*0,;
      LEFT=INT_015*405                                                          
  PROCEDURE INIT
       HK=ALLTRIM(THISFORM.MTH_LIST.DISPLAYVALUE)
       THISFORM.ORPGROUP.NEW_BOTT.VISIBLE=.F.
       THISFORM.ORPGROUP.EDIT_BOTT.VISIBLE=.F.
       THISFORM.ORPGROUP.DEL_BOTT.VISIBLE=.F.
       THISFORM.GRID1.LOCKCOLUMNS=8
       THISFORM.GRID1.BACKCOLOR=IIF(SEEK(sys_oper,'A01'),IIF(A01.F11=0,10009146,A01.F11),10009146)   
       THISFORM.GRID1.SETALL('FONTSIZE',INT_015*9,'COLUMN')
       THISFORM.GRID1.SETALL('FONTSIZE',INT_015*9,'HEADER')   
       THISFORM.GRID1.COLUMN1.WIDTH=INT_015*50
       THISFORM.GRID1.COLUMN2.WIDTH=INT_015*50
       THISFORM.GRID1.COLUMN3.WIDTH=INT_015*50
       THISFORM.GRID1.COLUMN4.WIDTH=INT_015*50
       THISFORM.GRID1.COLUMN5.WIDTH=INT_015*30
       THISFORM.GRID1.COLUMN6.WIDTH=INT_015*30
       THISFORM.GRID1.COLUMN7.WIDTH=INT_015*30
       THISFORM.GRID1.COLUMN8.WIDTH=INT_015*30
       THISFORM.GRID1.COLUMN9.WIDTH=INT_015*55
       THISFORM.GRID1.COLUMN10.WIDTH=INT_015*55
       THISFORM.GRID1.COLUMN11.WIDTH=INT_015*55
       THISFORM.GRID1.COLUMN12.WIDTH=INT_015*55
       THISFORM.GRID1.COLUMN13.WIDTH=INT_015*55
       THISFORM.GRID1.COLUMN14.WIDTH=INT_015*55
       THISFORM.GRID1.COLUMN15.WIDTH=INT_015*55
       THISFORM.GRID1.COLUMN16.WIDTH=INT_015*55
       THISFORM.GRID1.COLUMN17.WIDTH=INT_015*55
       THISFORM.GRID1.COLUMN18.WIDTH=INT_015*55
       THISFORM.GRID1.COLUMN19.WIDTH=INT_015*55
       THISFORM.GRID1.COLUMN20.WIDTH=INT_015*55
       THISFORM.GRID1.COLUMN21.WIDTH=INT_015*70
       THISFORM.GRID1.COLUMN22.WIDTH=INT_015*70
       THISFORM.GRID1.COLUMN23.WIDTH=INT_015*95
       THISFORM.GRID1.COLUMN24.WIDTH=INT_015*95
       THISFORM.GRID1.COLUMN1.HEADER1.CAPTION='人員編號'
       THISFORM.GRID1.COLUMN2.HEADER1.CAPTION='人員姓名'
       THISFORM.GRID1.COLUMN3.HEADER1.CAPTION='部門名稱'	   
       THISFORM.GRID1.COLUMN4.HEADER1.CAPTION='年假天數'	
       THISFORM.GRID1.COLUMN5.HEADER1.CAPTION='事假'	   
       THISFORM.GRID1.COLUMN6.HEADER1.CAPTION='病假'
       THISFORM.GRID1.COLUMN7.HEADER1.CAPTION='公假'
       THISFORM.GRID1.COLUMN8.HEADER1.CAPTION='年假'	       
       THISFORM.GRID1.COLUMN9.HEADER1.CAPTION='一月' 
       THISFORM.GRID1.COLUMN10.HEADER1.CAPTION='二月' 
       THISFORM.GRID1.COLUMN11.HEADER1.CAPTION='三月' 
       THISFORM.GRID1.COLUMN12.HEADER1.CAPTION='四月' 
       THISFORM.GRID1.COLUMN13.HEADER1.CAPTION='五月' 
       THISFORM.GRID1.COLUMN14.HEADER1.CAPTION='六月' 
       THISFORM.GRID1.COLUMN15.HEADER1.CAPTION='七月' 
       THISFORM.GRID1.COLUMN16.HEADER1.CAPTION='八月' 
       THISFORM.GRID1.COLUMN17.HEADER1.CAPTION='九月' 
       THISFORM.GRID1.COLUMN18.HEADER1.CAPTION='十月' 
       THISFORM.GRID1.COLUMN19.HEADER1.CAPTION='十一月' 
       THISFORM.GRID1.COLUMN20.HEADER1.CAPTION='十二月' 
       THISFORM.GRID1.COLUMN21.HEADER1.CAPTION='遲到累計(分)' 
       THISFORM.GRID1.COLUMN22.HEADER1.CAPTION='早退累計(分)' 
       THISFORM.GRID1.COLUMN23.HEADER1.CAPTION='平日加班累計(時)' 
       THISFORM.GRID1.COLUMN24.HEADER1.CAPTION='假日加班累計(時)' 
       THISFORM.GRID1.COLUMN1.CONTROLSOURCE='S25_TEMP.F01'
       THISFORM.GRID1.COLUMN2.CONTROLSOURCE='S25_TEMP.F02'
       THISFORM.GRID1.COLUMN3.CONTROLSOURCE='S25_TEMP.F03'
       THISFORM.GRID1.COLUMN4.CONTROLSOURCE='S25_TEMP.F04'
       THISFORM.GRID1.COLUMN5.CONTROLSOURCE='S25_TEMP.F06'
       THISFORM.GRID1.COLUMN6.CONTROLSOURCE='S25_TEMP.F07'
       THISFORM.GRID1.COLUMN7.CONTROLSOURCE='S25_TEMP.F08'
       THISFORM.GRID1.COLUMN8.CONTROLSOURCE='S25_TEMP.F05'
       THISFORM.GRID1.COLUMN9.CONTROLSOURCE="IIF(S25_TEMP.F11 = 0 AND S25_TEMP.F31 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F11,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F31,'@R 999')))"
       THISFORM.GRID1.COLUMN10.CONTROLSOURCE="IIF(S25_TEMP.F12 = 0 AND S25_TEMP.F32 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F12,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F32,'@R 999')))"
       THISFORM.GRID1.COLUMN11.CONTROLSOURCE="IIF(S25_TEMP.F13 = 0 AND S25_TEMP.F33 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F13,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F33,'@R 999')))"
       THISFORM.GRID1.COLUMN12.CONTROLSOURCE="IIF(S25_TEMP.F14 = 0 AND S25_TEMP.F34 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F14,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F34,'@R 999')))"
       THISFORM.GRID1.COLUMN13.CONTROLSOURCE="IIF(S25_TEMP.F15 = 0 AND S25_TEMP.F35 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F15,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F35,'@R 999')))"
       THISFORM.GRID1.COLUMN14.CONTROLSOURCE="IIF(S25_TEMP.F16 = 0 AND S25_TEMP.F36 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F16,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F36,'@R 999')))"
       THISFORM.GRID1.COLUMN15.CONTROLSOURCE="IIF(S25_TEMP.F17 = 0 AND S25_TEMP.F37 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F17,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F37,'@R 999')))"
       THISFORM.GRID1.COLUMN16.CONTROLSOURCE="IIF(S25_TEMP.F18 = 0 AND S25_TEMP.F38 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F18,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F38,'@R 999')))"
       THISFORM.GRID1.COLUMN17.CONTROLSOURCE="IIF(S25_TEMP.F19 = 0 AND S25_TEMP.F39 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F19,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F39,'@R 999')))"
       THISFORM.GRID1.COLUMN18.CONTROLSOURCE="IIF(S25_TEMP.F20 = 0 AND S25_TEMP.F40 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F20,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F40,'@R 999')))"
       THISFORM.GRID1.COLUMN19.CONTROLSOURCE="IIF(S25_TEMP.F21 = 0 AND S25_TEMP.F41 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F21,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F41,'@R 999')))"
       THISFORM.GRID1.COLUMN20.CONTROLSOURCE="IIF(S25_TEMP.F22 = 0 AND S25_TEMP.F42 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F22,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F42,'@R 999')))"
       THISFORM.GRID1.COLUMN21.CONTROLSOURCE='S25_TEMP.F51'
       THISFORM.GRID1.COLUMN22.CONTROLSOURCE='S25_TEMP.F52'
       THISFORM.GRID1.COLUMN23.CONTROLSOURCE='S25_TEMP.F09'
       THISFORM.GRID1.COLUMN24.CONTROLSOURCE='S25_TEMP.F10'
       THISFORM.GRID1.READONLY=.T.       
       THISFORM.GRID1.SETFOCUS    
        IF  THISFORM.GRID1.ACTIVEROW=0 
              THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.F.      
	      THISFORM.CMDGROUP.UP_BOTT.ENABLED=.F.
	      THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.F.
	      THISFORM.CMDGROUP.END_BOTT.ENABLED=.F.    
	      THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.	        
	      THISFORM.ORPGROUP.PNT_BOTT.ENABLED=.F.   
        ELSE
              THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.T.      
	      THISFORM.CMDGROUP.UP_BOTT.ENABLED=.T.
	      THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.T.
	      THISFORM.CMDGROUP.END_BOTT.ENABLED=.T.    
	      THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.	        
	      THISFORM.ORPGROUP.PNT_BOTT.ENABLED=IIF(A02.F07='*',.T.,.F.)   &&判斷有無列印的權限    
        ENDIF       
       JK='人員編號'
  ENDPROC    
  PROC KEY_LIST.INIT 
       WITH THIS 
           .ADDITEM('依人員編號排列')
           .ADDITEM('依人員姓名排列')      
       ENDWITH      
  ENDPROC 
  PROC KEY_LIST.INTERACTIVECHANGE                 
       SELE S25_TEMP
       DO CASE
          CASE THIS.DISPLAYVALUE='依人員編號排列'          
                     THISFORM.GRID1.COLUMN1.HEADER1.CAPTION='人員編號'
		     THISFORM.GRID1.COLUMN2.HEADER1.CAPTION='人員姓名'
		     THISFORM.GRID1.COLUMN1.CONTROLSOURCE='S25_TEMP.F01'
		     THISFORM.GRID1.COLUMN2.CONTROLSOURCE='S25_TEMP.F02'	        
                     SET ORDER TO S25_TEMP1
          CASE THIS.DISPLAYVALUE='依人員姓名排列'           	
                     THISFORM.GRID1.COLUMN1.HEADER1.CAPTION='人員姓名'
		     THISFORM.GRID1.COLUMN2.HEADER1.CAPTION='人員編號'		     
		     THISFORM.GRID1.COLUMN1.CONTROLSOURCE='S25_TEMP.F02'
		     THISFORM.GRID1.COLUMN2.CONTROLSOURCE='S25_TEMP.F01'		     	        
                     SET ORDER TO S25_TEMP2       
       ENDCASE 
       JK=THISFORM.GRID1.COLUMN1.HEADER1.CAPTION
       THISFORM.GRID1.REFRESH
       THISFORM.GRID1.SETFOCUS
  ENDPROC             
  ***********
  PROC MTH_LIST.INIT        
       WITH THIS
            SELE A23
            SELECT LEFT(DTOS(F01),4) FROM A23  INTO CURSOR A23A
            SELECT * FROM A23A GROUP BY EXP_1 ORDER BY EXP_1 INTO CURSOR A23_TEMP
            GO TOP
            K=0
            S=0
            DO WHILE !EOF()                
               K=K+1
               .ADDITEM(A23_TEMP.EXP_1)
               IF LEFT(DTOS(DATE()),4) = A23_TEMP.EXP_1
                  S=K
               ENDIF       
               SKIP
            ENDDO   
            .VALUE=S
            SELECT A23A
            USE 
            SELECT A23_TEMP
            USE
       ENDWITH   
  ENDPROC       
***********
  PROC MTH_LIST.INTERACTIVECHANGE
        HK=ALLTRIM(THISFORM.MTH_LIST.DISPLAYVALUE)
        THISFORM.GRID1.RECORDSOURCE=''         
        SELECT S25_TEMP
        USE
	CREATE CURSOR S25_TEMP;
	 (F01 C(4),F02 C(8),F03 C(8),F04 N(3),F05 N(5,1),F06 N(5,1),F07 N(5,1),F08 N(5,1),F09 N(8,1),F10 N(8,1),;
	  F11 N(3),F12 N(3),F13 N(3),F14 N(3),F15 N(3),F16 N(3),F17 N(3),F18 N(3),F19 N(3),F20 N(3),F21 N(3),F22 N(3),;
	  F31 N(3),F32 N(3),F33 N(3),F34 N(3),F35 N(3),F36 N(3),F37 N(3),F38 N(3),F39 N(3),F40 N(3),F41 N(3),F42 N(3),F51 N(4),F52 N(4))
	INDE ON F01 TAG S25_TEMP1
	INDE ON F02 TAG S25_TEMP2
	SELECT S25_TEMP
	SET ORDER TO S25_TEMP1
	*****先帶入S14.年度出勤紀錄檔
	SELECT F01,F02 FROM S14 WHERE LEFT(DTOS(F08),4) = ALLTRIM(HK) GROUP BY F01 ORDER BY F01 INTO CURSOR S14_TEMP
	SELECT S14_TEMP
	GO TOP
	DO WHILE !EOF()
	   IF INDEXSEEK(S14_TEMP.F01,.T.,'S05','S051') = .T. AND EMPTY(S05.F02) = .F. AND EMPTY(S05.F06) = .F.
	      SELECT S25_TEMP
	      APPEND BLANK 
	      REPLACE S25_TEMP.F01 WITH S14_TEMP.F01		&&員工編號
	      REPLACE S25_TEMP.F02 WITH S05.F02				&&員工姓名
	      REPLACE S25_TEMP.F03 WITH S05.F06				&&部門名稱
	   ELSE
	      IF INDEXSEEK(S14_TEMP.F02,.T.,'S05','S052') = .T. AND EMPTY(S05.F02) = .F. AND EMPTY(S05.F06) = .F.
	         SELECT S25_TEMP
	         APPEND BLANK 
	         REPLACE S25_TEMP.F01 WITH S05.F01			&&員工編號
	         REPLACE S25_TEMP.F02 WITH S05.F02			&&員工姓名
	         REPLACE S25_TEMP.F03 WITH S05.F06			&&部門名稱          
	      ENDIF
	   ENDIF   
	   SELECT S14_TEMP
	   SKIP	
	ENDDO
	SELECT S14_TEMP
	USE
	SELECT S05
	SET ORDER TO S051
	****
	SELECT * FROM S14 WHERE LEFT(DTOS(F08),4) = ALLTRIM(HK) ORDER BY F01,F08 INTO CURSOR S14_TEMP
	SELECT S14_TEMP
	GO TOP
	DO WHILE !EOF()
	       SELECT S25_TEMP
	       SEEK S14_TEMP.F01
	       IF FOUND()
	            DO CASE 
	                   CASE MONTH(S14_TEMP.F08) = 1
	                              REPLACE S25_TEMP.F11 WITH S14_TEMP.F05		&&遲到
	                              REPLACE S25_TEMP.F31 WITH S14_TEMP.F06		&&早退
	                   CASE MONTH(S14_TEMP.F08) = 2
	                              REPLACE S25_TEMP.F12 WITH S14_TEMP.F05
	                              REPLACE S25_TEMP.F32 WITH S14_TEMP.F06
	                   CASE MONTH(S14_TEMP.F08) = 3
	                              REPLACE S25_TEMP.F13 WITH S14_TEMP.F05
	                              REPLACE S25_TEMP.F33 WITH S14_TEMP.F06
	                   CASE MONTH(S14_TEMP.F08) = 4
	                              REPLACE S25_TEMP.F14 WITH S14_TEMP.F05
	                              REPLACE S25_TEMP.F34 WITH S14_TEMP.F06
	                   CASE MONTH(S14_TEMP.F08) = 5
	                              REPLACE S25_TEMP.F15 WITH S14_TEMP.F05
	                              REPLACE S25_TEMP.F35 WITH S14_TEMP.F06
	                   CASE MONTH(S14_TEMP.F08) = 6
	                              REPLACE S25_TEMP.F16 WITH S14_TEMP.F05
	                              REPLACE S25_TEMP.F36 WITH S14_TEMP.F06
	                   CASE MONTH(S14_TEMP.F08) = 7
	                              REPLACE S25_TEMP.F17 WITH S14_TEMP.F05
	                              REPLACE S25_TEMP.F37 WITH S14_TEMP.F06
	                   CASE MONTH(S14_TEMP.F08) = 8
	                              REPLACE S25_TEMP.F18 WITH S14_TEMP.F05
	                              REPLACE S25_TEMP.F38 WITH S14_TEMP.F06
	                   CASE MONTH(S14_TEMP.F08) = 9
	                              REPLACE S25_TEMP.F19 WITH S14_TEMP.F05
	                              REPLACE S25_TEMP.F39 WITH S14_TEMP.F06
	                   CASE MONTH(S14_TEMP.F08) = 10
	                              REPLACE S25_TEMP.F20 WITH S14_TEMP.F05
	                              REPLACE S25_TEMP.F40 WITH S14_TEMP.F06
	                   CASE MONTH(S14_TEMP.F08) = 11
	                              REPLACE S25_TEMP.F21 WITH S14_TEMP.F05
	                              REPLACE S25_TEMP.F41 WITH S14_TEMP.F06           
	                   CASE MONTH(S14_TEMP.F08) = 12
	                              REPLACE S25_TEMP.F22 WITH S14_TEMP.F05
	                              REPLACE S25_TEMP.F42 WITH S14_TEMP.F06                                                                                                                                                                                                                                                                                                                               
	            ENDCASE
	            REPLACE S25_TEMP.F09 WITH S25_TEMP.F09 + S14_TEMP.F09	&&平日加班累計(小時)
	            REPLACE S25_TEMP.F10 WITH S25_TEMP.F10 + S14_TEMP.F10	&&假日加班累計(小時)
	       ENDIF
	       SELECT S14_TEMP
	       SKIP
	ENDDO
	SELECT S14_TEMP
	USE
	****帶入缺勤S0A.年度缺勤紀錄檔 
	SELECT * FROM S0A WHERE LEFT(DTOS(F08),4) = ALLTRIM(HK)  ORDER BY F01,F08 INTO CURSOR S0A_TEMP
	SELECT S0A_TEMP
	GO TOP
	DO WHILE !EOF()
	       SELECT S25_TEMP
	       SEEK S0A_TEMP.F01
	       IF FOUND()
	           DO CASE 
	                  CASE S0A_TEMP.F05 ='A1'		&&年假
	                             REPLACE S25_TEMP.F05 WITH S25_TEMP.F05 + S0A_TEMP.F07 
	                  CASE S0A_TEMP.F05 ='A3'		&&事假
	                  	     REPLACE S25_TEMP.F06 WITH S25_TEMP.F06 + S0A_TEMP.F07 
	                  CASE S0A_TEMP.F05 ='A4'		&&病假
	                  	     REPLACE S25_TEMP.F07 WITH S25_TEMP.F07 + S0A_TEMP.F07 
	                  CASE S0A_TEMP.F05 ='A8'		&&公假
	                  	     REPLACE S25_TEMP.F08 WITH S25_TEMP.F08 + S0A_TEMP.F07 
	           ENDCASE     
	       ENDIF
	       SELECT S0A_TEMP
	       SKIP
	ENDDO
	SELECT S0A_TEMP
	USE
	****帶入缺勤S0B.年假記錄檔 
	SELECT S25_TEMP
	GO TOP
	DO WHILE !EOF()
	       SELECT S0B
	       SEEK S25_TEMP.F01 + ALLTRIM(HK) 
	       IF FOUND()
	           REPLACE S25_TEMP.F04 WITH S0B.F04	&&可休年假
	       ELSE    
                   SELECT S05
                   SEEK S25_TEMP.F01
                   IF FOUND()
                       REPLACE S25_TEMP.F04 WITH S05.F11	&&可休年假
                   ENDIF	           
	       ENDIF
	       REPLACE S25_TEMP.F51 WITH S25_TEMP.F11 + S25_TEMP.F12 + S25_TEMP.F13 + S25_TEMP.F14 + S25_TEMP.F15 + S25_TEMP.F16 + ;
	       							      S25_TEMP.F17 + S25_TEMP.F18 + S25_TEMP.F19 + S25_TEMP.F20 + S25_TEMP.F21 + S25_TEMP.F22 		&&遲到累計(分)
	       REPLACE S25_TEMP.F52 WITH S25_TEMP.F31 + S25_TEMP.F32 + S25_TEMP.F33 + S25_TEMP.F34 + S25_TEMP.F35 + S25_TEMP.F36 + ;
	       							      S25_TEMP.F37 + S25_TEMP.F38 + S25_TEMP.F39 + S25_TEMP.F40 + S25_TEMP.F41 + S25_TEMP.F42 		&&早退累計(分)       							      
	       SELECT S25_TEMP
	       SKIP
	ENDDO
	SELECT S25_TEMP
	SET ORDER TO S25_TEMP1
	GO TOP	
       THISFORM.GRID1.RECORDSOURCE='S25_TEMP'
       THISFORM.GRID1.COLUMN1.CONTROLSOURCE='S25_TEMP.F01'
       THISFORM.GRID1.COLUMN2.CONTROLSOURCE='S25_TEMP.F02'
       THISFORM.GRID1.COLUMN3.CONTROLSOURCE='S25_TEMP.F03'
       THISFORM.GRID1.COLUMN4.CONTROLSOURCE='S25_TEMP.F04'
       THISFORM.GRID1.COLUMN5.CONTROLSOURCE='S25_TEMP.F06'
       THISFORM.GRID1.COLUMN6.CONTROLSOURCE='S25_TEMP.F07'
       THISFORM.GRID1.COLUMN7.CONTROLSOURCE='S25_TEMP.F08'
       THISFORM.GRID1.COLUMN8.CONTROLSOURCE='S25_TEMP.F05'
       THISFORM.GRID1.COLUMN9.CONTROLSOURCE="IIF(S25_TEMP.F11 = 0 AND S25_TEMP.F31 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F11,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F31,'@R 999')))"
       THISFORM.GRID1.COLUMN10.CONTROLSOURCE="IIF(S25_TEMP.F12 = 0 AND S25_TEMP.F32 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F12,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F32,'@R 999')))"
       THISFORM.GRID1.COLUMN11.CONTROLSOURCE="IIF(S25_TEMP.F13 = 0 AND S25_TEMP.F33 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F13,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F33,'@R 999')))"
       THISFORM.GRID1.COLUMN12.CONTROLSOURCE="IIF(S25_TEMP.F14 = 0 AND S25_TEMP.F34 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F14,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F34,'@R 999')))"
       THISFORM.GRID1.COLUMN13.CONTROLSOURCE="IIF(S25_TEMP.F15 = 0 AND S25_TEMP.F35 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F15,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F35,'@R 999')))"
       THISFORM.GRID1.COLUMN14.CONTROLSOURCE="IIF(S25_TEMP.F16 = 0 AND S25_TEMP.F36 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F16,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F36,'@R 999')))"
       THISFORM.GRID1.COLUMN15.CONTROLSOURCE="IIF(S25_TEMP.F17 = 0 AND S25_TEMP.F37 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F17,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F37,'@R 999')))"
       THISFORM.GRID1.COLUMN16.CONTROLSOURCE="IIF(S25_TEMP.F18 = 0 AND S25_TEMP.F38 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F18,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F38,'@R 999')))"
       THISFORM.GRID1.COLUMN17.CONTROLSOURCE="IIF(S25_TEMP.F19 = 0 AND S25_TEMP.F39 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F19,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F39,'@R 999')))"
       THISFORM.GRID1.COLUMN18.CONTROLSOURCE="IIF(S25_TEMP.F20 = 0 AND S25_TEMP.F40 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F20,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F40,'@R 999')))"
       THISFORM.GRID1.COLUMN19.CONTROLSOURCE="IIF(S25_TEMP.F21 = 0 AND S25_TEMP.F41 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F21,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F41,'@R 999')))"
       THISFORM.GRID1.COLUMN20.CONTROLSOURCE="IIF(S25_TEMP.F22 = 0 AND S25_TEMP.F42 = 0,'',ALLTRIM(TRANSFORM(S25_TEMP.F22,'@R 999')) +' ／ ' + ALLTRIM(TRANSFORM(S25_TEMP.F42,'@R 999')))"
       THISFORM.GRID1.COLUMN21.CONTROLSOURCE='S25_TEMP.F51'
       THISFORM.GRID1.COLUMN22.CONTROLSOURCE='S25_TEMP.F52'
       THISFORM.GRID1.COLUMN23.CONTROLSOURCE='S25_TEMP.F09'
       THISFORM.GRID1.COLUMN24.CONTROLSOURCE='S25_TEMP.F10'
       THISFORM.KEY_LIST.INTERACTIVECHANGE
       THISFORM.REFRESH       
       THISFORM.GRID1.SETFOCUS
        IF  THISFORM.GRID1.ACTIVEROW=0 
              THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.F.      
	      THISFORM.CMDGROUP.UP_BOTT.ENABLED=.F.
	      THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.F.
	      THISFORM.CMDGROUP.END_BOTT.ENABLED=.F.    
	      THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.	        
	      THISFORM.ORPGROUP.PNT_BOTT.ENABLED=.F.   
         ELSE
              THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.T.      
	      THISFORM.CMDGROUP.UP_BOTT.ENABLED=.T.
	      THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.T.
	      THISFORM.CMDGROUP.END_BOTT.ENABLED=.T.    
	      THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.	        
	      THISFORM.ORPGROUP.PNT_BOTT.ENABLED=IIF(A02.F07='*',.T.,.F.)   &&判斷有無列印的權限   
        ENDIF
*!*	        THISFORM.REFRESH
 ENDPROC      
*******        
  PROC GRID1.AFTERROWCOLCHANGE
       LPARAMETERS NCOLINDEX
       FCH=THISFORM.ACTIVECONTROL.NAME
       CHK=''
       THISFORM.REFRESH
  ENDPROC        
ENDDEFINE      
***********************************************列印程序
PROCEDURE PNT_PRC  
   SELECT S25_TEMP
   ANS_RANGE=CREATEOBJECT("ANS_RANGE")  
   ANS_RANGE.SHOW    
ENDPROC 
***********************************************列印範圍選定
DEFINE CLASS ANS_RANGE AS FORM
*!*	  AUTOCENTER=.T.
  CAPTION='請輸入列印資料範圍'
  TOP=INT_015*200
  LEFT=INT_015*250 
  HEIGHT=INT_015*120
  WIDTH=INT_015*280
  FONTSIZE=INT_015*9
  MOVABLE=.F.
  MAXBUTTON=.F.
  MINBUTTON=.F.   
  CONTROLBOX=.F.
  BORDERSTYLE=2
  SHOWTIPS=.T.
  SHOWWINDOW=1
  WINDOWTYPE=1
  NAME='ANS_RANGE'
  ADD OBJECT LABEL1 AS LABEL WITH;
      AUTOSIZE=.T.,;
      HEIGHT=INT_015*25,;
      LEFT=INT_015*30,;
      TOP=INT_015*36,;
      CAPTION='起始員工編號',;
      NAME='LABEL1'
  ADD OBJECT TEXT1 AS TEXTBOX WITH;
      TOP=INT_015*30,;
      LEFT=INT_015*110,;
      HEIGHT=INT_015*25,; 
      WIDTH=INT_015*60,; 
      MAXLENGTH=4,;
      NAME='TEXT1'      
  ADD OBJECT LABEL2 AS LABEL WITH;
      AUTOSIZE=.T.,;
      HEIGHT=INT_015*25,;
      LEFT=INT_015*30,;
      TOP=INT_015*66,;
      CAPTION='截止員工編號',;
      NAME='LABEL2'
  ADD OBJECT TEXT2 AS TEXTBOX WITH;
      TOP=INT_015*60,;
      LEFT=INT_015*110,;
      HEIGHT=INT_015*25,;   
      WIDTH=INT_015*60,;     
      MAXLENGTH=4,;   
      NAME='TEXT2'    
  ADD OBJECT CMND1 AS COMMANDBUTTON WITH;
      LEFT=INT_015*190,;    
      HEIGHT=INT_015*25,; 
      WIDTH=INT_015*70,;    
      TOP=INT_015*14,;  
      MOUSEPOINTER=99,;
      MOUSEICON='BMPS\harrow.cur',;        
      CAPTION='\<P.列         印',;
      TOOLTIPTEXT='列印所輸入的範圍鍵值!快速鍵->ALT+Y',;
      NAME='CMND1' 
  ADD OBJECT CMND2 AS COMMANDBUTTON WITH;
      LEFT=INT_015*190,;
      TOP=INT_015*76,;
      HEIGHT=INT_015*25,;
      WIDTH=INT_015*70,; 
      MOUSEPOINTER=99,;
      MOUSEICON='BMPS\harrow.cur',;        
      CAPTION='\<C.取        消',;
      TOOLTIPTEXT='取消作業!快速鍵->ALT+C',;
      NAME='CMND2'
  PROCEDURE INIT 
      THISFORM.SETALL('FONTSIZE',INT_015*10,'TEXTBOX')
      THISFORM.SETALL('FONTSIZE',INT_015*10,'LABEL')      
      THISFORM.SETALL('FONTSIZE',INT_015*10,'COMMANDBUTTON')    
      THISFORM.LABEL1.CAPTION='起始員工編號' 
      THISFORM.LABEL2.CAPTION='截止員工編號' 
      THISFORM.TEXT1.VALUE=S25_TEMP.F01
      THISFORM.TEXT2.VALUE=S25_TEMP.F01                      
  ENDPROC   
  *** 
  PROCEDURE CMND1.CLICK 
      IF  EMPTY(THISFORM.TEXT1.VALUE)
           =MESSAGEBOX('起始編號不得為空白!',0+64,'提示訊息視窗')
           THISFORM.TEXT1.SETFOCUS
  	   RETURN 
      ENDIF
      IF  EMPTY(THISFORM.TEXT2.VALUE)
           =MESSAGEBOX('截止編號不得為空白!',0+64,'提示訊息視窗')
           THISFORM.TEXT2.SETFOCUS
  	   RETURN 
      ENDIF      
      SELECT  * FROM S25_TEMP WHERE F01>=THISFORM.TEXT1.VALUE AND F01<=THISFORM.TEXT2.VALUE ORDER BY F01 NOWAIT
      IF  _TALLY >0
	   REPORT FORM ALLTRIM(INT_116)+'S25'  TO PRINTER PROMPT  PREVIEW   
      ELSE
	   =MESSAGEBOX('查無此範圍資料',0+48,'警示')
	   THISFORM.TEXT1.SETFOCUS
	    RETURN     
      ENDIF                                                   
      THISFORM.CMND2.CLICK
  ENDPROC  
  ****
  PROCEDURE CMND2.CLICK
      THISFORM.RELEASE
  ENDPROC      
  PROC CMND1.MOUSEENTER      
       LPARAMETERS nButton, nShift, nXCoord, nYCoord 
             THISFORM.CMND1.FORECOLOR=RGB(255,0,0)
             THISFORM.CMND1.TOP=INT_015*15
             THISFORM.CMND1.LEFT=INT_015*191
  ENDPROC     
  PROC CMND1.MOUSELEAVE      
        LPARAMETERS nButton, nShift, nXCoord, nYCoord 
             THISFORM.CMND1.FORECOLOR=RGB(0,0,0)  
             THISFORM.CMND1.TOP=INT_015*14
             THISFORM.CMND1.LEFT=INT_015*190                  
  ENDPROC         
  PROC CMND2.MOUSEENTER      
       LPARAMETERS nButton, nShift, nXCoord, nYCoord 
             THISFORM.CMND2.FORECOLOR=RGB(255,0,0)
             THISFORM.CMND2.TOP=INT_015*77
             THISFORM.CMND2.LEFT=INT_015*191
  ENDPROC     
  PROC CMND2.MOUSELEAVE      
        LPARAMETERS nButton, nShift, nXCoord, nYCoord 
             THISFORM.CMND2.FORECOLOR=RGB(0,0,0)  
             THISFORM.CMND2.TOP=INT_015*76
             THISFORM.CMND2.LEFT=INT_015*190                  
  ENDPROC   
ENDDEFINE                