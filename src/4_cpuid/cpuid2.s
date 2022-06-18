/*
调用系统函数，输出cpu厂商信息

```
# 汇编
  as --32 -o cpuid2.o cpuid2.s
# 链接
  ld -m elf_i386 -dynamic-linker /lib/ld-linux.so.2 -lc -o cpuid2 cpuid2.o
```
--------------------------------------------------------------------------
可能出现的问题:
问题1:
  ld: cannot find -lc
原因: 
  没找到libc.so动态库
解决方法: 
  1. 先安装glibc 32位版本
    yum install glibc.i686 -y
  2. 手动链接生成libc.so, 原因阅读linux动态库命名规则
    ln -s /lib/libc.so.6 /lib/libc.so

问题2:
  cpuid2.s: Assembler messages:
  cpuid2.s:19: Error: invalid instruction suffix for `push'
  cpuid2.s:20: Error: invalid instruction suffix for `push'
  cpuid2.s:23: Error: invalid instruction suffix for `push'
原因: 
  64位汇编的地址是8字节的，pushl是4字节，不匹配
解决方法:
  编译时指定32位平台，具体命令参考上面

*/

.section .data
output:
  .asciz "this cpu vender is %s\n"  /* .asciz会在最后填充\0 */

.section .bbs
  .lcomm buffer, 13

.section .text

.globl _start

_start:
  movl $0, %eax
  cpuid
  movl $buffer, %edi
  movl %ebx, (%edi)
  movl %edx, 4(%edi)
  movl %ecx, 8(%edi)

  /*
  调用函数，参数逆序入栈
  注意恢复栈
  */
  pushl $buffer
  pushl $output
  call printf
  addl $8, %esp  /*上面入栈了2个4字节参数，这里+8还原*/

  pushl $0
  call exit
