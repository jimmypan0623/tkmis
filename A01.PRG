***A01.新增程式授權資料
CLOSE ALL
CLEAR 
FLG='0'
FCH=''
AREA1='A03'
CHK=''
IF !USED('A01')
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
SEEK SYS_OPER+'A01'   
IF !USED('A03')
   SELE 0
   USE A03 INDE A03
ELSE 
   SELE A03
ENDIF
SET ORDER TO 1         
GO TOP
A01FORM=CREATEOBJECT("TKA01")
A01FORM.SHOW  
DEFINE CLASS TKA01 AS FORM
  CAPTION='A01.新增程式授權資料'
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
  NAME='TKA01'
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
  ADD OBJECT LBLF01 AS LABEL WITH;
      LEFT=INT_015*244,;
      TOP=INT_015*29,;
      WIDTH=INT_015*50,;
      CAPTION='程式編號'
  ADD OBJECT TXTF01 AS TEXTBOX WITH;      
      LEFT=INT_015*295,;
      TOP=INT_015*23,;
      WIDTH=INT_015*35,;
      HEIGHT=INT_015*25,;
      MAXLENGTH=3,;
      NAME='TXTF01'      
  ADD OBJECT LBLF02 AS LABEL WITH;      
      LEFT=INT_015*244,;
      TOP=INT_015*57,;
      WIDTH=INT_015*50,;
      CAPTION='程式說明'
 ADD OBJECT TXTF02 AS TEXTBOX WITH;
      LEFT=INT_015*295,;
      TOP=INT_015*51,;
      WIDTH=INT_015*136,;
       HEIGHT=INT_015*25,;
      MAXLENGTH=20,;
      NAME='TXTF02'      
  ADD OBJECT LBLF04 AS LABEL WITH;
      LEFT=INT_015*244,;
      TOP=INT_015*85,;
      WIDTH=INT_015*50,;
      CAPTION='新增功能' 
   ADD OBJECT TXTF04 AS TEXTBOX WITH;
      LEFT=INT_015*295,;
      TOP=INT_015*79,;
      WIDTH=INT_015*50,;
      HEIGHT=INT_015*25,;
      NAME='TXTF04'       
 ADD OBJECT  OPTION04 AS OPTIONGROUP WITH; 
      VISIBLE=.F.,;
      TOP=INT_015*79,;
      LEFT=INT_015*295,;
      HEIGHT=INT_015*25,;
     WIDTH=INT_015*170,;
      FONTSIZE=INT_015*9,;
      VALUE=1,;
      BUTTONCOUNT=3,;
      OPTION1.CAPTION='不可用',;
      OPTION1.LEFT=INT_015*2,;
      OPTION1.TOP=INT_015*1,;
      OPTION1.WIDTH=INT_015*50,;
      OPTION1.HEIGHT=INT_015*25,;
      OPTION2.CAPTION='可用',;
      OPTION2.LEFT=INT_015*57,;
      OPTION2.TOP=INT_015*1,;
      OPTION2.WIDTH=INT_015*40,;
      OPTION2.HEIGHT=INT_015*25,;
      OPTION3.CAPTION='依授權',;
      OPTION3.LEFT=INT_015*103,;
      OPTION3.TOP=INT_015*1,;
      OPTION3.WIDTH=INT_015*56,;
      OPTION3.HEIGHT=INT_015*25
  ADD OBJECT LBLF05 AS LABEL WITH;
      LEFT=INT_015*500,;
      TOP=INT_015*85,;
      WIDTH=INT_015*50,;
      CAPTION='修改功能'
 ADD OBJECT TXTF05 AS TEXTBOX WITH;
      LEFT=INT_015*551,;
      TOP=INT_015*79,;
      WIDTH=INT_015*50,;
      HEIGHT=INT_015*25,;
      NAME='TXTF05'         
  ADD OBJECT  OPTION05 AS OPTIONGROUP WITH;  
      VISIBLE=.F.,;
      TOP=INT_015*79,;
      LEFT=INT_015*551,;
      HEIGHT=INT_015*25,;
     WIDTH=INT_015*170,;
      FONTSIZE=INT_015*9,;
      VALUE=1,;
      BUTTONCOUNT=3,;
      OPTION1.CAPTION='不可用',;
      OPTION1.LEFT=INT_015*2,;
      OPTION1.TOP=INT_015*1,;
      OPTION1.WIDTH=INT_015*50,;
      OPTION1.HEIGHT=INT_015*25,;
      OPTION2.CAPTION='可用',;
      OPTION2.LEFT=INT_015*57,;
      OPTION2.TOP=INT_015*1,;
      OPTION2.WIDTH=INT_015*40,;
      OPTION2.HEIGHT=INT_015*25,;
      OPTION3.CAPTION='依授權',;
      OPTION3.LEFT=INT_015*103,;
      OPTION3.TOP=INT_015*1,;
      OPTION3.WIDTH=INT_015*56,;
      OPTION3.HEIGHT=INT_015*25    
  ADD OBJECT LBLF06 AS LABEL WITH;
      LEFT=INT_015*244,;
      TOP=INT_015*112,;
      WIDTH=INT_015*50,;
      CAPTION='刪除功能' 
 ADD OBJECT TXTF06 AS TEXTBOX WITH;
      LEFT=INT_015*295,;
      TOP=INT_015*107,;
      WIDTH=INT_015*50,;
      HEIGHT=INT_015*25,;
      NAME='TXTF06'           
  ADD OBJECT  OPTION06 AS OPTIONGROUP WITH; 
      VISIBLE=.F.,;
      TOP=INT_015*107,;
      LEFT=INT_015*295,;
      HEIGHT=INT_015*25,;
     WIDTH=INT_015*170,;
      FONTSIZE=INT_015*9,;
      VALUE=1,;
      BUTTONCOUNT=3,;
      OPTION1.CAPTION='不可用',;
      OPTION1.LEFT=INT_015*2,;
      OPTION1.TOP=INT_015*1,;
      OPTION1.WIDTH=INT_015*50,;
      OPTION1.HEIGHT=INT_015*25,;
      OPTION2.CAPTION='可用',;
      OPTION2.LEFT=INT_015*57,;
      OPTION2.TOP=INT_015*1,;
      OPTION2.WIDTH=INT_015*40,;
      OPTION2.HEIGHT=INT_015*25,;
      OPTION3.CAPTION='依授權',;
      OPTION3.LEFT=INT_015*103,;
      OPTION3.TOP=INT_015*1,;
      OPTION3.WIDTH=INT_015*56,;
      OPTION3.HEIGHT=INT_015*25    
  ADD OBJECT LBLF07 AS LABEL WITH;
      LEFT=INT_015*500,;
      TOP=INT_015*112,;
      WIDTH=INT_015*50,;
      CAPTION='列印功能'  
  ADD OBJECT TXTF07 AS TEXTBOX WITH;
      LEFT=INT_015*551,;
      TOP=INT_015*107,;
      WIDTH=INT_015*50,;
      HEIGHT=INT_015*25,;
      NAME='TXTF07'        
  ADD OBJECT  OPTION07 AS OPTIONGROUP WITH;  
      VISIBLE=.F.,;
      TOP=INT_015*107,;
      LEFT=INT_015*551,;
      HEIGHT=INT_015*25,;
     WIDTH=INT_015*170,;
      FONTSIZE=INT_015*9,;
      VALUE=1,;
      BUTTONCOUNT=3,;
      OPTION1.CAPTION='不可用',;
      OPTION1.LEFT=INT_015*2,;
      OPTION1.TOP=INT_015*1,;
      OPTION1.WIDTH=INT_015*50,;
      OPTION1.HEIGHT=INT_015*25,;
      OPTION2.CAPTION='可用',;
      OPTION2.LEFT=INT_015*57,;
      OPTION2.TOP=INT_015*1,;
      OPTION2.WIDTH=INT_015*40,;
      OPTION2.HEIGHT=INT_015*25,;
      OPTION3.CAPTION='依授權',;
      OPTION3.LEFT=INT_015*103,;
      OPTION3.TOP=INT_015*1,;
      OPTION3.WIDTH=INT_015*56,;
      OPTION3.HEIGHT=INT_015*25    
  ADD OBJECT LBLF08 AS LABEL WITH;
      LEFT=INT_015*244,;
      TOP=INT_015*141,;
      WIDTH=INT_015*50,;
      CAPTION='附  註  一'
   ADD OBJECT TXTF08 AS TEXTBOX WITH;
      LEFT=INT_015*295,;
      TOP=INT_015*135,;
      WIDTH=INT_015*136,;
      HEIGHT=INT_015*25,;
      MAXLENGTH=20,;
      NAME='TXTF08'               
  ADD OBJECT LBLF09 AS LABEL WITH;
      LEFT=INT_015*500,;
      TOP=INT_015*141,;
      WITH=INT_015*50,;
      CAPTION='附  註  二'
   ADD OBJECT TXTF09 AS TEXTBOX WITH;
      LEFT=INT_015*551,;
      TOP=INT_015*135,;
      WIDTH=INT_015*136,;
      HEIGHT=INT_015*25,;
      MAXLENGTH=20,;
      NAME='TXTF09'           
  ADD OBJECT LBLF10 AS LABEL WITH;
      LEFT=INT_015*244,;
      TOP=INT_015*169,;
      WIDTH=INT_015*50,;
      CAPTION='附  註  三'
   ADD OBJECT TXTF10 AS TEXTBOX WITH;
      LEFT=INT_015*295,;
      TOP=INT_015*163,;
      WIDTH=INT_015*136,;
      HEIGHT=INT_015*25,;
      MAXLENGTH=20,;
      NAME='TXTF10'           
  ADD OBJECT LBLF11 AS LABEL WITH;
      LEFT=INT_015*500,;
      TOP=INT_015*169,;
      WITH=INT_015*50,;
      CAPTION='附  註  四'
   ADD OBJECT TXTF11 AS TEXTBOX WITH;
      LEFT=INT_015*551,;
      TOP=INT_015*163,;
      WIDTH=INT_015*136,;
      HEIGHT=INT_015*25,;
      MAXLENGTH=20,;
      NAME='TXTF11'           
  ADD OBJECT LBLF12 AS LABEL WITH;
      LEFT=INT_015*244,;
      TOP=INT_015*197,;
      WITH=INT_015*50,;
      CAPTION='附  註  五' 
  ADD OBJECT TXTF12 AS TEXTBOX WITH;
      LEFT=INT_015*295,;
      TOP=INT_015*191,;
      WIDTH=INT_015*136,;
      HEIGHT=INT_015*25,;
      MAXLENGTH=20,;
      NAME='TXTF12'    
   ADD OBJECT LBLF131 AS LABEL WITH;
      LEFT=INT_015*244,;
      TOP=INT_015*226,;
      WIDTH=INT_015*85,;
      CAPTION='需整理之作業數'
  ADD OBJECT TXTF13 AS TEXTBOX WITH;
      LEFT=INT_015*330,;
      TOP=INT_015*219,;
      WIDTH=INT_015*30,;
      HEIGHT=INT_015*25,;
      MAXLENGTH=3,;
      NAME='TXTF13'
  ADD OBJECT LBLF141 AS LABEL WITH;
      LEFT=INT_015*500,;
      TOP=INT_015*226,;
      WITH=INT_015*80,;
      CAPTION='是否可執行作業' 
  ADD OBJECT TXTF14 AS TEXTBOX WITH;
      LEFT=INT_015*587,;
      TOP=INT_015*219,;
      WIDTH=INT_015*30,;
      HEIGHT=INT_015*25,;
      NAME='TXTF14'      
  ADD OBJECT  OPTION14 AS OPTIONGROUP WITH; 
      VISIBLE=.F.,; 
      TOP=INT_015*219,;
      LEFT=INT_015*587,;
      HEIGHT=INT_015*25,;
      WIDTH=INT_015*80,;
      FONTSIZE=INT_015*9,;
      VALUE=1,;
      BUTTONCOUNT=2,;
      OPTION1.CAPTION='是',;
      OPTION1.LEFT=INT_015*2,;
      OPTION1.TOP=INT_015*1,;
      OPTION1.WIDTH=INT_015*30,;
      OPTION1.HEIGHT=INT_015*25,;
      OPTION2.CAPTION='否',;
      OPTION2.LEFT=INT_015*40,;
      OPTION2.TOP=INT_015*1,;
      OPTION2.WIDTH=INT_015*30,;
      OPTION2.HEIGHT=INT_015*25      
  ADD OBJECT LBLF15 AS LABEL WITH;
      AUTOSIZE=.T.,;
      LEFT=INT_015*244,;
      TOP=INT_015*255,;
      CAPTION='程式所開啟之DBF名稱' 
  ADD OBJECT LBLF151 AS LABEL WITH;
      VISIBLE=.F.,;
      LEFT=INT_015*370,;
      TOP=INT_015*254,;
      AUTOSIZE=.T.,;
      BACKCOLOR=RGB(255,255,0),;
      CAPTION="(每各程式名稱後面須加上'  , ' )"      
  ADD OBJECT TXTF15 AS TEXTBOX WITH;
      LEFT=INT_015*244,;
      TOP=INT_015*270,;
      WIDTH=INT_015*500,;
      HEIGHT=INT_015*25,;
      MAXLENGTH=20,;
      NAME='TXTF15'   
 ADD OBJECT LBLF16 AS LABEL WITH;      
      LEFT=INT_015*550,;
      TOP=INT_015*315,;
      WIDTH=INT_015*50,;
      CAPTION='安全資料'      
 ADD OBJECT LBLF161 AS LABEL WITH;
      LEFT=INT_015*601,;
      TOP=INT_015*315,;
      AUTOSIZE=.T.                                                               
  ADD OBJECT KEY_LIST AS KEY_LIST WITH;
      AUTOCENTER=.T.
  ADD OBJECT GRID1 AS GRID1 WITH;
      NAME='GRID1',;
      COLUMNCOUNT=2,;            
      RECORDSOURCE='A03',; 
      FONTSIZE=INT_015*9,;           
      COLUMN1.NAME='COLUMN1',;
      COLUMN2.NAME='COLUMN2'
  ADD OBJECT CMDGROUP AS CMDGROUP WITH;
      AUTOCENTER=.T.        
  ADD OBJECT ORPGROUP AS ORPGROUP WITH;    
      AUTOCENTER=.T.
  ADD OBJECT SHRGROUP AS SHRGROUP WITH;
      TOP=INT_015*330,;
      LEFT=INT_015*545   
