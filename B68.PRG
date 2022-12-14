******B68.借出還出月報表 
close all
clear 
FLG='0'
FCH=''
CHK=''
R=0
MTH_STR=''
AREA1='B68_1'
AREA2='B68_3'
IF ! USED('A01')
   SELE 0
   USE A01 INDE A01
ELSE
   SELE A01
ENDIF      
SET ORDER TO A01
IF !USED('A02')
   SELE 0
   USE A02 INDE A02
ELSE
   SELE A02
ENDIF
SET ORDER TO A021      
SEEK sys_oper+'B68'
IF !USED('A23')
    SELE 0
    USE A23
ELSE 
   SELE A23
ENDIF
SET ORDER TO 1     
IF !USED('B01')
   SELE 0
   USE B01 INDE B01
ELSE
   SELE B01
ENDIF
SET ORDER TO 1     
IF !USED('D01')
   SELE 0
   USE D01 INDE D01
ELSE
   SELE D01
ENDIF
SET ORDER TO D011
IF !USED('C01')
   SELE 0
   USE C01 INDE C01
ELSE
   SELE C01
ENDIF
SET ORDER TO C011
B62='B62'+LEFT(DTOS(DATE()),6)&&還出單
IF FILE(B62+'.DBF')=.T.
       IF !USED('&B62')
          SELE 0 
          USE (B62) ALIA B62
       ELSE
          SELE B62
       ENDIF
          SET ORDER TO 1
ELSE
	CREATE CURSOR B62;
 	(F01 C(1),F02 C(1),F03 C(1),F04 N(1),F05 C(1),F06 C(1),F07 C(1),F08 C(1),F09 C(1),F10 C(1),F11 C(1),F12 C(1),F13 C(1),F14 D(1))       
ENDIF
B63='B63'+LEFT(DTOS(DATE()),6)&&借出單
 IF FILE(B63+'.DBF')=.T.
       IF !USED('&B63')
          SELE 0 
          USE (B63) ALIA B63
       ELSE
          SELE B63
       ENDIF
          SET ORDER TO 1
ELSE
	CREATE CURSOR B63;
 	(F01 C(1),F02 C(1),F03 C(1),F04 N(1),F05 C(1),F06 C(1),F07 C(1),F08 C(1),F09 C(1),F10 C(1),F11 C(1),F12 C(1),F13 C(1),F14 D(1))       
ENDIF
*******************************表身
CREATE CURSOR B68_2;
(F01 C(10),F02 C(2),F03 C(43),F04 N(11),F07 C(20),F10 C(5),F14 D(8),EXP_8 B(2),F38 B(4),F08 C(10))
INDE ON F10 TAG B68_21
**************************
SELECT  B62.F01,B62.F02,B62.F03,B62.F04,B62.F07,B62.F10,B01.F38*B62.F04,B01.F38,B62.F08 FROM B01,B62  WHERE B01.F01=B62.F03   INTO CURSOR B682
SELECT B682
GO TOP
DO WHILE !EOF()
	SELECT B68_2
	APPEND BLANK
	REPLACE F01 WITH B682.F01
	REPLACE F02 WITH B682.F02
	REPLACE F03 WITH B682.F03
	REPLACE F04 WITH B682.F04
	REPLACE F07 WITH B682.F07
	REPLACE F10 WITH B682.F10
	REPLACE EXP_8 WITH B682.EXP_7
	REPLACE F38 WITH B682.F38
	REPLACE F08 WITH B682.F08
	SELECT B682
   	SKIP
ENDDO
SELECT B682
USE
SELECT B68_2
SET ORDER TO 1
**************************
SELECT  B63.F01,B63.F02,B63.F03,B63.F04,B63.F07,B63.F10,B63.F14,B01.F38*B63.F04,B01.F38,B63.F08 FROM B01,B63  WHERE B01.F01=B63.F03   INTO CURSOR B683
SELECT B683
GO TOP
DO WHILE !EOF()
	SELECT B68_2
	APPEND BLANK
	REPLACE F01 WITH B683.F01
	REPLACE F02 WITH B683.F02
	REPLACE F03 WITH B683.F03
	REPLACE F04 WITH B683.F04
	REPLACE F07 WITH B683.F07
	REPLACE F10 WITH B683.F10
	REPLACE F14 WITH B683.F14
	REPLACE EXP_8 WITH B683.EXP_8
	REPLACE F38 WITH B683.F38
	SELECT B683
   	SKIP
ENDDO
SELECT B683
USE
SELECT B68_2
SET ORDER TO 1
******************
SELECT  B68_2.*,B01.F02 FROM B68_2,B01 WHERE B68_2.F03=B01.F01  INTO CURSOR B683
SELECT  B683.*,C01.F05 FROM B683,C01 WHERE B683.F10=C01.F01 INTO CURSOR C01B
SELECT  B683.*,D01.F04 FROM B683,D01 WHERE B683.F10=D01.F01 INTO CURSOR D01B
CREATE CURSOR B68_3;
(F01 C(10),F02 C(2),F03 C(43),F04 N(11),F07 C(20),F10 C(5),F14 D(8),EXP_8 B(2),F38 B(4),F021 C(40),F54 C(10),F08 C(10),F99 C(15))
INDE ON F54+F03 TAG B68_31
SELECT C01B
BROW
GO TOP
DO WHILE !EOF()
	SELECT B68_3
	APPEND BLANK
	REPLACE F01 WITH C01B.F01
	REPLACE F02 WITH C01B.F02_A
	REPLACE F03 WITH C01B.F03
	REPLACE F04 WITH 0-C01B.F04
	REPLACE F07 WITH C01B.F07
	REPLACE F10 WITH C01B.F10
	REPLACE F14 WITH C01B.F14
	REPLACE EXP_8 WITH 0-C01B.EXP_8
	REPLACE F38 WITH C01B.F38
	REPLACE F021 WITH C01B.F02_B
	REPLACE F54 WITH C01B.F05
	REPLACE F08 WITH C01B.F08
	DO CASE
	       CASE LEFT(ALLTRIM(C01B.F01),2)='BW'
	       		  REPLACE F99 WITH '借出'
	       CASE LEFT(ALLTRIM(C01B.F01),2)='BV'
	   	          REPLACE F99 WITH '還出'
	ENDCASE
	SELECT C01B
   	SKIP
