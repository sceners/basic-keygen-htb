;Keygen do CrackMe2 by massh^CookieCrK
;Created by FiNS - finsss@wp.pl
;rozprowadzono razem z HTB ZINE ISSUE #1

.486
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\gdi32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\gdi32.lib

;-----------------------------
;          -=CONST=-
;-----------------------------

.const
DIALOG_ID   =10
ICON_ID     =30
EDITN_ID    =100
EDITS_ID    =101
GENERATE_ID =1
ABOUT_ID    =103
EXIT_ID     =104

;-----------------------------
;          -=DATA?=-
;-----------------------------

.data?
hInstance   dd  4 dup (?)
myname      db  64 dup (?)
serial      db  64 dup (?)

;-----------------------------
;          -=DATA=-
;-----------------------------

.data
tytulmsgbox db  'About',0
tekstmsgbox db  'CrackMe2 by massh^CookieCrK - keygen',13,10
            db  ' ',13,10
            db  'Created by:',13,10
            db  'FiNS - finsss@wp.pl',0

;-----------------------------
;          -=CODE=-
;-----------------------------

.code
start:
    push    0
    call    GetModuleHandleA
    mov     hInstance, eax

    push    0
    push    offset DlgProc
    push    0
    push    DIALOG_ID
    push    hInstance
    call    DialogBoxParamA

    push    0
    call    ExitProcess

;-----------------------------
;          -=DIALOG=-
;-----------------------------

DlgProc     proc uses esi edi ebp ebx, hDlg:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
    cmp     uMsg, WM_INITDIALOG
    jz      initdlg
    cmp     uMsg, WM_CLOSE
    jz      close
    cmp     uMsg, WM_COMMAND
    jz      wmcommand
    cmp     uMsg, WM_MOUSEMOVE
    je      move

powrot:
    xor     eax, eax
    ret

initdlg:
    push    ICON_ID
    push    hInstance
    call    LoadIconA

    push    eax
    push    1
    push    WM_SETICON
    push    hDlg
    call    SendMessageA
    jmp     powrot

close:
    push    0
    push    hDlg
    call    EndDialog
    jmp     powrot

move:
    cmp     wParam, 1
    je      moveform
    jmp     powrot
moveform:
    call    ReleaseCapture
    push    0
    push    0F012h
    push    WM_SYSCOMMAND
    push    hDlg
    call    SendMessageA
    jmp     powrot

wmcommand:
    cmp     wParam, GENERATE_ID
    jz      go
    cmp     wParam, ABOUT_ID
    jz      about
    cmp     wParam, EXIT_ID
    jz      close
    jmp     powrot

about:
    push    MB_ICONINFORMATION
    push    offset tytulmsgbox
    push    offset tekstmsgbox
    push    hDlg
    call    MessageBoxA
    jmp     powrot

;-----------------------------
;            -=GO=-
;-----------------------------

go:
    push    255
    push    offset myname
    push    EDITN_ID
    push    hDlg
    call    GetDlgItemTextA

    test    eax, eax
    jz      koniec
    cmp     eax, 64
    jge     koniec

    mov     ebx, offset serial
    mov     eax, offset myname
nastepny:
    movzx   edx, byte ptr [eax]
    and     edx, 0Fh
    shr     edx, 1
    add     edx, 30h
    mov     [ebx], dl
    inc     eax
    inc     ebx
    cmp     byte ptr [eax], 0
    jne     nastepny
    xor     eax, eax
    mov     [ebx], eax

    push    offset serial
    push    EDITS_ID
    push    hDlg
    call    SetDlgItemTextA

koniec:
    jmp     powrot

DlgProc     endp
end start