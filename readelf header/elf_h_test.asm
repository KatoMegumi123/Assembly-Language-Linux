;nasm -f elf64 elf_h_test.asm
;gcc -no-pie elf_h_test.o

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

section .bss
  pStruc  resb 8
  pStruc2 resb 8
  pStruc3 resb 8

section .data
  notelf db 'Not ELF file',10,0

  header db 'ELF Header:',10,0

  magic db 'Magic:',9,9,9,9,9,9,0

  class db 'Class:',9,9,9,9,9,9,0
  elf32 db 'ELF32',0
  elf64 db 'ELF64',0

  data db 'Data:',9,9,9,9,9,9,0
  little db 'Little endian',0
  big db 'Big endian',0

  version db 'Version:',9,9,9,9,9,9,0
  current db '1 (current)',0
  notcurrent db 'Not current',0

  osabii db 'OS/ABI:',9,9,9,9,9,9,0
  systemv db 'System V',0
  hpux db 'HP-UX',0
  netbsd db 'NetBSD',0
  linux db 'Linux',0
  gnuhurd db 'GNU Hurd',0
  solaris db 'Solaris',0
  aix db 'AIX',0
  irix db 'IRIX',0
  freebsd db 'FreeBSD',0
  tru64 db 'Tru64',0
  novellmodesto db 'Novell Modesto',0
  openbsd db 'OpenBSD',0
  openvms db 'OpenVMS',0
  nonstopkernel db 'NonStop Kernel',0
  aros db 'AROS',0
  fenixos db 'Fenix OS',0
  cloudabi db 'CloudABI',0

  abiversion db 'ABI Version:',9,9,9,9,9,0
  
  type db 'Type',9,9,9,9,9,9,0
  none db 'None',0
  abirel db 'Rel',0
  exec db 'Exec',0
  dyn db 'Dyn',0
  core db 'Core',0
  loos db 'Loos',0
  hios db 'Hios',0
  loproc db 'Loproc',0
  hiproc db 'Hiproc',0

  machine_e db 'Machine:',9,9,9,9,9,0
  unknown db 'Unkown',0
  sparc db 'SPARC',0
  x86 db 'x86',0
  mips db 'MIPS',0
  powerpc db 'PowerPC',0
  s390 db 'S390',0
  arm db 'ARM',0
  superh db 'SuperH',0
  ia64 db 'IA-64',0
  x8664 db 'x86-64',0
  aarch64 db 'AArch64',0
  riscv db 'RISC-V',0

  version_e db 'Version:',9,9,9,9,9,0
  version1_e db '1',0
  versionnot1_e db '!=1',0

  entry db 'Entry point address:',9,9,9,9,0

  phoff db 'Start of program headers:',9,9,9,0

  shoff db 'Start of section headers:',9,9,9,0

  flags db 'Flags:',9,9,9,9,9,9,0

  ehsize db 'Size of this header:',9,9,9,9,0

  phentsize db 'Size of program headers:',9,9,9,0

  phnum db 'Number of program headers:',9,9,9,0

  shentsize db 'Size of section headers:',9,9,9,0

  shnum db 'Number of section headers:',9,9,9,0

  shstrndx db 'Section header string table index:',9,9,0

  sectionheader db 'Section Headers:',10,0

  prehex db '0x',0
  hex db '%02x ',0
  alo db 10,0
  decimal db '%d',0

section .text
  global main
  extern printf
  extern malloc

main:
  push rbp
  mov rbp, rsp
  sub rsp, 64
  cmp edi, 2
  je _getparam
  jmp _exit

_getparam:

  mov [rbp-64], rsi
  mov rdi, 64
  call malloc
  mov [pStruc], rax

  mov rax, [rbp-64]
  add rax, 8
  mov rax, [rax]
  mov rdi, rax
  mov rsi, 0
  mov rax, 2
  syscall
  cmp rax, 0
  je _exit
  mov [rbp-8], rax

  mov rdi, [rbp-8]
  mov rsi, pStruc
  mov rdx, 64
  mov rax, 0
  syscall

  cmp dword [pStruc], 0x464c457f
  je _header
  mov rdi, notelf
  call printf
  jmp _exit