ENDDO
SELECT C01B
USE
SELECT B68_3
SET ORDER TO 1
SELECT D01B
GO TOP
DO WHILE !EOF()
	SELECT B68_3
	APPEND BLANK
	REPLACE F01 WITH D01B.F01
	REPLACE F02 WITH D01B.F02_A
	REPLACE F03 WITH D01B.F03
	REPLACE F04 WITH 0-D01B.F04_A
	REPLACE F07 WITH D01B.F07
	REPLACE F10 WITH D01B.F10
	REPLACE F14 WITH D01B.F14
	REPLACE EXP_8 WITH 0-D01B.EXP_8
	REPLACE F38 WITH D01B.F38
	REPLACE F021 WITH D01B.F02_B
	REPLACE F54 WITH D01B.F04_B
	REPLACE F08 WITH D01B.F08
	DO CASE
	       CASE LEFT(ALLTRIM(D01B.F01),2)='BW'
	       		  REPLACE F99 WITH '借出'
	       CASE LEFT(ALLTRIM(D01B.F01),2)='BV'
	   	          REPLACE F99 WITH '還出'
	ENDCASE
	SELECT D01B
   	SKIP
ENDDO
SELECT D01B
SELECT  * FROM B68_3  ORDER BY F02 INTO CURSOR B68_3
INDE ON F54+F03 TAG B68_31
GO TOP
SET ORDER TO 1
**************************表頭
CREATE CURSOR B68_1 (F54 C(10),F43 C(40))
INDE ON F54 TAG B68_11
SELECT C01.F05,C01.F04 FROM B68_3,C01 WHERE  B68_3.F10=C01.F01 INTO CURSOR B68C
SELECT B68C
GO TOP
DO WHILE !EOF()
	SELECT B68_1
	APPEND BLANK
	REPLACE F54 WITH B68C.F05
	REPLACE F43 WITH B68C.F04
	SELECT B68C
   	SKIP
ENDDO
SELECT B68C
USE
SELECT D01.F04,D01.F03 FROM B68_3,D01 WHERE  B68_3.F10=D01.F01 INTO CURSOR B68D
SELECT B68D
GO TOP
DO WHILE !EOF()
	SELECT B68_1
	APPEND BLANK
	REPLACE F54 WITH B68D.F04
	REPLACE F43 WITH B68D.F03
	SELECT B68D
   	SKIP
ENDDO
SELECT B68D
USE
SELECT B68_1
SELECT  DISTINCT F54,F43 FROM  B68_1   INTO CURSOR B68_1
INDE ON F54 TAG B68_11
SELECT B68_1
GO TOP
SET ORDER TO 1
**************************
B68form=createobject("tkB68")
B68form.show  
define class tkB68 as form
  caption='B68.借出還出月報表'
*!*	  autocenter=.t.
  controlbox=.F.
  BORDERSTYLE=1  
  MAXBUTTON=.F.
  MINBUTTON=.F.
  MOVABLE=.F.
  CLOSABLE=.F.
  controlcount=57
  FONTSIZE=INT_015*9
  HEIGHT=INT_015*550
  showtips=.t.
  showwindow=1
  WIDTH=INT_015*789
  windowtype=1
  NAME='TKB68'
  add object shape1 as shape1 with;
      autocenter=.t.
  ADD OBJECT LBL_REC AS LBL_REC WITH;
      AUTOCENTER =.T.
  add object shape2 as shape2 with;
      autocenter=.t.
  add object shape3 as shape3 with;
      autocenter=.t.
  ADD OBJECT PAGEFRAME1 AS PAGEFRAME WITH;
      LEFT=INT_015*236,;
      WIDTH=INT_015*540,;
      HEIGHT=INT_015*200,;
      FONTSIZE=INT_015*9,;
      PAGECOUNT=2,;
      TABSTRETCH=1,;
      ACTIVEPAGE=1,;
      VISIBLE=.T.,;
      PAGE1.NAME='PAGE1',;
      PAGE1.VISIBLE=.T.,;
      PAGE1.CAPTION='表頭資料',;
      PAGE2.NAME='PAGE2',;
      PAGE2.VISIBLE=.T.,;
      PAGE2.CAPTION='表身詳細資料內容'   
  ADD OBJECT KEY_LIST AS KEY_LIST WITH;
      autocenter=.t.,;
      WIDTH=INT_015*130
  ADD OBJECT MTH_LIST AS MTH_LIST WITH;
      autocenter=.t.
  ADD OBJECT grid1 AS grid1 WITH;
      columncount=1,;            
      RECORDSOURCE='B68_1',;      
      COLUMN1.NAME='COLUMN1'
  ADD OBJECT grid2 AS grid2 WITH;
      columncount=9,;            
      RECORDSOURCE='B68_3',; 
      LINKMASTER='B68_1',;
      RELATIONALEXPR='F54',;
      childorder='B68_31',;  
      COLUMN1.NAME='COLUMN1',;
      COLUMN2.NAME='COLUMN2',;
      COLUMN3.NAME='COLUMN3',;
      COLUMN4.NAME='COLUMN4',;
      COLUMN5.NAME='COLUMN5',;
      COLUMN6.NAME='COLUMN6',;
      COLUMN7.NAME='COLUMN7',;
      COLUMN8.NAME='COLUMN8',;
      COLUMN9.NAME='COLUMN9'
 ADD OBJECT CMDGROUP AS CMDGROUP WITH;
      TOP=INT_015*415,;
      LEFT=INT_015*10,;
      ENABLED=.T.,;
      VISIBLE=.T.  
  ADD OBJECT ORPGROUP AS ORPGROUP WITH;
      TOP=INT_015*455,;
      LEFT=INT_015*10  
 ADD OBJECT PNT_MTH AS COMMANDBUTTON WITH;
      TOP=INT_015*460,;
      LEFT=INT_015*55,;
      height=INT_015*25,; 
      width=INT_015*83,;
      caption='\<M.本月份列印',;   
      NAME='PNT_MTH'
