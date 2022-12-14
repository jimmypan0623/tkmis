******E08.製令缺料表
close all
clear 
FLG='0'
FCH=''
CHK=''
R=0
AREA1='A1D'
AREA2='E0H'
IF !USED('A14')
   SELE 0
   USE A14 INDE A14
ELSE
   SELE A14
ENDIF
SET ORDER TO A141
GO TOP
IF !USED('E16')
   SELECT 0
   USE E16
ELSE
   SELECT E16
ENDIF
SET ORDER TO E166
SELECT E16.F06,A14.F02 FROM E16,A14 WHERE A14.F01=E16.F06 AND E16.F04>0 GROUP BY E16.F06 ORDER BY E16.F06 INTO CURSOR A14_1 NOWAIT
IF _TALLY>0
   CREATE CURSOR A1D (F01 C(5),F02 C(8))
   INDEX ON F01 TAG A1D1
   SELECT A14_1
   GO TOP
   DO WHILE !EOF()
      SELECT A1D
      APPEND BLANK
      REPLACE F01 WITH A14_1.F06
      REPLACE F02 WITH A14_1.F02
      SELECT A14_1
      SKIP
   ENDDO
   SELECT A14_1
   USE 
   SELECT A1D
   SET ORDER TO A1D1
ELSE
   =MESSAGEBOX('無製令領料計劃!',0+48,'提示訊息視窗')
   CLOSE TABLES ALL
   RETURN       
ENDIF   
SELECT F02 FROM E16 GROUP BY F02 INTO CURSOR E16_3 WHERE F04>0 ORDER BY F02 NOWAIT
IF _TALLY>0
   CREATE CURSOR E0K (F01 C(43))
   INDEX ON F01 TAG E0K1
   SELECT E16_3
   GO TOP
   DO WHILE !EOF()
      SELECT E0K
      APPEND BLANK
      REPLACE F01 WITH E16_3.F02
      SELECT E16_3
      SKIP
   ENDDO
   SELECT E16_3
   USE
    SELECT E0K
    SET ORDER TO 1   
ENDIF

SELECT F06,F02,SUM(F04) FROM E16 GROUP BY F06,F02 WHERE F04>0 INTO CURSOR E16_2 ORDER BY F06,F02 NOWAIT
IF _TALLY>0
    CREATE CURSOR E0H (F01 C(5),F03 C(43),F04 N(16,4))
    INDEX ON F01+F03 TAG E0H1
    INDEX ON F03+F01 TAG E0H2
    SELECT E16_2
    GO TOP
    DO WHILE !EOF()
       SELECT E0H
       APPEND BLANK
       REPLACE F01 WITH E16_2.F06
       REPLACE F03 WITH E16_2.F02
       REPLACE F04 WITH E16_2.SUM_F04
       SELECT E16_2
       SKIP
    ENDDO
    SELECT E16_2
    USE
    SELECT E0H
    SET ORDER TO E0H1
ENDIF    
             SELE F01,F02,F03,F04 FROM D07 UNION ALL SELE F01,F02,F03,F04*(-1) FROM C05 WHERE F02= ANY(SELE F02 FROM E16) INTO CURSOR TKE081             
             SELE F01,F02,F03,F04 FROM E06 UNION ALL SELE F01,F02,F03,F04*(-1) FROM E16 WHERE F02= ANY(SELE F02 FROM E16) INTO CURSOR TKE082
             CREATE CURSOR TKE08 (F01 C(12),F02 C(43),F03 D(8),F04 N(13,4))
             INDEX ON F02+DTOS(F03)+F01 TAG TKE08
             SET ORDER TO 1
             SELE TKE081
             GO TOP
             DO WHILE !EOF()
                SELE TKE08
                APPEND BLANK
                REPL F01 WITH TKE081.F01
                REPL F02 WITH TKE081.F02
                REPL F03 WITH TKE081.F03
                REPL F04 WITH TKE081.F04
                SELE TKE081
                SKIP
             ENDDO
             SELE TKE081
             USE
             SELE TKE082
             GO TOP
             DO WHILE !EOF()
                SELE TKE08
                APPEND BLANK
                REPL F01 WITH TKE082.F01
                REPL F02 WITH TKE082.F02
                REPL F03 WITH TKE082.F03
                REPL F04 WITH TKE082.F04
                SELE TKE082
                SKIP
             ENDDO             
             SELE TKE082
             USE


SELECT E16
USE
IF !USED('C01')
   SELECT 0
   USE C01
ELSE 
   SELECT C01
ENDIF      
SET ORDER TO C011
IF !USED('D01')
   SELECT 0
   USE D01
ELSE 
   SELECT D01
