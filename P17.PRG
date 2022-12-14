********P17.JW進貨費用明細彙總表*****
SET EXCL OFF
CLOSE ALL
CLEAR 
AREA1='P17_1'
AREA2='P17_3'
FLG='0'
FCH=''
CHK=''
CHK_STR=''
R=0
QTY=0
TQTY=0
DATA_STR=''			&&資料期間
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
SEEK SYS_OPER+'P17'	
********************
P17FORM=CREATEOBJECT("TKP17")
P17FORM.SHOW       
DEFINE CLASS TKP17 AS FORM
*!*	  AUTOCENTER=.T.
  CAPTION='請選擇您所需要彙總日期範圍'
  LEFT=INT_015*200
  TOP=INT_015*230  
  FONTSIZE=INT_015*9
  HEIGHT=INT_015*80
  WIDTH=INT_015*380
  FONTSIZE=INT_015*9
  MAXBUTTON=.F.
  MINBUTTON=.F.  
  CONTROLBOX=.F.
  CLOSABLE=.F.
  BORDERSTYLE=1
  SHOWTIPS=.T.
  SHOWWINDOW=1
  WINDOWTYPE=1
  NAME='TKP17'      
  ADD OBJECT LBLF01 AS LABEL WITH;
      LEFT=INT_015*25,;
      TOP=INT_015*30,;
      WIDTH=INT_015*50,;
      CAPTION='起始年月'
  ADD OBJECT MTH_LIST1 AS MTH_LIST WITH;
      LEFT=INT_015*75,;
      TOP=INT_015*25,;
      FONTSIZE=INT_015*9,;
      WIDTH=INT_015*65        
  ADD OBJECT LBLF02 AS LABEL WITH;
      LEFT=INT_015*160,;
      TOP=INT_015*30,;
      WIDTH=INT_015*50,;
      CAPTION='截止年月'
  ADD OBJECT MTH_LIST2 AS MTH_LIST WITH;
      LEFT=INT_015*215,;
      TOP=INT_015*25,;
      FONTSIZE=INT_015*9,;
      WIDTH=INT_015*65            
  ADD OBJECT CMND1 AS COMMANDBUTTON WITH;
      LEFT=INT_015*300,;     
      TOP=INT_015*10,;  
      HEIGHT=INT_015*25,;    
      WIDTH=INT_015*50,;
      CAPTION='\<Y.確定',;
      TOOLTIPTEXT='確認所選擇的鍵值!快速鍵->ALT+Y',;
      NAME='CMND1'
  ADD OBJECT CMND2 AS COMMANDBUTTON WITH;
      LEFT=INT_015*300,;
      TOP=INT_015*45,;
      HEIGHT=INT_015*25,;    
      WIDTH=INT_015*50,;
      CAPTION='\<X.離開',;
      TOOLTIPTEXT='離開此作業!快速鍵->ALT+X',;
      NAME='CMND2'  
 PROCEDURE INIT 
         THISFORM.SETALL('FONTSIZE',INT_015*9,'LABEL')
         THISFORM.SETALL('FONTSIZE',INT_015*9,'COMMANDBUTTON')  
 ENDPROC      
  PROC MTH_LIST1.INIT        
       IF !USED('A23')
	    SELECT  0
	    USE A23
       ELSE 
	    SELECT  A23
       ENDIF
       SET ORDER TO A231    
       SELECT  LEFT(DTOS(A23.F01),6) FROM A23 ORDER BY A23.F01  INTO CURSOR A23A
       SELECT A23A
       GO TOP
       WITH THIS
            K=0
            S=0
            DO WHILE !EOF()                
                   K=K+1
                  .ADDITEM(LEFT(A23A.EXP_1,4) + '/' + RIGHT(A23A.EXP_1,2))
                   IF LEFT(DTOS(DATE()),6)=A23A.EXP_1
                       S=K
                   ENDIF       
                   SKIP
            ENDDO   
            .VALUE=S
       ENDWITH   
       SELECT A23
       USE
       SELECT A23A
       USE 
  ENDPROC 
  PROC MTH_LIST2.INIT        
       IF !USED('A23')
	    SELECT  0
	    USE A23
       ELSE 
	    SELECT  A23
       ENDIF
       SET ORDER TO A231    
       SELECT  LEFT(DTOS(A23.F01),6) FROM A23 ORDER BY A23.F01  INTO CURSOR A23A
       SELECT A23A
       GO TOP
       WITH THIS
            K=0
            S=0
            DO WHILE !EOF()                
                   K=K+1
                  .ADDITEM(LEFT(A23A.EXP_1,4) + '/' + RIGHT(A23A.EXP_1,2))
                   IF LEFT(DTOS(DATE()),6)=A23A.EXP_1
                       S=K
                   ENDIF       
                   SKIP
            ENDDO   
            .VALUE=S
       ENDWITH   
       SELECT A23
       USE
       SELECT A23A
       USE 
  ENDPROC   