***************************PAGEFRAME1.PAGE1
PROCEDURE PAGEFRAME1.PAGE1.INIT   
     THIS.ADDOBJECT('LBLF43','LABEL')
     WITH THIS.LBLF43
          .VISIBLE=.T.
          .LEFT=INT_015*14
          .TOP=INT_015*27
          .WIDTH=INT_015*50
          .CAPTION='公司名稱'          
     ENDWITH
     THIS.ADDOBJECT('TXTF43','TEXTBOX')     
     WITH THIS.TXTF43
          .VISIBLE=.T.
          .LEFT=INT_015*64
          .TOP=INT_015*23
          .WIDTH=INT_015*180
          .HEIGHT=INT_015*25
          .MAXLENGTH=40
     ENDWITH
***********************PAGEFRAME1.PAGE2                  
PROCEDURE PAGEFRAME1.PAGE2.INIT
     THIS.ADDOBJECT('LBLF02','LABEL')
     WITH THIS.LBLF02
          .VISIBLE=.T.
          .LEFT=INT_015*14
          .TOP=INT_015*13
          .WIDTH=INT_015*50
          .CAPTION='日        期'          
     ENDWITH
THIS.ADDOBJECT('TXTF02','TEXTBOX')          
     WITH THIS.TXTF02
          .VISIBLE=.T.
          .LEFT=INT_015*65
          .TOP=INT_015*9
          .WIDTH=INT_015*50
          .HEIGHT=INT_015*25
          .MAXLENGTH=8
ENDWITH        
THIS.ADDOBJECT('LBLF01','LABEL')
     WITH THIS.LBLF01
         .VISIBLE=.T.
         .LEFT=INT_015*14
         .TOP=INT_015*45
         .WIDTH=INT_015*60
         .CAPTION='單據編號'
ENDWITH
THIS.ADDOBJECT('LBLF011','LABEL')     
     WITH THIS.LBLF011
          .VISIBLE=.T.
          .LEFT=INT_015*166
          .TOP=INT_015*45
          .AUTOSIZE=.T.
ENDWITH
THIS.ADDOBJECT('TXTF01','TEXTBOX')          
     WITH THIS.TXTF01
          .VISIBLE=.T.
          .LEFT=INT_015*65
          .TOP=INT_015*41
          .WIDTH=INT_015*100
          .HEIGHT=INT_015*25
          .MAXLENGTH=10
ENDWITH    
THIS.ADDOBJECT('LBLF03','LABEL')     
     WITH THIS.LBLF03
          .VISIBLE=.T.
          .LEFT=INT_015*14
          .TOP=INT_015*77
          .WIDTH=INT_015*50  
          .CAPTION='品        號'
ENDWITH            
THIS.ADDOBJECT('LBLF031','LABEL')     
     WITH THIS.LBLF031
          .VISIBLE=.T.
          .LEFT=INT_015*337
          .TOP=INT_015*77
          .AUTOSIZE=.T.
ENDWITH
THIS.ADDOBJECT('TXTF03','TEXTBOX')          
     WITH THIS.TXTF03
          .VISIBLE=.T.
          .LEFT=INT_015*65
          .TOP=INT_015*73
          .WIDTH=INT_015*261
          .HEIGHT=INT_015*25
          .MAXLENGTH=43
ENDWITH                              
THIS.ADDOBJECT('LBLF04','LABEL')
     WITH THIS.LBLF04
         .VISIBLE=.T.
         .LEFT=INT_015*14
         .TOP=INT_015*109
         .WIDTH=INT_015*50
         .CAPTION='數        量'
ENDWITH
THIS.ADDOBJECT('TXTF04','TEXTBOX')          
     WITH THIS.TXTF04
          .VISIBLE=.T.
          .LEFT=INT_015*65
          .TOP=INT_015*105
          .WIDTH=INT_015*70
          .HEIGHT=INT_015*25
          .MAXLENGTH=15
ENDWITH 
THIS.ADDOBJECT('LBLF38','LABEL')
     WITH THIS.LBLF38
         .VISIBLE=.F.
         .LEFT=INT_015*14
         .TOP=INT_015*141
         .WIDTH=INT_015*50
         .CAPTION='單        價'
ENDWITH
THIS.ADDOBJECT('TXTF38','TEXTBOX')          
     WITH THIS.TXTF38
          .VISIBLE=.F.
          .LEFT=INT_015*65
          .TOP=INT_015*137
          .WIDTH=INT_015*70
          .HEIGHT=INT_015*25
          .MAXLENGTH=15
ENDWITH 
 THIS.ADDOBJECT('LBLFEXP8','LABEL')
     WITH THIS.LBLFEXP8
         .VISIBLE=.F.
         .LEFT=INT_015*338
         .TOP=INT_015*13
         .WIDTH=INT_015*50
         .CAPTION='小        計'
ENDWITH
THIS.ADDOBJECT('TXTFEXP8','TEXTBOX')          
     WITH THIS.TXTFEXP8
          .VISIBLE=.F.
          .LEFT=INT_015*389
          .TOP=INT_015*9
          .WIDTH=INT_015*100
          .HEIGHT=INT_015*25
          .MAXLENGTH=20