_header:
  mov rdi, header
  call printf
  mov rdi, alo
  call printf

  mov rdi, magic
  call printf

  mov al, byte [pStruc]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+1]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+2]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+3]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+4]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+5]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+6]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+7]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+8]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+9]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+10]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+11]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+12]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+13]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+14]
  mov rdi, hex
  mov rsi, rax
  call printf

  mov al, byte [pStruc+15]
  mov rdi, hex
  mov rsi, rax
  call printf

_class:
  mov rdi, alo
  call printf
  mov rdi, class
  call printf
  cmp byte [pStruc+4h],1
  je _class_elf_32
  cmp byte [pStruc+4h],2
  je _class_elf_64

_class_elf_64:
  mov rdi, elf64
  call printf
  jmp _data

_data:
  mov rdi, alo
  call printf
  mov rdi, data
  call printf
  cmp byte [pStruc+5h],1
  je _little
  cmp byte [pStruc+5h],2
  je _big

_little:
  mov rdi, little
  call printf
  jmp _version

_big:
  mov rdi, big
  call printf
  jmp _version

_version:
  mov rdi, alo
  call printf
  mov rdi, version_e
  call printf
  cmp byte [pStruc+6h],1
  je _version1
  cmp byte [pStruc+6h],1
  je _versionnot1

_version1:
  mov rdi, current
  call printf
  jmp _osabi

_versionnot1:
  mov rdi, notcurrent
  call printf
  jmp _osabi

_osabi:
  mov rdi, alo
  call printf
  mov rdi, osabii
  call printf
  cmp byte [pStruc+7h],0h
  je _systemv
  cmp byte [pStruc+7h],2h
  je _hpux
  cmp byte [pStruc+7h],3h
  je _netbsd
  cmp byte [pStruc+7h],4h
  je _linux
  cmp byte [pStruc+7h],5h
  je _gnuhurd
  cmp byte [pStruc+7h],6h
  je _solaris
  cmp byte [pStruc+7h],7h
  je _aix
  cmp byte [pStruc+7h],8h
  je _irix
  cmp byte [pStruc+7h],9h
  je _freebsd
  cmp byte [pStruc+7h],10
  je _tru64
  cmp byte [pStruc+7h],11
  je _novellmodestro
  cmp byte [pStruc+7h],12
  je _openbsd
  cmp byte [pStruc+7h],13
  je _openvms
  cmp byte [pStruc+7h],14
  je _nonstopkernel
  cmp byte [pStruc+7h],15
  je _aros
  cmp byte [pStruc+7h],16
  je _fenixos
  cmp byte [pStruc+7h],17
  je _cloudabi

_systemv:
  mov rdi, systemv
  call printf
  jmp _abiversion

_hpux:
  mov rdi, hpux
  call printf
  jmp _abiversion

_netbsd:
  mov rdi, netbsd
  call printf
  jmp _abiversion

_linux:
  mov rdi, linux
  call printf
  jmp _abiversion

_gnuhurd:
  mov rdi, gnuhurd
  call printf
  jmp _abiversion

_solaris:
  mov rdi, solaris
  call printf
  jmp _abiversion

_aix:
  mov rdi, aix
  call printf
  jmp _abiversion

_irix:
  mov rdi, irix
  call printf
  jmp _abiversion

_freebsd:
  mov rdi, freebsd
  call printf
  jmp _abiversion

_tru64:
  mov rdi, tru64
  call printf
  jmp _abiversion

_novellmodestro:
  mov rdi, novellmodesto
  call printf
  jmp _abiversion

_openbsd:
  mov rdi, openbsd
  call printf
  jmp _abiversion

_openvms:
  mov rdi, openvms
  call printf
  jmp _abiversion

_nonstopkernel:
  mov rdi, nonstopkernel
  call printf
  jmp _abiversion

_aros:
  mov rdi, aros
  call printf
  jmp _abiversion

_fenixos:
  mov rdi, fenixos
  call printf
  jmp _abiversion

_cloudabi:
  mov rdi, cloudabi
  call printf
  jmp _abiversion

_abiversion:
  mov rdi, alo
  call printf
  mov rdi, abiversion
  call printf
  mov al, byte [pStruc+8h]
  mov rdi, hex
  mov rsi, rax
  call printf

_type:
  mov rdi, alo
  call printf
  mov rdi, type
  call printf
  cmp byte [pStruc+5h],1
  je _littletype
  cmp byte [pStruc+5h],2
  je _bigtype

