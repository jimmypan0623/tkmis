****A08.修改個人密碼
CLOSE ALL
CLEAR
IF !USED('A02')
   SELE 0
   USE A02 INDE A02
ELSE
   SELE A02
ENDIF
SET ORDER TO A021      
SEEK SYS_OPER+'A08'
IF !USED('A01')
   SELE 0
   USE A01
ELSE 
  SELE A01
ENDIF
SET ORDER TO A01
*****
A08FORM=CREATEOBJECT("TKA08")
A08FORM.SHOW  
DEFINE CLASS TKA08 AS FORM
  CAPTION='A08.修改個人密碼'
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
  WIDTH=INT_015*791
  SHOWTIPS=.T.
  SHOWWINDOW=1
  WINDOWTYPE=1
  NAME='TKA08' 
  ADD OBJECT CMND1 AS COMMANDBUTTON WITH;
      VISIBLE=.F.,;
      LEFT=INT_015*131,;
      TOP=INT_015*340,;
      HEIGHT=INT_015*25,;
      WIDTH=INT_015*40,;
      FONTSIZE=INT_015*9,;
      MOUSEPOINTER=99,;
      MOUSEICON='BMPS\harrow.cur',;        
      CAPTION='\<C.選擇',;
      TOOLTIPTEXT='選擇此作業畫面!快速鍵->ALT+A'
      NAME='CMND1'        
  PROCEDURE  INIT       
      v_scrx=SYSMETRIC(1)
      v_scry=SYSMETRIC(2)
      DO CASE
           CASE  v_scrx=640 AND v_scry=480 
                      THISFORM.PICTURE='BMPS\XP800600.JPG' 
           CASE  v_scrx=800 AND v_scry=600 
                      THISFORM.PICTURE='BMPS\XP800600.JPG' 
           CASE  v_scrx=1024 AND v_scry=768
  	              THISFORM.PICTURE='BMPS\XP1024768.JPG' 
           OTHERWISE
     	              THISFORM.PICTURE='BMPS\XP1024768.JPG' 
      ENDCASE  
 ENDPROC
 PROCEDURE ACTIVATE
       THISFORM.CMND1.SETFOCUS
       THISFORM.CMND1.CLICK	
 ENDPROC
 PROCEDURE CMND1.CLICK  
      TKA08_TEMP=CREATEOBJECT("TKA08_TEMP")  
      TKA08_TEMP.SHOW    
      THISFORM.RELEASE      
      IF !USED('A05')
           SELE 0
           USE A05 
      ELSE
           SELE A05
      ENDIF   
      SET ORDER TO 1    
      SEEK sys_oper+'A08'
      IF FOUND()
         DELETE 
      ENDIF   
      UNLOCK ALL                  
      CLOSE TABLE ALL
      THISFORM.RELEASE 
      RETURN  