ENDIF      
SET ORDER TO D011   
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
SEEK sys_oper+'E08'
IF !USED('B01')
   SELE 0
   USE B01 
ELSE
   SELE B01
ENDIF
SET ORDER TO 1   
if !used('B11')
   SELE 0
   USE B11
ELSE
   SELE B11
ENDIF
SET FILTER TO F01<>INT_190
SET ORDER TO B112  
SELECT F01,F03,SUM(F04) FROM B11 GROUP BY F01,F03 ORDER BY F03,F01 INTO CURSOR B11_2 NOWAIT
CREATE CURSOR B11_1 (F01 C(5),F03 C(43),F04 N(14,4))
INDEX ON F03+F01 TAG B11_12
SET ORDER TO B11_12
SELECT B11_2
GO TOP
DO WHILE !EOF()
   SELECT B11_1
   APPEND BLANK
   REPLACE F01 WITH B11_2.F01
   REPLACE F03 WITH B11_2.F03
   REPLACE F04 WITH B11_2.SUM_F04
   SELECT B11_2
   SKIP
ENDDO
SELECT B11_2
USE
SELECT E0H
SET RELATION TO F03+F01 INTO B11_1 
SET RELATION TO F03 INTO B01 ADDI
E08form=createobject("tkE08")
E08form.show  
define class tkE08 as form
  caption='E08.製令缺料表'
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
  width=INT_015*789
  windowtype=1
  NAME='TKE08'
  add object shape1 as shape1 with;
      autocenter=.t.
  ADD OBJECT LBL_REC AS LBL_REC WITH;
      AUTOCENTER =.T.
  ADD OBJECT REC_COUNT AS REC_COUNT  with;
      caption=str(reccount())        
  add object shape2 as shape2 with;
      autocenter=.t.
  add object shape3 as shape3 with;
      autocenter=.t.
  ADD OBJECT INV_BOTT AS COMMANDBUTTON WITH;
      TOP=INT_015*490,;
      LEFT=INT_015*75,;
      HEIGHT=INT_015*25,;
      WIDTH=INT_015*70,;
      FONTSIZE=INT_015*9,;
      CAPTION='\<V.庫存明細',;
      NAME='INV_BOTT'      
  ADD OBJECT IODT_BOTT AS COMMANDBUTTON WITH;
      TOP=INT_015*490,;
      LEFT=INT_015*10,;
      HEIGHT=INT_015*25,;
      WIDTH=INT_015*65,;
      CAPTION='\<Z.預期進出',;
      FONTSIZE=INT_015*9,;
      ENABLED=.T.,;
      VISIBLE=.T.            
  ADD OBJECT PAGEFRAME1 AS PAGEFRAME WITH;
      LEFT=INT_015*236,;
      WIDTH=INT_015*540,;
      HEIGHT=INT_015*200,;
      PAGECOUNT=2,;
      TABSTRETCH=1,;
      ACTIVEPAGE=1,;
      VISIBLE=.T.,;
      PAGE1.NAME='PAGE1',;
      PAGE1.VISIBLE=.T.,;
      PAGE1.CAPTION='依照部門搜尋紀錄',;
      PAGE2.NAME='PAGE2',;
      PAGE2.VISIBLE=.T.,;
      PAGE2.CAPTION='詳細資料內容'   
  ADD OBJECT KEY_LIST AS KEY_LIST WITH;
      AUTOCENTER=.T.
  ADD OBJECT grid1 AS grid1 WITH;
      columncount=2,;            
      RECORDSOURCE='A1D',;
      COLUMN1.NAME='COLUMN1',;
      COLUMN2.NAME='COLUMN2'      
  ADD OBJECT grid2 AS grid2 WITH;
      columncount=5,;            
      RECORDSOURCE='E0H',;
      LINKMASTER='A1D',;
      RELATIONALEXPR='F01',;
      CHILDORDER='E0H1',;      
      COLUMN1.NAME='COLUMN1',;
      COLUMN2.NAME='COLUMN2',;
      COLUMN3.NAME='COLUMN3',;
      COLUMN4.NAME='COLUMN4',;
      COLUMN5.NAME='COLUMN5'
  ADD OBJECT CMDGROUP AS CMDGROUP WITH;
      TOP=INT_015*415,;
      LEFT=INT_015*10,;
      ENABLED=.T.,;
      VISIBLE=.T.  
  ADD OBJECT ORPGROUP AS ORPGROUP WITH;
      TOP=INT_015*455,;
      LEFT=INT_015*10                            
  PROCEDURE PAGEFRAME1.PAGE1.INIT     
     THIS.ADDOBJECT('LBLF01','LABEL')
     WITH THIS.LBLF01
          .VISIBLE=.T.
          .LEFT=INT_015*14
          .TOP=INT_015*27
          .WIDTH=INT_015*50
          .CAPTION='部門編號'          
     ENDWITH
     THIS.ADDOBJECT('LBLF011','LABEL')     
     WITH THIS.LBLF011
          .VISIBLE=.T.
          .LEFT=INT_015*140
          .TOP=INT_015*27
          .AUTOSIZE=.T.  
     ENDWITH            
     THIS.ADDOBJECT('TXTF01','TEXTBOX')     
     WITH THIS.TXTF01
          .VISIBLE=.T.
          .LEFT=INT_015*64
          .TOP=INT_015*23
          .WIDTH=INT_015*74
          .HEIGHT=INT_015*25
          .MAXLENGTH=5
     ENDWITH        
  ENDPROC   
  PROCEDURE PAGEFRAME1.PAGE2.INIT
	THIS.ADDOBJECT('LBLF01','LABEL')
	WITH THIS.LBLF01  
         .LEFT=INT_015*14
         .TOP=INT_015*13
	     .WIDTH=INT_015*50
         .CAPTION='部門編號'
    ENDWITH  
    THIS.ADDOBJECT('LBLF011','LABEL')
    WITH THIS.LBLF011
         .LEFT=INT_015*126
	     .TOP=INT_015*14
	     .autosize=.t.
	ENDWITH     
    THIS.ADDOBJECT('LBLF03','LABEL')
    WITH THIS.LBLF03
         .VISIBLE=.T.
	     .LEFT=INT_015*14
	     .TOP=INT_015*14
	     .WIDTH=INT_015*50
	     .CAPTION='品        號'
	ENDWITH     
    THIS.ADDOBJECT('LBLF031','Label')
    WITH THIS.LBLF031
         .VISIBLE=.T.
         .LEFT=INT_015*337
         .TOP=INT_015*14
         .WIDTH=INT_015*144         
    ENDWITH     
    THIS.ADDOBJECT('LBLF04','LABEL')
    WITH THIS.LBLF04
         .VISIBLE=.T.    
         .LEFT=INT_015*14
         .TOP=INT_015*39
         .WIDTH=INT_015*50
         .CAPTION='需求數量'       
    ENDWITH     
    THIS.ADDOBJECT('LBLF05','LABEL')
    WITH THIS.LBLF05
         .VISIBLE=.T.           
         .LEFT=INT_015*14
         .TOP=INT_015*64
         .WIDTH=INT_015*50
         .CAPTION='已領數量'
    ENDWITH     
    THIS.ADDOBJECT('LBLF06','LABEL')
    WITH THIS.LBLF06
         .VISIBLE=.T.           
         .LEFT=INT_015*14
         .TOP=INT_015*89
         .WIDTH=INT_015*50
         .CAPTION='缺/溢領量'
    ENDWITH     
	THIS.ADDOBJECT('TXTF01','TEXTBOX')
	WITH THIS.TXTF01      
	     .LEFT=INT_015*65
	     .TOP=INT_015*10
	     .WIDTH=INT_015*60
	     .HEIGHT=INT_015*25
	     .MAXLENGTH=5
	     .NAME='TXTF01'  
	ENDWITH     
	THIS.ADDOBJECT('TXTF03','TEXTBOX')
	WITH THIS.TXTF03
	     .VISIBLE=.T.
	     .LEFT=INT_015*65
	     .TOP=INT_015*10
	     .WIDTH=INT_015*261
	     .HEIGHT=INT_015*25
	     .MAXLENGTH=43
	     .NAME='TXTF03'	    
	ENDWITH     
    THIS.ADDOBJECT('TXTF04','TEXTBOX')
    WITH THIS.TXTF04
         .VISIBLE=.T.           
         .LEFT=INT_015*65
         .TOP=INT_015*35
         .WIDTH=INT_015*100
         .ALIGNMENT=1
         .NAME='TXTF04'
    ENDWITH     
    THIS.ADDOBJECT('TXTF05','TEXTBOX')
    WITH THIS.TXTF05     
         .VISIBLE=.T.           
         .LEFT=INT_015*65
         .TOP=INT_015*60
         .WIDTH=INT_015*100
         .ALIGNMENT=1         
         .NAME='TXTF05'
    ENDWITH     
    THIS.ADDOBJECT('TXTF06','TEXTBOX')
    WITH THIS.TXTF06
         .VISIBLE=.T.           
         .LEFT=INT_015*65
         .TOP=INT_015*85
         .WIDTH=INT_015*100
         .ALIGNMENT=1         
         .NAME='TXTF06'                 
    ENDWITH          
  ENDPROC       
  PROCEDURE PAGEFRAME1.PAGE1.activate
     R=0
     IF THISFORM.KEY_LIST.DISPLAYVALUE='依部門編號排列'
        SELE A1D
        THISFORM.INV_BOTT.ENABLED=.F.        
        THISFORM.IODT_BOTT.ENABLED=.F.                
     ELSE
        SELE E0K
        THISFORM.INV_BOTT.ENABLED=.T.
        THISFORM.IODT_BOTT.ENABLED=.T.                        
     ENDIF      
     SEEK THISFORM.PAGEFRAME1.PAGE1.TXTF01.VALUE 
        THISFORM.GRID1.ENABLED=.T.           
        THISFORM.GRID1.SETFOCUS                       
     IF THISFORM.GRID1.ACTIVEROW=0
        THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.F.      
        THISFORM.CMDGROUP.UP_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.END_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.
        THISFORM.PAGEFRAME1.PAGE1.TXTF01.VALUE=''
        THISFORM.PAGEFRAME1.PAGE1.LBLF011.CAPTION=''
     ELSE
        THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.T.      
        THISFORM.CMDGROUP.UP_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.END_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.
     ENDIF   
     THISFORM.KEY_LIST.ENABLED=.T.
  ENDPROC
  PROCEDURE PAGEFRAME1.PAGE2.activate
     SELE E0H
     THISFORM.GRID2.READONLY=.T.  
     THISFORM.GRID2.SETFOCUS 
     IF THISFORM.GRID2.ACTIVEROW=0 
        THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.F.      
        THISFORM.CMDGROUP.UP_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.END_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.
        THISFORM.PAGEFRAME1.PAGE2.SETALL('VALUE','','TEXTBOX')
        THISFORM.PAGEFRAME1.PAGE2.TXTF01.VALUE=''
        THISFORM.PAGEFRAME1.PAGE2.TXTF03.VALUE=''
        THISFORM.PAGEFRAME1.PAGE2.LBLF011.CAPTION=''
        THISFORM.PAGEFRAME1.PAGE2.LBLF031.CAPTION=''
     ELSE
        THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.T.      
        THISFORM.CMDGROUP.UP_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.END_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.  
        IF THISFORM.KEY_LIST.DISPLAYVALUE='依部門編號排列'
           THISFORM.INV_BOTT.ENABLED=.T. 
           THISFORM.IODT_BOTT.ENABLED=.T.                   
        ELSE
           THISFORM.INV_BOTT.ENABLED=.F.
           THISFORM.IODT_BOTT.ENABLED=.F.                              
        ENDIF              
     ENDIF   
     R=RECNO('&AREA1')
     THISFORM.GRID1.SETALL("DYNAMICBACKCOLOR","IIF(RECNO('&AREA1')=R,RGB(255,255,0),'')","COLUMN")
     THISFORM.GRID1.ENABLED=.F.     
     THISFORM.KEY_LIST.ENABLED=.F.     
  ENDPROC   
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
       THISFORM.GRID1.BACKCOLOR=IIF(SEEK(sys_oper,'A01'),IIF(A01.F11=0,10009146,A01.F11),10009146)
       THISFORM.GRID2.BACKCOLOR=IIF(SEEK(sys_oper,'A01'),IIF(A01.F11=0,10009146,A01.F11),10009146) 
       THISFORM.GRID1.COLUMN1.WIDTH=INT_015*50
       THISFORM.GRID1.COLUMN2.WIDTH=INT_015*50
       THISFORM.GRID1.COLUMN1.HEADER1.CAPTION='部門編號'
       THISFORM.GRID1.COLUMN2.HEADER1.CAPTION='部門名稱'
       THISFORM.GRID1.COLUMN1.CONTROLSOURCE='A1D.F01'
       THISFORM.GRID1.COLUMN2.CONTROLSOURCE='A1D.F02'
       thisform.GRID2.setall('FONTSIZE',INT_015*9,'COLUMN')
       thisform.GRID2.setall('FONTSIZE',INT_015*9,'HEADER')       
       THISFORM.grid2.COLUMN1.HEADER1.CAPTION='料品編號'
       THISFORM.grid2.COLUMN2.HEADER1.CAPTION='品名規格'
	   THISFORM.grid2.COLUMN3.HEADER1.CAPTION='需求數量'
	   THISFORM.grid2.COLUMN4.HEADER1.CAPTION='已領數量'
	   THISFORM.GRID2.COLUMN5.HEADER1.CAPTION='缺/溢領量'
	   THISFORM.grid2.COLUMN1.CONTROLSOURCE='E0H.F03'
	   THISFORM.grid2.COLUMN2.CONTROLSOURCE="B01.F02"
	   THISFORM.grid2.COLUMN3.CONTROLSOURCE='E0H.F04'
	   THISFORM.grid2.COLUMN4.CONTROLSOURCE='B11_1.F04'
	   THISFORM.grid2.COLUMN5.CONTROLSOURCE='B11_1.F04-E0H.F04'
	   THISFORM.grid2.COLUMN1.WIDTH=INT_015*149
	   THISFORM.GRID2.COLUMN2.WIDTH=INT_015*149
       THISFORM.grid2.COLUMN3.WIDTH=INT_015*80
       THISFORM.GRID2.COLUMN4.WIDTH=INT_015*80
       THISFORM.GRID2.COLUMN5.WIDTH=INT_015*80
       THISFORM.GRID2.SETALL("DYNAMICBACKCOLOR","IIF(B11_1.F04>E0H.F04,RGB(255,255,0),IIF(B11_1.F04<E0H.F04,RGB(255,0,0),''))","COLUMN")                                 
       THISFORM.grid1.READONLY=.T.    
       THISFORM.grid2.READONLY=.T.       
       THISFORM.grid1.SETFOCUS
       IF THISFORM.GRID1.ACTIVEROW=0
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.
       ELSE
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.      
       ENDIF          
       THISFORM.KEY_LIST.DISPLAYVALUE='依部門編號排列'       
       JK='部門編號'
       SELE A1D
       GO TOP
       THISFORM.PAGEFRAME1.PAGE1.TXTF01.VALUE=A1D.F01
       THISFORM.PAGEFRAME1.PAGE1.LBLF011.CAPTION=A1D.F02
  ENDPROC           
  PROC KEY_LIST.INIT 
       with this 
           .additem('依部門編號排列')
           .additem('依料品編號排列')
       endwith      
  ENDPROC 
  PROC KEY_LIST.INTERACTIVECHANGE                 
       THISFORM.GRID1.RECORDSOURCE=''
       THISFORM.GRID1.CHILDORDER=''
       DO CASE
          CASE THIS.DISPLAYVALUE='依部門編號排列'
               AREA1='A1D'                 
               THISFORM.PAGEFRAME1.PAGE1.CAPTION='依照部門搜尋紀錄'
               SELECT E0K
               SET RELATION OFF INTO B01
               SELECT E0H
               SET RELATION OFF INTO A14
               SET RELATION TO F03 INTO B01 ADDI
               SET ORDER TO E0H1                    
               SELE A1D
               GO TOP
               THISFORM.PAGEFRAME1.PAGE1.LBLF01.CAPTION='部門編號'
               THISFORM.PAGEFRAME1.PAGE1.TXTF01.WIDTH=INT_015*74
               THISFORM.PAGEFRAME1.PAGE1.TXTF01.MAXLENGTH=5
               THISFORM.PAGEFRAME1.PAGE1.TXTF01.VALUE=A1D.F01
               THISFORM.PAGEFRAME1.PAGE1.LBLF011.LEFT=INT_015*140
               THISFORM.PAGEFRAME1.PAGE1.LBLF011.CAPTION=A1D.F02
               THISFORM.PAGEFRAME1.PAGE2.LBLF01.VISIBLE=.F.
               THISFORM.PAGEFRAME1.PAGE2.LBLF011.VISIBLE=.F.
               THISFORM.PAGEFRAME1.PAGE2.TXTF01.VISIBLE=.F.
               THISFORM.PAGEFRAME1.PAGE2.TXTF01.ENABLED=.F.
               THISFORM.PAGEFRAME1.PAGE2.LBLF03.VISIBLE=.T.
               THISFORM.PAGEFRAME1.PAGE2.LBLF031.VISIBLE=.T.
               THISFORM.PAGEFRAME1.PAGE2.TXTF03.VISIBLE=.T.
               THISFORM.PAGEFRAME1.PAGE2.TXTF03.ENABLED=.T.
               THISFORM.GRID1.RECORDSOURCE='A1D'
               THISFORM.GRID1.COLUMN1.HEADER1.CAPTION='部門編號'
               THISFORM.GRID1.COLUMN2.HEADER1.CAPTION='部門名稱'
               THISFORM.GRID1.COLUMN1.CONTROLSOURCE='A1D.F01'
               THISFORM.GRID1.COLUMN2.CONTROLSOURCE='A1D.F02'   
               THISFORM.GRID1.COLUMN1.WIDTH=INT_015*50
               THISFORM.GRID1.COLUMN2.WIDTH=INT_015*50
               THISFORM.GRID2.LINKMASTER='A1D'
               THISFORM.GRID2.RELATIONALEXPR='F01'
               THISFORM.GRID2.CHILDORDER='E0H1'            
               THISFORM.grid2.COLUMN1.HEADER1.CAPTION='料品編號'
               THISFORM.grid2.COLUMN1.CONTROLSOURCE='E0H.F03'
               THISFORM.grid2.COLUMN1.WIDTH=INT_015*149
               THISFORM.grid2.COLUMN2.HEADER1.CAPTION='品名規格'
               THISFORM.grid2.COLUMN2.CONTROLSOURCE='B01.F02'   
               THISFORM.grid2.COLUMN2.WIDTH=INT_015*100                     
          CASE THIS.DISPLAYVALUE='依料品編號排列'
               AREA1='E0K'          
               THISFORM.PAGEFRAME1.PAGE1.CAPTION='依照料號搜尋紀錄'          
               SELECT E0H
               SET RELATION OFF INTO B01
               SET RELATION TO F01 INTO A14 ADDI
               SET ORDER TO E0H2
               SELE E0K
               SET ORDER TO E0K1
               SET RELATION TO F01 INTO B01               
               GO TOP
               SET RELA TO F01 INTO B01
               THISFORM.PAGEFRAME1.PAGE1.LBLF01.CAPTION='料品編號'
               THISFORM.PAGEFRAME1.PAGE1.TXTF01.WIDTH=INT_015*261
               THISFORM.PAGEFRAME1.PAGE1.TXTF01.MAXLENGTH=43
               THISFORM.PAGEFRAME1.PAGE1.TXTF01.VALUE=E0K.F01
               THISFORM.PAGEFRAME1.PAGE1.LBLF011.LEFT=INT_015*337
               THISFORM.PAGEFRAME1.PAGE1.LBLF011.CAPTION=B01.F02
               THISFORM.PAGEFRAME1.PAGE2.LBLF01.VISIBLE=.T.
               THISFORM.PAGEFRAME1.PAGE2.LBLF011.VISIBLE=.T.
               THISFORM.PAGEFRAME1.PAGE2.TXTF01.VISIBLE=.T.
               THISFORM.PAGEFRAME1.PAGE2.TXTF01.ENABLED=.T.
               THISFORM.PAGEFRAME1.PAGE2.LBLF03.VISIBLE=.F.
               THISFORM.PAGEFRAME1.PAGE2.LBLF031.VISIBLE=.F.
               THISFORM.PAGEFRAME1.PAGE2.TXTF03.VISIBLE=.F.
               THISFORM.PAGEFRAME1.PAGE2.TXTF03.ENABLED=.F.                
               THISFORM.GRID1.RECORDSOURCE='E0K'
               THISFORM.GRID1.COLUMN1.HEADER1.CAPTION='料品編號'
               THISFORM.GRID1.COLUMN2.HEADER1.CAPTION='品名規格'
               THISFORM.GRID1.COLUMN1.CONTROLSOURCE='E0K.F01'
               THISFORM.GRID1.COLUMN2.CONTROLSOURCE='B01.F02'
               THISFORM.GRID1.COLUMN1.WIDTH=INT_015*149
               THISFORM.GRID1.COLUMN2.WIDTH=INT_015*149   
               THISFORM.GRID2.LINKMASTER='E0K'
               THISFORM.GRID2.RELATIONALEXPR='F03'
               THISFORM.GRID2.CHILDORDER='E0H2'  
               THISFORM.grid2.COLUMN1.HEADER1.CAPTION='部門編號'
               THISFORM.grid2.COLUMN1.CONTROLSOURCE='E0H.F01'
               THISFORM.grid2.COLUMN1.WIDTH=INT_015*50               
               THISFORM.grid2.COLUMN2.HEADER1.CAPTION='部門名稱'
               THISFORM.grid2.COLUMN2.CONTROLSOURCE='A14.F02'       
               THISFORM.grid2.COLUMN2.WIDTH=INT_015*50                                        
       ENDCASE 
        THISFORM.PAGEFRAME1.ACTIVEPAGE=2
        THISFORM.PAGEFRAME1.ACTIVEPAGE=1
        SELE &AREA1
        THISFORM.grid1.SETFOCUS
  ENDPROC      
  PROC grid1.AFTERROWCOLCHANGE
       LPARAMETERS nColIndex
       IF THISFORM.KEY_list.DISPLAYVALUE='依部門編號排列'
          THISFORM.PAGEFRAME1.PAGE1.TXTF01.VALUE=A1D.F01
          THISFORM.PAGEFRAME1.PAGE1.LBLF011.CAPTION=A1D.F02
       ELSE          
          THISFORM.PAGEFRAME1.page1.TXTF01.VALUE=E0K.F01
          THISFORM.PAGEFRAME1.PAGE1.LBLF011.CAPTION=B01.F02
       ENDif

       FCH=THISFORM.ACTIVECONTROL.NAME
       JK=THIS.COLUMN1.HEADER1.CAPTION  
       IF THIS.ACTIVEROW=0
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.
       ELSE
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.
       ENDIF   
       CHK=''     
       thisform.refresh
  ENDPROC     
  PROC grid2.AFTERROWCOLCHANGE
       LPARAMETERS nColIndex
       THISFORM.PAGEFRAME1.PAGE2.TXTF01.VALUE=E0H.F01
       THISFORM.PAGEFRAME1.PAGE2.LBLF011.CAPTION=A14.F02
       THISFORM.PAGEFRAME1.PAGE2.TXTF03.VALUE=E0H.F03
       THISFORM.PAGEFRAME1.PAGE2.LBLF031.CAPTION=B01.F02
       THISFORM.PAGEFRAME1.PAGE2.TXTF04.VALUE=E0H.F04
       THISFORM.PAGEFRAME1.PAGE2.TXTF05.VALUE=B11_1.F04
       THISFORM.PAGEFRAME1.PAGE2.TXTF06.VALUE=B11_1.F04-E0H.F04
       FCH=THISFORM.ACTIVECONTROL.NAME
       JK=THIS.COLUMN1.HEADER1.CAPTION
       CHK=THISFORM.PAGEFRAME1.PAGE1.TXTF01.VALUE
       if thisform.pageframe1.activepage=1
          thisform. CMDGROUP.SEEK_BOTT.ENABLED=.F.
       ENDIF   
  ENDPROC 
  **********查看庫存明細
  PROC INV_BOTT.CLICK
         IF !USED('B1A')
            SELECT 0
            USE B1A
         ELSE
            SELECT B1A
         ENDIF
         SET ORDER TO 1  
         THISFORM.CMDGROUP.SETALL('FORECOLOR',RGB(128,128,128),'COMMANDBUTTON')
         THISFORM.ORPGROUP.SETALL('FORECOLOR',RGB(128,128,128),'COMMANDBUTTON')
         THISFORM.INV_BOTT.FORECOLOR=RGB(128,128,128)  
         THISFORM.IODT_BOTT.FORECOLOR=RGB(128,128,128)                         
         SELE B11.F01,B11.F03,A14.F02,B11.F04,B11.F05,B11.F08 FROM B11,A14 WHERE B11.F01<>INT_190 AND B11.F03=E0H.F03 AND A14.F01=B11.F01  INTO CURSOR INV ORDER BY B11.F01
         INV_SEEK=CREATEOBJECT("INV_SEEK")  
         INV_SEEK.SHOW                  
         IF THISFORM.KEY_LIST.DISPLAYVALUE='依部門編號排列'
            AREA1='A1D'
         ELSE
            AREA1='E0K'
         ENDIF   
         THISFORM.CMDGROUP.SETALL('FORECOLOR',RGB(0,0,0),'COMMANDBUTTON')
         THISFORM.ORPGROUP.SETALL('FORECOLOR',RGB(0,0,0),'COMMANDBUTTON')
         THISFORM.INV_BOTT.FORECOLOR=RGB(0,0,0)                  
         THISFORM.IODT_BOTT.FORECOLOR=RGB(0,0,0)                           
         
         THISFORM.GRID1.SETFOCUS
  ENDPROC           