ENDWITH           
THIS.ADDOBJECT('LBLF14','LABEL')
     WITH THIS.LBLF14
         .VISIBLE=.T.
         .LEFT=INT_015*338
         .TOP=INT_015*45
         .WIDTH=INT_015*50
         .CAPTION='歸還日期'
ENDWITH
THIS.ADDOBJECT('LBLF141','LABEL')
     WITH THIS.LBLF141
         .VISIBLE=.F.
         .LEFT=INT_015*338
         .TOP=INT_015*45
         .WIDTH=INT_015*50
         .CAPTION='借入單號'
ENDWITH
THIS.ADDOBJECT('LBLF142','LABEL')
     WITH THIS.LBLF142
         .VISIBLE=.F.
         .LEFT=INT_015*338
         .TOP=INT_015*45
         .WIDTH=INT_015*50
         .CAPTION='借出單號'
ENDWITH
THIS.ADDOBJECT('TXTF14','TEXTBOX')          
     WITH THIS.TXTF14
          .VISIBLE=.T.
          .LEFT=INT_015*389
          .TOP=INT_015*41
          .WIDTH=INT_015*100
          .HEIGHT=INT_015*25
          .MAXLENGTH=10
ENDWITH
THIS.ADDOBJECT('LBLF07','LABEL')
     WITH THIS.LBLF07
         .VISIBLE=.T.
         .LEFT=INT_015*338
         .TOP=INT_015*109
         .WIDTH=INT_015*50
         .CAPTION='備        註'
ENDWITH
THIS.ADDOBJECT('TXTF07','TEXTBOX')          
     WITH THIS.TXTF07
          .VISIBLE=.T.
          .LEFT=INT_015*389
          .TOP=INT_015*105
          .WIDTH=INT_015*120
          .HEIGHT=INT_015*25
          .MAXLENGTH=20    
ENDWITH
THIS.ADDOBJECT('LBLF98','LABEL')
     WITH THIS.LBLF98
         .VISIBLE=.T.
         .LEFT=INT_015*338
         .TOP=INT_015*141
         .WIDTH=INT_015*50
         .CAPTION='說        明'
ENDWITH
THIS.ADDOBJECT('TXTF98','TEXTBOX')          
     WITH THIS.TXTF98
          .VISIBLE=.T.
          .LEFT=INT_015*389
          .TOP=INT_015*137
          .WIDTH=INT_015*120
          .HEIGHT=INT_015*25
          .MAXLENGTH=20    
ENDWIT
ENDPROC
******************設定PAGE1之動態動作******************        
  PROCEDURE PAGEFRAME1.PAGE1.ACTIVATE
    R=0
     THISFORM.GRID1.ENABLED=.T.          
     THISFORM.GRID1.SETFOCUS     
     IF THISFORM.GRID1.ACTIVEROW=0
        THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.F.      
        THISFORM.CMDGROUP.UP_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.END_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.
        THISFORM.PAGEFRAME1.PAGE1.TXTF43.VALUE=''
     ELSE
        THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.T.      
        THISFORM.CMDGROUP.UP_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.END_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.
     ENDIF
     THISFORM.KEY_LIST.ENABLED=.T.
     THISFORM.MTH_LIST.ENABLED=.T.   
       ENDPROC
