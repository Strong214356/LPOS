
jmp EnterProtectedMode


%include "GDT.asm"
%include "print.asm"

EnterProtectedMode:
    call EnableA20
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp codeseg:startProtectedMode

EnableA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]

%include "CPUID.asm"
%include "simplePaging.asm"

startProtectedMode:
    mov ax, dataseg
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov [0xb8000], byte 'L'
    mov [0xb8002], byte 'P'
    mov [0xb8004], byte 'O'
    mov [0xb8006], byte 'S'

    call SetUpIdentityPaging
    call detectCPUID
    call detectLongMode
    call EditGDT

    jmp codeseg:start64BITS

[bits 64]
[extern _start]

start64BITS:
    mov edi, 0xb8000
    mov rax, 0x1f201f201f201f20
    mov ecx, 500
    rep stosq
    call _start
    jmp $

times 2048-($-$$) db 0