_littletype:
  cmp word [pStruc+10h],0x00
  je _none
  cmp word [pStruc+10h],0x01
  je _rel
  cmp word [pStruc+10h],0x02
  je _exec
  cmp word [pStruc+10h],3h
  je _dyn
  cmp word [pStruc+10h],4h
  je _core
  cmp word [pStruc+10h],0xfe00
  je _loos
  cmp word [pStruc+10h],0xfeff
  je _hios
  cmp word [pStruc+10h],0xff00
  je _loproc
  cmp word [pStruc+10h],0xffff
  je _hiporc

_bigtype:
  cmp word [pStruc+10h],0
  je _none
  cmp word [pStruc+10h],0x0100
  je _rel
  cmp word [pStruc+10h],0x0200
  je _exec
  cmp word [pStruc+10h],0x0300
  je _dyn
  cmp word [pStruc+10h],0x0400
  je _core
  cmp word [pStruc+10h],0x00fe
  je _loos
  cmp word [pStruc+10h],0xfffe
  je _hios
  cmp word [pStruc+10h],0x00ff
  je _loproc
  cmp word [pStruc+10h],0xffff
  je _hiporc
  
_none:
  mov rdi, none
  call printf
  jmp _machine

_rel:
  mov rdi, abirel
  call printf
  jmp _machine

_exec:
  mov rdi, exec
  call printf
  jmp _machine

_dyn:
  mov rdi, dyn
  call printf
  jmp _machine

_core:
  mov rdi, core
  call printf
  jmp _machine

_loos:
  mov rdi, loos
  call printf
  jmp _machine

_hios:
  mov rdi, hios
  call printf
  jmp _machine

_loproc:
  mov rdi, loproc
  call printf
  jmp _machine

_hiporc:
  mov rdi, hiproc
  call printf
  jmp _machine

_machine:
  mov rdi, alo
  call printf
  mov rdi, machine_e
  call printf
  cmp byte [pStruc+5h],1
  je _littlemachine
  cmp byte [pStruc+5h],2
  je _bigmachine

_littlemachine:
  cmp word [pStruc+0x12],0h
  je _unknown
  cmp word [pStruc+0x12],0x02
  je _sparc
  cmp word [pStruc+0x12],0x03
  je _x86
  cmp word [pStruc+0x12],0x08
  je _mips
  cmp word [pStruc+0x12],0x14
  je _powerpc
  cmp word [pStruc+0x12],0x16
  je _s390
  cmp word [pStruc+0x12],0x28
  je _arm
  cmp word [pStruc+0x12],0x2a
  je _superh
  cmp word [pStruc+0x12],0x32
  je _ia64
  cmp word [pStruc+0x12],0x3e
  je _x8664
  cmp word [pStruc+0x12],0xb7
  je _aarch64
  cmp word [pStruc+0x12],0xf3
  je _riscv
  jmp _unknown
  

_bigmachine:
  cmp word [pStruc+0x12],0h
  je _unknown
  cmp word [pStruc+0x12],0x0200
  je _sparc
  cmp word [pStruc+0x12],0x0300
  je _x86
  cmp word [pStruc+0x12],0x0800
  je _mips
  cmp word [pStruc+0x12],0x1400
  je _powerpc
  cmp word [pStruc+0x12],0x1600
  je _s390
  cmp word [pStruc+0x12],0x2800
  je _arm
  cmp word [pStruc+0x12],0x2a00
  je _superh
  cmp word [pStruc+0x12],0x3200
  je _ia64
  cmp word [pStruc+0x12],0x3e00
  je _x8664
  cmp word [pStruc+0x12],0xb700
  je _aarch64
  cmp word [pStruc+0x12],0xf300
  je _riscv
  jmp _unknown

_unknown:
  mov rdi, unknown
  call printf
  jmp _version_e
_sparc:
  mov rdi, sparc
  call printf
  jmp _version_e
_x86:
  mov rdi, x86
  call printf
  jmp _version_e
_mips:
  mov rdi, mips
  call printf
  jmp _version_e
_powerpc:
  mov rdi, powerpc
  call printf
  jmp _version_e
_s390:
  mov rdi, s390
  call printf
  jmp _version_e
_arm:
  mov rdi, arm
  call printf
  jmp _version_e
_superh:
  mov rdi, superh
  call printf
  jmp _version_e
