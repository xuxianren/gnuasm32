/*
实现1个求前n位自然数之和的函数
*/

.section .data
s:
  .asciz "sum is %d\n"

n:
  .int 10

.section .text
.globl _start
_start:
  // call sum3
  pushl n
  call sum4
  addl $4, %esp
  /*print(&s, n)*/
  pushl %eax
  pushl $s
  call printf
  addl $8, %esp
  /*exit(0)*/
  pushl $0
  call exit

.type sum1, @function
sum1:
  movl n, %ecx
  xor %eax, %eax
  twosum:
  addl %ecx, %eax
  loop twosum
  ret


.type sum2, @function
sum2:
  xor %eax, %eax
  movl $0, %ebx
  movl n, %ecx
  loop1:
  addl %ebx, %eax
  inc %ebx
  cmp %ebx, %ecx
  jae loop1
  end:
    ret

.type sum3, @function
sum3:
  movl n, %eax
  inc %eax
  movl n, %ebx
  mul %ebx
  movl $2, %ebx
  div %ebx
  ret

.type sum4, @function
sum4:
  pushl %ebp
  movl %esp, %ebp
  movl 8(%ebp), %ecx
  xor %eax, %eax
  twosum2:
  addl %ecx, %eax
  loop twosum2
  movl %ebp, %esp
  popl %ebp
  ret