PROCEDURE CMND1.CLICK
   DATA_STR = THISFORM.MTH_LIST1.DISPLAYVALUE + ' ∼ ' + THISFORM.MTH_LIST2.DISPLAYVALUE
    IF ALLTRIM(THISFORM.MTH_LIST1.DISPLAYVALUE) > ALLTRIM(THISFORM.MTH_LIST2.DISPLAYVALUE)
        =MESSAGEBOX('起始日起不得大於截止日期!',0+64,'提示訊息視窗')
        THISFORM.MTH_LIST1.SETFOCUS
        RETURN
    ENDIF    
    IF !USED('B01')
        SELE 0
        USE B01 
    ELSE
        SELE B01
    ENDIF
    SET ORDER TO B011    
    WAIT WINDOW "資料匯入中,請稍後!" AT 0,150 NOWAIT NOCLEAR
    **依送貨單號
    CREATE CURSOR P17_1 (F01 C(6),F02 N(12,2),F03 C(43),F04 C(17),F10 C(10),F11 C(10),F12 C(7),F13 C(7))
    INDE ON F01+F13 TAG P17_11
    **依料品編號     
    CREATE CURSOR P17_2 (F05 C(43),B01F02 C(40),F10 C(10),F11 C(10))
    INDE ON F05 TAG P17_21 
    SET ORDER TO P17_21    
    **表身內容
    CREATE CURSOR P17_3 (F01 C(6),F02 N(12,2),F03 C(43),F04 C(17),F05 C(43),B01F02 C(40),F06 N(12,3),F07 N(16,6),F08 N(10,6),F09 N(12,2),F10 C(10),F11 C(10),F12 C(7),F13 C(7))
    INDE ON F01+F05 TAG P17_31    
    INDE ON F05+F01+F13 TAG P17_32 
    ***彙總P17月份檔
    S1=LEFT(DTOS(CTOD(ALLTRIM(THISFORM.MTH_LIST1.DISPLAYVALUE)+'/01')),6)
    H1='P17'+ALLTRIM(S1)
    F1=ALLTRIM(H1)+'.DBF'
    S2=LEFT(DTOS(CTOD(ALLTRIM(THISFORM.MTH_LIST2.DISPLAYVALUE)+'/01')),6)
    H2='P17'+ALLTRIM(S2)
    F2=ALLTRIM(H2)+'.DBF'
    DO WHILE  FILE('&F1')=.T.   
	   IF !USED('&F1')
	        SELE 0
	        USE &F1 
	   ELSE
	        SELE &F1
	   ENDIF    
	   **依送貨單號
	   SELECT F01,F02,F03,F04,F10,F11,F12 FROM &F1  GROUP BY F01 ORDER BY F01 INTO CURSOR P18_1
	   SELECT P18_1
	   GO TOP
           DO  WHILE !EOF()
                   SELECT P17_1
                   APPEND BLANK 
                   REPLACE P17_1.F01 WITH P18_1.F01 
                   REPLACE P17_1.F02 WITH P18_1.F02 
                   REPLACE P17_1.F03 WITH P18_1.F03 
                   REPLACE P17_1.F04 WITH P18_1.F04 
                   REPLACE P17_1.F10 WITH P18_1.F10 
                   REPLACE P17_1.F11 WITH P18_1.F11 
                   REPLACE P17_1.F12 WITH P18_1.F12
                   REPLACE P17_1.F13 WITH LEFT(ALLTRIM(S1),4) + '/' + RIGHT(ALLTRIM(S1),2)
                   SELECT P18_1
                   SKIP
           ENDDO	
           SELECT P18_1
           USE
           **依料品編號    
	   SELECT F05,F10,F11 FROM &F1 GROUP BY F05 ORDER BY F05 INTO CURSOR P18_2
	   SELECT P18_2
	   GO TOP
           DO  WHILE !EOF()  
               IF INDEXSEEK(P18_2.F05,.F.,'P17_2','P17_21') = .F.
                   SELECT P17_2
                   APPEND BLANK 
                   REPLACE P17_2.F05 WITH P18_2.F05 
                   REPLACE P17_2.B01F02 WITH IIF(SEEK(P18_2.F05,'B01'),B01.F02,'')
                   REPLACE P17_2.F10 WITH P18_2.F10 
                   REPLACE P17_2.F11 WITH P18_2.F11 
                ENDIF   
                   SELECT P18_2
                   SKIP
           ENDDO	
           SELECT P18_2
           USE
           **表身內容             
	   SELECT &H1
	   GO TOP	    
           DO  WHILE !EOF()
                   SELECT P17_3
                   APPEND BLANK 
                   REPLACE P17_3.F01 WITH &H1..F01 
                   REPLACE P17_3.F02 WITH &H1..F02
                   REPLACE P17_3.F03 WITH &H1..F03
                   REPLACE P17_3.F04 WITH &H1..F04
                   REPLACE P17_3.F05 WITH &H1..F05
                   REPLACE P17_3.F06 WITH &H1..F06
                   REPLACE P17_3.F07 WITH &H1..F07
                   REPLACE P17_3.F08 WITH &H1..F08
                   REPLACE P17_3.F09 WITH &H1..F09
                   REPLACE P17_3.F10 WITH &H1..F10
                   REPLACE P17_3.F11 WITH &H1..F11
                   REPLACE P17_3.F12 WITH &H1..F12
                   REPLACE P17_3.B01F02 WITH IIF(SEEK(&H1..F05,'B01'),B01.F02,'')
                   REPLACE P17_3.F13 WITH LEFT(ALLTRIM(S1),4) + '/' + RIGHT(ALLTRIM(S1),2)
                   SELECT &H1
                   SKIP
           ENDDO
           SELECT &H1
           USE
           ***
           IF  H1=H2
	        EXIT 
*!*		        USE
	   ENDIF  
	   IF  ALLTRIM(STR(VAL(RIGHT(S1,2))+1))='13'
	         S1=ALLTRIM(STR(VAL(LEFT(S1,4))+1)+'01')
	   	 H1='P17'+ALLTRIM(S1)
	         F1=ALLTRIM(H1)+'.DBF'  
	   ELSE
	         S1=ALLTRIM(STR(VAL(S1)+1))
	         H1='P17'+ALLTRIM(S1)
	         F1=ALLTRIM(H1)+'.DBF'  
	   ENDIF             
    ENDDO
    WAIT CLEAR
    SELECT B01
    USE
    SELECT P17_3
    SET ORDER TO P17_31
    SELECT P17_1
    SET ORDER TO P17_11
    GO TOP  
    ****   
    P17PFORM=CREATEOBJECT("TKP17P")  
    P17PFORM.SHOW  
    THISFORM.CMND2.CLICK	 
 ENDPROC      
 **************************      
 PROCEDURE CMND2.CLICK       
      CLOSE TABLE ALL
      THISFORM.RELEASE 
      RETURN  
 ENDPROC      