_ia64:
  mov rdi, ia64
  call printf
  jmp _version_e
_x8664:
  mov rdi, x8664
  call printf
  jmp _version_e
_aarch64:
  mov rdi, aarch64
  call printf
  jmp _version_e
_riscv:
  mov rdi, riscv
  call printf
  jmp _version_e

_version_e:
  mov rdi, alo
  call printf
  mov rdi, version_e
  call printf
  cmp byte [pStruc+5h],1
  je _littleversion_e
  cmp byte [pStruc+5h],2
  je _bigversion_e

_littleversion_e:
  cmp dword [pStruc+0x14],1
  je _version1_e
  jmp _versionnot1_e

_bigversion_e:
  cmp dword [pStruc+0x14],0x01000000
  je _version1_e
  jmp _versionnot1_e

_version1_e:
  mov rdi, version1_e
  call printf
  jmp _entry
_versionnot1_e:
  mov rdi, versionnot1_e
  call printf
  jmp _entry

_entry:
  mov rdi, alo
  call printf
  mov rdi, entry
  call printf
  mov rdi, prehex
  call printf
  mov rax, qword [pStruc+0x18]
  cmp byte [pStruc+5h],1
  je _littleentry
  bswap rax
_littleentry:
  mov rdi, hex
  mov rsi, rax
  call printf

__phoff:
  mov rdi, alo
  call printf
  mov rdi, phoff
  call printf
  mov rax, qword [pStruc+0x20]
  cmp byte [pStruc+5h],1
  je _littlephoff
  bswap rax
_littlephoff:
  mov rdi, decimal
  mov rsi, rax
  call printf

_shoff:
  mov rdi, alo
  call printf
  mov rdi, shoff
  call printf
  mov rax, qword [pStruc+0x28]
  cmp byte [pStruc+5h],1
  je _littleshoff
  bswap rax
_littleshoff:
  mov rdi, decimal
  mov rsi, rax
  call printf

_flags:
  mov rdi, alo
  call printf
  mov rdi, flags
  call printf
  mov rdi, prehex
  call printf
  mov eax, dword [pStruc+0x30]
  cmp byte [pStruc+5h],1
  je _littleflags
  bswap eax
_littleflags:
  mov rdi, hex
  mov rsi, rax
  call printf

_ehsize:
  mov rdi, alo
  call printf
  mov rdi, ehsize
  call printf
  mov ax, word [pStruc+0x34]
  cmp byte [pStruc+5h],1
  je _littleehsize
  xchg al,ah
_littleehsize:
  mov rdi, decimal
  mov rsi, rax
  call printf

_phentsize:
  mov rdi, alo
  call printf
  mov rdi, phentsize
  call printf
  mov ax, word [pStruc+0x36]
  cmp byte [pStruc+5h],1
  je _littlephentsize
  xchg al,ah
_littlephentsize:
  mov rdi, decimal
  mov rsi, rax
  call printf

_phnum:
  mov rdi, alo
  call printf
  mov rdi, phnum
  call printf
  mov ax, word [pStruc+0x38]
  cmp byte [pStruc+5h],1
  je _littlephnum
  xchg al,ah
_littlephnum:
  mov rdi, decimal
  mov rsi, rax
  call printf

_shentsize:
  mov rdi, alo
  call printf
  mov rdi, shentsize
  call printf
  mov ax, word [pStruc+0x3a]
  cmp byte [pStruc+5h],1
  je _littleshentsize
  xchg al,ah
_littleshentsize:
  mov rdi, decimal
  mov rsi, rax
  call printf

_shnum:
  mov rdi, alo
  call printf
  mov rdi, shnum
  call printf
  mov ax, word [pStruc+0x3c]
  cmp byte [pStruc+5h],1
  je _littleshnum
  xchg al,ah
_littleshnum:
  mov rdi, decimal
  mov rsi, rax
  call printf

_shstrndx:
  mov rdi, alo
  call printf
  mov rdi, shstrndx
  call printf
  mov ax, word [pStruc+0x3e]
  cmp byte [pStruc+5h],1
  je _littleshstrndx
  xchg al,ah
_littleshstrndx:
  mov rdi, decimal
  mov rsi, rax
  call printf

  mov rdi, alo
  call printf
  mov rdi, alo
  call printf

  jmp _exit

_class_elf_32:
  mov rdi, elf32
  call printf
  jmp _data32

