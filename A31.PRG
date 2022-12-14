CLEAR DLLS 

&&--------------------------註冊表使用之函式------------------------------
#DEFINE HKEY_CLASSES_ROOT bitset(0,31) &&-2147483648
#DEFINE HKEY_CURRENT_USER bitset(0,31)+1 &&-2147483647
#DEFINE HKEY_LOCAL_MACHINE bitset(0,31)+2 &&-2147483646
#DEFINE HKEY_USER bitset(0,31)+3 &&-2147483645
#DEFINE HKEY_CURRENT_CONFIG bitset(0,31)+5 &&-2147483643
#DEFINE HKEY_DYN_DATA bitset(0,31)+6 &&-2147483642

#DEFINE REG_SZ 1
#DEFINE REG_BINARY 3
#DEFINE REG_DWORD 4

* 以下API函式返回0時，操作成功。

DECLARE Integer RegOpenKey IN Win32API ;
Integer nHKey, String @cSubKey, Integer @nResult

DECLARE Integer RegCreateKey IN Win32API ;
Integer nHKey, String @cSubKey, Integer @nResult

DECLARE Integer RegSetValueEx IN Win32API ;
Integer hKey, String lpszValueName, Integer dwReserved,;
Integer fdwType, String lpbData, Integer cbData

DECLARE Integer RegQueryValueEx IN Win32API ;
Integer nHKey, String lpszValueName, Integer dwReserved,;
Integer @lpdwType,string @lpbData, Integer @lpcbData

* DECLARE Integer RegDeleteKey IN Win32API ;
* Integer nHKey, String @cSubKey

* DECLARE Integer RegDeleteValue IN Win32API ;
* Integer nHKey, String cSubKey

DECLARE Integer RegCloseKey IN Win32API ;
Integer nHKey
&&--------------------------註冊表使用之函式-----------------------------

nPrintCount=APRINTERS(aArrayPrint)
IF nPrintCount=0
    =MESSAGEBOX("當前系統中沒安裝印表機")
    RETURN .F.
ENDIF     
cCurrentPrinter=SET("Printer",3) &&取得預設印表機
FOR i=1 TO nPrintCount
    IF UPPER(aArrayPrint(i,1))=cCurrentPrinter&&比較印表機的名稱
        cPort=aArrayPrint(i,2)&&取得印表機的連線port
    ENDIF 
ENDFOR 
*!*	IF SUBSTR(cPort,1,3)#"LPT"
*!*	    =MESSAGEBOX("印表機是網路印表機")
*!*	    *RETURN .F.
*!*	ENDIF 

DECLARE Integer OpenPrinter IN WinSpool.Drv AS WS_OpenPrinter ;
    String pPrinterName, ;
    Integer @phPrinter, ;
    String pDefault
DECLARE Integer DocumentProperties IN WinSpool.Drv ;
    Integer, ;
    Integer, ;
    String, ;
    String, ;
    String, ;
    Integer
DECLARE Integer ClosePrinter IN WinSpool.Drv AS WS_ClosePrinter ;
    Integer hPrinter
DECLARE Integer EnumForms in WinSpool.Drv ;
    Integer, ;
    Integer, ;
    String, ;
    Integer, ;
    Integer, ;
    Integer
DECLARE Integer AddForm IN WinSpool.Drv ;
    Integer, ;
    Integer, ;
    String
DECLARE Integer DeleteForm in WinSpool.Drv ;
    Integer, ;
    String
DECLARE Long CreateDC IN Gdi32.DLL ;
    String @cDriver, ;
    String @cDevice, ;
    String cOutput, ;
    String cInitData
DECLARE Long DeleteDC IN Gdi32.DLL ;
DECLARE Long ResetDC IN Gdi32.DLL ;
    Integer, ;
    String
DECLARE RtlMoveMemory IN Kernel32 AS CopyMemory;
    String @ Destination,;
    Integer Source,;
    Integer nLength
DECLARE Integer lstrcpy IN Kernel32.DLL ;
    Integer lpString1,;
    String @lpString2
DECLARE Integer GetForm IN WinSpool.drv ;
    Integer,;
    String, ;
    Integer,;
    String, ;
    Integer,;
    Integer
DECLARE Integer SetForm IN WinSpool.drv ;
    Integer,;
    String,;
    Integer,;
    String
