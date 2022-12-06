.model small
.stack 100h
.data
    array dw 5, 3, 1, 2, 4
    i dw 0
    j dw 2
    min dw 0
    count dw 10
.code
main proc
    mov ax, @data
    mov ds, ax
    mov cx, 10
    call sort_signed_word_array
    mov ah, 4ch
    int 21h        
main endp

sort_signed_word_array proc
    push ax
    push bx
    push si
sort_signed_word_array_loop0:
    cmp i, cx
    jge end_sort_signed_word_array_loop0
    mov si, i
    mov min, si
    mov j, si
    add j, 2
sort_signed_word_array_loop1:
    cmp j, cx
    jge end_sort_signed_word_array_loop1
    mov si, min
    mov ax, array[si]
    mov si, j
    mov bx, array[si]
    cmp ax, bx
    jg sort_signed_word_array_set_min
    jmp end_sort_signed_word_array_set_min
sort_signed_word_array_set_min:
    mov min, si
end_sort_signed_word_array_set_min:
    add j, 2
    jmp sort_signed_word_array_loop1
end_sort_signed_word_array_loop1:
    mov si, min
    mov ax, array[si]
    mov si, i
    mov bx, array[si]
    push ax
    mov ax, bx
    pop bx
    mov si, min
    mov word ptr array[si], ax
    mov si, i
    mov word ptr array[si], bx
    add i, 2
    jmp sort_signed_word_array_loop0
end_sort_signed_word_array_loop0:
    pop si
    pop bx
    pop ax
    ret    
sort_signed_word_array endp

end main