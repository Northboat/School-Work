data segment
in0 equ 298h
ioc equ 28ah
iok equ 28bh
data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    mov dx,iok
    mov al,89h
    out dx,al
    s1:
    mov dx,in0
    out dx,al
    readc:
    mov dx,ioc
    in al,dx
    test al,00000001b
    jz readc
    mov dx,in0
    in al,dx
    mov bl,al
    mov cl,4
    shr bl,cl
    call disp
    and al,0fh
    mov bl,al
    call disp
    mov dl,20h
    mov ah,2
    int 21h
    mov ah,1
    int 16h
    jz s1
    mov ah,4ch
    int 21h
    
disp proc
    push bx
    push ax
    push dx
    mov dl,bl
    cmp dl,9
    jbe t
    add dl,7
    t:add dl,30h
    mov ah,2
    int 21h
    pop dx
    pop ax
    pop bx
    ret
disp endp
    
code ends
end start
