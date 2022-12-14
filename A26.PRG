***************A26.系統參數設定****************
CLOSE ALL
CLEAR 
FLG='0'
FCH=''
AREA1='A26'
CHK=''
***************開起相關基本檔***************
IF !USED('A01')
   SELE 0
   USE A01 INDE A01
ELSE
   SELE A01
ENDIF      
SET ORDER TO A01
SEEK SYS_OPER
GK=F03
IF !USED('A03')
   SELE 0
   USE A03
ELSE 
   SELE A03
ENDIF
SET ORDER TO A03
IF !USED('A26')
   SELE 0
   USE A26  
ELSE 
   SELE A26
ENDIF
SET ORDER TO 1
IF !USED('A02')
   SELE 0
   USE A02 INDE A02
ELSE 
   SELE A02
ENDIF
SET ORDER TO A021
SEEK SYS_OPER+'A26'
*************************建立表單A20FORM*************************    
A26FORM=CREATEOBJECT("TKA26")
A26FORM.SHOW  
DEFINE CLASS TKA26 AS FORM
  CAPTION='A26.系統參數設定'
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
  NAME='TKA26'
  ADD OBJECT SHAPE1 AS SHAPE1 WITH;
      AUTOCENTER=.T.
  ADD OBJECT SHAPE2 AS SHAPE2 WITH;
      AUTOCENTER=.T.
  ADD OBJECT SHAPE3 AS SHAPE3 WITH;
      AUTOCENTER=.T.
  ADD OBJECT LBL_REC AS LBL_REC WITH;
      AUTOCENTER =.T.
  ADD OBJECT REC_COUNT AS REC_COUNT  WITH;
      CAPTION=STR(RECCOUNT()) 