********************************             
  PROC INIT
       THISFORM.ORPGROUP.NEW_BOTT.ENABLED=IIF(A02.F04='*',.T.,.F.)   &&判斷有無新增的權限
       THISFORM.ORPGROUP.EDIT_BOTT.ENABLED=IIF(A02.F05='*',.T.,.F.)  &&判斷有無修改的權限
       THISFORM.ORPGROUP.DEL_BOTT.ENABLED=IIF(A02.F06='*',.T.,.F.)   &&判斷有無刪除的權限
       THISFORM.ORPGROUP.PNT_BOTT.ENABLED=IIF(A02.F07='*',.T.,.F.)   &&判斷有無列印的權限
       THISFORM.SHRGROUP.VISIBLE=.F.
       THISFORM.SHRGROUP.ENABLED=.F. 
       THISFORM.SETALL('HEIGHT',25*INT_015,'TEXTBOX')
       THISFORM.SETALL('HEIGHT',23*INT_015,'LABEL')
       THISFORM.SETALL('READONLY',.T.,'TEXTBOX')
       THISFORM.SETALL('FONTSIZE',INT_015*9,'TEXTBOX')         
       THISFORM.SETALL('FONTSIZE',INT_015*9,'LABEL')         
       THISFORM.GRID1.BACKCOLOR=IIF(SEEK(sys_oper,'A01'),IIF(A01.F11=0,10009146,A01.F11),10009146)
       THISFORM.GRID1.SETALL('FONTSIZE',INT_015*9,'COLUMN')  
       THISFORM.GRID1.SETALL('FONTSIZE',INT_015*9,'HEADER')         
       THISFORM.GRID1.COLUMN1.WIDTH=INT_015*50
       THISFORM.GRID1.COLUMN2.WIDTH=INT_015*150
       THISFORM.GRID1.COLUMN1.HEADER1.CAPTION='程式編號'
       THISFORM.GRID1.COLUMN2.HEADER1.CAPTION='程式說明'
       THISFORM.GRID1.COLUMN1.CONTROLSOURCE='A03.F01'
       THISFORM.GRID1.COLUMN2.CONTROLSOURCE='A03.F02'
       THISFORM.GRID1.READONLY=.T.       
       THISFORM.GRID1.SETFOCUS
       IF THISFORM.GRID1.ACTIVEROW=0
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.F.
       ELSE
          THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.      
       ENDIF       
       JK='程式編號'
  ENDPROC
  *******************     
  PROC KEY_LIST.INIT 
       WITH THIS 
           .ADDITEM('依程式編號排列')
       ENDWITH      
  ENDPROC 
  ***************
  PROC GRID1.AFTERROWCOLCHANGE
       LPARAMETERS NCOLINDEX
       THISFORM.TXTF01.VALUE=A03.F01
       THISFORM.TXTF02.VALUE=A03.F02
       THISFORM.TXTF04.VALUE=BILL(A03.F04)
       THISFORM.TXTF05.VALUE=BILL(A03.F05)
       THISFORM.TXTF06.VALUE=BILL(A03.F06)
       THISFORM.TXTF07.VALUE=BILL(A03.F07)
       THISFORM.TXTF08.VALUE=A03.F08
       THISFORM.TXTF09.VALUE=A03.F09
       THISFORM.TXTF10.VALUE=A03.F10
       THISFORM.TXTF11.VALUE=A03.F11
       THISFORM.TXTF12.VALUE=A03.F12
       THISFORM.TXTF13.VALUE=A03.F13
       THISFORM.TXTF14.VALUE=IIF(A03.F14=.T.,'是','否')
       THISFORM.TXTF15.VALUE=A03.F15
       THISFORM.LBLF161.CAPTION=A03.F16       
       FCH=THISFORM.ACTIVECONTROL.NAME
       CHK=''
       THISFORM.REFRESH
  ENDPROC
