/*
打印所有环境变量
*/
.section .data
fmt:
  .asciz "%s\n"

.section .text
.globl _start
_start:
  movl %esp, %edi
  movl (%edi), %ebx
  addl $1, %ebx
  printone:
  inc %ebx
  movl (%edi, %ebx, 4), %eax
  cmpl $0, %eax
  je end
  pushl %eax
  pushl $fmt
  call printf
  addl $8, %esp
  jmp printone
  end:
  pushl $0
  call exit