ENDPROC                  
ENDDEFINE
***   
DEFINE CLASS TKA08_TEMP AS FORM
*!*	  AUTOCENTER=.T.
  CAPTION='A08.修改個人密碼'
  TOP=INT_015*190
  LEFT=INT_015*270  
  FONTSIZE=INT_015*9
  HEIGHT=INT_015*180
  WIDTH=INT_015*220
  MAXBUTTON=.F.
  MINBUTTON=.F.
  MOVABLE=.F.
  CLOSABLE=.F.  
  CONTROLBOX=.F.
  BORDERSTYLE=2
  SHOWTIPS=.T.
  SHOWWINDOW=1
  WINDOWTYPE=1
  NAME='TKA08_TEMP'
  ADD OBJECT LBL1 AS LABEL WITH;
      LEFT=INT_015*5,;
      TOP=INT_015*40,;
      AUTOSIZE=.T.,;
      CAPTION='請輸入原來密碼'
  ADD OBJECT TXT1 AS TEXTBOX WITH;
      LEFT=INT_015*120,;
      TOP=INT_015*35,;
      HEIGHT=INT_015*25,;
      WIDTH=INT_015*55,;
      PASSWORDCHAR='*',;
      MAXLENGTH=5,;
      NAME='TXT1'          
  ADD OBJECT LBL2 AS LABEL WITH;
      LEFT=INT_015*5,;
      TOP=INT_015*80,;
      AUTOSIZE=.T.,;
      CAPTION='請輸入新的密碼'      
  ADD OBJECT TXT2 AS TEXTBOX WITH;
      LEFT=INT_015*120,;
      TOP=INT_015*74,;
      HEIGHT=INT_015*25,;
      WIDTH=INT_015*55,;
      PASSWORDCHAR='*',; 
      INPUTMASK='#####',;           
      NAME='TXT2'          
  ADD OBJECT CMND1 AS COMMANDBUTTON WITH;
      LEFT=INT_015*20,;
      TOP=INT_015*125,;
      HEIGHT=INT_015*30,;
      WIDTH=INT_015*65,;
      FONTSIZE=INT_015*12,;
      CAPTION='\<Y.確認',;
      TOOLTIPTEXT='確認所修改的密碼',;
      NAME='CMND1'
  ADD OBJECT CMND2 AS COMMANDBUTTON WITH;
      LEFT=INT_015*130,;
      TOP=INT_015*125,;
      HEIGHT=INT_015*30,;
      WIDTH=INT_015*65,;
      FONTSIZE=INT_015*12,;
      CAPTION='\<X.離開',;
      TOOLTIPTEXT='離開此查詢尋畫面!快速鍵->ALT+X'
      NAME='CMND2'
 PROCEDURE INIT 
         THISFORM.SETALL('FONTSIZE',INT_015*11,'LABEL')
         THISFORM.SETALL('HEIGHT',INT_015*25,'TEXTBOX')
         THISFORM.SETALL('FONTSIZE',INT_015*11,'TEXTBOX')
         THISFORM.SETALL('FONTSIZE',INT_015*11,'COMMANDBUTTON')  
         THISFORM.SETALL('MOUSEPOINTER',99,'COMMANDBUTTON')  
         THISFORM.SETALL('MOUSEICON','BMPS\harrow.cur','COMMANDBUTTON')
         THISFORM.TXT1.SETFOCUS                
ENDPROC
PROCEDURE CMND1.CLICK
      SELECT  A01
      SEEK SYS_OPER
      IF THISFORM.TXT1.VALUE=A01.F02
           REPLACE  F02 WITH THISFORM.TXT2.VALUE
           =MESSAGEBOX('密碼更新成功!',0+64,'提示訊息視窗')
      ELSE
           =MESSAGEBOX('原來密碼輸入錯誤!',0+48,'提示訊息視窗')
           THISFORM.TXT1.SETFOCUS
           RETURN
      ENDIF    
      THISFORM.CMND2.SETFOCUS    
 ENDPROC
 PROCEDURE CMND2.CLICK        
      CLOSE TABLE ALL
      THISFORM.RELEASE 
      RETURN  
 ENDPROC      
*****
 PROC CMND1.MOUSEENTER      
       LPARAMETERS nButton, nShift, nXCoord, nYCoord 
             THISFORM.CMND1.FORECOLOR=RGB(255,0,0)
             THISFORM.CMND1.TOP=INT_015*126
             THISFORM.CMND1.LEFT=INT_015*21
  ENDPROC     
  PROC CMND1.MOUSELEAVE      
        LPARAMETERS nButton, nShift, nXCoord, nYCoord 
             THISFORM.CMND1.FORECOLOR=RGB(0,0,0)  
             THISFORM.CMND1.TOP=INT_015*125
             THISFORM.CMND1.LEFT=INT_015*20                
  ENDPROC 
 PROC CMND2.MOUSEENTER      
       LPARAMETERS nButton, nShift, nXCoord, nYCoord 
             THISFORM.CMND2.FORECOLOR=RGB(255,0,0)
             THISFORM.CMND2.TOP=INT_015*126
             THISFORM.CMND2.LEFT=INT_015*131
  ENDPROC     
  PROC CMND2.MOUSELEAVE      
        LPARAMETERS nButton, nShift, nXCoord, nYCoord 
             THISFORM.CMND2.FORECOLOR=RGB(0,0,0)  
             THISFORM.CMND2.TOP=INT_015*125
             THISFORM.CMND2.LEFT=INT_015*130
 ENDPROC            
ENDDEFINE            