******************新增
  PROCEDURE ORPGROUP.NEW_BOTT.CLICK    
       THISFORM.SETALL('READONLY',.F.,'TEXTBOX')
       THISFORM.SETALL('VISIBLE',.T.,'OPTIONGROUP')   
       THISFORM.LBLF151.VISIBLE=.T.
       THISFORM.TXTF01.VALUE=''
       THISFORM.TXTF02.VALUE=''
       THISFORM.TXTF08.VALUE=''
       THISFORM.TXTF09.VALUE=''
       THISFORM.TXTF10.VALUE=''
       THISFORM.TXTF11.VALUE=''
       THISFORM.TXTF12.VALUE=''
       THISFORM.TXTF13.VALUE=0
       THISFORM.TXTF15.VALUE=''
       THISFORM.LBLF161.CAPTION=''
       THISFORM.TXTF01.SETFOCUS()
       THISFORM.GRID1.ENABLED=.F.
       FLG='1'
  ENDPROC
*****************修改   
  PROCEDURE ORPGROUP.EDIT_BOTT.CLICK
     THISFORM.TXTF01.READONLY=.T. 
     THISFORM.TXTF02.SETFOCUS
     THISFORM.LBLF151.VISIBLE=.T.
     THISFORM.SETALL('VISIBLE',.T.,'OPTIONGROUP') 
     THISFORM.GRID1.ENABLED=.F. 
     IF THISFORM.TXTF04.VALUE='不可用'
         THISFORM.OPTION04.VALUE=1
     ELSE
          IF  THISFORM.TXTF04.VALUE='可用'
               THISFORM.OPTION04.VALUE=2
          ELSE
               THISFORM.OPTION04.VALUE=3
          ENDIF
     ENDIF
     IF THISFORM.TXTF05.VALUE='不可用'
         THISFORM.OPTION05.VALUE=1
     ELSE
          IF  THISFORM.TXTF05.VALUE='可用'
               THISFORM.OPTION05.VALUE=2
          ELSE
               THISFORM.OPTION05.VALUE=3
          ENDIF
     ENDIF
     IF THISFORM.TXTF06.VALUE='不可用'
         THISFORM.OPTION06.VALUE=1
     ELSE
          IF  THISFORM.TXTF06.VALUE='可用'
               THISFORM.OPTION06.VALUE=2
          ELSE
               THISFORM.OPTION06.VALUE=3
          ENDIF
     ENDIF
     IF THISFORM.TXTF07.VALUE='不可用'
         THISFORM.OPTION07.VALUE=1
     ELSE
          IF  THISFORM.TXTF07.VALUE='可用'
               THISFORM.OPTION07.VALUE=2
          ELSE
               THISFORM.OPTION07.VALUE=3
          ENDIF
     ENDIF
     IF THISFORM.TXTF14.VALUE='是'
         THISFORM.OPTION14.VALUE=1
     ELSE
         THISFORM.OPTION14.VALUE=2
     ENDIF      	
     LOCK()  
     IF !RLOCK()
        DO FILE_IMPACT
        RETURN
     ENDIF
  ENDPROC 
 *****************刪除***********
 PROCEDURE ORPGROUP.DEL_BOTT.CLICK
     IF MESSAGEBOX('是否確定要刪除此筆資料',4+32+256,'請確認') = 6	        
        SELE A03
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
**********************新增確認
 PROCEDURE SHRGROUP.SHURE1_BOTT.CLICK
    IF EMPTY(THISFORM.TXTF01.VALUE)
       =MESSAGEBOX('程式編號不得空白!',0+64,'提示視窗')
       THISFORM.TXTF01.SETFOCUS
       RETURN
    ENDIF
    IF SEEK(THISFORM.TXTF01.VALUE,'A03')=.T.
        =MESSAGEBOX('此程式編號已存在請重新輸入!',0+64,'提示視窗')    
       THISFORM.TXTF01.SETFOCUS
       RETURN
    ENDIF   
    IF EMPTY(THISFORM.TXTF02.VALUE)
       =MESSAGEBOX('程式說明不得空白!',0+64,'提示視窗')
       THISFORM.TXTF01.SETFOCUS
       RETURN
    ENDIF
    SELECT A03      
    APPEND BLANK
    LOCK()
    IF RLOCK()
       REPLACE F01 WITH THISFORM.TXTF01.VALUE
       REPLACE F02 WITH THISFORM.TXTF02.VALUE
       DO CASE 
       	      CASE  THISFORM.OPTION04.VALUE=1
       			  REPLACE F04 WITH '0'
       	      CASE  THISFORM.OPTION04.VALUE=2
       			  REPLACE F04 WITH '1'
              CASE  THISFORM.OPTION04.VALUE=3
       			  REPLACE F04 WITH '2'	
       ENDCASE
       DO CASE 
       	      CASE  THISFORM.OPTION05.VALUE=1
       			  REPLACE F05 WITH '0'
       	      CASE  THISFORM.OPTION05.VALUE=2
       			  REPLACE F05 WITH '1'
              CASE  THISFORM.OPTION05.VALUE=3
       			  REPLACE F05 WITH '2'	
       ENDCASE
        DO CASE 
       	      CASE  THISFORM.OPTION06.VALUE=1
       			  REPLACE F06 WITH '0'
       	      CASE  THISFORM.OPTION06.VALUE=2
       			  REPLACE F06 WITH '1'
              CASE  THISFORM.OPTION06.VALUE=3
       			  REPLACE F06 WITH '2'	
       ENDCASE
       DO CASE 
       	      CASE  THISFORM.OPTION07.VALUE=1
       			  REPLACE F07 WITH '0'
       	      CASE  THISFORM.OPTION07.VALUE=2
       			  REPLACE F07 WITH '1'
              CASE  THISFORM.OPTION07.VALUE=3
       			  REPLACE F07 WITH '2'	
       ENDCASE			  		
       REPLACE F08 WITH THISFORM.TXTF08.VALUE
       REPLACE F09 WITH THISFORM.TXTF09.VALUE
       REPLACE F10 WITH THISFORM.TXTF10.VALUE
       REPLACE F11 WITH THISFORM.TXTF11.VALUE
       REPLACE F12 WITH THISFORM.TXTF12.VALUE 
       REPLACE F13 WITH THISFORM.TXTF13.VALUE
       DO CASE 
       	      CASE  THISFORM.OPTION14.VALUE=1
       			  REPLACE F14 WITH .T.
       	      CASE  THISFORM.OPTION14.VALUE=2
       			  REPLACE F14 WITH .F.	
       ENDCASE			 
       REPLACE F15 WITH THISFORM.TXTF15.VALUE
       REPLACE F16 WITH IIF(INT_012=1,PADL(ALLTRIM(STR(YEAR(DATE())-1911)),3,' ')+RIGHT(DTOC(DATE()),6),dtoc(DATE())+' ')+IIF(SEEK(sys_oper,'A01'),A01.F03,'')                          
    ENDIF
    UNLOCK
    THISFORM.REC_COUNT.CAPTION=STR(RECCOUNT())
    THISFORM.GRID1.ENABLED=.T.
    THISFORM.REFRESH
    THISFORM.GRID1.SETFOCUS    
    THISFORM.ORPGROUP.NEW_BOTT.CLICK            
  ENDPROC