_data32:
  mov rdi, alo
  call printf
  mov rdi, data
  call printf
  cmp byte [pStruc+5h],1
  je _little32
  cmp byte [pStruc+5h],2
  je _big32

_little32:
  mov rdi, little
  call printf
  jmp _version32

_big32:
  mov rdi, big
  call printf
  jmp _version32

_version32:
  mov rdi, alo
  call printf
  mov rdi, version_e
  call printf
  cmp byte [pStruc+6h],1
  je _version132
  cmp byte [pStruc+6h],1
  je _versionnot132

_version132:
  mov rdi, current
  call printf
  jmp _osabi32

_versionnot132:
  mov rdi, notcurrent
  call printf
  jmp _osabi32

_osabi32:
  mov rdi, alo
  call printf
  mov rdi, osabii
  call printf
  cmp byte [pStruc+7h],0h
  je _systemv32
  cmp byte [pStruc+7h],2h
  je _hpux32
  cmp byte [pStruc+7h],3h
  je _netbsd32
  cmp byte [pStruc+7h],4h
  je _linux32
  cmp byte [pStruc+7h],5h
  je _gnuhurd32
  cmp byte [pStruc+7h],6h
  je _solaris32
  cmp byte [pStruc+7h],7h
  je _aix32
  cmp byte [pStruc+7h],8h
  je _irix32
  cmp byte [pStruc+7h],9h
  je _freebsd32
  cmp byte [pStruc+7h],10
  je _tru6432
  cmp byte [pStruc+7h],11
  je _novellmodestro32
  cmp byte [pStruc+7h],12
  je _openbsd32
  cmp byte [pStruc+7h],13
  je _openvms32
  cmp byte [pStruc+7h],14
  je _nonstopkernel32
  cmp byte [pStruc+7h],15
  je _aros32
  cmp byte [pStruc+7h],16
  je _fenixos32
  cmp byte [pStruc+7h],17
  je _cloudabi32

_systemv32:
  mov rdi, systemv
  call printf
  jmp _abiversion32

_hpux32:
  mov rdi, hpux
  call printf
  jmp _abiversion32

_netbsd32:
  mov rdi, netbsd
  call printf
  jmp _abiversion32

_linux32:
  mov rdi, linux
  call printf
  jmp _abiversion32

_gnuhurd32:
  mov rdi, gnuhurd
  call printf
  jmp _abiversion32

_solaris32:
  mov rdi, solaris
  call printf
  jmp _abiversion32

_aix32:
  mov rdi, aix
  call printf
  jmp _abiversion32

_irix32:
  mov rdi, irix
  call printf
  jmp _abiversion32

_freebsd32:
  mov rdi, freebsd
  call printf
  jmp _abiversion32

_tru6432:
  mov rdi, tru64
  call printf
  jmp _abiversion32

_novellmodestro32:
  mov rdi, novellmodesto
  call printf
  jmp _abiversion32

_openbsd32:
  mov rdi, openbsd
  call printf
  jmp _abiversion32

_openvms32:
  mov rdi, openvms
  call printf
  jmp _abiversion32

_nonstopkernel32:
  mov rdi, nonstopkernel
  call printf
  jmp _abiversion32

_aros32:
  mov rdi, aros
  call printf
  jmp _abiversion32

_fenixos32:
  mov rdi, fenixos
  call printf
  jmp _abiversion32

_cloudabi32:
  mov rdi, cloudabi
  call printf
  jmp _abiversion32

_abiversion32:
  mov rdi, alo
  call printf
  mov rdi, abiversion
  call printf
  mov al, byte [pStruc+8h]
  mov rdi, hex
  mov rsi, rax
  call printf

_type32:
  mov rdi, alo
  call printf
  mov rdi, type
  call printf
  cmp byte [pStruc+5h],1
  je _littletype32
  cmp byte [pStruc+5h],2
  je _bigtype32

_littletype32:
  cmp word [pStruc+10h],0x00
  je _none32
  cmp word [pStruc+10h],0x01
  je _rel32
  cmp word [pStruc+10h],0x02
  je _exec32
  cmp word [pStruc+10h],3h
  je _dyn32
  cmp word [pStruc+10h],4h
  je _core32
  cmp word [pStruc+10h],0xfe00
  je _loos32
  cmp word [pStruc+10h],0xfeff
  je _hios32
  cmp word [pStruc+10h],0xff00
  je _loproc32
  cmp word [pStruc+10h],0xffff
  je _hiporc32

