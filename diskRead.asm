PROGRAM_SPACE equ 0x7e00

readDisk:
    mov ah, 0x02
    mov bx, PROGRAM_SPACE
    mov al, 2
    mov dl, [BOOT_DISK]
    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02

    int 0x13

    jc DiskReadError

    ret

BOOT_DISK:
    db 0

DISK_READ_ERROR_STRING:
    db 'LPOS-BOOT[ERROR] : Disk read failed.',0

DiskReadError:
    mov bx, DISK_READ_ERROR_STRING
    call printString
    
    jmp $