**************************修改確認
  PROCEDURE SHRGROUP.SHURE2_BOTT.CLICK
   IF EMPTY(THISFORM.TXTF02.VALUE)
       =MESSAGEBOX('程式說明不得空白!',0+64,'提示視窗')
       THISFORM.TXTF01.SETFOCUS
       RETURN
    ENDIF   
    SELECT A03
    IF RLOCK()
       REPLACE F02 WITH THISFORM.TXTF02.VALUE
       DO CASE 
       	      CASE  THISFORM.OPTION04.VALUE=1
       			  REPLACE F04 WITH '0'
       	      CASE  THISFORM.OPTION04.VALUE=2
       			  REPLACE F04 WITH '1'
              CASE  THISFORM.OPTION04.VALUE=3
       			  REPLACE F04 WITH '2'	
       ENDCASE
       DO CASE 
       	      CASE  THISFORM.OPTION05.VALUE=1
       			  REPLACE F05 WITH '0'
       	      CASE  THISFORM.OPTION05.VALUE=2
       			  REPLACE F05 WITH '1'
              CASE  THISFORM.OPTION05.VALUE=3
       			  REPLACE F05 WITH '2'	
       ENDCASE
        DO CASE 
       	      CASE  THISFORM.OPTION06.VALUE=1
       			  REPLACE F06 WITH '0'
       	      CASE  THISFORM.OPTION06.VALUE=2
       			  REPLACE F06 WITH '1'
              CASE  THISFORM.OPTION06.VALUE=3
       			  REPLACE F06 WITH '2'	
       ENDCASE
       DO CASE 
       	      CASE  THISFORM.OPTION07.VALUE=1
       			  REPLACE F07 WITH '0'
       	      CASE  THISFORM.OPTION07.VALUE=2
       			  REPLACE F07 WITH '1'
              CASE  THISFORM.OPTION07.VALUE=3
       			  REPLACE F07 WITH '2'	
       ENDCASE			  		
       REPLACE F08 WITH THISFORM.TXTF08.VALUE
       REPLACE F09 WITH THISFORM.TXTF09.VALUE
       REPLACE F10 WITH THISFORM.TXTF10.VALUE
       REPLACE F11 WITH THISFORM.TXTF11.VALUE
       REPLACE F12 WITH THISFORM.TXTF12.VALUE 
       REPLACE F13 WITH THISFORM.TXTF13.VALUE
       DO CASE 
       	      CASE  THISFORM.OPTION14.VALUE=1
       			  REPLACE F14 WITH .T.
       	      CASE  THISFORM.OPTION14.VALUE=2
       			  REPLACE F14 WITH .F.	
       ENDCASE			 
       REPLACE F15 WITH THISFORM.TXTF15.VALUE
       REPLACE F16 WITH IIF(INT_012=1,PADL(ALLTRIM(STR(YEAR(DATE())-1911)),3,' ')+RIGHT(DTOC(DATE()),6),dtoc(DATE())+' ')+IIF(SEEK(sys_oper,'A01'),A01.F03,'')
    ELSE
      DO FILE_IMPACT
      RETURN   
    ENDIF   
    THISFORM.SHRGROUP.ABANDON_BOTT.CLICK    
  ENDPROC 
