**程式名稱:客戶訂單表身檔
set excl off
close all
clear 
AREA1='C04'
FLG='0'
FCH=''
CHK=''
IF !USED('C04')
   SELE 0
   USE C04 
ELSE
   SELE C04
ENDIF
SET ORDER TO C041      

TKC04form=createobject("tKC04")
TKC04form.show  
define class tKC04 as form
  caption='客戶訂單表身檔'
  autocenter=.t.
  controlbox=.F.
  BORDERSTYLE=3  
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

  ADD OBJECT GRID1 AS GRID1 WITH;
      columncount=24,;            
      RECORDSOURCE='C04',; 
      HEIGHT=INT_015*500,;     
      WIDTH=INT_015*780,;
      READONLY=.F.,;
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
  ADD OBJECT ORPGROUP AS ORPGROUP WITH;      
      TOP=INT_015*0,;
      LEFT=INT_015*450              
  ADD OBJECT CMDGROUP AS CMDGROUP WITH;
      TOP=INT_015*0,;
      LEFT=INT_015*300,;
      ENABLED=.T.,;
      VISIBLE=.T.                 

  PROCEDURE INIT
       SELE C04
       THISFORM.GRID1.ALLOWCELLSELECTION=.T.
       THISFORM.CMDGROUP.SEEK_BOTT.VISIBLE=.T.
       THISFORM.CMDGROUP.SEEK_BOTT.ENABLED=.T.
       THISFORM.ORPGROUP.NEW_BOTT.VISIBLE=.F.
       THISFORM.ORPGROUP.EDIT_BOTT.VISIBLE=.F.
       THISFORM.ORPGROUP.pnt_BOTT.VISIBLE=.F.
       THISFORM.GRID1.SETALL('FONTSIZE',INT_015*9,'COLUMN')
       THISFORM.GRID1.SETALL('FONTSIZE',INT_015*9,'HEADER')   
       THISFORM.GRID1.COLUMN1.HEADER1.CAPTION='訂貨日期'
       THISFORM.GRID1.COLUMN2.HEADER1.CAPTION='客戶編號'
       THISFORM.GRID1.COLUMN3.HEADER1.CAPTION='訂單編號'
       THISFORM.GRID1.COLUMN4.HEADER1.CAPTION='品        號'
       THISFORM.GRID1.COLUMN5.HEADER1.CAPTION='訂單數量'
       THISFORM.GRID1.COLUMN6.HEADER1.CAPTION='幣        別'
       THISFORM.GRID1.COLUMN7.HEADER1.CAPTION='單        價'
       THISFORM.GRID1.COLUMN8.HEADER1.CAPTION='小        計'
       THISFORM.GRID1.COLUMN9.HEADER1.CAPTION='已出數量'
       THISFORM.GRID1.COLUMN10.HEADER1.CAPTION='未出累計'
       THISFORM.GRID1.COLUMN11.HEADER1.CAPTION='已排製令'
       THISFORM.GRID1.COLUMN12.HEADER1.CAPTION='安全紀錄'
       THISFORM.GRID1.COLUMN13.HEADER1.CAPTION='特價代碼'       
       THISFORM.GRID1.COLUMN14.HEADER1.CAPTION='子製令數'
       THISFORM.GRID1.COLUMN15.HEADER1.CAPTION='計價量'
       THISFORM.GRID1.COLUMN16.HEADER1.CAPTION='無價量'
       THISFORM.GRID1.COLUMN17.HEADER1.CAPTION='客戶品號'
       THISFORM.GRID1.COLUMN18.HEADER1.CAPTION='計價已出'
       THISFORM.GRID1.COLUMN19.HEADER1.CAPTION='無價已出'                                                        
       THISFORM.GRID1.COLUMN20.HEADER1.CAPTION='退貨不補(無)'
       THISFORM.GRID1.COLUMN21.HEADER1.CAPTION='訂單取消量'
       THISFORM.GRID1.COLUMN22.HEADER1.CAPTION='歷史單價'
       THISFORM.GRID1.COLUMN23.HEADER1.CAPTION='開單未出'       
       THISFORM.GRID1.COLUMN24.HEADER1.CAPTION='開單未退'
       THISFORM.GRID1.SETFOCUS   
       JK='訂單編號'
  ENDPROC       

  PROC GRID1.AFTERROWCOLCHANGE
       LPARAMETERS nColIndex       
       FCH=THISFORM.ACTIVECONTROL.NAME
       CHK=''
       thisform.refresh
  ENDPROC      
  PROC ORPGROUP.DEL_BOTT.CLICK
       SELE C04
       DELE 
       SKIP -1
       IF BOF()
         GO TOP
       ENDIF
       SELE C04
       THISFORM.GRID1.SETFOCUS  
enddefine            