_bigtype32:
  cmp word [pStruc+10h],0
  je _none32
  cmp word [pStruc+10h],0x0100
  je _rel32
  cmp word [pStruc+10h],0x0200
  je _exec32
  cmp word [pStruc+10h],0x0300
  je _dyn32
  cmp word [pStruc+10h],0x0400
  je _core32
  cmp word [pStruc+10h],0x00fe
  je _loos32
  cmp word [pStruc+10h],0xfffe
  je _hios32
  cmp word [pStruc+10h],0x00ff
  je _loproc32
  cmp word [pStruc+10h],0xffff
  je _hiporc32
  
_none32:
  mov rdi, none
  call printf
  jmp _machine32

_rel32:
  mov rdi, abirel
  call printf
  jmp _machine32

_exec32:
  mov rdi, exec
  call printf
  jmp _machine32

_dyn32:
  mov rdi, dyn
  call printf
  jmp _machine32

_core32:
  mov rdi, core
  call printf
  jmp _machine32

_loos32:
  mov rdi, loos
  call printf
  jmp _machine32

_hios32:
  mov rdi, hios
  call printf
  jmp _machine32

_loproc32:
  mov rdi, loproc
  call printf
  jmp _machine32

_hiporc32:
  mov rdi, hiproc
  call printf
  jmp _machine32

_machine32:
  mov rdi, alo
  call printf
  mov rdi, machine_e
  call printf
  cmp byte [pStruc+5h],1
  je _littlemachine32
  cmp byte [pStruc+5h],2
  je _bigmachine32

_littlemachine32:
  cmp word [pStruc+0x12],0h
  je _unknown32
  cmp word [pStruc+0x12],0x02
  je _sparc32
  cmp word [pStruc+0x12],0x03
  je _x8632
  cmp word [pStruc+0x12],0x08
  je _mips32
  cmp word [pStruc+0x12],0x14
  je _powerpc32
  cmp word [pStruc+0x12],0x16
  je _s39032
  cmp word [pStruc+0x12],0x28
  je _arm32
  cmp word [pStruc+0x12],0x2a
  je _superh32
  cmp word [pStruc+0x12],0x32
  je _ia6432
  cmp word [pStruc+0x12],0x3e
  je _x866432
  cmp word [pStruc+0x12],0xb7
  je _aarch6432
  cmp word [pStruc+0x12],0xf3
  je _riscv32
  jmp _unknown32
  

_bigmachine32:
  cmp word [pStruc+0x12],0h
  je _unknown32
  cmp word [pStruc+0x12],0x0200
  je _sparc32
  cmp word [pStruc+0x12],0x0300
  je _x8632
  cmp word [pStruc+0x12],0x0800
  je _mips32
  cmp word [pStruc+0x12],0x1400
  je _powerpc32
  cmp word [pStruc+0x12],0x1600
  je _s39032
  cmp word [pStruc+0x12],0x2800
  je _arm32
  cmp word [pStruc+0x12],0x2a00
  je _superh32
  cmp word [pStruc+0x12],0x3200
  je _ia6432
  cmp word [pStruc+0x12],0x3e00
  je _x866432
  cmp word [pStruc+0x12],0xb700
  je _aarch6432
  cmp word [pStruc+0x12],0xf300
  je _riscv32
  jmp _unknown32

_unknown32:
  mov rdi, unknown
  call printf
  jmp _version_e32
_sparc32:
  mov rdi, sparc
  call printf
  jmp _version_e32
_x8632:
  mov rdi, x86
  call printf
  jmp _version_e32
_mips32:
  mov rdi, mips
  call printf
  jmp _version_e32
_powerpc32:
  mov rdi, powerpc
  call printf
  jmp _version_e32
_s39032:
  mov rdi, s390
  call printf
  jmp _version_e32
_arm32:
  mov rdi, arm
  call printf
  jmp _version_e32
_superh32:
  mov rdi, superh
  call printf
  jmp _version_e32
_ia6432:
  mov rdi, ia64
  call printf
  jmp _version_e32
_x866432:
  mov rdi, x8664
  call printf
  jmp _version_e32
_aarch6432:
  mov rdi, aarch64
  call printf
  jmp _version_e32
