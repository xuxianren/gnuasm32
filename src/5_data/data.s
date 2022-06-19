/*
练习寻址
  - 立即数寻址 -- 访问立即数
  - 直接寻址 -- 根据数值(在代码中)指定的地址 ，访问内存
      1. 通过label
      2. 通过label + 偏移
      3. 通过数值 [需要手动调试出来，不通用]
  - 寄存器寻址 -- 访问寄存器
  - 变址寻址 -- 根据寄存器 + 
  - 间接寻址 --根据寄存器里的地址 + 偏移 访问内存

*/
.section .data
s:
  .ascii "ABCD\n"

.section .text
.globl _start
_start:
  /*打印全部字符串*/
  movl $5,           %edx  /*立即数寻址*/
  movl $s,           %ecx  /*直接寻址1*/
  movl $1,           %ebx
  movl $4,           %eax
  int  $0x80
  
  /*打印s[1:]*/
  movl $4,           %edx
  movl $s + 1,       %ecx  /*编译时会计算出结果*/
  movl $1,           %ebx
  movl $4,           %eax
  int  $0x80
  
  /* s[1] = 'A' */
  movb $65,          s + 1  /*直接寻址2*/

  movl $5,           %edx
  movl $s,           %ecx
  movl $1,           %ebx
  movl $4,           %eax
  int  $0x80
  
  /*s[0] = 'C' */
  movb $67,          0x80490e6   /*直接寻址3 这个地址是手动调试后确认的，不通用*/

  movl $5,           %edx
  movl $s,           %ecx
  movl $1,           %ebx
  movl $4,           %eax
  int  $0x80

    /*s[0] = 'C' */
  movl $s,           %edi
  movb $65,          (%edi)      /*间接寻址*/
  movb $66,         1(%edi)   
  movl $5,           %edx
  movl $s,           %ecx
  movl $1,           %ebx
  movl $4,           %eax
  int  $0x80
  
  /*将每个字符+1 结果BCDE*/
  movl $4, %ecx
  xor  %edi, %edi
loop1:
  movb s(,%edi,1), %al           /*变址寻址*/
  addb $1, %al
  movb %al, s(,%edi,1)
  inc %edi
  loop loop1

  movl $5,           %edx
  movl $s ,          %ecx
  movl $1,           %ebx
  movl $4,           %eax
  int  $0x80
  
  /*exit(0)*/
  movl $0, %ebx
  movl $1, %eax
  int  $0x80