*********************************    
  ADD OBJECT LBLF01 AS LABEL WITH;
      LEFT=INT_015*244,;
      TOP=INT_015*29,;
      WIDTH=INT_015*85,;
      CAPTION='變數編號'
  ADD OBJECT LBLF011 AS LABEL WITH;
      VISIBLE=.F.,;
      LEFT=INT_015*392,;
      TOP=INT_015*29,;
      AUTOSIZE=.T.,;
      BACKCOLOR=RGB(255,255,0),;
      CAPTION='變數編號前四碼必須為 INT_'   
  ADD OBJECT TXTF01 AS TEXTBOX WITH;      
      LEFT=INT_015*320,;
      TOP=INT_015*23,;
      WIDTH=INT_015*70,;
      MAXLENGTH=7,;
      NAME='TXTF01'      
  ADD OBJECT LBLF02 AS LABEL WITH;      
      LEFT=INT_015*244,;
      TOP=INT_015*58,;
      WIDTH=INT_015*85,;
      CAPTION='變數說明'
  ADD OBJECT TXTF02 AS TEXTBOX WITH;
      AUTOSIZE=.T.,;
      LEFT=INT_015*320,;
      TOP=INT_015*52,;
      WIDTH=INT_015*250,;
      MAXLENGTH=40,;
      NAME='TXTF02'             
  ADD OBJECT LBLF03 AS LABEL WITH;
      LEFT=INT_015*244,;
      TOP=INT_015*87,;
      WIDTH=INT_015*85,;
      CAPTION='所用程式編號' 
  ADD OBJECT TXTF03 AS TEXTBOX WITH;
      LEFT=INT_015*320,;
      TOP=INT_015*81,;
      WIDTH=INT_015*250,;
      HEIGHT=INT_015*25,;
      MAXLENGTH=3,;
      NAME='TXTF03'
  ADD OBJECT LBLF04 AS LABEL WITH;
      LEFT=INT_015*244,;
      TOP=INT_015*116,;
      WIDTH=INT_015*85,;
      CAPTION='變數型態'
  ADD OBJECT TXTF04 AS TEXTBOX WITH;
      LEFT=INT_015*320,;
      TOP=INT_015*110,;
      WIDTH=INT_015*70,;
      MAXLENGTH=8,;
      NAME='TXTF04'  
  ADD OBJECT VARITYPE AS COMBOBOX WITH;
      HEIGHT=INT_015*27,;
      WIDTH=INT_015*78,;
      TOP=INT_015*110,;
      LEFT=INT_015*320,;
      FONTSIZE=INT_015*9,;
      BOUNDCOLUMN=1,;
      COLUMNCOUNT=1,;
      ROWSOURCETYPE=1,;
      STYLE=2,;
      NAME='VARITYPE'            
  ADD OBJECT LBLF05 AS LABEL WITH;
      LEFT=INT_015*450,;
      TOP=INT_015*116,;
      WIDTH=INT_015*50,;
      CAPTION='變數長度'   
    ADD OBJECT TXTF05 AS TEXTBOX WITH;
      LEFT=INT_015*500,;
      TOP=INT_015*110,;
      WIDTH=INT_015*50,;
      MAXLENGTH=2,;
      NAME='TXTF05'     
  ADD OBJECT LBLF06 AS LABEL WITH;
      LEFT=INT_015*244,;
      TOP=INT_015*145,;
      WIDTH=INT_015*85,;
      CAPTION='設定內容'  
  ADD OBJECT TXTF06 AS TEXTBOX WITH;
      LEFT=INT_015*320,;
      TOP=INT_015*139,;
      WIDTH=INT_015*420,;
      MAXLENGTH=90,;
      NAME='TXTF06'          
  ADD OBJECT LBLF07 AS LABEL WITH;
      LEFT=INT_015*244,;
      TOP=INT_015*174,;
      WIDTH=INT_015*85,;
      CAPTION='內容說明'
  ADD OBJECT TXTF07 AS TEXTBOX WITH;
      LEFT=INT_015*320,;
      TOP=INT_015*168,;
      WIDTH=INT_015*420,;
      MAXLENGTH=70,;
      NAME='TXTF07'     
  ADD OBJECT LBLF08 AS LABEL WITH;
      LEFT=INT_015*244,;
      TOP=INT_015*203,;
      WITH=INT_015*85,;
      CAPTION='檢查用字串'      
  ADD OBJECT TXTF08 AS TEXTBOX WITH;
      LEFT=INT_015*320,;
      TOP=INT_015*197,;
      WIDTH=INT_015*420,;
      MAXLENGTH=80,;
      NAME='TXTF08' 
  ADD OBJECT LBLF09 AS LABEL WITH;
      LEFT=INT_015*558,;
      TOP=INT_015*235,;
      WITH=INT_015*50,;
      CAPTION='安全資料' 
  ADD OBJECT LBLF091 AS LABEL WITH;
      LEFT=INT_015*610,;
      TOP=INT_015*235,;
      WITH=INT_015*50,;
      AUTOSIZE=.T. ,;
      CAPTION=''  
  ADD OBJECT KEY_LIST AS KEY_LIST WITH;
      AUTOCENTER=.T.   
  ADD OBJECT GRID1 AS GRID1 WITH;
      COLUMNCOUNT=2,;            
      RECORDSOURCE='A26',; 
      FONTSIZE=INT_015*9,;           
      COLUMN1.NAME='COLUMN1',;
      COLUMN2.NAME='COLUMN2'       
 ADD OBJECT CMDGROUP AS CMDGROUP WITH;
      AUTOCENTER=.T.        
  ADD OBJECT ORPGROUP AS ORPGROUP WITH;    
      AUTOCENTER=.T.
  ADD OBJECT SHRGROUP AS SHRGROUP WITH;
      TOP=INT_015*250,;
      LEFT=INT_015*558                     
 *********************               
  PROC INIT
       THISFORM.ORPGROUP.NEW_BOTT.ENABLED=IIF(A02.F04='*',.T.,.F.)   &&判斷有無新增的權限
       THISFORM.ORPGROUP.EDIT_BOTT.ENABLED=IIF(A02.F05='*',.T.,.F.)  &&判斷有無修改的權限
       THISFORM.ORPGROUP.DEL_BOTT.ENABLED=IIF(A02.F06='*',.T.,.F.)   &&判斷有無刪除的權限
       THISFORM.ORPGROUP.PNT_BOTT.ENABLED=IIF(A02.F07='*',.T.,.F.)   &&判斷有無列印的權限
       THISFORM.SHRGROUP.VISIBLE=.F.
       THISFORM.SHRGROUP.ENABLED=.F. 
       THISFORM.SETALL('HEIGHT',25*INT_015,'TEXTBOX')
       THISFORM.SETALL('HEIGHT',17*INT_015,'LABEL')
       THISFORM.SETALL('READONLY',.T.,'TEXTBOX')
       THISFORM.SETALL('FONTSIZE',INT_015*9,'TEXTBOX')         
       THISFORM.SETALL('FONTSIZE',INT_015*9,'LABEL')         
       THISFORM.GRID1.SETALL('FONTSIZE',INT_015*9,'COLUMN')  
       THISFORM.GRID1.SETALL('FONTSIZE',INT_015*9,'HEADER')     
       THISFORM.GRID1.BACKCOLOR=IIF(SEEK(sys_oper,'A01'),IIF(A01.F11=0,10009146,A01.F11),10009146)    
       THISFORM.GRID1.COLUMN1.WIDTH=INT_015*55
       THISFORM.GRID1.COLUMN2.WIDTH=INT_015*150
       THISFORM.GRID1.COLUMN1.HEADER1.CAPTION='變數編號'
       THISFORM.GRID1.COLUMN2.HEADER1.CAPTION='變數說明'
       THISFORM.GRID1.COLUMN1.CONTROLSOURCE='A26.F01'
       THISFORM.GRID1.COLUMN2.CONTROLSOURCE='A26.F02'
       THISFORM.GRID1.READONLY=.T.       
       THISFORM.GRID1.SETFOCUS
       IF THISFORM.GRID1.ACTIVEROW=0
           THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.
       ELSE
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.      
          THISFORM.REC_COUNT.CAPTION=STR(RECCOUNT())
       ENDIF       
       JK='變數編號'       
  ENDPROC     
 ************************
  PROC KEY_LIST.INIT 
       WITH THIS 
           .ADDITEM('依變數編號排列')
       ENDWITH      
  ENDPROC 
 ********************* 
  PROC GRID1.AFTERROWCOLCHANGE
       LPARAMETERS NCOLINDEX
       SELECT A26
       THISFORM.TXTF01.VALUE=F01
       THISFORM.TXTF02.VALUE=F02
       THISFORM.TXTF03.VALUE=F03
       THISFORM.TXTF04.VALUE=BILL(ALLTRIM(F04))
       THISFORM.TXTF05.VALUE=F05
       THISFORM.TXTF06.VALUE=F06
       THISFORM.TXTF07.VALUE=F07
       THISFORM.TXTF08.VALUE=F08
       THISFORM.LBLF091.CAPTION=F09       
       FCH=THISFORM.ACTIVECONTROL.NAME
       CHK=''
       THISFORM.REFRESH
  ENDPROC
 *****************************新增        
  PROCEDURE ORPGROUP.NEW_BOTT.CLICK    
       THISFORM.SETALL('READONLY',.F.,'TEXTBOX')
       THISFORM.GRID1.ENABLED=.F.   
       THISFORM.LBLF011.VISIBLE=.T.
       THISFORM.TXTF01.SETFOCUS()
       THISFORM.TXTF01.VALUE='INT_'
       THISFORM.TXTF02.VALUE=''
       THISFORM.TXTF03.VALUE=''
       THISFORM.TXTF04.VISIBLE=.F.
       THISFORM.VARITYPE.VISIBLE=.T.
       THISFORM.VARITYPE.VALUE=1
       THISFORM.TXTF05.VALUE=INT(VAL(''))
       THISFORM.TXTF06.VALUE=''
       THISFORM.TXTF07.VALUE=''
       THISFORM.TXTF08.VALUE=''
       THISFORM.LBLF091.CAPTION=''
       FLG='1'
  ENDPROC
 **************************修改   
  PROCEDURE ORPGROUP.EDIT_BOTT.CLICK
     THISFORM.GRID1.ENABLED=.F.
     THISFORM.TXTF01.READONLY=.T.
     THISFORM.TXTF04.VISIBLE=.F.
     THISFORM.VARITYPE.VISIBLE=.T.
     THISFORM.TXTF02.SETFOCUS
     DO CASE  
                   CASE THISFORM.TXTF04.VALUE='字元'
              	              THISFORM.VARITYPE.VALUE=1
              	   CASE THISFORM.TXTF04.VALUE='日期'
              	              THISFORM.VARITYPE.VALUE=2
              	   CASE THISFORM.TXTF04.VALUE='時間日期'
              	              THISFORM.VARITYPE.VALUE=3
              	   CASE THISFORM.TXTF04.VALUE='數值'
              	              THISFORM.VARITYPE.VALUE=4
              	   CASE THISFORM.TXTF04.VALUE='浮點數'
              	              THISFORM.VARITYPE.VALUE=5
           	   CASE THISFORM.TXTF04.VALUE='整數'
              	              THISFORM.VARITYPE.VALUE=6           
              	   CASE THISFORM.TXTF04.VALUE='倍精度數'
              	              THISFORM.VARITYPE.VALUE=7
              	   CASE THISFORM.TXTF04.VALUE='貨幣'
              	              THISFORM.VARITYPE.VALUE=8             
              	   CASE THISFORM.TXTF04.VALUE='邏輯'
              	              THISFORM.VARITYPE.VALUE=9
              	   CASE THISFORM.TXTF04.VALUE='備註'
              	              THISFORM.VARITYPE.VALUE=10 
              	   CASE THISFORM.TXTF04.VALUE='通用'
              	              THISFORM.VARITYPE.VALUE=11                                                
             ENDCASE
     LOCK()
     IF !RLOCK()
        DO FILE_IMPACT
        RETURN
     ENDIF
  ENDPROC
 ************************ 刪除 
  PROCEDURE ORPGROUP.DEL_BOTT.CLICK
     IF MESSAGEBOX('是否確定要刪除此筆資料',4+32+256,'請確認') = 6	        
        SELE A26
        LOCK()
        IF RLOCK()   
           DELE
           UNLOCK
           SKIP -1
           IF BOF()
              GO TOP
           ENDIF   
           THISFORM.GRID1.SETFOCUS
           IF THISFORM.GRID1.ACTIVEROW=0
              THISFORM.SETALL('VALUE','','TEXTBOX')
              THISFORM.CMDGROUP.ENABLED=.F.
              THISFORM.ORPGROUP.EDIT_BOTT.ENABLED=.F.
              THISFORM.ORPGROUP.DEL_BOTT.ENABLED=.F.
              THISFORM.ORPGROUP.PNT_BOTT.ENABLED=.F.
           ELSE
              THISFORM.CMDGROUP.ENABLED=.T.
              THISFORM.ORPGROUP.NEW_BOTT.ENABLED=IIF(A02.F04='*',.T.,.F.)   &&判斷有無新增的權限
              THISFORM.ORPGROUP.EDIT_BOTT.ENABLED=IIF(A02.F05='*',.T.,.F.)  &&判斷有無修改的權限
              THISFORM.ORPGROUP.DEL_BOTT.ENABLED=IIF(A02.F06='*',.T.,.F.)   &&判斷有無刪除的權限
              THISFORM.ORPGROUP.PNT_BOTT.ENABLED=IIF(A02.F07='*',.T.,.F.)   &&判斷有無列印的權限              
           ENDIF
        ELSE
          DO FILE_IMPACT    
        ENDIF     
     ENDIF   
  ENDPROC
 ******************** 新增確認
  PROCEDURE SHRGROUP.SHURE1_BOTT.CLICK
    IF EMPTY(THISFORM.TXTF01.VALUE)
       =MESSAGEBOX('變數編號不得空白!',0+64,'提示視窗')
       THISFORM.TXTF01.SETFOCUS
       RETURN
    ENDIF
     IF SEEK(THISFORM.TXTF01.VALUE,'A26')=.T.
       =MESSAGEBOX('此變數編號已經建立!',0+64,'請注意')
       THISFORM.TXTF01.VALUE='INT_'
       THISFORM.TXTF01.SETFOCUS  
       RETURN
    ENDIF
     IF LEFT(ALLTRIM(THISFORM.TXTF01.VALUE),4)!='INT_'
       =MESSAGEBOX('變數編號左邊4碼需為 INT_ 請確認!',0+64,'提示視窗')
       THISFORM.TXTF01.VALUE='INT_'
       THISFORM.TXTF01.SETFOCUS
       RETURN
    ENDIF
     IF EMPTY(THISFORM.TXTF02.VALUE)
       =MESSAGEBOX('變數說明不得空白!',0+64,'提示視窗')
       THISFORM.TXTF02.SETFOCUS
       RETURN
    ENDIF   
     IF EMPTY(THISFORM.TXTF04.VALUE)
       =MESSAGEBOX('變數型態不得空白!',0+64,'提示視窗')
       THISFORM.TXTF04.SETFOCUS
       RETURN
    ENDIF   
     IF EMPTY(THISFORM.TXTF05.VALUE)
       =MESSAGEBOX('變數長度不得空白!',0+64,'提示視窗')
       THISFORM.TXTF05.SETFOCUS
       RETURN
    ENDIF
     IF THISFORM.TXTF05.VALUE<1 OR THISFORM.TXTF05.VALUE>100
       =MESSAGEBOX('變數長度只能為數字!',0+64,'提示視窗')
       THISFORM.TXTF05.SETFOCUS
       RETURN
    ENDIF
    IF EMPTY(THISFORM.TXTF06.VALUE)
       =MESSAGEBOX('設定內容不得空白!',0+64,'提示視窗')
       THISFORM.TXTF06.SETFOCUS
       RETURN
    ENDIF
    IF EMPTY(THISFORM.TXTF07.VALUE)
       =MESSAGEBOX('內容說明不得空白!',0+64,'提示視窗')
       THISFORM.TXTF07.SETFOCUS
       RETURN
    ENDIF 
    IF EMPTY(THISFORM.TXTF08.VALUE)
       =MESSAGEBOX('檢查用字串不得空白!',0+64,'提示視窗')
       THISFORM.TXTF08.SETFOCUS
       RETURN
    ENDIF     
    SELE A26
    SET ORDER TO 1
    APPEND BLANK
    LOCK()
    IF RLOCK()
        REPLACE F01 WITH THISFORM.TXTF01.VALUE
        REPLACE F02 WITH THISFORM.TXTF02.VALUE
        REPLACE F03 WITH THISFORM.TXTF03.VALUE
               DO  CASE  
                      CASE THISFORM.VARITYPE.VALUE=1
              	                 REPLACE F04 WITH   'C'
              	      CASE THISFORM.VARITYPE.VALUE=2
              	                 REPLACE F04 WITH   'D'
              	      CASE THISFORM.VARITYPE.VALUE=3
              	                 REPLACE F04 WITH   'T'
              	      CASE THISFORM.VARITYPE.VALUE=4
              	                 REPLACE F04 WITH   'N'
              	      CASE THISFORM.VARITYPE.VALUE=5
              	                 REPLACE F04 WITH   'F' 
  	              CASE THISFORM.VARITYPE.VALUE=6
  	                         REPLACE F04 WITH   'I'    
  	              CASE THISFORM.VARITYPE.VALUE=7
  	                         REPLACE F04 WITH   'B'    
  	              CASE THISFORM.VARITYPE.VALUE=8
  	                         REPLACE F04 WITH   'Y'    
  	              CASE THISFORM.VARITYPE.VALUE=9
  	                         REPLACE F04 WITH   'L'    
  	              CASE THISFORM.VARITYPE.VALUE=10
  	                         REPLACE F04 WITH   'M'
  	              CASE THISFORM.VARITYPE.VALUE=11
              	                 REPLACE F04 WITH   'G'         
        ENDCASE
        REPLACE F05 WITH THISFORM.TXTF05.VALUE
        REPLACE F06 WITH THISFORM.TXTF06.VALUE
        REPLACE F07 WITH THISFORM.TXTF07.VALUE
        REPLACE F08 WITH THISFORM.TXTF08.VALUE
        REPLACE F09 WITH DTOC(DATE())+' '+IIF(SEEK(SYS_OPER,'A01'),A01.F03,'')              
    ENDIF
    UNLOCK
    THISFORM.REC_COUNT.CAPTION=STR(RECCOUNT())
    THISFORM.GRID1.ENABLED=.T.
    THISFORM.REFRESH
    THISFORM.GRID1.SETFOCUS    
    THISFORM.ORPGROUP.NEW_BOTT.CLICK            
  ENDPROC
  *************************修改確認  
  PROCEDURE SHRGROUP.SHURE2_BOTT.CLICK
     IF EMPTY(THISFORM.TXTF02.VALUE)
       =MESSAGEBOX('變數說明不得空白!',0+64,'提示視窗')
       THISFORM.TXTF02.SETFOCUS
       RETURN
    ENDIF   
     IF EMPTY(THISFORM.TXTF04.VALUE)
       =MESSAGEBOX('變數型態不得空白!',0+64,'提示視窗')
       THISFORM.TXTF04.SETFOCUS
       RETURN
    ENDIF   
     IF EMPTY(THISFORM.TXTF05.VALUE)
       =MESSAGEBOX('變數長度不得空白!',0+64,'提示視窗')
       THISFORM.TXTF05.SETFOCUS
       RETURN
    ENDIF
     IF THISFORM.TXTF05.VALUE<1 OR THISFORM.TXTF05.VALUE>100
       =MESSAGEBOX('變數長度只能為數字!',0+64,'提示視窗')
       THISFORM.TXTF05.SETFOCUS
       RETURN
    ENDIF
    IF EMPTY(THISFORM.TXTF06.VALUE)
       =MESSAGEBOX('設定內容不得空白!',0+64,'提示視窗')
       THISFORM.TXTF06.SETFOCUS
       RETURN
    ENDIF
    IF EMPTY(THISFORM.TXTF07.VALUE)
       =MESSAGEBOX('內容說明不得空白!',0+64,'提示視窗')
       THISFORM.TXTF07.SETFOCUS
       RETURN
    ENDIF 
    IF EMPTY(THISFORM.TXTF08.VALUE)
       =MESSAGEBOX('檢查用字串不得空白!',0+64,'提示視窗')
       THISFORM.TXTF08.SETFOCUS
       RETURN
    ENDIF 
    SELE A26
    IF RLOCK()
       REPLACE F02 WITH THISFORM.TXTF02.VALUE
       REPLACE F03 WITH THISFORM.TXTF03.VALUE
       DO  CASE  
                      CASE THISFORM.VARITYPE.VALUE=1
              	                 REPLACE F04 WITH   'C'
              	      CASE THISFORM.VARITYPE.VALUE=2
              	                 REPLACE F04 WITH   'D'
              	      CASE THISFORM.VARITYPE.VALUE=3
              	                 REPLACE F04 WITH   'T'
              	      CASE THISFORM.VARITYPE.VALUE=4
              	                 REPLACE F04 WITH   'N'
              	      CASE THISFORM.VARITYPE.VALUE=5
              	                 REPLACE F04 WITH   'F' 
  	              CASE THISFORM.VARITYPE.VALUE=6
  	                         REPLACE F04 WITH   'I'    
  	              CASE THISFORM.VARITYPE.VALUE=7
  	                         REPLACE F04 WITH   'B'    
  	              CASE THISFORM.VARITYPE.VALUE=8
  	                         REPLACE F04 WITH   'Y'    
  	              CASE THISFORM.VARITYPE.VALUE=9
  	                         REPLACE F04 WITH   'L'    
  	              CASE THISFORM.VARITYPE.VALUE=10
  	                         REPLACE F04 WITH   'M'
  	              CASE THISFORM.VARITYPE.VALUE=11
              	                 REPLACE F04 WITH   'G'         
        ENDCASE
       REPLACE F05 WITH THISFORM.TXTF05.VALUE
       REPLACE F06 WITH THISFORM.TXTF06.VALUE
       REPLACE F07 WITH THISFORM.TXTF07.VALUE
       REPLACE F08 WITH THISFORM.TXTF08.VALUE
       REPLACE F09 WITH DTOC(DATE())+' '+IIF(SEEK(SYS_OPER,'A01'),A01.F03,'')       
    ELSE
      DO FILE_IMPACT
      RETURN   
    ENDIF   
    THISFORM.SHRGROUP.ABANDON_BOTT.CLICK    
  ENDPROC
  ********************   
  PROCEDURE SHRGROUP.ABANDON_BOTT.CLICK
      THISFORM.SHRGROUP.ENABLED=.F.
      THISFORM.SHRGROUP.VISIBLE=.F.      
      THISFORM.ORPGROUP.ENABLED=.T.
      THISFORM.CMDGROUP.ENABLED=.T.
      THISFORM.ORPGROUP.NEW_BOTT.ENABLED=IIF(A02.F04='*',.T.,.F.)   &&判斷有無新增的權限      
      THISFORM.ORPGROUP.EDIT_BOTT.ENABLED=IIF(A02.F05='*',.T.,.F.)  &&判斷有無修改的權限
      THISFORM.ORPGROUP.DEL_BOTT.ENABLED=IIF(A02.F06='*',.T.,.F.)   &&判斷有無刪除的權限
      THISFORM.ORPGROUP.PNT_BOTT.ENABLED=IIF(A02.F07='*',.T.,.F.)   &&判斷有無列印的權限      
      THISFORM.ORPGROUP.SETALL('FORECOLOR',RGB(0,0,0),'COMMANDBUTTON')
      THISFORM.CMDGROUP.SETALL('ENABLED',.T.,'COMMANDBUTTON')
      THISFORM.CMDGROUP.SETALL('FORECOLOR',RGB(0,0,0),'COMMANDBUTTON')
      THISFORM.KEY_LIST.ENABLED=.T. 
      THISFORM.LBLF011.VISIBLE=.F.
      THISFORM.TXTF04.VISIBLE=.T.
      THISFORM.VARITYPE.VISIBLE=.F.     
      THISFORM.SETALL('READONLY',.T.,'TEXTBOX')   
      UNLOCK ALL
      SELE A26
      THISFORM.GRID1.ENABLED=.T.
      THISFORM.GRID1.SETFOCUS           
  ENDPROC
  *******************
  PROCEDURE SHRGROUP.FINISH_BOTT.CLICK   
       THISFORM.SHRGROUP.ABANDON_BOTT.CLICK
  ENDPROC