_riscv32:
  mov rdi, riscv
  call printf
  jmp _version_e32

_version_e32:
  mov rdi, alo
  call printf
  mov rdi, version_e
  call printf
  cmp byte [pStruc+5h],1
  je _littleversion_e32
  cmp byte [pStruc+5h],2
  je _bigversion_e32

_littleversion_e32:
  cmp dword [pStruc+0x14],1
  je _version1_e32
  jmp _versionnot1_e32

_bigversion_e32:
  cmp dword [pStruc+0x14],0x01000000
  je _version1_e32
  jmp _versionnot1_e32

_version1_e32:
  mov rdi, version1_e
  call printf
  jmp _entry32
_versionnot1_e32:
  mov rdi, versionnot1_e
  call printf
  jmp _entry32

_entry32:
  mov rdi, alo
  call printf
  mov rdi, entry
  call printf
  mov rdi, prehex
  call printf
  mov eax, dword [pStruc+0x18]
  cmp byte [pStruc+5h],1
  je _littleentry32
  bswap eax
_littleentry32:
  mov rdi, hex
  mov rsi, rax
  call printf

__phoff32:
  mov rdi, alo
  call printf
  mov rdi, phoff
  call printf
  mov eax, dword [pStruc+0x1c]
  cmp byte [pStruc+5h],1
  je _littlephoff32
  bswap eax
_littlephoff32:
  mov rdi, decimal
  mov rsi, rax
  call printf

_shoff32:
  mov rdi, alo
  call printf
  mov rdi, shoff
  call printf
  mov eax, dword [pStruc+0x20]
  cmp byte [pStruc+5h],1
  je _littleshoff32
  bswap eax
_littleshoff32:
  mov rdi, decimal
  mov rsi, rax
  call printf

_flags32:
  mov rdi, alo
  call printf
  mov rdi, flags
  call printf
  mov rdi, prehex
  call printf
  mov eax, dword [pStruc+0x24]
  cmp byte [pStruc+5h],1
  je _littleflags32
  bswap eax
_littleflags32:
  mov rdi, hex
  mov rsi, rax
  call printf

_ehsize32:
  mov rdi, alo
  call printf
  mov rdi, ehsize
  call printf
  mov ax, word [pStruc+0x28]
  cmp byte [pStruc+5h],1
  je _littleehsize
  xchg al,ah
_littleehsize32:
  mov rdi, decimal
  mov rsi, rax
  call printf

_phentsize32:
  mov rdi, alo
  call printf
  mov rdi, phentsize
  call printf
  mov ax, word [pStruc+0x2a]
  cmp byte [pStruc+5h],1
  je _littlephentsize32
  xchg al,ah
_littlephentsize32:
  mov rdi, decimal
  mov rsi, rax
  call printf

_phnum32:
  mov rdi, alo
  call printf
  mov rdi, phnum
  call printf
  mov ax, word [pStruc+0x2c]
  cmp byte [pStruc+5h],1
  je _littlephnum32
  xchg al,ah
_littlephnum32:
  mov rdi, decimal
  mov rsi, rax
  call printf

_shentsize32:
  mov rdi, alo
  call printf
  mov rdi, shentsize
  call printf
  mov ax, word [pStruc+0x2e]
  cmp byte [pStruc+5h],1
  je _littleshentsize32
  xchg al,ah
_littleshentsize32:
  mov rdi, decimal
  mov rsi, rax
  call printf

_shnum32:
  mov rdi, alo
  call printf
  mov rdi, shnum
  call printf
  mov ax, word [pStruc+0x30]
  cmp byte [pStruc+5h],1
  je _littleshnum32
  xchg al,ah
_littleshnum32:
  mov rdi, decimal
  mov rsi, rax
  call printf

_shstrndx32:
  mov rdi, alo
  call printf
  mov rdi, shstrndx
  call printf
  mov ax, word [pStruc+0x32]
  cmp byte [pStruc+5h],1
  je _littleshstrndx32
  xchg al,ah
_littleshstrndx32:
  mov rdi, decimal
  mov rsi, rax
  call printf

  mov rdi, alo
  call printf
  mov rdi, alo
  call printf

  jmp _exit

;_sections:

  ;mov rdi, [rbp-8]

  ;mov rdi, sectionheader
  ;call printf
_exit:
	leave
  ret


