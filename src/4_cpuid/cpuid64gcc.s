/*
使用gcc进行编译
*/

.section .data
output:
  .asciz "this cpu vender is '%s'\n"

.section .bbs
  .lcomm buffer, 13

.section .text

.globl main
main:
  movq $0, %rax
  cpuid
  movq $buffer, %rsi
  movl %ebx, (%rsi)
  movl %edx, 4(%rsi)
  movl %ecx, 8(%rsi)
  movq $output, %rdi
  call printf
  movq $0, %rdi
  call exit

/*
as -o cpuid64.o  cpuid64.s
ld -lc -I /usr/lib64/ld-linux-x86-64.so.2 -o cpuid64 cpuid64.o
*/

