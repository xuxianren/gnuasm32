/*
使用未打包的bcd，实现加法运算
例:
  28125
+ 52933
= 81058
*/

.section .data
a:
  .byte 0x05, 0x02, 0x01, 0x08, 0x02  /* 小端序 */
b:
  .byte 0x03, 0x03, 0x09, 0x02, 0x05

.section .bss
  .lcomm sum, 6  /* 结果多一位防止溢出 */

.section .text
.globl _start

_start:
  nop  /* 空指令，用于断点 */
  xor %edi, %edi
  movl $5, %ecx  /* 和loop指令配合， 用于5次循环 */
  clc  /* 辅助进位标志AF置0 */
loop1:
  movb a(, %edi, 1), %al
  adcb b(, %edi, 1), %al  /* adc会加上上次的进位，所以记得前面清零 */
  aaa  /* 调整bcd格式 */
  movb %al, sum(, %edi, 1)
  inc %edi
  loop loop1
  adcb $0, sum(, %edi, 4)  /* 最后加0，其实是加上上次的进位，保证进位不会被漏掉 */
  
  /*以下为非功能代码*/
  /*把bcd转换成ascii码*/
  movl $sum, %edi
  or $0x30, (%edi)
  or $0x30, 1(%edi)
  or $0x30, 2(%edi)
  or $0x30, 3(%edi)
  or $0x30, 4(%edi)

  /*把数组逆序，否则会先输出低位*/ 
  movl sum, %eax 
  bswap %eax
  movb 4(%edi), %bl
  movb %bl, (%edi)
  mov %eax, 1(%edi)

  /*输出sum*/
  movl $4,      %eax  /*write*/
  movl $1,      %ebx  /*stdout */
  movl $sum,    %ecx  
  movl $6,      %edx  
  int  $0x80
  /* exit(0) */
  movl $1, %eax  
  movl $0, %ebx
  int $0x80