ENDDEFINE
****
***********        
DEFINE CLASS TKP17P AS FORM
  CAPTION='P17.JW進貨費用明細彙總表' + '      資料期間：' + DATA_STR 
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
  WIDTH=INT_015*789
  WINDOWTYPE=1
  NAME='TKB99B'
  ADD OBJECT SHAPE1 AS SHAPE1 WITH;
      AUTOCENTER=.T.
  ADD OBJECT SHAPE2 AS SHAPE2 WITH;
      AUTOCENTER=.T.
  ADD OBJECT SHAPE3 AS SHAPE3 WITH;
      AUTOCENTER=.T.
 ADD OBJECT EXCEL_BOTT AS COMMANDBUTTON WITH;
      TOP=INT_015*490,;
      LEFT=INT_015*152,;
      HEIGHT=INT_015*25,;
      WIDTH=INT_015*65,;
      FONTSIZE=INT_015*9,;    
      CAPTION='\<T.轉EXCEL',;
      NAME='EXCEL_BOTT'                  
  ADD OBJECT PAGEFRAME1 AS PAGEFRAME WITH;
      LEFT=INT_015*236,;
      WIDTH=INT_015*540,;
      HEIGHT=INT_015*200,;
      FONTSIZE=INT_015*9,;
      PAGECOUNT=2,;
      TABSTRETCH=1,;
      ACTIVEPAGE=1,;
      VISIBLE=.T.,;
      MOUSEPOINTER=99,;
      MOUSEICON='BMPS\harrow.cur',;         
      PAGE1.NAME='PAGE1',;
      PAGE1.VISIBLE=.T.,;
      PAGE1.CAPTION='表頭資料',;
      PAGE2.NAME='PAGE2',;
      PAGE2.VISIBLE=.T.,;
      PAGE2.CAPTION='表身詳細資料內容'    
  ADD OBJECT KEY_LIST AS KEY_LIST WITH;
      AUTOCENTER=.T.
  ADD OBJECT GRID1 AS GRID1 WITH;
      COLUMNCOUNT=2,;            
      RECORDSOURCE='P17_1',;      
      COLUMN1.NAME='COLUMN1',;
      COLUMN2.NAME='COLUMN2'      
  ADD OBJECT GRID2 AS GRID2 WITH;
      COLUMNCOUNT=7,;            
      RECORDSOURCE='P17_3',; 
      LINKMASTER='P17_1',;
      RELATIONALEXPR='F01',;
      CHILDORDER='P17_31',;  
      COLUMN1.NAME='COLUMN1',;
      COLUMN2.NAME='COLUMN2',;
      COLUMN3.NAME='COLUMN3',;
      COLUMN4.NAME='COLUMN4',;
      COLUMN5.NAME='COLUMN5',;
      COLUMN6.NAME='COLUMN6',;
      COLUMN7.NAME='COLUMN7'                
  ADD OBJECT CMDGROUP AS CMDGROUP WITH;
      AUTOSIZE=.T.              
  ADD OBJECT ORPGROUP AS ORPGROUP WITH;    
      AUTOSIZE=.T.              
  ADD OBJECT SHRGROUP AS SHRGROUP WITH;
      TOP=INT_015*173,;
      LEFT=INT_015*558       
  PROCEDURE PAGEFRAME1.PAGE1.INIT     
     THIS.ADDOBJECT('LBLF01','LABEL')
     WITH THIS.LBLF01
          .VISIBLE=.T.
          .LEFT=INT_015*14
          .TOP=INT_015*13
          .WIDTH=INT_015*50
          .CAPTION='送貨單號'          
     ENDWITH
     THIS.ADDOBJECT('LBLF02','LABEL')     
     WITH THIS.LBLF02
          .VISIBLE=.T.
          .LEFT=INT_015*14
          .TOP=INT_015*63
          .WIDTH=INT_015*50  
          .CAPTION='進貨費用'
     ENDWITH            
     THIS.ADDOBJECT('LBLF03','LABEL')
     WITH THIS.LBLF03
         .VISIBLE=.T.
         .LEFT=INT_015*14
         .TOP=INT_015*138
         .WIDTH=INT_015*50
         .CAPTION='備註說明'
     ENDWITH    
     THIS.ADDOBJECT('LBLF04','LABEL')
     WITH THIS.LBLF04
         .VISIBLE=.T.
         .LEFT=INT_015*368
         .TOP=INT_015*63
         .WIDTH=INT_015*50
         .CAPTION='安全資料'
     ENDWITH    
     THIS.ADDOBJECT('LBLF041','LABEL')
     WITH THIS.LBLF041
         .VISIBLE=.T.
         .LEFT=INT_015*419
         .TOP=INT_015*63
         .AUTOSIZE=.T.
     ENDWITH    
     THIS.ADDOBJECT('TXTF01','TEXTBOX')          
     WITH THIS.TXTF01
          .VISIBLE=.T.
          .LEFT=INT_015*64
          .TOP=INT_015*9
          .WIDTH=INT_015*81
          .HEIGHT=INT_015*25
          .MAXLENGTH=6
     ENDWITH        

     THIS.ADDOBJECT('TXTF02','TEXTBOX')          
     WITH THIS.TXTF02
          .VISIBLE=.T.
          .LEFT=INT_015*64
          .TOP=INT_015*59
          .WIDTH=INT_015*100
          .HEIGHT=INT_015*25
          .INPUTMASK='9999999.99'
     ENDWITH        
     THIS.ADDOBJECT('TXTF03','TEXTBOX')          
     WITH THIS.TXTF03
          .VISIBLE=.T.
          .LEFT=INT_015*64
          .TOP=INT_015*134
          .WIDTH=INT_015*261
          .HEIGHT=INT_015*25
          .MAXLENGTH=36
     ENDWITH      
  ENDPROC   
  PROCEDURE PAGEFRAME1.PAGE2.INIT
	THIS.ADDOBJECT('LBLF05','LABEL')
	WITH THIS.LBLF05  
	     .VISIBLE=.T.
         .LEFT=INT_015*14
         .TOP=INT_015*18
	     .WIDTH=INT_015*50
         .CAPTION='料品編號'
    ENDWITH  
    THIS.ADDOBJECT('LBLF051','LABEL')
    WITH THIS.LBLF051
         .VISIBLE=.T.
         .LEFT=INT_015*330
	     .TOP=INT_015*18
	     .AUTOSIZE=.T.
	ENDWITH     
    THIS.ADDOBJECT('LBLF06','Label')
    WITH THIS.LBLF06
         .VISIBLE=.T.
         .LEFT=INT_015*14
         .TOP=INT_015*43
         .WIDTH=INT_015*50
         .CAPTION='進貨數量'         
    ENDWITH     
    THIS.ADDOBJECT('LBLF07','Label')
    WITH THIS.LBLF07
         .VISIBLE=.T.
         .LEFT=INT_015*14
         .TOP=INT_015*68
         .WIDTH=INT_015*50
         .CAPTION='進貨單價'         
    ENDWITH         
    THIS.ADDOBJECT('LBLFTL','Label')
    WITH THIS.LBLFTL
         .VISIBLE=.T.
         .LEFT=INT_015*14
         .TOP=INT_015*93
         .WIDTH=INT_015*50
         .CAPTION='金額小計'         
    ENDWITH             
    THIS.ADDOBJECT('LBLFTL1','Label')
    WITH THIS.LBLFTL1
         .VISIBLE=.T.
         .LEFT=INT_015*65
         .TOP=INT_015*93
         .AUTOSIZE=.T.
         .CAPTION=''         
    ENDWITH                 
    THIS.ADDOBJECT('LBLF08','Label')
    WITH THIS.LBLF08
         .VISIBLE=.T.
         .LEFT=INT_015*14
         .TOP=INT_015*118
         .WIDTH=INT_015*50
         .CAPTION='百 分 比'         
    ENDWITH             
    THIS.ADDOBJECT('LBLF09','Label')
    WITH THIS.LBLF09
         .VISIBLE=.T.
         .LEFT=INT_015*14
         .TOP=INT_015*143
         .WIDTH=INT_015*50
         .CAPTION='分攤金額'         
    ENDWITH           
    THIS.ADDOBJECT('LBLF10','Label')
    WITH THIS.LBLF10
         .VISIBLE=.T.
         .LEFT=INT_015*255
         .TOP=INT_015*118
         .WIDTH=INT_015*50
         .CAPTION='進貨單號'         
    ENDWITH             
    THIS.ADDOBJECT('LBLF11','Label')
    WITH THIS.LBLF11
         .VISIBLE=.T.
         .LEFT=INT_015*255
         .TOP=INT_015*143
         .WIDTH=INT_015*50
         .CAPTION='採購單號'         
    ENDWITH                
	THIS.ADDOBJECT('TXTF05','TEXTBOX')
	WITH THIS.TXTF05      
	     .VISIBLE=.T.
	     .LEFT=INT_015*65
	     .TOP=INT_015*14
	     .WIDTH=INT_015*261
	     .HEIGHT=INT_015*25
	     .MAXLENGTH=43
	     .NAME='TXTF05'  
	ENDWITH         
	THIS.ADDOBJECT('TXTF06','TEXTBOX')
	WITH THIS.TXTF06      
	     .VISIBLE=.T.
	     .LEFT=INT_015*65
	     .TOP=INT_015*39
	     .WIDTH=INT_015*100
	     .HEIGHT=INT_015*25
	     .INPUTMASK='99999999.999'
	     .NAME='TXTF06'  
	ENDWITH         	
	THIS.ADDOBJECT('TXTF07','TEXTBOX')
	WITH THIS.TXTF07      
	     .VISIBLE=.T.
	     .LEFT=INT_015*65
	     .TOP=INT_015*64
	     .WIDTH=INT_015*100
	     .HEIGHT=INT_015*25
	     .INPUTMASK='99999999.999999'
	     .NAME='TXTF07'  
	ENDWITH     
	THIS.ADDOBJECT('TXTF08','TEXTBOX')
	WITH THIS.TXTF08
	     .VISIBLE=.T.
	     .LEFT=INT_015*65
	     .TOP=INT_015*114
	     .WIDTH=INT_015*100
	     .HEIGHT=INT_015*25
	     .INPUTMASK='999.999999'
	     .NAME='TXTF08'	    
	ENDWITH     
	THIS.ADDOBJECT('TXTF09','TEXTBOX')
	WITH THIS.TXTF09
	     .VISIBLE=.T.
	     .LEFT=INT_015*65
	     .TOP=INT_015*139
	     .WIDTH=INT_015*100
	     .HEIGHT=INT_015*25
	     .INPUTMASK='999999999.99'
	     .NAME='TXTF09'	    
	ENDWITH    
	THIS.ADDOBJECT('TXTF10','TEXTBOX')
	WITH THIS.TXTF10
	     .VISIBLE=.T.
	     .LEFT=INT_015*310
	     .TOP=INT_015*114
	     .WIDTH=INT_015*100
	     .HEIGHT=INT_015*25
	     .NAME='TXTF10'	    
	ENDWITH     
	THIS.ADDOBJECT('TXTF11','TEXTBOX')
	WITH THIS.TXTF11
	     .VISIBLE=.T.
	     .LEFT=INT_015*310
	     .TOP=INT_015*139
	     .WIDTH=INT_015*100
	     .HEIGHT=INT_015*25
	     .NAME='TXTF11'	    
	ENDWITH 	 	
  ENDPROC        
  
  PROC INIT       
       THISFORM.PAGEFRAME1.PAGE1.FONTITALIC=.T.
       THISFORM.PAGEFRAME1.PAGE1.FORECOLOR=RGB(0,0,255)            
       THISFORM.PAGEFRAME1.PAGE1.FONTSIZE=INT_015*10
       THISFORM.PAGEFRAME1.PAGE2.FONTSIZE=INT_015*10         
       THISFORM.SETALL('HEIGHT',INT_015*25,'TEXTBOX')
       THISFORM.SETALL('HEIGHT',INT_015*17,'LABEL')
       THISFORM.SETALL('FONTSIZE',INT_015*9,'TEXTBOX')
       THISFORM.SETALL('FONTSIZE',INT_015*9,'LABEL')       
       THISFORM.SETALL('READONLY',.T.,'TEXTBOX')
       THISFORM.SHRGROUP.VISIBLE=.F.
       THISFORM.SHRGROUP.ENABLED=.F.
       THISFORM.GRID1.BACKCOLOR=IIF(SEEK(SYS_OPER,'A01'),IIF(A01.F11=0,10009146,A01.F11),10009146)
       THISFORM.GRID2.BACKCOLOR=IIF(SEEK(SYS_OPER,'A01'),IIF(A01.F11=0,10009146,A01.F11),10009146)
       THISFORM.GRID1.SETALL('FONTSIZE',INT_015*9,'COLUMN')
       THISFORM.GRID1.SETALL('FONTSIZE',INT_015*9,'HEADER')         
       THISFORM.GRID1.COLUMN1.HEADER1.CAPTION='送貨單號'
       THISFORM.GRID1.COLUMN1.CONTROLSOURCE='P17_1.F01'
       THISFORM.GRID1.COLUMN1.WIDTH=INT_015*80
       THISFORM.GRID1.COLUMN2.HEADER1.CAPTION='單據日期'
       THISFORM.GRID1.COLUMN2.CONTROLSOURCE='P17_1.F13'
       THISFORM.GRID1.COLUMN2.WIDTH=INT_015*60       
       THISFORM.GRID2.SETALL('FONTSIZE',INT_015*9,'COLUMN')
       THISFORM.GRID2.SETALL('FONTSIZE',INT_015*9,'HEADER')           
       THISFORM.GRID2.COLUMN1.HEADER1.CAPTION='料品編號'
       THISFORM.GRID2.COLUMN2.HEADER1.CAPTION='品名規格'
	   THISFORM.GRID2.COLUMN3.HEADER1.CAPTION='金額小計'	   
	   THISFORM.GRID2.COLUMN4.HEADER1.CAPTION='分攤百分比'
	   THISFORM.GRID2.COLUMN5.HEADER1.CAPTION='分攤金額'	   
	   THISFORM.GRID2.COLUMN6.HEADER1.CAPTION='進貨單號'	   
	   THISFORM.GRID2.COLUMN7.HEADER1.CAPTION='採購單號'	   	   	   
	   THISFORM.GRID2.COLUMN1.CONTROLSOURCE='P17_3.F05'
	   THISFORM.GRID2.COLUMN2.CONTROLSOURCE='P17_3.B01F02'
	   THISFORM.GRID2.COLUMN3.CONTROLSOURCE='ROUND(P17_3.F06 * P17_3.F07,0)'
	   THISFORM.GRID2.COLUMN4.CONTROLSOURCE='P17_3.F08'
	   THISFORM.GRID2.COLUMN5.CONTROLSOURCE='P17_3.F09'	   
	   THISFORM.GRID2.COLUMN6.CONTROLSOURCE='P17_3.F10'	   
	   THISFORM.GRID2.COLUMN7.CONTROLSOURCE='P17_3.F11'	   	   	   
	   THISFORM.GRID2.COLUMN1.WIDTH=INT_015*149
	   THISFORM.GRID2.COLUMN2.WIDTH=INT_015*100
       THISFORM.GRID2.COLUMN3.WIDTH=INT_015*90
       THISFORM.GRID2.COLUMN4.WIDTH=INT_015*90
       THISFORM.GRID2.COLUMN5.WIDTH=INT_015*90
       THISFORM.GRID2.COLUMN6.WIDTH=INT_015*80
       THISFORM.GRID2.COLUMN7.WIDTH=INT_015*80              
       THISFORM.GRID1.READONLY=.T.      
       THISFORM.GRID2.READONLY=.T.            
       THISFORM.GRID1.SETFOCUS
       THISFORM.ORPGROUP.NEW_BOTT.ENABLED=.F.
       THISFORM.ORPGROUP.EDIT_BOTT.ENABLED=.F.
       THISFORM.ORPGROUP.DEL_BOTT.ENABLED=.F.
       THISFORM.ORPGROUP.NEW_BOTT.VISIBLE=.F.
       THISFORM.ORPGROUP.EDIT_BOTT.VISIBLE=.F.
       THISFORM.ORPGROUP.DEL_BOTT.VISIBLE=.F.       
       IF THISFORM.GRID1.ACTIVEROW=0
          THISFORM.CMDGROUP.ENABLED=.F.
 
          THISFORM.ORPGROUP.PNT_BOTT.ENABLED=.F.
          THISFORM.EXCEL_BOTT.ENABLED=.F.
       ELSE
          THISFORM.CMDGROUP.ENABLED=.T.     
          THISFORM.ORPGROUP.PNT_BOTT.ENABLED=IIF(A02.F07='*',.T.,.F.)   &&判斷有無列印的權限       
          THISFORM.EXCEL_BOTT.ENABLED=.T.
       ENDIF          
       JK='送貨單號'
       SELE P17_1
       THISFORM.PAGEFRAME1.PAGE1.TXTF01.VALUE=P17_1.F01
  ENDPROC             
  
  PROCEDURE PAGEFRAME1.PAGE1.ACTIVATE
     R=0
     IF THISFORM.SHRGROUP.VISIBLE=.F.
        THISFORM.GRID1.ENABLED=.T.   
        THISFORM.GRID1.SETFOCUS   
        THISFORM.KEY_LIST.ENABLED=.T.
     ELSE
       THISFORM.KEY_LIST.ENABLED=.F.      
     ENDIF                
        THISFORM.PAGEFRAME1.PAGE1.FONTITALIC=.T.
        THISFORM.PAGEFRAME1.PAGE1.FORECOLOR=RGB(0,0,255)
        THISFORM.PAGEFRAME1.PAGE2.FONTITALIC=.F.
        THISFORM.PAGEFRAME1.PAGE2.FORECOLOR=RGB(0,0,0)         
    IF THISFORM.GRID1.ACTIVEROW=0 .AND. THISFORM.SHRGROUP.ENABLED=.F.
        THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.F.      
        THISFORM.CMDGROUP.UP_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.END_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.
        THISFORM.ORPGROUP.PNT_BOTT.ENABLED=.F.
        THISFORM.PAGEFRAME1.PAGE1.SETALL('VALUE','','TEXTBOX')        
        THISFORM.PAGEFRAME1.PAGE1.TXTF01.VALUE=''
        THISFORM.PAGEFRAME1.PAGE1.TXTF02.VALUE=0
        THISFORM.PAGEFRAME1.PAGE1.TXTF03.VALUE=''
        THISFORM.PAGEFRAME1.PAGE1.LBLF041.CAPTION=''                   
        THISFORM.PAGEFRAME1.PAGE2.ENABLED=.F.      
     ELSE
        THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.T.      
        THISFORM.CMDGROUP.UP_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.END_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.
        THISFORM.ORPGROUP.PNT_BOTT.ENABLED=IIF(A02.F07='*',.T.,.F.)    &&判斷有無列印的權限  
        THISFORM.PAGEFRAME1.PAGE2.ENABLED=.T.
     ENDIF   
  ENDPROC
  PROCEDURE PAGEFRAME1.PAGE2.ACTIVATE
     SELE P17_3
     IF THISFORM.SHRGROUP.ENABLED=.F.
        THISFORM.GRID2.READONLY=.T.   
        THISFORM.GRID2.SETFOCUS   
     ENDIF   
        THISFORM.PAGEFRAME1.PAGE1.FONTITALIC=.F.
        THISFORM.PAGEFRAME1.PAGE1.FORECOLOR=RGB(0,0,0)
        THISFORM.PAGEFRAME1.PAGE2.FONTITALIC=.T.
        THISFORM.PAGEFRAME1.PAGE2.FORECOLOR=RGB(0,0,255)        
     IF THISFORM.GRID2.ACTIVEROW=0 .AND. THISFORM.SHRGROUP.ENABLED=.F.
        THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.F.      
        THISFORM.CMDGROUP.UP_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.END_BOTT.ENABLED=.F.
        THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.
 
        THISFORM.ORPGROUP.PNT_BOTT.ENABLED=.F.
        THISFORM.PAGEFRAME1.PAGE2.SETALL('VALUE','','TEXTBOX')
        THISFORM.PAGEFRAME1.PAGE2.TXTF05.VALUE=''
        THISFORM.PAGEFRAME1.PAGE2.LBLF051.CAPTION=''
        THISFORM.PAGEFRAME1.PAGE2.LBLFTL1.CAPTION=''
     ELSE
        THISFORM.CMDGROUP.TOP_BOTT.ENABLED=.T.      
        THISFORM.CMDGROUP.UP_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.NEXT_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.END_BOTT.ENABLED=.T.
        THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.
 
        THISFORM.ORPGROUP.PNT_BOTT.ENABLED=IIF(A02.F07='*',.T.,.F.)    &&判斷有無列印的權限  
     ENDIF   
     R=RECNO('&AREA1')
     THISFORM.GRID1.SETALL("DYNAMICBACKCOLOR","IIF(RECNO('&AREA1')=R,RGB(255,255,0),'')","COLUMN")
     THISFORM.GRID1.ENABLED=.F.     
     THISFORM.ORPGROUP.NEW_BOTT.ENABLED=.F.
     THISFORM.KEY_LIST.ENABLED=.F.     
  ENDPROC       
  
  PROC GRID1.AFTERROWCOLCHANGE
       LPARAMETERS NCOLINDEX
       DO CASE 
              CASE THISFORM.KEY_LIST.DISPLAYVALUE='依入貨單號排列'       
		         SELECT P17_1
		         THISFORM.PAGEFRAME1.PAGE1.SETALL('VISIBLE',.T.,'TEXTBOX')
		         THISFORM.PAGEFRAME1.PAGE1.SETALL('VISIBLE',.T.,'LABEL')                    
		         THISFORM.PAGEFRAME1.PAGE1.LBLF01.CAPTION='送貨單號'
		         THISFORM.PAGEFRAME1.PAGE1.TXTF01.MAXLENGTH=6
		         THISFORM.PAGEFRAME1.PAGE1.TXTF01.WIDTH=INT_015*81	
		         THISFORM.PAGEFRAME1.PAGE1.LBLF02.CAPTION='進貨費用'
		         THISFORM.PAGEFRAME1.PAGE1.TXTF02.INPUTMASK='9999999.99'
		         THISFORM.PAGEFRAME1.PAGE1.TXTF02.WIDTH=INT_015*100		  
		         THISFORM.PAGEFRAME1.PAGE1.TXTF02.MAXLENGTH=10       	         
		         THISFORM.PAGEFRAME1.PAGE1.TXTF01.VALUE=P17_1.F01
		         THISFORM.PAGEFRAME1.PAGE1.TXTF02.VALUE=P17_1.F02
		         THISFORM.PAGEFRAME1.PAGE1.TXTF03.VALUE=P17_1.F03
		         THISFORM.PAGEFRAME1.PAGE1.LBLF041.CAPTION=P17_1.F04	         
              CASE THISFORM.KEY_LIST.DISPLAYVALUE='依料品編號排列'	
		         SELECT P17_2
		         THISFORM.PAGEFRAME1.PAGE1.SETALL('VISIBLE',.F.,'TEXTBOX')
		         THISFORM.PAGEFRAME1.PAGE1.SETALL('VISIBLE',.F.,'LABEL')      
		         THISFORM.PAGEFRAME1.PAGE1.TXTF01.VISIBLE=.T.
		         THISFORM.PAGEFRAME1.PAGE1.LBLF01.VISIBLE=.T.        
		         THISFORM.PAGEFRAME1.PAGE1.TXTF02.VISIBLE=.T.
		         THISFORM.PAGEFRAME1.PAGE1.LBLF02.VISIBLE=.T.    		         		                 
                         THISFORM.PAGEFRAME1.PAGE1.LBLF01.CAPTION='料品編號'
		         THISFORM.PAGEFRAME1.PAGE1.TXTF01.MAXLENGTH=43
		         THISFORM.PAGEFRAME1.PAGE1.TXTF01.WIDTH=INT_015*260                         
                         THISFORM.PAGEFRAME1.PAGE1.LBLF02.CAPTION='品名規格'
		         THISFORM.PAGEFRAME1.PAGE1.TXTF02.INPUTMASK=''
		         THISFORM.PAGEFRAME1.PAGE1.TXTF02.WIDTH=INT_015*300                        
                         THISFORM.PAGEFRAME1.PAGE1.TXTF02.MAXLENGTH=40
                         THISFORM.PAGEFRAME1.PAGE1.TXTF01.VALUE=P17_2.F05    
                         THISFORM.PAGEFRAME1.PAGE1.TXTF02.VALUE=P17_2.B01F02                     
       ENDCASE       	         
       FCH=THISFORM.ACTIVECONTROL.NAME
       JK=THIS.COLUMN1.HEADER1.CAPTION  
       IF THIS.ACTIVEROW=0
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.
       ELSE
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.
       ENDIF   
       CHK=''     
