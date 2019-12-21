struc elf64h
  e_ident:      resb 16
  e_type:       resb 2
  e_machine:    resb 2
  e_version:    resb 4
  e_entry:      resb 8
  e_phoff:      resb 8
  e_shoff:      resb 8
  e_flags:      resb 4
  e_ehsize:     resb 2
  e_phentsize:  resb 2
  e_phnum:      resb 2
  e_shentsize:  resb 2
  e_shnum:      resb 2
  e_shstrndx:   resb 2
endstruc

;section .bss



section .data
  msg    db     'Test', 10, 0

section .text
  global main
  extern printf
  extern malloc

main:
  mov rbp, rsp
  sub rsp, 64
  cmp edi, 2
  je _shit

_shit:
  mov     [rbp-36], edi
  mov     [rbp-48], rsi
  mov     rax, [rbp-48]
  add     rax, 8
  mov     rax, [rax]
  mov     rdi, msg
  mov     eax, 0
  call    printf
  mov     eax, 0
  ;pop rax
  ;pop rax
  ;mov rcx, rax
  ;push rcx

_exit:
	mov rax, 60					
	mov rdi, 0
	syscall