OHEAP=CREATEOBJECT("Heap") 
IF GetPrinterSettings()=.F. 
    =MESSAGEBOX("無法取得印表機資料")
ENDIF 

FUNCTION GetPrinterSettings
    hPrinter=0
    nSize=0
    IF WS_OpenPrinter(cCurrentPrinter, @hPrinter, 0)#0
        FormName="中一刀"+CHR(0)+CHR(0)  &&自定紙張名稱
        *
        *RetVal=DeleteForm(hPrinter,"中一刀")
        *IF RetVal=0
        *    =MESSAGEBOX("刪除")
        *ENDIF 
        nStringBase=OHEAP.ALLOCBLOB(FormName)
        RetVal=AddForm(hPrinter,1,NumToDWord(0)+;
            NumToDWord(nStringBase)+;
            NumToDWord(215900)+; 
            NumToDWord(139700)+; 
            NumToDWord(1)+;
            NumToDWord(0)+;
            NumToDWord(215900)+;
            NumToDWord(139700)+;
            NumToDWord(1)+;
            NumToDWord(0))
        IF RetVal=0
            =MESSAGEBOX("新增自定紙張中一刀已存在")
        ELSE 
        	CLEAR
		csubkey='SYSTEM\CurrentControlSet\Control\Print\Forms'
		LOCAL result as Long 
		nresult=0 
		if RegOpenKey(HKEY_LOCAL_MACHINE,@csubkey,@nresult)=0 
			*result=RegOpenKey(HKEY_LOCAL_MACHINE,@csubkey,@nresult)
			RegSetValueEx(nresult,'中一刀',0,REG_BINARY,NumToLong(215900)+; 
		        NumToLong(139700)+; 
		        NumToLong(0)+;
		        NumToLong(0)+;
		        NumToLong(215900)+;
		        NumToLong(139700)+;
		        NumToLong(1)+;
		        NumToLong(2),32)
		ENDIF
		RegCloseKey(nresult)
		=MESSAGEBOX("新增自定紙張 '中一刀' 已設定成功")
        ENDIF 
    ELSE 
        WAIT WINDOW "無法開啟印表機!"
    ENDIF 
    IF !USED('A05')
        SELECT 0
        USE A05
    ELSE
       SELECT A05
    ENDIF
    SET ORDER TO 1
    SEEK sys_oper+'A31'
    IF FOUND()
       DELETE 
    ENDIF    
    USE
    CLEAR DLLS 
    RETURN 
ENDFUNC 