*       THISFORM.REFRESH
  ENDPROC     
  PROC GRID2.AFTERROWCOLCHANGE
       LPARAMETERS NCOLINDEX
       DO CASE 
              CASE THISFORM.KEY_LIST.DISPLAYVALUE='依入貨單號排列'              
		       THISFORM.PAGEFRAME1.PAGE2.LBLF05.CAPTION='料品編號'
		       THISFORM.PAGEFRAME1.PAGE2.TXTF05.MAXLENGTH=43
		       THISFORM.PAGEFRAME1.PAGE2.TXTF05.WIDTH=INT_015*261			       
		       THISFORM.PAGEFRAME1.PAGE2.TXTF05.VALUE=P17_3.F05
		       THISFORM.PAGEFRAME1.PAGE2.LBLF051.LEFT=INT_015*330
		       THISFORM.PAGEFRAME1.PAGE2.LBLF051.CAPTION=P17_3.B01F02
              CASE THISFORM.KEY_LIST.DISPLAYVALUE='依料品編號排列'	
		       THISFORM.PAGEFRAME1.PAGE2.LBLF05.CAPTION='送貨單號 '
		       THISFORM.PAGEFRAME1.PAGE2.TXTF05.MAXLENGTH=6
		       THISFORM.PAGEFRAME1.PAGE2.TXTF05.WIDTH=INT_015*100		       
		       THISFORM.PAGEFRAME1.PAGE2.TXTF05.VALUE=P17_3.F01
		       THISFORM.PAGEFRAME1.PAGE2.LBLF051.LEFT=INT_015*180
		       THISFORM.PAGEFRAME1.PAGE2.LBLF051.CAPTION='單據日期：' + P17_3.F13
       ENDCASE       	
       THISFORM.PAGEFRAME1.PAGE2.TXTF06.VALUE=P17_3.F06      
       THISFORM.PAGEFRAME1.PAGE2.TXTF07.VALUE=P17_3.F07
       THISFORM.PAGEFRAME1.PAGE2.TXTF08.VALUE=P17_3.F08       
       THISFORM.PAGEFRAME1.PAGE2.TXTF09.VALUE=P17_3.F09  
       THISFORM.PAGEFRAME1.PAGE2.TXTF10.VALUE=P17_3.F10 
       THISFORM.PAGEFRAME1.PAGE2.TXTF11.VALUE=P17_3.F11
       THISFORM.PAGEFRAME1.PAGE2.LBLFTL1.CAPTION=TRANSFORM(ROUND(P17_3.F06*P17_3.F07,0),'@R 999999999.99')       	       
       FCH=THISFORM.ACTIVECONTROL.NAME
       JK=THIS.COLUMN1.HEADER1.CAPTION
       CHK=THISFORM.PAGEFRAME1.PAGE1.TXTF01.VALUE
       IF THISFORM.PAGEFRAME1.ACTIVEPAGE=1
          THISFORM. CMDGROUP.SEEK_BOTT.ENABLED=.F.
       ENDIF   