*********************************查看進出明細
  PROC IODT_BOTT.CLICK
            THISFORM.CMDGROUP.SETALL('FORECOLOR',RGB(128,128,128),'COMMANDBUTTON')
            THISFORM.ORPGROUP.SETALL('FORECOLOR',RGB(128,128,128),'COMMANDBUTTON')
            THISFORM.INV_BOTT.FORECOLOR=RGB(128,128,128)    
            THISFORM.IODT_BOTT.FORECOLOR=RGB(128,128,128)                
            LK=E0H.F03
            LV=DATE()
            SELE D07.F01,D07.F03,D07.F04,D07.F05,D07.F07,D07.F09 FROM D07 WHERE D07.F02=LK   INTO CURSOR IODT1 ORDER BY D07.F03 NOWAIT&&
            SELE E06.F01,E06.F03,E06.F04,E06.F05,E06.F07,E06.F09 FROM E06 WHERE E06.F02=LK   INTO CURSOR IODT3  ORDER BY E06.F03 NOWAIT&&            
            SELE C05.F01,C05.F03,C05.F04,C05.F06 FROM C05 WHERE C05.F02=LK  INTO CURSOR IODT2  ORDER BY C05.F03 NOWAIT&&
            SELE E16.F01,E16.F03,E16.F04,E16.F06 FROM E16 WHERE E16.F02=LK  INTO CURSOR IODT4 ORDER BY E16.F03 NOWAIT&&         
            CREATE CURSOR IODT(F01 C(12),F03 D(8),F04 N(13,3),F08 N(13,3),F05 C(50))
            INDE ON DTOS(F03)+F01 TAG IODT
            SET ORDER TO 1
            SELE IODT1
            GO TOP
            DO WHILE !EOF()
               SELE IODT
               APPEND BLANK
               REPL F01 WITH IODT1.F01
               REPL F03 WITH IODT1.F03
               REPL F04 WITH IODT1.F04
               REPL F05 WITH '採:'+IODT1.F05+PADL(IIF(SEEK(IODT1.F05,'D01'),D01.F04,''),8,' ')+IIF(IODT1.F09='1','  ','><')+IIF(!EMPTY(IODT1.F07),'請:','')+IODT1.F07
               SELE IODT1
               SKIP
            ENDDO   
            USE
            SELE IODT3
            GO TOP
            DO WHILE !EOF()
               SELE IODT
               APPEND BLANK
               REPL F01 WITH IODT3.F01
               REPL F03 WITH IODT3.F03
               REPL F04 WITH IODT3.F04
               REPL F05 WITH '產:'+IODT3.F05+PADL(IIF(SEEK(IODT3.F05,'A14'),A14.F02,''),8,' ')+IIF(IODT3.F09='1','  ','><')+'出:'+IODT3.F07+IIF(SEEK(IODT3.F07,'C01'),C01.F05,'')
               SELE IODT3
               SKIP
            ENDDO   
            USE
            SELE IODT2
            GO TOP
            DO WHILE !EOF()
               SELE IODT
               APPEND BLANK
               REPL F01 WITH IODT2.F01
               REPL F03 WITH IODT2.F03
               REPL F04 WITH IODT2.F04*(-1)
               REPL F05 WITH '出:'+IODT2.F06+IIF(SEEK(IODT2.F06,'C01'),C01.F05,'')
               SELE IODT2
               SKIP
            ENDDO   
            USE
            SELE IODT4
            GO TOP
            DO WHILE !EOF()
               SELE IODT
               APPEND BLANK
               REPL F01 WITH IODT4.F01
               REPL F03 WITH IODT4.F03
               REPL F04 WITH IODT4.F04*(-1)
               REPL F05 WITH '領:'+IODT4.F06+IIF(SEEK(IODT4.F06,'A14'),A14.F02,'')           
               SELE IODT4
               SKIP
            ENDDO       
            USE                               
                ORD_NO=''
                STD_NO=E0H.F03            
                DTE_NO=DATE()
               IODT_SEEK=CREATEOBJECT("IODT_SEEK")  
               IODT_SEEK.SHOW           
         THISFORM.CMDGROUP.SETALL('FORECOLOR',RGB(0,0,0),'COMMANDBUTTON')
         THISFORM.ORPGROUP.SETALL('FORECOLOR',RGB(0,0,0),'COMMANDBUTTON')
         THISFORM.INV_BOTT.FORECOLOR=RGB(0,0,0)                  
         THISFORM.IODT_BOTT.FORECOLOR=RGB(0,0,0)                                        
         IF THISFORM.KEY_LIST.DISPLAYVALUE='依部門編號排列'
            AREA1='A1D'
         ELSE
            AREA1='E0K'
         ENDIF   
         IF THISFORM.PAGEFRAME1.ACTIVEPAGE=1
            THISFORM.GRID1.SETFOCUS
         ELSE
            THISFORM.GRID2.SETFOCUS
         ENDIF            
**********  
ENDDEFINE    


************************************************************
PROCEDURE PNT_PRC  
    IF AREA1='A1D'
       LK=A1D.F01
       LV=A1D.F02
       SELECT E0H.F03,B01.F02,E0H.F04,IIF(SEEK(E0H.F03+E0H.F01,'B11_1','B11_12'),B11_1.F04,0) FROM E0H,B01 WHERE E0H.F01=LK AND B01.F01=E0H.F03 NOWAIT
       IF _TALLY>0
          REPORT FORM ALLTRIM(INT_116)+'E08A' TO PRINT PROMPT PREVIEW          
       ENDIF       
    ELSE
       LK=E0K.F01
       SELECT E0H.F01,A14.F02,E0H.F04,IIF(SEEK(E0H.F03+E0H.F01,'B11_1','B11_12'),B11_1.F04,0) FROM E0H,A14 WHERE E0H.F03=LK AND A14.F01=E0H.F01 NOWAIT
       IF _TALLY>0
          REPORT FORM ALLTRIM(INT_116)+'E08B' TO PRINT PROMPT PREVIEW          
       ENDIF              
    ENDIF 
ENDPROC