*****************設定PAGE2之動態動作****************** 
 PROCEDURE PAGEFRAME1.PAGE2.activate
     SELE B68_3
     THISFORM.GRID2.ENABLED=.T.
     THISFORM.GRID2.SETFOCUS 
      IF IIF(SEEK(SYS_OPER,'A01'),A01.F04,'')='P000'
      	  THISFORM.PAGEFRAME1.PAGE2.LBLF38.VISIBLE=.T.
      	  THISFORM.PAGEFRAME1.PAGE2.TXTF38.VISIBLE=.T.
      	  THISFORM.PAGEFRAME1.PAGE2.LBLFEXP8.VISIBLE=.T.
      	  THISFORM.PAGEFRAME1.PAGE2.TXTFEXP8.VISIBLE=.T.
     ENDIF 	  	
     IF THISFORM.GRID2.ACTIVEROW=0 
        THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.F.      
        THISFORM.CMDGROUP.UP_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.END_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.
        THISFORM.PAGEFRAME1.PAGE2.SETALL('VALUE','','TEXTBOX')
    ELSE
        THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.T.      
        THISFORM.CMDGROUP.UP_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.END_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.  
     ENDIF   
     R=RECNO('&AREA1')
     THISFORM.GRID1.SETALL("DYNAMICBACKCOLOR","IIF(RECNO('&AREA1')=R,RGB(255,255,0),'')","COLUMN")
     THISFORM.GRID1.ENABLED=.F.     
     THISFORM.KEY_LIST.ENABLED=.F.
     THISFORM.MTH_LIST.ENABLED=.F.     
      FCH=THISFORM.ACTIVECONTROL.NAME
       JK='品        號'
       CHK=B68_3.F54
  ENDPROC 
 ****************************************
  PROC INIT       
       thisform.setall('height',INT_015*25,'textbox')
       thisform.setall('height',INT_015*17,'label')
       thisform.setall('FONTSIZE',INT_015*9,'textbox')
       thisform.setall('FONTSIZE',INT_015*9,'label')       
       THISFORM.SETALL('READONLY',.T.,'TEXTBOX')
       THISFORM.ORPGROUP.NEW_BOTT.VISIBLE=.F.
       THISFORM.ORPGROUP.EDIT_BOTT.VISIBLE=.F.
       THISFORM.ORPGROUP.DEL_BOTT.VISIBLE=.F. 
       THISFORM.ORPGROUP.PNT_BOTT.ENABLED=IIF(A02.F07='*',.T.,.F.)   &&判斷有無列印的權限    
       thisform.GRID1.setall('FONTSIZE',INT_015*9,'COLUMN')
       thisform.GRID1.setall('FONTSIZE',INT_015*9,'HEADER')          
       THISFORM.GRID1.COLUMN1.HEADER1.CAPTION='公司簡稱'
       THISFORM.GRID1.COLUMN1.CONTROLSOURCE='B68_1.F54'
       THISFORM.GRID1.COLUMN1.WIDTH=INT_015*60
       thisform.GRID2.setall('FONTSIZE',INT_015*9,'COLUMN')
       thisform.GRID2.setall('FONTSIZE',INT_015*9,'HEADER') 
       THISFORM.GRID1.BACKCOLOR=IIF(SEEK(sys_oper,'A01'),IIF(A01.F11=0,10009146,A01.F11),10009146)
       THISFORM.GRID2.BACKCOLOR=IIF(SEEK(sys_oper,'A01'),IIF(A01.F11=0,10009146,A01.F11),10009146)
     IF IIF(SEEK(SYS_OPER,'A01'),A01.F04,'')='P000'     
       THISFORM.grid2.COLUMN1.HEADER1.CAPTION='品號'  
       THISFORM.grid2.COLUMN2.HEADER1.CAPTION='日期'
       THISFORM.grid2.COLUMN3.HEADER1.CAPTION='單據編號'
       THISFORM.grid2.COLUMN4.HEADER1.CAPTION='數        量'
       THISFORM.grid2.COLUMN5.HEADER1.CAPTION='單        價'
       THISFORM.grid2.COLUMN6.HEADER1.CAPTION='小        計'
       THISFORM.grid2.COLUMN7.HEADER1.CAPTION='歸還日期'
       THISFORM.grid2.COLUMN8.HEADER1.CAPTION='借出(入)單號'
       THISFORM.grid2.COLUMN9.HEADER1.CAPTION='備        註'
	   THISFORM.grid2.COLUMN1.CONTROLSOURCE='B68_3.F03'
	   THISFORM.grid2.COLUMN2.CONTROLSOURCE='B68_3.F02'
	   THISFORM.grid2.COLUMN3.CONTROLSOURCE='B68_3.F01'
	   THISFORM.grid2.COLUMN4.CONTROLSOURCE='B68_3.F04'
	   THISFORM.grid2.COLUMN5.CONTROLSOURCE='B68_3.F38'
	   THISFORM.grid2.COLUMN6.CONTROLSOURCE='B68_3.EXP_8'
	   THISFORM.grid2.COLUMN7.CONTROLSOURCE='B68_3.F14'
	   THISFORM.grid2.COLUMN8.CONTROLSOURCE='B68_3.F08'
           THISFORM.grid2.COLUMN9.CONTROLSOURCE='B68_3.F07'
       THISFORM.grid2.COLUMN1.WIDTH=INT_015*110
       THISFORM.GRID2.COLUMN2.WIDTH=INT_015*30
       THISFORM.grid2.COLUMN3.WIDTH=INT_015*80
       THISFORM.GRID2.COLUMN4.WIDTH=INT_015*60
       THISFORM.GRID2.COLUMN5.WIDTH=INT_015*70
        THISFORM.GRID2.COLUMN6.WIDTH=INT_015*90
       THISFORM.GRID2.COLUMN7.WIDTH=INT_015*60
       THISFORM.GRID2.COLUMN8.WIDTH=INT_015*80
       THISFORM.GRID2.COLUMN9.WIDTH=INT_015*100
     ELSE
     	  THISFORM.grid2.COLUMN1.HEADER1.CAPTION='品號'  
       THISFORM.grid2.COLUMN2.HEADER1.CAPTION='日期'
       THISFORM.grid2.COLUMN3.HEADER1.CAPTION='單據編號'
       THISFORM.grid2.COLUMN4.HEADER1.CAPTION='數        量'
       THISFORM.grid2.COLUMN5.HEADER1.CAPTION='歸還日期'
       THISFORM.grid2.COLUMN6.HEADER1.CAPTION='借出(入)單號'
       THISFORM.grid2.COLUMN7.HEADER1.CAPTION='備        註'
       THISFORM.grid2.COLUMN8.HEADER1.CAPTION=''
       THISFORM.grid2.COLUMN9.HEADER1.CAPTION=''
	   THISFORM.grid2.COLUMN1.CONTROLSOURCE='B68_3.F03'
	   THISFORM.grid2.COLUMN2.CONTROLSOURCE='B68_3.F02'
	   THISFORM.grid2.COLUMN3.CONTROLSOURCE='B68_3.F01'
	   THISFORM.grid2.COLUMN4.CONTROLSOURCE='B68_3.F04'
	   THISFORM.grid2.COLUMN5.CONTROLSOURCE='B68_3.F14'
	   THISFORM.grid2.COLUMN6.CONTROLSOURCE='B68_3.F08'
           THISFORM.grid2.COLUMN7.CONTROLSOURCE='B68_3.F07'
           THISFORM.grid2.COLUMN8.CONTROLSOURCE=''
	   THISFORM.grid2.COLUMN9.CONTROLSOURCE=''
       THISFORM.grid2.COLUMN1.WIDTH=INT_015*110
       THISFORM.GRID2.COLUMN2.WIDTH=INT_015*30
       THISFORM.grid2.COLUMN3.WIDTH=INT_015*80
       THISFORM.GRID2.COLUMN4.WIDTH=INT_015*60
       THISFORM.GRID2.COLUMN5.WIDTH=INT_015*60
       THISFORM.GRID2.COLUMN6.WIDTH=INT_015*80
       THISFORM.GRID2.COLUMN7.WIDTH=INT_015*100
       THISFORM.GRID2.COLUMN8.WIDTH=INT_015*10
        THISFORM.GRID2.COLUMN9.WIDTH=INT_015*10
      ENDIF 
       THISFORM.grid1.READONLY=.T.      
       THISFORM.grid2.READONLY=.T.            
       THISFORM.grid1.SETFOCUS
        IF THISFORM.GRID1.ACTIVEROW=0
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.
       ELSE
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.      
       ENDIF          
       THISFORM.KEY_LIST.DISPLAYVALUE='依公司簡稱排列'       
       JK='公司簡稱'
       SELE B68_1
       GO TOP
       THISFORM.PAGEFRAME1.PAGE1.TXTF43.VALUE=B68_1.F43
  ENDPROC            
