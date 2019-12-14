struct elf64h
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
endstruct

section .bss


section .data

section .text
  global _start

_start:
  pop rax
  cmp rax, byte 2
  jne _getparam

_noparam:
  jmp _exit

_getparam:
  pop rax
  pop rax
  mov rcx, rax
  push rcx