***********************  
  PROCEDURE SHRGROUP.ABANDON_BOTT.CLICK
      THISFORM.SHRGROUP.ENABLED=.F.
      THISFORM.SHRGROUP.VISIBLE=.F.      
      THISFORM.ORPGROUP.ENABLED=.T.
      THISFORM.ORPGROUP.NEW_BOTT.ENABLED=IIF(A02.F04='*',.T.,.F.)   &&判斷有無新增的權限      
      THISFORM.ORPGROUP.EDIT_BOTT.ENABLED=IIF(A02.F05='*',.T.,.F.)  &&判斷有無修改的權限
      THISFORM.ORPGROUP.DEL_BOTT.ENABLED=IIF(A02.F06='*',.T.,.F.)   &&判斷有無刪除的權限
      THISFORM.ORPGROUP.PNT_BOTT.ENABLED=IIF(A02.F07='*',.T.,.F.)   &&判斷有無列印的權限      
      THISFORM.SETALL('VISIBLE',.F.,'OPTIONGROUP')
      THISFORM.SETALL('VISIBLE',.T.,'TEXTBOX')
      THISFORM.SETALL('READONLY',.T.,'TEXTBOX')   
      THISFORM.ORPGROUP.SETALL('FORECOLOR',RGB(0,0,0),'COMMANDBUTTON')
      THISFORM.CMDGROUP.ENABLED=.T.
      THISFORM.CMDGROUP.SETALL('ENABLED',.T.,'COMMANDBUTTON')
      THISFORM.CMDGROUP.SETALL('FORECOLOR',RGB(0,0,0),'COMMANDBUTTON')
      THISFORM.LBLF151.VISIBLE=.F.
      THISFORM.KEY_LIST.ENABLED=.T.      
      UNLOCK ALL
      SELE A03
      THISFORM.GRID1.ENABLED=.T.
      THISFORM.GRID1.SETFOCUS          
  ENDPROC
 ****************** 
  PROCEDURE SHRGROUP.FINISH_BOTT.CLICK   
       THISFORM.SHRGROUP.ABANDON_BOTT.CLICK
  ENDPROC     
ENDDEFINE
********************
FUNC BILL
     PARA JUK
     JO=''
     DO CASE
        CASE JUK='0'
             JO='不可用'
        CASE JUK='1'
             JO='可用'
        CASE JUK='2'
             JO='依受權'                
     ENDCASE
     RETURN JO              