***************GRID1動態改變*********
 PROC grid1.AFTERROWCOLCHANGE
       LPARAMETERS nColIndex 
       THISFORM.PAGEFRAME1.PAGE1.TXTF43.VALUE=B68_1.F43
        FCH=THISFORM.ACTIVECONTROL.NAME
       JK=THIS.COLUMN1.HEADER1.CAPTION
       IF THIS.ACTIVEROW=0
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.
       ELSE
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.
       ENDIF   
       CHK=''
       THISFORM.REFRESH
  ENDPROC     
***************GRID2動態改變*************** 
PROC grid2.AFTERROWCOLCHANGE
      LPARAMETERS nColIndex
       THISFORM.PAGEFRAME1.PAGE2.TXTF02.VALUE=THISFORM.MTH_LIST.DISPLAYVALUE+'/'+B68_3.F02
       THISFORM.PAGEFRAME1.PAGE2.TXTF01.VALUE=B68_3.F01
       THISFORM.PAGEFRAME1.PAGE2.LBLF011.CAPTION=BILL(LEFT(ALLTRIM(B68_3.F01),2))
       THISFORM.PAGEFRAME1.PAGE2.TXTF03.VALUE=B68_3.F03
       THISFORM.PAGEFRAME1.PAGE2.LBLF031.CAPTION=B68_3.F021
       THISFORM.PAGEFRAME1.PAGE2.TXTF04.VALUE=B68_3.F04
       THISFORM.PAGEFRAME1.PAGE2.TXTF38.VALUE=B68_3.F38
       THISFORM.PAGEFRAME1.PAGE2.TXTFEXP8.VALUE=B68_3.EXP_8
       THISFORM.PAGEFRAME1.PAGE2.TXTF07.VALUE=B68_3.F07
      IF EMPTY(B68_3.F08)
       	   THISFORM.PAGEFRAME1.PAGE2.LBLF141.VISIBLE=.F.
       	   THISFORM.PAGEFRAME1.PAGE2.LBLF142.VISIBLE=.F.
       	   THISFORM.PAGEFRAME1.PAGE2.LBLF14.VISIBLE=.T.
       	   THISFORM.PAGEFRAME1.PAGE2.TXTF14.VALUE=DTOC(B68_3.F14)
      ELSE
      	   IF LEFT(ALLTRIM(B68_3.F01),2)='BV'
      	       THISFORM.PAGEFRAME1.PAGE2.LBLF14.VISIBLE=.F.
      	       THISFORM.PAGEFRAME1.PAGE2.LBLF142.VISIBLE=.F.
      	       THISFORM.PAGEFRAME1.PAGE2.LBLF141.VISIBLE=.T.
       	       THISFORM.PAGEFRAME1.PAGE2.TXTF14.VALUE=B68_3.F08
       	  ELSE
       	       THISFORM.PAGEFRAME1.PAGE2.LBLF14.VISIBLE=.F.
      	       THISFORM.PAGEFRAME1.PAGE2.LBLF141.VISIBLE=.F.
      	       THISFORM.PAGEFRAME1.PAGE2.LBLF142.VISIBLE=.T.
       	       THISFORM.PAGEFRAME1.PAGE2.TXTF14.VALUE=B68_3.F08
       	  ENDIF
      ENDIF 
      DO CASE
      	     CASE  LEFT(ALLTRIM(B68_3.F01),2)='BW'
      	     		THISFORM.PAGEFRAME1.PAGE2.TXTF98.VALUE='借至'+B68_1.F54
      	     		RETURN
             CASE  LEFT(ALLTRIM(B68_3.F01),2)='BV'
       	     		THISFORM.PAGEFRAME1.PAGE2.TXTF98.VALUE='還出'+B68_1.F54
      	     		RETURN	 		
       ENDCASE
       if thisform.pageframe1.activepage=1
          thisform. CMDGROUP.SEEK_BOTT.ENABLED=.F.
       ENDIF   
  ENDPROC 
**************************************            
 PROC KEY_LIST.INIT 
       with this 
           .additem('依公司簡稱排列')
       endwith      
  ENDPROC 
****************************  
  PROC KEY_LIST.INTERACTIVECHANGE                 
       SELE B68_1 
       SET ORDER TO B68_11
               THISFORM.GRID1.COLUMN1.HEADER1.CAPTION='公司簡稱'
               THISFORM.GRID1.COLUMN1.CONTROLSOURCE='B68_1.F54'
               THISFORM.GRID1.COLUMN1.WIDTH=INT_015*60                                             
       THISFORM.grid1.SETFOCUS
  ENDPROC  
**************************
PROC MTH_LIST.INIT        
       with this
            SELECT * FROM A23 WHERE F01>CTOD('91/10/01') INTO CURSOR A231
            GO TOP
            K=0
            S=0
            DO WHILE !EOF()                
               K=K+1
		.ADDITEM(left(dtoc(A231.F01),5))
            IF LEFT(DTOC(DATE()),5)=left(dtoc(A231.F01),5)
                  S=K
               ENDIF       
               SKIP
            ENDDO   
            .VALUE=S
       ENDWITH
       MTH_STR=THIS.DISPLAYVALUE   
  ENDPROC 
 **************************       
  PROC MTH_LIST.INTERACTIVECHANGE
       THISFORM.GRID1.RECORDSOURCE=''
       THISFORM.GRID2.RECORDSOURCE=''
       THISFORM.GRID2.LINKMASTER=''
       THISFORM.GRID2.RELATIONALEXPR=''
       THISFORM.GRID2.childorder=''
       CLOSE ALL
       SET EXCL OFF
