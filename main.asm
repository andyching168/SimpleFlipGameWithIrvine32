INCLUDE Irvine32.inc
INCLUDE Macros.inc
.data
    array dd 1,4,5,3,2,6,3,2,1,6,5,4
    MessageBar BYTE "-------",0dh,0ah,0
    MessageFirst BYTE "First Attempt",0dh,0ah,0
    MessageSecond BYTE "Second Attempt",0dh,0ah,0
    MessageOK BYTE "OK",0
    WinStatus DWORD -3
    WinTimes DWORD 0
    Num DWORD 0,0
    i DWORD 0
    j DWORD 0
    First_i DWORD 0
    First_j DWORD 0
    isVisible DWORD 0

    Num0 DWORD 0
    Num1 DWORD 0


    u DWORD 0
    KeyboardSELECT DWORD -1
    r DWORD 0
    s DWORD 0
    q DWORD 0
    g DWORD 0
    tempValueInArray DWORD 0
    CurrentCursor DWORD 0
    tempFirstLocation DWORD 0
    tempSecondLocation DWORD 0
    XYPos COORD <0,9>
    XYPos1 COORD <0,2>
    consoleHandle DWORD ?

    buffer  BYTE  50  DUP(0)
    byteCount   DWORD   ? 
    intVal SDWORD ?
    Message1 BYTE "Fibonacci Numbers by, Andy",0dh,0ah,0dh,0ah,0
    Message2 BYTE "What is your name?:",0
    MessageName DWORD  ?
    Message3 BYTE "Hi, ",0
    MessageSpace BYTE " ",0dh,0ah,0dh,0ah,0
    MessageNL BYTE 0dh,0ah,0
    MessageTab BYTE "   ",0
    Message4 BYTE "How many Fibonacci numbers should I display?",0dh,0ah,0
    MessageEnter BYTE "Enter and integer in the range [1...25]: ",0
    MessageError BYTE "That number was out of range, try again.",0dh,0ah,0
    MessageGoodBye BYTE "Goodbye,",0
    MessageF1 BYTE "F(",0
    MessageF2 BYTE ") = ",0
    MessageFP BYTE ") + ",0
    Val1   DWORD   ?
    Val2   DWORD   0
    Val3   DWORD   0
    ValMax DWORD ?
    ValTab DWORD   0
nextTerm		DWORD	1	;To hold the next term in the sequence, starting with 1
.code
main PROC
MAINPROC:
;While Winstatus is 0 run forever


;for u=0;u<2;u++
INPUTPROC:

mov  edx,OFFSET MessageBar
call WriteString

.IF u==0
call OUTFIRST
.ELSE

call OUTSECOND
.ENDIF

