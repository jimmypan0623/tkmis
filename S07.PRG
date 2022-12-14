***程式名稱:S07.調薪修改作業
CLOSE ALL
CLEAR 
IF !USED('A02')	&&權限設定檔
   SELE 0
   USE A02 INDE A02
ELSE
   SELE A02
ENDIF
SET ORDER TO A021      
SEEK SYS_OPER+'S07'    
*****
S07FORM=CREATEOBJECT("TKS07")
S07FORM.SHOW  
DEFINE CLASS TKS07 AS FORM
  CAPTION='S07.調薪修改作業'
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
  NAME='TKS07' 
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
      TKS07_TEMP=CREATEOBJECT("TKS07_TEMP")  
      TKS07_TEMP.SHOW    
      THISFORM.RELEASE      
      IF !USED('A04')
           SELE 0
           USE A04 INDE A04
      ELSE
           SELE A04
      ENDIF   
      SET ORDER TO 1    
      SEEK sys_oper
      IF FOUND()
          REPL F02 WITH ''
          REPL F03 WITH ''
          REPL F04 WITH ''
      ENDIF   
      UNLOCK ALL                  
      CLOSE TABLE ALL
      THISFORM.RELEASE 
      RETURN  
ENDPROC                  
ENDDEFINE
**
DEFINE CLASS TKS07_TEMP AS FORM
*!*	  AUTOCENTER=.T.
  CAPTION='S07.調薪修改作業'
  FONTSIZE=INT_015*9
  TOP=INT_015*200
  LEFT=INT_015*225
  HEIGHT=INT_015*100
  WIDTH=INT_015*290
  MOVABLE=.F.
  MAXBUTTON=.F.
  MINBUTTON=.F.
  CONTROLBOX=.F.
  BORDERSTYLE=1
  SHOWTIPS=.T.
  SHOWWINDOW=1
  WINDOWTYPE=1
  NAME='TKS07_TEMP'
   ADD OBJECT OP_CHOICE AS OPTIONGROUP WITH;
      LEFT=INT_015*30,;
      TOP=INT_015*20,;
      ALIGNMENT=0,;
      AUTOSIZE=.T.,;
      BUTTONCOUNT=2,;
      VALUE=1,;
      OPTION1.CAPTION='S07A.人員調薪修改作業',;
      OPTION1.FONTSIZE=INT_015*10  ,;
      OPTION1.TOP=INT_015*7,;
      OPTION1.AUTOSIZE=.T.,;
      OPTION1.LEFT=INT_015*5,;
      OPTION1.NAME='OPTION1',;
      OPTION2.CAPTION='S07B.部門調薪修改作業',;
      OPTION2.FONTSIZE=INT_015*10,;
      OPTION2.TOP=INT_015*40,;
      OPTION2.AUTOSIZE=.T.,;
      OPTION2.LEFT=INT_015*5,;
      OPTION2.NAME='OPTION2'        
  ADD OBJECT CMND1 AS COMMANDBUTTON WITH;
      LEFT=INT_015*210,;
      TOP=INT_015*20,;
      HEIGHT=INT_015*25,;
      WIDTH=INT_015*50,;
      FONTSIZE=INT_015*10,;
      MOUSEPOINTER=99,;
      MOUSEICON='BMPS\harrow.cur',;  
      CAPTION='\<Y.確認',;
      TOOLTIPTEXT='確認所輸入之內容->ALT+Y',;
      NAME='CMND1'
 ADD OBJECT CMND2 AS COMMANDBUTTON WITH;
      LEFT=INT_015*210,;
      TOP=INT_015*55,;
      HEIGHT=INT_015*25,;
      WIDTH=INT_015*50,;
      FONTSIZE=INT_015*10,;
      MOUSEPOINTER=99,;
      MOUSEICON='BMPS\harrow.cur',;        
      CAPTION='\<C.取消',;
      TOOLTIPTEXT='取消此畫面!快速鍵->ALT+C'
      NAME='CMND2'  
 PROCEDURE INIT 
         THISFORM.OP_CHOICE.OPTION1.FONTSIZE=INT_015*10
	 THISFORM.OP_CHOICE.OPTION2.FONTSIZE=INT_015*10
         THISFORM.SETALL('FONTSIZE',INT_015*10,'COMMANDBUTTON')     
         IF A02.F10='*'   &&判斷是否可執行S07B.部門調薪修改作業之權限
             THISFORM.OP_CHOICE.ENABLED=.T. 
             THISFORM.OP_CHOICE.OPTION2.FONTSTRIKETHRU=.F.
         ELSE
              THISFORM.OP_CHOICE.ENABLED=.F. 
              THISFORM.OP_CHOICE.OPTION2.FONTSTRIKETHRU=.T.
         ENDIF             
 ENDPROC            
********確認鍵******
PROCEDURE CMND1.CLICK    
    IF THISFORM.OP_CHOICE.VALUE=1
        DO S07A
    ELSE
        DO S07B
    ENDIF
    THISFORM.CMND2.CLICK
 ENDPROC   
 ***********
 PROC CMND1.MOUSEENTER      
     LPARAMETERS nButton, nShift, nXCoord, nYCoord 
            THISFORM.CMND1.FORECOLOR=RGB(255,0,0)
            THISFORM.CMND1.TOP=INT_015*21
            THISFORM.CMND1.LEFT=INT_015*211
 ENDPROC     
 PROC CMND1.MOUSELEAVE      
     LPARAMETERS nButton, nShift, nXCoord, nYCoord 
            THISFORM.CMND1.FORECOLOR=RGB(0,0,0)  
            THISFORM.CMND1.TOP=INT_015*20
            THISFORM.CMND1.LEFT=INT_015*210                  
 ENDPROC 
********離開鍵***********
 PROCEDURE CMND2.CLICK     
     CLOSE TABLE ALL
     THISFORM.RELEASE 
     RETURN  
 ENDPROC      
 **********
 PROC CMND2.MOUSEENTER      
     LPARAMETERS nButton, nShift, nXCoord, nYCoord 
            THISFORM.CMND2.FORECOLOR=RGB(255,0,0)
            THISFORM.CMND2.TOP=INT_015*56
            THISFORM.CMND2.LEFT=INT_015*211
 ENDPROC     
 PROC CMND2.MOUSELEAVE      
     LPARAMETERS nButton, nShift, nXCoord, nYCoord 
            THISFORM.CMND2.FORECOLOR=RGB(0,0,0)  
            THISFORM.CMND2.TOP=INT_015*55
            THISFORM.CMND2.LEFT=INT_015*210                  
 ENDPROC    
ENDDEFINE       