*       THISFORM.REFRESH
  ENDPROC      
  
  PROC KEY_LIST.INIT 
       WITH THIS 
           .ADDITEM('依入貨單號排列')
           .ADDITEM('依料品編號排列')
           .VALUE=1
       ENDWITH             
  ENDPROC       
  
  PROC KEY_LIST.INTERACTIVECHANGE                 
     DO CASE 
           CASE THIS.DISPLAYVALUE='依入貨單號排列'
            	       AREA1='P17_1'
            	       SELECT P17_3
            	       SET ORDER TO P17_31
            	       SELECT P17_1
            	       SET ORDER TO P17_11
            	       GO TOP
            	       THISFORM.GRID1.RECORDSOURCE='P17_1'
            	       THISFORM.GRID2.RECORDSOURCE='P17_3'
	               THISFORM.GRID2.LINKMASTER='P17_1'
                       THISFORM.GRID2.RELATIONALEXPR='F01'       
                       THISFORM.GRID2.CHILDORDER='P17_31'    	       
		       THISFORM.GRID1.COLUMN1.HEADER1.CAPTION='送貨單號'
		       THISFORM.GRID1.COLUMN1.CONTROLSOURCE='P17_1.F01'
		       THISFORM.GRID1.COLUMN1.WIDTH=INT_015*80
		       THISFORM.GRID1.COLUMN2.HEADER1.CAPTION='單據日期'
		       THISFORM.GRID1.COLUMN2.CONTROLSOURCE='P17_1.F13'
		       THISFORM.GRID1.COLUMN2.WIDTH=INT_015*60            
		       THISFORM.GRID2.COLUMN1.HEADER1.CAPTION='料品編號'
		       THISFORM.GRID2.COLUMN2.HEADER1.CAPTION='品名規格'
		       THISFORM.GRID2.COLUMN3.HEADER1.CAPTION='金額小計'	   
		       THISFORM.GRID2.COLUMN4.HEADER1.CAPTION='分攤百分比'
		       THISFORM.GRID2.COLUMN5.HEADER1.CAPTION='分攤金額'	   
		       THISFORM.GRID2.COLUMN6.HEADER1.CAPTION='進貨單號'	   
		       THISFORM.GRID2.COLUMN7.HEADER1.CAPTION='採購單號'	   	   	   
		       THISFORM.GRID2.COLUMN1.CONTROLSOURCE='P17_3.F05'
		       THISFORM.GRID2.COLUMN2.CONTROLSOURCE='P17_3.B01F02'
		       THISFORM.GRID2.COLUMN3.CONTROLSOURCE='ROUND(P17_3.F06 * P17_3.F07,0)'
		       THISFORM.GRID2.COLUMN4.CONTROLSOURCE='P17_3.F08'
		       THISFORM.GRID2.COLUMN5.CONTROLSOURCE='P17_3.F09'	   
		       THISFORM.GRID2.COLUMN6.CONTROLSOURCE='P17_3.F10'	   
		       THISFORM.GRID2.COLUMN7.CONTROLSOURCE='P17_3.F11'	   	   	   
		       THISFORM.GRID2.COLUMN1.WIDTH=INT_015*149
		       THISFORM.GRID2.COLUMN2.WIDTH=INT_015*100
		       THISFORM.GRID2.COLUMN3.WIDTH=INT_015*90
		       THISFORM.GRID2.COLUMN4.WIDTH=INT_015*90
		       THISFORM.GRID2.COLUMN5.WIDTH=INT_015*90
		       THISFORM.GRID2.COLUMN6.WIDTH=INT_015*80
		       THISFORM.GRID2.COLUMN7.WIDTH=INT_015*80    		              	       
           CASE THIS.DISPLAYVALUE='依料品編號排列'
            	       AREA1='P17_2'
            	       SELECT P17_3
            	       SET ORDER TO P17_32
            	       SELECT P17_2
            	       SET ORDER TO P17_21  
            	       GO TOP   
            	       THISFORM.GRID1.RECORDSOURCE='P17_2'
            	       THISFORM.GRID2.RECORDSOURCE='P17_3'
	               THISFORM.GRID2.LINKMASTER='P17_2'
                       THISFORM.GRID2.RELATIONALEXPR='F05'       
                       THISFORM.GRID2.CHILDORDER='P17_32'               	       
		       THISFORM.GRID1.COLUMN1.HEADER1.CAPTION='料品編號'
		       THISFORM.GRID1.COLUMN1.CONTROLSOURCE='P17_2.F05'
		       THISFORM.GRID1.COLUMN1.WIDTH=INT_015*170
		       THISFORM.GRID1.COLUMN2.HEADER1.CAPTION='品名規格'
		       THISFORM.GRID1.COLUMN2.CONTROLSOURCE='P17_2.B01F02'
		       THISFORM.GRID1.COLUMN2.WIDTH=INT_015*200         
		       THISFORM.GRID2.COLUMN1.HEADER1.CAPTION='送貨單號'
		       THISFORM.GRID2.COLUMN2.HEADER1.CAPTION='單據日期'
		       THISFORM.GRID2.COLUMN3.HEADER1.CAPTION='金額小計'	   
		       THISFORM.GRID2.COLUMN4.HEADER1.CAPTION='分攤百分比'
		       THISFORM.GRID2.COLUMN5.HEADER1.CAPTION='分攤金額'	   
		       THISFORM.GRID2.COLUMN6.HEADER1.CAPTION='進貨單號'	   
		       THISFORM.GRID2.COLUMN7.HEADER1.CAPTION='採購單號'	   	   	   
		       THISFORM.GRID2.COLUMN1.CONTROLSOURCE='P17_3.F01'
		       THISFORM.GRID2.COLUMN2.CONTROLSOURCE='P17_3.F13'
		       THISFORM.GRID2.COLUMN3.CONTROLSOURCE='ROUND(P17_3.F06 * P17_3.F07,0)'
		       THISFORM.GRID2.COLUMN4.CONTROLSOURCE='P17_3.F08'
		       THISFORM.GRID2.COLUMN5.CONTROLSOURCE='P17_3.F09'	   
		       THISFORM.GRID2.COLUMN6.CONTROLSOURCE='P17_3.F10'	   
		       THISFORM.GRID2.COLUMN7.CONTROLSOURCE='P17_3.F11'	   	   	   
		       THISFORM.GRID2.COLUMN1.WIDTH=INT_015*80
		       THISFORM.GRID2.COLUMN2.WIDTH=INT_015*60
		       THISFORM.GRID2.COLUMN3.WIDTH=INT_015*90
		       THISFORM.GRID2.COLUMN4.WIDTH=INT_015*90
		       THISFORM.GRID2.COLUMN5.WIDTH=INT_015*90
		       THISFORM.GRID2.COLUMN6.WIDTH=INT_015*80
		       THISFORM.GRID2.COLUMN7.WIDTH=INT_015*80  	           	             
     ENDCASE
     THISFORM.GRID1.SETFOCUS
  ENDPROC     
  PROCEDURE EXCEL_BOTT.CLICK
     LK=P17_1.F01
     ANS_RANGE=CREATEOBJECT("ANS_RANGE")  
     ANS_RANGE.SHOW    

  ENDPROC  
 ENDDEFINE
