
[org 0x7c00]

mov [BOOT_DISK], dl

mov bp, 0x7c00
mov sp, bp
mov bx, startText
call printString
call readDisk
jmp PROGRAM_SPACE

%include "print.asm"
%include "diskRead.asm"

startText:
    db "LPOS is starting...",0

times 510-($-$$) db 0

dw 0xaa55