LookForKey PROC
    mov  eax,50          ; sleep, to allow OS to time slice
    call Delay           ; (otherwise, some key presses are lost)

    call ReadKey         ; look for keyboard input
    jz   LookForKey      ; no key pressed yet
    



    .IF dx==VK_DOWN
        ;mov  edx,OFFSET MessageOK
        ;call WriteString
        .IF i<2
            add i,1
        .ENDIF
        .IF u==0
            INVOKE GetStdHandle, STD_OUTPUT_HANDLE
            mov consoleHandle,eax
            INVOKE SetConsoleCursorPosition, consoleHandle, XYPos1
            ;gotoxy(0,2)
        .ELSE
            INVOKE GetStdHandle, STD_OUTPUT_HANDLE
            mov consoleHandle,eax
            INVOKE SetConsoleCursorPosition, consoleHandle, XYPos
            ;gotoxy(0,13)
        .ENDIF
        call Crlf

        mov isVisible,0

        call UPDATECursor
        call DrawGUI
        mWrite "["
        mov eax,i
        add eax,1
        call WriteDec
        mWrite "] "
        mWrite "["
        mov eax,j
        add eax,1
        call WriteDec
        mWrite "]"
        



    .ENDIF
    .IF dx==VK_UP
        .IF i>0
            add i,-1
        .ENDIF
        .IF u==0    ;是否為第一次
            INVOKE GetStdHandle, STD_OUTPUT_HANDLE
            mov consoleHandle,eax
            INVOKE SetConsoleCursorPosition, consoleHandle, XYPos1
            ;gotoxy(0,2)
        .ELSE
            INVOKE GetStdHandle, STD_OUTPUT_HANDLE
            mov consoleHandle,eax
            INVOKE SetConsoleCursorPosition, consoleHandle, XYPos
            ;gotoxy(0,13)
        .ENDIF
        call Crlf
        mov isVisible,0
        call UPDATECursor
        call DrawGUI
        mWrite "["
        mov eax,i
        add eax,1
        call WriteDec
        mWrite "] "
        mWrite "["
        mov eax,j
        add eax,1
        call WriteDec
        mWrite "]"

    .ENDIF
    .IF dx==VK_LEFT
        .IF j>0
            add j,-1
        .ENDIF
        .IF u==0
            INVOKE GetStdHandle, STD_OUTPUT_HANDLE
            mov consoleHandle,eax
            INVOKE SetConsoleCursorPosition, consoleHandle, XYPos1
            ;gotoxy(0,2)
        .ELSE
            INVOKE GetStdHandle, STD_OUTPUT_HANDLE
            mov consoleHandle,eax
            INVOKE SetConsoleCursorPosition, consoleHandle, XYPos
            ;gotoxy(0,13)
        .ENDIF
        call Crlf
        mov isVisible,0

        call UPDATECursor

        call DrawGUI
        mWrite "["
        mov eax,i
        add eax,1
        call WriteDec
        mWrite "] "
        mWrite "["
        mov eax,j
        add eax,1
        call WriteDec
        mWrite "]"


    .ENDIF
    .IF dx==VK_RIGHT
        .IF j<3
            add j,1
        .ENDIF
        .IF u==0
            ;mov  dl,0  ;column
            ;mov  dh,2  ;row
            ;call Gotoxy
            INVOKE GetStdHandle, STD_OUTPUT_HANDLE
            mov consoleHandle,eax
            INVOKE SetConsoleCursorPosition, consoleHandle, XYPos1
            ;gotoxy(0,2)
        .ELSE
            ;mov  dl,0  ;column
            ;mov  dh,13  ;row
            ;call Gotoxy
            ;SetConsoleCursorPosition(0,13)
            INVOKE GetStdHandle, STD_OUTPUT_HANDLE
            mov consoleHandle,eax
            INVOKE SetConsoleCursorPosition, consoleHandle, XYPos
            ;gotoxy(0,13)
        .ENDIF
        call Crlf
        mov isVisible,0

        call UPDATECursor

        call DrawGUI
        ;extern fflush
        ;xor  edi, edi          ; RDI = 0
        ;call fflush            ; fflush(NULL) flushes all streams
        mWrite "["
        mov eax,i
        add eax,1
        call WriteDec
        mWrite "] "
        mWrite "["
        mov eax,j
        add eax,1
        call WriteDec
        mWrite "]"

        

    .ENDIF
    .IF dx==VK_HOME
        MOV KeyboardSELECT,5
        ;call     DumpRegs
        call PRINTALL
    .ENDIF
    .IF dx==VK_RETURN
        mov eax,i
        shl eax,2
        mov ebx,j
        add eax,ebx
        mov eax,[array+eax*4]
        mov edx,eax
        .if edx!=0
            call Crlf
            mWrite "You Picked "
            mWrite "["
            mov eax,i
            add eax,1
            call WriteDec
            mWrite "] "
            mWrite "["
            mov eax,j
            add eax,1
            call WriteDec
            mWrite "]"
            mWrite " is "
            mov eax,i
            shl eax,2
            mov ebx,j
            add eax,ebx
            .if u==0
                mov tempFirstLocation,eax
            .else
                mov tempSecondLocation,eax
            .endif
            mov eax,[array+eax*4]
            mov edx,eax
            .if u==0
                mov Num0,edx
            .else
                mov Num1,edx
            .endif
            call writeDec
            call Crlf
        .else
            call INPUTERROR
        .endif
        
        


        MOV KeyboardSELECT,0
    .ELSE
        jmp LookForKey 
    .ENDIF
    LookForKey ENDP







add u,1
;mWrite "OK"
cmp u,2
jae LL1
jb INPUTPROC
LL1:
    mov u,0
    jmp COMP
COMP PROC
;compare the first number and second number
mov eax,Num0
mov ebx,Num1