************************************
DEFINE CLASS ANS_RANGE AS FORM
  AUTOCENTER=.T.
  FONTSIZE=INT_015*9
  HEIGHT=INT_015*80
  WIDTH=INT_015*290
  FONTSIZE=INT_015*9
  MAXBUTTON=.F.
  MINBUTTON=.F.
  MOVABLE=.F.
  CLOSABLE=.F.    
  CONTROLBOX=.F.
  BORDERSTYLE=2
  SHOWTIPS=.T.
  SHOWWINDOW=1
  WINDOWTYPE=1
  NAME='ANS_RANGE'
ADD OBJECT DATA_OPTION AS OPTIONGROUP WITH;
      LEFT=INT_015*17,;
      TOP=INT_015*10,;
      AUTOSIZE=.T.,;
      FONTSIZE=INT_015*12,;
      BUTTONCOUNT=2,;
      OPTION1.TOP=INT_015*0,;
      OPTION1.FONTSIZE=INT_015*9,;
      OPTION1.AUTOSIZE=.T.,;
      OPTION2.TOP=INT_015*30,;
      OPTION2.FONTSIZE=INT_015*9,;
      OPTION2.AUTOSIZE=.T.,;         
      NAME='DATA_OPTION'    
  ADD OBJECT CMND1 AS COMMANDBUTTON WITH;
      LEFT=INT_015*200,;     
      TOP=INT_015*10,;  
      HEIGHT=INT_015*25,;    
      WIDTH=INT_015*70,;
      FONTSIZE=INT_015*10,;
      CAPTION='\<P.執   行',;
      TOOLTIPTEXT='確認所選擇的鍵值!快速鍵->ALT+Y',;
      NAME='CMND1'    
  ADD OBJECT CMND3 AS COMMANDBUTTON WITH;
      LEFT=INT_015*200,;
      TOP=INT_015*40,;
      HEIGHT=INT_015*25,;    
      WIDTH=INT_015*70,;
      FONTSIZE=INT_015*10,;
      CAPTION='\<C.取   消',;
      TOOLTIPTEXT='取消作業!快速鍵->ALT+C',;
      NAME='CMND3'   
   ****
 PROCEDURE INIT 
      THISFORM.CAPTION='請選擇資料範圍' 
      THISFORM.SETALL('FONTSIZE',INT_015*9,'COMMANDBUTTON') 
      THISFORM.SETALL('READONLY',.T.,'TEXTBOX') 
      THISFORM.DATA_OPTION.OPTION1.CAPTION='僅轉此筆單號資料'  
      THISFORM.DATA_OPTION.OPTION2.CAPTION='轉出全部運費資料 '
      THISFORM.CMND1.SETFOCUS
 ENDPROC    
 PROCEDURE DATA_OPTION.INTERACTIVECHANGE
   DO CASE
      CASE THISFORM.DATA_OPTION.VALUE = 1
           
           
      CASE THISFORM.DATA_OPTION.VALUE = 2

 
   ENDCASE
 ENDPROC   
 PROCEDURE CMND1.CLICK 
           IF !USED('C01')
              SELECT 0
              USE C01
           ELSE
              SELECT C01
           ENDIF
           SET ORDER TO 1
           IF !USED('P04')
              SELECT 0
              USE P04
           ELSE
              SELECT P04
           ENDIF
           SET ORDER TO 1            
           IF THISFORM.DATA_OPTION.VALUE=1
              SELECT P17_3.F01 送貨單號,P17_3.F02 原始金額,P17_3.F03 備註說明,P17_3.F05 進貨料號,B01.F99 流水編號,P17_3.F06 進貨數量,P17_3.F07 進貨單價,;
              P17_3.F08 運費分攤百分比,P17_3.F09 分攤金額,P17_3.F10 進貨單號,P17_3.F11 採購單號,IIF(SEEK(IIF(SEEK(P17_3.F11+P17_3.F05,'P04'),P04.F14,''),'C01'),C01.F05,''),IIF(SEEK(P17_3.F11+P17_3.F05,'P04'),P04.F14,'') 客戶編號, 客戶簡稱 FROM P17_3,B01 WHERE P17_3.F01=LK AND B01.F01=P17_3.F05 ORDER BY P17_3.F01,P17_3.F05 NOWAIT
              
           ELSE
              SELECT P17_3.F01 送貨單號,P17_3.F02 原始金額,P17_3.F03 備註說明,P17_3.F05 進貨料號,B01.F99 流水編號,P17_3.F06 進貨數量,P17_3.F07 進貨單價,;
              P17_3.F08 運費分攤百分比,P17_3.F09 分攤金額,P17_3.F10 進貨單號,P17_3.F11 採購單號,IIF(SEEK(P17_3.F11+P17_3.F05,'P04'),P04.F14,'') 客戶編號,IIF(SEEK(IIF(SEEK(P17_3.F11+P17_3.F05,'P04'),P04.F14,''),'C01'),C01.F05,'') 客戶簡稱 FROM P17_3,B01 WHERE  B01.F01=P17_3.F05 ORDER BY P17_3.F01,P17_3.F05 NOWAIT
           ENDIF   
             IF _TALLY>0

                FILE_NAME='外購其他進貨費用'   	           	        
   	            GCDELIMFILE=PUTFILE('儲存路徑',FILE_NAME,'XLS')
	            IF EMPTY(GCDELIMFILE)  && ESC PRESSED	          
                   RETURN
                ELSE
                  ON ERROR DO FILE_IMPACT
                  COPY TO (GCDELIMFILE) TYPE XL5   
		          =MESSAGEBOX('儲存成功',0+48,'提示訊息視窗')              
                ENDIF                   
              

          
             ENDIF
             SELECT C01
             USE
             SELECT P04
             USE
  
   THISFORM.RELEASE 
 ENDPROC      
 PROCEDURE CMND3.CLICK
 
   THISFORM.REFRESH
   THISFORM.RELEASE
 ENDPROC        
ENDDEFINE        