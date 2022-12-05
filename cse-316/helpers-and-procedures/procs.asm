; takes reg ax as argument
; returns in dx
twos_comp proc
    not ax
    add ax, 1
    mov dx, ax
    ret
twos_comp endp

; no argument
; returns in dx
signed_input proc
    push ax
    push bx
    push cx
    xor bx, bx
    xor cx, cx
    xor dx, dx
    mov ah, 1
    int 21h
    cmp al, '-'
    jne set_sign
    mov cl, 1
    jmp input
set_sign:
    mov cl, 0
    mov ch, al
    mov ax, dx
    mov bx, 10
    mul bx
    mov dx, ax
    sub ch, '0'
    xor ax, ax
    mov al, ch
    add dx, ax
input:
    mov ah, 1
    int 21h
    cmp al, 13
    je pre_exit
    cmp al, ' '
    je pre_exit
    mov ch, al
    mov ax, dx
    mov bx, 10
    mul bx
    mov dx, ax
    sub ch, '0'
    xor ax, ax
    mov al, ch
    add dx, ax
    jmp input
pre_exit:
    cmp cl, 1
    jne exit
    mov ax, dx
    call twos_comp
exit:
    pop cx
    pop bx
    pop ax
    ret
signed_input endp

; ax as argument
signed_output proc
    push bx
    push cx
    push dx
    xor bx, bx
    xor cx, cx
    xor dx, dx
    mov dl, ah
    and dl, 80h
    cmp dl, 80h
    je set_negative
    jmp push_stack
set_negative:
    push ax
    mov ah, 2
    mov dl, '-'
    int 21h
    pop ax
    call twos_comp
    mov ax, dx
push_stack:
    cmp ax, 0
    je end_push
    xor dx, dx
    mov bx, 10
    div bx
    add dl, '0'
    push dx
    inc cx
    jmp push_stack
end_push:
output:    
    cmp cx, 0
    je end_output
    pop dx
    mov ah, 2
    int 21h
    dec cx
    jmp output
end_output:
    pop dx
    pop cx
    pop bx
    ret
signed_output endp  

; shall return dx
unsigned_input proc
    push ax
    push bx
    push cx
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
input:
    mov ah, 1
    int 21h
    cmp al, 13
    je end_input
    cmp al, ' '
    je end_input
    mov ch, al
    mov ax, dx
    mov bx, 10
    imul bx
    mov dx, ax
    sub ch, '0'
    xor ax, ax
    mov al, ch
    add dx, ax
    jmp input
end_input:
    pop cx
    pop bx
    pop ax
    ret
unsigned_input endp

; ax argument
unsigned_output proc
    push bx
    push cx
    push dx
    xor bx, bx
    xor cx, cx
    xor dx, dx
push_stack:
    cmp ax, 0
    je end_push
    xor dx, dx
    mov bx, 10
    div bx
    add dl, '0'
    push dx
    inc cx
    jmp push_stack
end_push:
output:    
    cmp cx, 0
    je end_output
    pop dx
    mov ah, 2
    int 21h
    dec cx
    jmp output
end_output:
    pop dx
    pop cx
    pop bx
    ret
unsigned_output endp

; no arg and return
line_break proc
    push ax
    push dx
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    pop dx
    pop ax
    ret
line_break endp

return_control_to_os proc
    mov ah, 4ch
    int 21h
return_control_to_os endp

signed_word_array_input proc
    push ax
    push cx
    push dx
    push si
    cmp cx, 0
    je end_input_word_array
input_word_array:
    call signed_input
    mov word ptr [si], dx
    add si, 2
    cmp cx, 0
    je end_input_word_array
    sub cx, 2
    cmp cx, 0
    je end_input_word_array
    jmp input_word_array
end_input_word_array:
    pop si
    pop dx
    pop cx
    pop ax
    ret
signed_word_array_input endp

unsigned_word_array_input proc
    push ax
    push cx
    push dx
    push si
    cmp cx, 0
    je end_input_unsigned_word_array
input_unsigned_word_array:
    call unsigned_input
    mov word ptr [si], dx
    add si, 2
    cmp cx, 0
    je end_input_unsigned_word_array
    sub cx, 2
    cmp cx, 0
    je end_input_unsigned_word_array
    jmp input_unsigned_word_array
end_input_unsigned_word_array:
    pop si
    pop dx
    pop cx
    pop ax
    ret
unsigned_word_array_input endp

signed_word_array_output proc
    push ax
    push cx
    push dx
    push si
    cmp cx, 0
    je end_output_word_array
output_word_array:
    mov ax, [si]
    call signed_output
    mov ah, 2
    mov dl, ' '
    int 21h
    add si, 2
    cmp cx, 0
    je end_output_word_array
    sub cx, 2
    cmp cx, 0
    je end_output_word_array
    jmp output_word_array
end_output_word_array:
    pop si
    pop dx
    pop cx
    pop ax
    ret 
signed_word_array_output endp

unsigned_word_array_output proc
    push ax
    push cx
    push dx
    push si
    cmp cx, 0
    je end_output_unsigned_word_array
output_unsigned_word_array:
    mov ax, [si]
    call unsigned_output
    mov ah, 2
    mov dl, ' '
    int 21h
    add si, 2
    cmp cx, 0
    je end_output_unsigned_word_array
    sub cx, 2
    cmp cx, 0
    je output_unsigned_word_array
    jmp output_unsigned_word_array
end_output_unsigned_word_array:
    pop si
    pop dx
    pop cx
    pop ax
    ret 
unsigned_word_array_output endp