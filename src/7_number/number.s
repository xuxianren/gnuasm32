/*
浮点数表示
2.5
01000000 00100000 00000000 00000000
*/

.section .data
f:
  .float 2.5

.section .text
.globl _start
_start:
  xor %eax, %eax
  pushl $0
  call exit