.IF eax==ebx
    mov isVisible,1
    call DrawGUI_Two
    call Crlf
    mWrite "Correct"
    call Crlf
    call WIN
    
    mov eax , 2000     ;2秒
    call     Delay
    .IF WinTimes==6
        mWrite "You Win"
        exit
    .ELSE
    call Clrscr
    jmp main
    .endif
    


.ELSE
    mov isVisible,1
    call DrawGUI_Two
    call Crlf
    mWrite "Incorrect"
    call Crlf
    mov eax , 2000     ;2秒
    call     Delay
    call Clrscr
    jmp main
.ENDIF
COMP ENDP
ret
main ENDP
DrawGUI PROC
SSS:
     xor eax,eax
     mov eax,r
     mov ecx,eax
     mov eax,[array+eax*4]
     ;call writeDec
     mov edx,eax
     mov tempValueInArray,edx

     mov ebx,tempFirstLocation
     .IF u==1
     
     .ENDIF
     .IF tempValueInArray==0
        mWrite "/"
     .ELSEIF tempValueInArray==757935405

        call     DumpRegs
     .ELSEIF ecx==CurrentCursor
        .IF isVisible==1
            mov eax,tempValueInArray
            call writeDec
        .ELSE
            mWrite "+"
        .ENDIF
        xor eax,eax
     .ELSE
        .IF u==1
            .IF ecx==ebx
                mov eax,tempFirstLocation
                mov eax,[array+eax*4]
                call writeDec
            .ELSE
                mWrite "*"
            .ENDIF
        .ELSE
            mWrite "*"
        .ENDIF
     .ENDIF
     ;call     DumpRegs
     ;mWrite "Y"
    .IF r==3
        call Crlf
    .ENDIF
    .IF r==7
        call Crlf
    .ENDIF
    .IF r==11
        call Crlf
    .ENDIF
.IF r<11
    add r,1
    jmp SSS
.ELSE
    
.ENDIF
mov r,0
RET
DrawGUI ENDP



DrawGUI_Two PROC
L0:
     xor eax,eax
     mov eax,r
     mov ecx,eax
     mov eax,[array+eax*4]
     mov tempValueInArray,eax


     mov ebx,tempFirstLocation
     .IF eax==0
        mWrite "/"
     .ELSEIF ecx==CurrentCursor
        .IF isVisible==1
            mov eax,CurrentCursor
            mov eax,[array+eax*4]
            call writeDec
        .ELSE
            mWrite "+"
        .ENDIF
        mov eax,0
     .ELSE
        .IF ecx==ebx
            mov eax,tempFirstLocation
            mov eax,[array+eax*4]
            call writeDec
        .ELSE
            mWrite "*"
        .ENDIF
     .ENDIF
     ;mWrite "Y"
    .IF r==3
        call Crlf
    .ENDIF
    .IF r==7
        call Crlf
    .ENDIF
    .IF r==11
        call Crlf
    .ENDIF
.IF r<11
    add r,1
    jmp L0
.ELSE
    mov r,0
.ENDIF
RET
DrawGUI_Two ENDP








OUTFIRST PROC
mWrite "First Attempt"
call Crlf
RET
OUTFIRST ENDP

OUTSECOND PROC
mWrite "Second Attempt"
call Crlf
RET
OUTSECOND ENDP

UPDATECursor PROC
mov esi,i
shl ESI,2
mov edi,j
add esi,edi
mov CurrentCursor,esi
RET
UPDATECursor ENDP
INPUTERROR PROC

call Crlf
mWrite "You Picked This Before"
call Crlf
.IF u==0
    mov u,-1
.ELSE
    mov u,0
.ENDIF
mov eax , 1000     ; 1秒
call Delay
call Clrscr

RET
INPUTERROR ENDP
WIN PROC
    mov eax,tempFirstLocation
    mov [array+eax*4],0
    mov eax,tempSecondLocation
    mov [array+eax*4],0
    mov i,0
    mov j,0
    add WinTimes,1
RET
WIN ENDP
;---------------------------------------------------------

PRINTALL PROC

mov eax,g
mov eax,[array+eax*4]
call writeInt
mWrite ","
.IF g<11
    add g,1
    jmp PRINTALL
.ENDIF
call Crlf
mov g,0
RET
PRINTALL ENDP

    

END main
