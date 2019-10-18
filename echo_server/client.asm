global _start

;; Data definitions
struc sockaddr_in
    .sin_family resw 1
    .sin_port resw 1
    .sin_addr resd 1
    .sin_zero resb 8
endstruc

section .bss
    sock resw 2
    echobuf resb 256
    read_count resw 2

section .data
    sock_suc_msg        db "Socket initialised", 0x0a, 0
    sock_suc_msg_len    equ $ - sock_suc_msg        

    sock_err_msg        db "Failed to initialise socket", 0x0a, 0
    sock_err_msg_len    equ $ - sock_err_msg

    bind_suc_msg        db "Binding socket successed", 0x0a, 0
    bind_suc_msg_len    equ $ - bind_suc_msg
    
    bind_err_msg        db "Failed to bind socket", 0x0a, 0
    bind_err_msg_len    equ $ - bind_err_msg

    send_suc_msg        db "Message sent", 0x0a, 0
    send_suc_msg_len    equ $ - send_suc_msg
    
    send_err_msg        db "Failed to send", 0x0a, 0
    send_err_msg_len    equ $ - send_err_msg

    connect_err_msg      db "Fail to connect", 0x0a, 0
    connect_err_msg_len  equ $ - connect_err_msg

    connect_msg          db "Server connected!", 0x0a, 0
    connect_msg_len      equ $ - connect_msg

    ;; sockaddr_in structure for the address the listening socket binds to
    pop_sa istruc sockaddr_in
        at sockaddr_in.sin_family, dw 2            ; AF_INET
        at sockaddr_in.sin_port, dw 0xa1ed        ; port 60833
        at sockaddr_in.sin_addr, dd 0             ; localhost
        at sockaddr_in.sin_zero, dd 0, 0
    iend
    sockaddr_in_len     equ $ - pop_sa

    key                          db "a"

section .text

;; Main entry point for the server.
_start:
    mov      word [sock], 0
    call     _socket
    call     _connect
    .mainloop:
      call   _send
      call   _recieve
      jmp .mainloop
    call   _close_sock
    mov    word [sock], 0

    ;; Exit with success (return 0)
    mov     rdi, 0
    call     _exit

;; Performs a sys_socket call to initialise a TCP/IP listening socket, storing 
;; socket file descriptor in the sock variable
_socket:
    mov         rax, 41     ; SYS_SOCKET
    mov         rdi, 2      ; AF_INET
    mov         rsi, 1      ; SOCK_STREAM
    mov         rdx, 0    
    syscall

    ;; Check socket was created correctly
    cmp        rax, 0
    jle        _socket_fail

    ;; Store socket descriptor in variable
    
    mov         [sock], rax
    mov         rsi, sock_suc_msg
    mov         rdx, sock_suc_msg_len
    mov         rax, 1 ; SYS_WRITE
    mov         rdi, 1 ; STDOUT
    syscall

    ret

;; Calls sys_bind and sys_listen to start listening for connections
_connect:
    ;; call sys_connect
    mov        rax, 42                  ; SYS_CONNECT
    mov        rdi, [sock]              ; client socket fd
    mov        rsi, pop_sa              ; sever address in struct
    mov        rdx, sockaddr_in_len     ; length of server sockaddr_in
    syscall

    ;; Check for success
    cmp        rax, 0
    jl         _listen_fail

    mov         rsi, connect_msg
    mov         rdx, connect_msg_len
    mov         rax, 1 ; SYS_WRITE
    mov         rdi, 1 ; STDOUT
    syscall
    ret

;; Accepts a connection from a client, storing the client socket file descriptor
;; in the client variable and logging the connection to stdout
_send:
    ;; Call sys_accept
    mov rdi, echobuf
    mov rcx, 0
    .clearloop:   
        cmp rcx, 256
        je .cleardone
        mov [rdi], byte 0
        inc rdi
        inc rcx
        jmp .clearloop
    .cleardone:   
    mov rax, 0
    mov rdi, 0
    mov rsi, echobuf
    mov rdx, 256
    syscall
    mov     [read_count], rax
    
    mov rdi, echobuf
    mov rcx, 0
    .encryptloop:   
        cmp rcx, 256
        je .done
        mov al, [rdi]
        xor al, [key]
        mov [rdi],al
        inc rdi
        inc rcx
        jmp .encryptloop
    .done: 
    mov     rax, 44              ; sendto
    mov     rdi, [sock]          ; client socket fd
    mov     rsi, echobuf         ; buffer
    mov     rdx, 256             ; number of bytes received in _read
    mov     rcx, 0               ; flag
    mov     r8, pop_sa
    mov     r9, sockaddr_in_len
    syscall

    ;; Check call succeeded
    cmp       rax, 0
    jl        _accept_fail

    ret

_recieve:
    mov rax, 0
    mov rsi, echobuf
    mov rdx, 256
    mov rdi, [sock]
    syscall

    mov      [read_count], rax

    mov rdi, echobuf
    mov rcx, 0
    .encryptloop:   
        cmp rcx, 256
        je .encryptdone
        mov al, [rdi]
        xor al, [key]
        mov [rdi],al
        inc rdi
        inc rcx
        jmp .encryptloop
    .encryptdone:
    mov         rsi, echobuf
    mov         rdx, read_count
    mov         rax, 1 ; SYS_WRITE
    mov         rdi, 1 ; STDOUT
    syscall
    ret 

;; Performs sys_close on the socket in rdi
_close_sock:
    mov     rax, 3        ; SYS_CLOSE
    syscall

    ret

;; Error Handling code
;; _*_fail handle the population of the rsi and rdx registers with the correct
;; error messages for the labelled situation. They then call _fail to show the
;; error message and exit the application.
_socket_fail:
    mov     rsi, sock_err_msg
    mov     rdx, sock_err_msg_len
    call    _fail

_bind_fail:
    mov     rsi, bind_err_msg
    mov     rdx, bind_err_msg_len
    call    _fail

_listen_fail:
    mov     rsi, connect_err_msg
    mov     rdx, connect_err_msg_len
    call    _fail

_accept_fail:
    mov     rsi, send_err_msg
    mov     rdx, send_err_msg_len
    call    _fail

;; Calls the sys_write syscall, writing an error message to stderr, then exits
;; the application. rsi and rdx must be populated with the error message and
;; length of the error message before calling _fail
_fail:
    mov        rax, 1 ; SYS_WRITE
    mov        rdi, 2 ; STDERR
    syscall

    mov        rdi, 1
    call       _exit

;; Exits cleanly, checking if the listening or client sockets need to be closed
;; before calling sys_exit
_exit:
    mov        rax, [sock]
    cmp        rax, 0
    je         .perform_exit
    mov        rdi, [sock]
    call       _close_sock

    .perform_exit:
    mov        rax, 60
    syscall