************************  
  PROCEDURE VARITYPE.INIT
     WITH THIS 
          .VISIBLE=.F.
          .VALUE=1
          .ADDITEM('字元')
          .ADDITEM('日期')
          .ADDITEM('時間日期')
          .ADDITEM('數值')
          .ADDITEM('浮點數')
          .ADDITEM('整數')
          .ADDITEM('倍精準數')
          .ADDITEM('貨幣')
          .ADDITEM('邏輯')
          .ADDITEM('備註')
          .ADDITEM('通用')
     ENDWITH   
  ENDPROC
 ******************   
  PROCEDURE VARITYPE.INTERACTIVECHANGE
     THISFORM.TXTF04.VALUE=THIS.DISPLAYVALUE
  ENDPROC        
ENDDEFINE
*******************
FUNC BILL
     PARA JUK
     JO=''
     DO CASE
        CASE JUK='C'
             JO='字元'
        CASE JUK='D'  
             JO='日期' 
        CASE JUK='T'  
             JO='時間日期'         
        CASE JUK='N'  
             JO='數值'
        CASE JUK='F'  
             JO='浮點數' 
        CASE JUK='I'  
             JO='整數'  
        CASE JUK='B'  
             JO='倍精準數'  
       CASE JUK='Y'  
             JO='貨幣'                                    
        CASE JUK='L'  
             JO='邏輯' 
        CASE JUK='M'  
             JO='備註'       
        CASE JUK='G'  
             JO='通用'       
     ENDCASE
     RETURN JO              

