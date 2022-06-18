/*
hello world
用于测试验证环境

汇编
as --32 -o hello.o hello.s
链接
ld -m elf_i386 -o hello hello.o
*/
.section .data
message:
   .ascii "hello world!\n"
   length = . - message

.section .text
.globl _start

_start:
   movl $length, %edx
   movl $message,%ecx
   movl $1,      %ebx
   movl $4,      %eax
   int  $0x80

   movl $0, %ebx
   movl $1, %eax
   int  $0x80
