/*
从命令行读取2个int参数求其平均数

avg = (a + b)/2
    = (a&b<<1 + a^b)>>1
    = a&b + a^b>>1

*/
.section .data
ans:
  .asciz "average=%u\n"
msg:
  .ascii "please input two args\n"

.section .text
.globl _start
_start:
  movl (%esp), %eax
  movl $3, %ebx
  cmp %eax, %ebx
  jne error
  /*参数1*/
  movl %esp, %edi
  pushl 8(%edi)
  call atoi
  movl %eax, %ebx
  pushl 12(%edi)
  call atoi
  movl %eax, %ecx
  movl %ebx, %edx
  and %ebx, %eax
  xor %ecx, %ebx
  shr %ebx
  addl %ebx, %eax
  pushl %eax
  pushl $ans
  call printf
  addl $8, %esp
  pushl $0
  call exit
error:
  pushl $msg
  call printf
  addl $4, %esp
  pushl $0
  call exit