IF ! USED('A01')
   SELE 0
   USE A01 INDE A01
ELSE
   SELE A01
ENDIF      
SET ORDER TO A01        
B62='B62'+LEFT(DTOS(CTOD(THIS.DISPLAYVALUE+'/01')),6)&&還出單
 IF FILE(B62+'.DBF')=.T. 
       IF !USED('&B62')
          SELE 0
          USE (B62) ALIA B62
       ELSE 
          SELE B62
       ENDIF
       SET ORDER TO 1 
 ELSE
  	CREATE CURSOR B62;
 	(F01 C(1),F02 C(1),F03 C(1),F04 N(1),F05 C(1),F06 C(1),F07 C(1),F08 C(1),F09 C(1),F10 C(1),F11 C(1),F12 C(1),F13 C(1)) 
 ENDIF	        
B63='B63'+LEFT(DTOS(CTOD(THIS.DISPLAYVALUE+'/01')),6)&&借出單
 IF FILE(B63+'.DBF')=.T.
       IF !USED('&B63')
          SELE 0 
          USE (B63) ALIA B63
       ELSE
          SELE B63
       ENDIF
          SET ORDER TO 1
ELSE
	CREATE CURSOR B63;
 	(F01 C(1),F02 C(1),F03 C(1),F04 N(1),F05 C(1),F06 C(1),F07 C(1),F08 C(1),F09 C(1),F10 C(1),F11 C(1),F12 C(1),F13 C(1),F14 D(1))       
ENDIF
 CREATE CURSOR B68_2;
(F01 C(10),F02 C(2),F03 C(43),F04 N(11),F07 C(20),F10 C(5),F14 D(8),EXP_8 B(2),F38 B(4),F08 C(10))
INDE ON F10 TAG B68_21
***********************
SELECT  B62.F01,B62.F02,B62.F03,B62.F04,B62.F07,B62.F10,B01.F38*B62.F04,B01.F38,B62.F08 FROM B01,B62  WHERE B01.F01=B62.F03   INTO CURSOR B682
SELECT B682
GO TOP
DO WHILE !EOF()
	SELECT B68_2
	APPEND BLANK
	REPLACE F01 WITH B682.F01
	REPLACE F02 WITH B682.F02
	REPLACE F03 WITH B682.F03
	REPLACE F04 WITH B682.F04
	REPLACE F07 WITH B682.F07
	REPLACE F10 WITH B682.F10
	REPLACE EXP_8 WITH B682.EXP_7
	REPLACE F38 WITH B682.F38
	REPLACE F08 WITH B682.F08
	SELECT B682
   	SKIP
ENDDO 
SELECT B682
USE
SELECT B68_2
SET ORDER TO 1
**************************
SELECT  B63.F01,B63.F02,B63.F03,B63.F04,B63.F07,B63.F10,B63.F14,B01.F38*B63.F04,B01.F38,B63.F08 FROM B01,B63  WHERE B01.F01=B63.F03   INTO CURSOR B683
SELECT B683
GO TOP
DO WHILE !EOF()
	SELECT B68_2
	APPEND BLANK
	REPLACE F01 WITH B683.F01
	REPLACE F02 WITH B683.F02
	REPLACE F03 WITH B683.F03
	REPLACE F04 WITH B683.F04
	REPLACE F07 WITH B683.F07
	REPLACE F10 WITH B683.F10
	REPLACE F14 WITH B683.F14
	REPLACE EXP_8 WITH B683.EXP_8
	REPLACE F38 WITH B683.F38
	SELECT B683
   	SKIP
ENDDO
SELECT B683
USE
SELECT B68_2
SET ORDER TO 1
******************
SELECT  B68_2.*,B01.F02 FROM B68_2,B01 WHERE B68_2.F03=B01.F01  INTO CURSOR B683
SELECT  B683.*,C01.F05 FROM B683,C01 WHERE B683.F10=C01.F01 INTO CURSOR C01B
SELECT  B683.*,D01.F04 FROM B683,D01 WHERE B683.F10=D01.F01 INTO CURSOR D01B
 CREATE CURSOR B68_3;
(F01 C(10),F02 C(2),F03 C(43),F04 N(11),F07 C(20),F10 C(5),F14 D(8),EXP_8 B(2),F38 B(4),F021 C(40),F54 C(10),F08 C(10),F99 C(15))
INDE ON F54+F03 TAG B68_31
SELECT C01B
GO TOP
DO WHILE !EOF()
	SELECT B68_3
	APPEND BLANK
	REPLACE F01 WITH C01B.F01
	REPLACE F02 WITH C01B.F02_A
	REPLACE F03 WITH C01B.F03
	REPLACE F04 WITH 0-C01B.F04
	REPLACE F07 WITH C01B.F07
	REPLACE F10 WITH C01B.F10
	REPLACE F14 WITH C01B.F14
	REPLACE EXP_8 WITH 0-C01B.EXP_8
	REPLACE F38 WITH C01B.F38
	REPLACE F021 WITH C01B.F02_B
	REPLACE F54 WITH C01B.F05
	REPLACE F08 WITH C01B.F08
	DO CASE
	       CASE LEFT(ALLTRIM(C01B.F01),2)='BW'
	       		  REPLACE F99 WITH '借出'
	       CASE LEFT(ALLTRIM(C01B.F01),2)='BV'
	   	          REPLACE F99 WITH '還出'
	ENDCASE
	SELECT C01B
   	SKIP
