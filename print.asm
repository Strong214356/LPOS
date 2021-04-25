printString:
    push ax
    push bx

    mov ah, 0x0e
    .loop:
    cmp [bx], byte 0
    je .end
        mov al, [bx]
        int 0x10
        inc bx
        jmp .loop
    .end:

    pop ax
    pop bx
    ret