DEFINE CLASS HEAP AS CUSTOM 
    PROTECTED INHANDLE, INNUMALLOCSACTIVE,IAALLOCS[1,3] 
    INHANDLE=NULL 
    INNUMALLOCSACTIVE=0 
    IAALLOCS=NULL 
    NAME="heap" 
 
    PROCEDURE ALLOC 
        LPARAMETER NSIZE 
        DECLARE Integer HeapAlloc IN WIN32API AS HAlloc ;
            Integer hHeap,Integer dwFlags,Integer dwBytes 
        DECLARE Integer HeapSize IN WIN32API AS HSize ;
            Integer hHeap,Integer dwFlags,Integer lpcMem 
        LOCAL NPTR 
        WITH THIS 
            NPTR=HALLOC(.INHANDLE, 0, @NSIZE) 
            IF NPTR # 0 
                .INNUMALLOCSACTIVE=.INNUMALLOCSACTIVE + 1 
                DIMENSION .IAALLOCS[.inNumAllocsActive,3] 
                .IAALLOCS[.inNumAllocsActive,1]=NPTR 
                .IAALLOCS[.inNumAllocsActive,2]=HSIZE(.INHANDLE, 0, NPTR) 
                .IAALLOCS[.inNumAllocsActive,3]=.T. 
            ELSE 
                NPTR=NULL 
            ENDIF 
        ENDWITH 
        RETURN NPTR 
    ENDPROC 
 
    FUNCTION ALLOCBLOB 
        LPARAMETER CBSTRINGTOCOPY 
        LOCAL NALLOCPTR 
        WITH THIS 
            NALLOCPTR=.ALLOC(LEN(CBSTRINGTOCOPY)) 
            IF !ISNULL(NALLOCPTR) 
                .COPYTO(NALLOCPTR,CBSTRINGTOCOPY) 
            ENDIF 
        ENDWITH 
        RETURN NALLOCPTR 
    ENDFUNC 
 
    FUNCTION ALLOCSTRING 
        LPARAMETER CSTRING 
        RETURN This.ALLOCBLOB(CSTRING+CHR(0)) 
    ENDFUNC 
 
    FUNCTION ALLOCINITAS 
        LPARAMETER NSIZEOFBUFFER, NBYTEvalue 
        IF TYPE("nBytevalue")#"N" OR !BETWEEN(NBYTEvalue,0,255) 
            NBYTEvalue=0 
        ENDIF 
        RETURN This.ALLOCBLOB(REPLICATE(CHR(NBYTEvalue),NSIZEOFBUFFER)) 
    ENDFUNC 
 
    PROCEDURE DEALLOC 
        LPARAMETER NPTR 
        DECLARE Integer HeapFree IN WIN32API AS HFree ; 
            Integer hHeap, ; 
            Integer dwFlags, ; 
            Integer lpMem 
        LOCAL NCTR 
        NCTR=NULL 
        WITH This 
            NCTR=.FINDALLOCID(NPTR) 
            IF !ISNULL(NCTR) 
                =HFREE(.INHANDLE, 0, NPTR) 
                .IAALLOCS[nCtr,3] = .F. 
            ENDIF 
        ENDWITH 
        RETURN !ISNULL(NCTR) 
    ENDPROC 
 
    PROCEDURE COPYTO 
        LPARAMETER NPTR, CSOURCE 
        DECLARE RtlMoveMemory IN WIN32API AS RtlCopy ; 
            Integer nDestBuffer, ; 
            String @pVoidSource, ; 
            Integer nLength 
        LOCAL NCTR 
        NCTR=NULL 
        IF TYPE("nPtr")="N" AND TYPE("cSource") $ "CM" ; 
                AND ! (ISNULL(NPTR) OR ISNULL(CSOURCE)) 
            WITH THIS 
                NCTR=.FINDALLOCID(NPTR) 
                IF ! ISNULL(NCTR) 
                    =RTLCOPY((.IAALLOCS[nCtr,1]), ; 
                        CSOURCE, ; 
                        MIN(LEN(CSOURCE),.IAALLOCS[nCtr,2])) 
                ENDIF 
            ENDWITH 
        ENDIF 
        RETURN !ISNULL(NCTR) 
    ENDPROC 
 
    PROCEDURE COPYFROM 
        LPARAMETER NPTR 
        DECLARE RtlMoveMemory IN WIN32API AS RtlCopy ; 
            String @DestBuffer, ; 
            Integer pVoidSource, ; 
            Integer nLength 
        LOCAL NCTR, UBUFFER 
        UBUFFER=NULL 
        NCTR=NULL 
        IF TYPE("nPtr")="N" AND !ISNULL(NPTR) 
            WITH This 
                NCTR=.FINDALLOCID(NPTR) 
                IF !ISNULL(NCTR) 
                    UBUFFER=REPLICATE(CHR(0),.IAALLOCS[nCtr,2]) 
                    =RTLCOPY(@UBUFFER, ; 
                        (.IAALLOCS[nCtr,1]), ; 
                        (.IAALLOCS[nCtr,2])) 
                ENDIF 
            ENDWITH 
        ENDIF 
        RETURN UBUFFER 
    ENDPROC 
 
    PROTECTED FUNCTION FINDALLOCID 
        LPARAMETER NPTR 
        LOCAL NCTR 
        WITH This 
            FOR NCTR=1 TO .INNUMALLOCSACTIVE 
                IF .IAALLOCS[nCtr,1] = NPTR AND .IAALLOCS[nCtr,3] 
                    EXIT 
                ENDIF 
            ENDFOR 
            RETURN IIF(NCTR <= .INNUMALLOCSACTIVE,NCTR,NULL) 
        ENDWITH 
    ENDPROC 
 
    PROCEDURE SIZEOFBLOCK 
        LPARAMETERS NPTR 
        LOCAL NCTR, NSIZEOFBLOCK 
        NSIZEOFBLOCK=NULL 
        WITH This 
            NCTR = .FINDALLOCID(NPTR) 
            RETURN IIF(ISNULL(NCTR),NULL,.IAALLOCS[nCtr,2]) 
        ENDWITH 
    ENDPROC 
 
    PROCEDURE DESTROY 
        DECLARE HeapDestroy IN WIN32API AS HDestroy Integer hHeap 
 
        LOCAL NCTR 
        WITH This
            FOR NCTR = 1 TO .INNUMALLOCSACTIVE 
                IF .IAALLOCS[nCtr,3] 
                    .DEALLOC(.IAALLOCS[nCtr,1]) 
                ENDIF 
            ENDFOR 
            HDESTROY[.inHandle] 
        ENDWITH 
        DODEFAULT() 
    ENDPROC 
 
    PROCEDURE INIT 
        DECLARE Integer HeapCreate IN WIN32API AS HCreate ; 
            Integer dwOptions, ; 
            Integer dwInitialSize, ; 
            Integer dwMaxSize 
        #DEFINE SWAPFILEPAGESIZE  4096 
        #DEFINE BLOCKALLOCSIZE    2 * SWAPFILEPAGESIZE 
        WITH This 
            .INHANDLE = HCREATE(0, BLOCKALLOCSIZE, 0) 
            DIMENSION .IAALLOCS[1,3] 
            .IAALLOCS[1,1] = 0 
            .IAALLOCS[1,2] = 0 
            .IAALLOCS[1,3] = .F. 
            .INNUMALLOCSACTIVE = 0 
        ENDWITH 
        RETURN (This.INHANDLE#0) 
    ENDPROC 
 
ENDDEFINE &&---類別定義結束 
 
&&-------------定義一些變數型態的轉換函式------------------- 
FUNCTION SETMEM&&設定記憶體函式,利用WinApi的函式進行記憶體拷備 
    LPARAMETERS NPTR, CSOURCE 
    DECLARE RtlMoveMemory IN WIN32API AS RtlCopy ; 
        Integer nDestBuffer, ; 
        String @pVoidSource, ; 
        Integer nLength 
 
    RTLCOPY(NPTR, ; 
        CSOURCE, ; 
        LEN(CSOURCE)) 
    RETURN .T.
ENDFUNC  
 
FUNCTION GETMEM&&將記憶體內容拷備至變數 
    LPARAMETERS NPTR, NLEN 
    DECLARE RtlMoveMemory IN WIN32API AS RtlCopy ; 
        String @DestBuffer, ; 
        Integer pVoidSource, ; 
        Integer nLength 
    LOCAL UBUFFER 
    UBUFFER = REPL(CHR(0),NLEN) 
    =RTLCOPY(@UBUFFER, ; 
        NPTR, ; 
        NLEN) 
    RETURN UBUFFER 
ENDFUNC 
 
FUNCTION GETMEMSTRING 
    LPARAMETERS NPTR, NSIZE 
    DECLARE Integer lstrcpyn IN WIN32API AS StrCpyN ; 
        STRING @ lpDestString, ; 
        Integer lpSource, ; 
        Integer nMaxLength 
    LOCAL UBUFFER 
    IF TYPE("nSize") # "N" OR ISNULL(NSIZE) 
        NSIZE = 512 
    ENDIF 
    UBUFFER = REPL(CHR(0), NSIZE) 
    IF STRCPYN(@UBUFFER, NPTR, NSIZE-1) # 0 
        UBUFFER = LEFT(UBUFFER, MAX(0,AT(CHR(0),UBUFFER) - 1)) 
    ELSE 
        UBUFFER = NULL 
    ENDIF 
    RETURN UBUFFER 
ENDFUNC 
 
FUNCTION SHORTTONUM&&數值型別的轉換 
    LPARAMETER TCINT 
    LOCAL B0,B1,NRETVAL 
    B0=ASC(TCINT) 
    B1=ASC(SUBS(TCINT,2,1)) 
    IF B1<128 
        NRETVAL=B1 * 256 + B0 
    ELSE 
        B1=255-B1 
        B0=256-B0 
        NRETVAL= -( (B1 * 256) + B0) 
    ENDIF 
    RETURN NRETVAL 
ENDFUNC 
 
FUNCTION NUMTOSHORT 
    LPARAMETER TNNUM 
    LOCAL B0,B1,X 
    IF TNNUM>=0 
        X=INT(TNNUM) 
        B1=INT(X/256) 
        B0=MOD(X,256) 
    ELSE 
        X=INT(-TNNUM) 
        B1=255-INT(X/256) 
        B0=256-MOD(X,256) 
        IF B0=256 
            B0=0 
            B1=B1+1 
        ENDIF 
    ENDIF 
    RETURN CHR(B0)+CHR(B1) 
ENDFUNC 
 
FUNCTION DWORDTONUM 
    LPARAMETER TCDWORD 
    LOCAL B0,B1,B2,B3 
    B0=ASC(TCDWORD) 
    B1=ASC(SUBS(TCDWORD,2,1)) 
    B2=ASC(SUBS(TCDWORD,3,1)) 
    B3=ASC(SUBS(TCDWORD,4,1)) 
    RETURN (((B3*256+B2)*256+B1)*256+B0) 
ENDFUNC 
 
FUNCTION NUMTODWORD 
    LPARAMETER TNNUM 
    RETURN NUMTOLONG(TNNUM) 
ENDFUNC 
 
FUNCTION WORDTONUM 
    LPARAMETER TCWORD 
    RETURN (256*ASC(SUBST(TCWORD,2,1)))+ASC(TCWORD) 
ENDFUNC 
 
FUNCTION NUMTOWORD 
    LPARAMETER TNNUM 
    LOCAL X 
    X=INT(TNNUM) 
    RETURN CHR(MOD(X,256))+CHR(INT(X/256)) 
ENDFUNC 
 
FUNCTION NUMTOLONG 
    LPARAMETER TNNUM 
    DECLARE RtlMoveMemory IN WIN32API AS RtlCopyLong ; 
        String @pDestString, ; 
        Integer @pVoidSource, ; 
        Integer nLength 
    LOCAL CSTRING 
    CSTRING=SPACE(4) 
    =RTLCOPYLONG(@CSTRING, BITOR(TNNUM,0), 4) 
    RETURN CSTRING 
ENDFUNC 
 
FUNCTION LONGTONUM 
    LPARAMETER TCLONG 
    DECLARE RtlMoveMemory IN WIN32API AS RtlCopyLong ; 
        Integer @DestNum, ; 
        String @pVoidSource, ; 
        Integer nLength 
    LOCAL NNUM 
    NNUM = 0 
    =RTLCOPYLONG(@NNUM, TCLONG, 4) 
    RETURN NNUM 
ENDFUNC  

FUNCTION ALLOCNETAPIBUFFER 
    LPARAMETER NSIZE 
    IF TYPE("nSize") # "N" OR NSIZE <= 0 
        RETURN NULL 
    ENDIF 
    IF ! "NT" $ OS() 
        RETURN NULL 
    ENDIF 
    DECLARE Integer NetApiBufferAllocate IN NETAPI32.DLL ; 
        Integer dwByteCount, ; 
        Integer lpBuffer 
    LOCAL  NBUFFERPOINTER 
    NBUFFERPOINTER = 0 
    IF NETAPIBUFFERALLOCATE(INT(NSIZE), @NBUFFERPOINTER) # 0 
        NBUFFERPOINTER = NULL 
    ENDIF 
    RETURN NBUFFERPOINTER 
ENDFUNC 
 
FUNCTION DEALLOCNETAPIBUFFER 
    LPARAMETER NPTR 
    IF TYPE("nPtr")#"N" 
        RETURN .F. 
    ENDIF 
    IF !"NT" $ OS() 
        RETURN .F. 
    ENDIF 
    DECLARE Integer NetApiBufferFree IN NETAPI32.DLL ; 
        Integer lpBuffer 
    RETURN (NETAPIBUFFERFREE(INT(NPTR))=0) 
ENDFUNC 
 
FUNCTION COPYDOUBLETOSTRING 
    LPARAMETER NDOUBLETOCOPY 
    DECLARE RtlMoveMemory IN WIN32API AS RtlCopyDbl ; 
        String @DestString, ; 
        Double @pVoidSource, ; 
        Integer nLength 
    LOCAL CSTRING 
    CSTRING=SPACE(8) 
    =RTLCOPYDBL(@CSTRING, NDOUBLETOCOPY, 8) 
    RETURN CSTRING 
ENDFUNC 
 
FUNCTION DOUBLETONUM 
    LPARAMETER CDOUBLEINSTRING 
    DECLARE RtlMoveMemory IN WIN32API AS RtlCopyDbl ; 
        Double @DestNumeric, ; 
        String @pVoidSource, ; 
        Integer nLength 
    LOCAL NNUM 
    NNUM = 0.000000000000000000 
    =RTLCOPYDBL(@NNUM, CDOUBLEINSTRING, 8) 
    RETURN NNUM
ENDFUNC 