ENDDO
SELECT C01B
USE
SELECT B68_3
SET ORDER TO 1
SELECT D01B
GO TOP
DO WHILE !EOF()
	SELECT B68_3
	APPEND BLANK
	REPLACE F01 WITH D01B.F01
	REPLACE F02 WITH D01B.F02_A
	REPLACE F03 WITH D01B.F03
	REPLACE F04 WITH 0-D01B.F04_A
	REPLACE F07 WITH D01B.F07
	REPLACE F10 WITH D01B.F10
	REPLACE F14 WITH D01B.F14
	REPLACE EXP_8 WITH 0-D01B.EXP_8
	REPLACE F38 WITH D01B.F38
	REPLACE F021 WITH D01B.F02_B
	REPLACE F54 WITH D01B.F04_B
	REPLACE F08 WITH D01B.F08
	DO CASE
	       CASE LEFT(ALLTRIM(D01B.F01),2)='BW'
	       		  REPLACE F99 WITH '借出'
	       CASE LEFT(ALLTRIM(D01B.F01),2)='BV'
	   	          REPLACE F99 WITH '還出'
	ENDCASE
	SELECT D01B
   	SKIP
ENDDO
SELECT D01B
SELECT  * FROM B68_3  ORDER BY F02 INTO CURSOR B68_3
INDE ON F54+F03 TAG B68_31
GO TOP
SET ORDER TO 1
**************************表頭
CREATE CURSOR B68_1 (F54 C(10),F43 C(40))
INDE ON F54 TAG B68_11
SELECT C01.F05,C01.F04 FROM B68_3,C01 WHERE  B68_3.F10=C01.F01 INTO CURSOR B68C
SELECT B68C
GO TOP
DO WHILE !EOF()
	SELECT B68_1
	APPEND BLANK
	REPLACE F54 WITH B68C.F05
	REPLACE F43 WITH B68C.F04
	SELECT B68C
   	SKIP
ENDDO
SELECT B68C
USE
SELECT D01.F04,D01.F03 FROM B68_3,D01 WHERE  B68_3.F10=D01.F01 INTO CURSOR B68D
SELECT B68D
GO TOP
DO WHILE !EOF()
	SELECT B68_1
	APPEND BLANK
	REPLACE F54 WITH B68D.F04
	REPLACE F43 WITH B68D.F03
	SELECT B68D
   	SKIP
ENDDO
SELECT B68D
USE
SELECT B68_1
SELECT  DISTINCT F54,F43 FROM  B68_1   INTO CURSOR B68_1
INDE ON F54 TAG B68_11
SELECT B68_1
GO TOP
SET ORDER TO 1
********************
       THISFORM.GRID1.RECORDSOURCE='B68_1'
       THISFORM.GRID2.RECORDSOURCE='B68_3'
       THISFORM.GRID2.LINKMASTER='B68_1'
       THISFORM.GRID2.RELATIONALEXPR='F54'      
       THISFORM.GRID2.CHILDORDER='B68_31' 
       IF IIF(SEEK(SYS_OPER,'A01'),A01.F04,'')='P000'  
           THISFORM.grid2.COLUMN1.CONTROLSOURCE='B68_3.F03'
	   THISFORM.grid2.COLUMN2.CONTROLSOURCE='B68_3.F02'
	   THISFORM.grid2.COLUMN3.CONTROLSOURCE='B68_3.F01'
	   THISFORM.grid2.COLUMN4.CONTROLSOURCE='B68_3.F04'
	   THISFORM.grid2.COLUMN5.CONTROLSOURCE='B68_3.F38'
	   THISFORM.grid2.COLUMN6.CONTROLSOURCE='B68_3.EXP_8'
	   THISFORM.grid2.COLUMN7.CONTROLSOURCE='B68_3.F14'
	   THISFORM.grid2.COLUMN8.CONTROLSOURCE='B68_3.F08' 
           THISFORM.grid2.COLUMN9.CONTROLSOURCE='B68_3.F07'  
       ELSE
           THISFORM.grid2.COLUMN1.CONTROLSOURCE='B68_3.F03'
	   THISFORM.grid2.COLUMN2.CONTROLSOURCE='B68_3.F02'
	   THISFORM.grid2.COLUMN3.CONTROLSOURCE='B68_3.F01'
	   THISFORM.grid2.COLUMN4.CONTROLSOURCE='B68_3.F04'
	   THISFORM.grid2.COLUMN5.CONTROLSOURCE='B68_3.F14'
	   THISFORM.grid2.COLUMN6.CONTROLSOURCE='B68_3.F08' 
           THISFORM.grid2.COLUMN7.CONTROLSOURCE='B68_3.F07'
           THISFORM.grid2.COLUMN8.CONTROLSOURCE=''
	   THISFORM.grid2.COLUMN9.CONTROLSOURCE=''        
	ENDIF   
       THISFORM.KEY_LIST.INTERACTIVECHANGE
	   THISFORM.PAGEFRAME1.ACTIVEPAGE=1
	   THISFORM.REFRESH
	   thisform.grid1.setfocus        
       IF THISFORM.GRID1.ACTIVEROW=0
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.
       ELSE
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.      
       ENDIF 
       MTH_STR=THIS.DISPLAYVALUE
 ENDPROC
 *************************************************************列印
 PROCEDURE PNT_MTH.CLICK
 	SELECT * FROM B68_3 ORDER BY F54 INTO CURSOR B68
 	REPORT FORM ALLTRIM(INT_116)+'B68_B' TO PRINT PROMPT PREVIEW
  	 CLEAR
 ENDPROC       
 ENDDEFINE  
  *************************************************************列印
PROCEDURE PNT_PRC  
	PO_NO=B68_1.F54
	PO_NAME=B68_1.F43
	SELECT * FROM B68_3 WHERE F54=PO_NO INTO CURSOR B68
   	REPORT FORM ALLTRIM(INT_116)+'B68_A' TO PRINT PROMPT PREVIEW
     CLEAR     
ENDPROC   
************************
FUNC BILL
     PARA JUK
     JO=''
     DO CASE
        CASE JUK='BW'
             JO='借出單'
        CASE JUK='BV'
             JO='借入還出單'
     ENDCASE
RETURN JO 