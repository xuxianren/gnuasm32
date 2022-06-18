/*
输出cpu的制造商信息

汇编
as --32 -o cpuid.o cpuid.s
链接
ld -m elf_i386 -o cpuid cpuid.o
*/

.section .data
output:
  .ascii "this cpu is xxxxxxxxxxxxxxxx\n"

.section .text
.globl _start
_start:
  movl $0, %eax
  cpuid
  movl $output, %edi
  movl %ebx, 12(%edi)
  movl %edx, 16(%edi)
  movl %ecx, 20(%edi) 

  /*打印*/
  movl $4, %eax
  movl $1, %ebx
  movl $output, %ecx
  movl $29, %edx  /*output的长度*/
  int $0x80

  /*exit(0)*/
  movl $1, %eax
  movl $0, %ebx
  int $0x80

