
# // #include <riscv.h>

#     .macro SAVE_ALL #定义汇编宏

#     csrw sscratch, sp #保存原先的栈顶指针到sscratch

#     addi sp, sp, -36*8 #8是riscv.h定义的常量，表示一个寄存器占据几个字节
#     #让栈顶指针向低地址空间延伸 36个寄存器的空间，可以放下一个trapFrame结构体。
#     #除了32个通用寄存器，我们还要保存4个和中断有关的CSR

#     #依次保存32个通用寄存器。但栈顶指针需要特殊处理。
#     #因为我们想在trapFrame里保存分配36个8之前的sp
#     #也就是保存之前写到sscratch里的sp的值
#     SD x0, 0(sp)
#     SD x1, 1*8(sp)
#     SD x3, 3*8(sp)
#     SD x4, 4*8(sp)
#     SD x5, 5*8(sp)
#     SD x6, 6*8(sp)
#     SD x7, 7*8(sp)
#     SD x8, 8*8(sp)
#     SD x9, 9*8(sp)
#     SD x10, 10*8(sp)
#     SD x11, 11*8(sp)
#     SD x12, 12*8(sp)
#     SD x13, 13*8(sp)
#     SD x14, 14*8(sp)
#     SD x15, 15*8(sp)
#     SD x16, 16*8(sp)
#     SD x17, 17*8(sp)
#     SD x18, 18*8(sp)
#     SD x19, 19*8(sp)
#     SD x20, 20*8(sp)
#     SD x21, 21*8(sp)
#     SD x22, 22*8(sp)
#     SD x23, 23*8(sp)
#     SD x24, 24*8(sp)
#     SD x25, 25*8(sp)
#     SD x26, 26*8(sp)
#     SD x27, 27*8(sp)
#     SD x28, 28*8(sp)
#     SD x29, 29*8(sp)
#     SD x30, 30*8(sp)
#     SD x31, 31*8(sp)
#     # RISCV不能直接从CSR写到内存, 需要csrr把CSR读取到通用寄存器，再从通用寄存器STORE到内存
#     csrrw s0, sscratch, x0
#     csrr s1, sstatus
#     csrr s2, sepc
#     csrr s3, sbadaddr
#     csrr s4, scause

#     SD s0, 2*8(sp)
#     SD s1, 8*8(sp)
#     SD s2, 33*8(sp)
#     SD s3, 34*8(sp)
#     SD s4, 35*8(sp)
#     .endm #汇编宏定义结束


#     .macro RESTORE_ALL

#     LD s1, 8*8(sp)
#     LD s2, 33*8(sp)
    
#     # 注意之前保存的几个CSR并不都需要恢
#     csrw sstatus, s1
#     csrw sepc, s2
    
#     # 恢复sp之外的通用寄存器，这时候还需要根据sp来确定其他寄存器数值保存的位置
#     LD x1, 1*8(sp)
#     LD x3, 3*8(sp)
#     LD x4, 4*8(sp)
#     LD x5, 5*8(sp)
#     LD x6, 6*8(sp)
#     LD x7, 7*8(sp)
#     LD x8, 8*8(sp)
#     LD x9, 9*8(sp)
#     LD x10, 10*8(sp)
#     LD x11, 11*8(sp)
#     LD x12, 12*8(sp)
#     LD x13, 13*8(sp)
#     LD x14, 14*8(sp)
#     LD x15, 15*8(sp)
#     LD x16, 16*8(sp)
#     LD x17, 17*8(sp)
#     LD x18, 18*8(sp)
#     LD x19, 19*8(sp)
#     LD x20, 20*8(sp)
#     LD x21, 21*8(sp)
#     LD x22, 22*8(sp)
#     LD x23, 23*8(sp)
#     LD x24, 24*8(sp)
#     LD x25, 25*8(sp)
#     LD x26, 26*8(sp)
#     LD x27, 27*8(sp)
#     LD x28, 28*8(sp)
#     LD x29, 29*8(sp)
#     LD x30, 30*8(sp)
#     LD x31, 31*8(sp)
#     # 最后恢复sp
#     LD x2, 2*8(sp)
#     .endm

    .section .text.entry
    .align 2
    .globl _traps 
_traps:
    # YOUR CODE 
    # 1. save 8 registers and sepc to stack
    //SAVE_ALL
    csrw sscratch, sp #保存原先的栈顶指针到sscratch

    addi sp, sp, -36*8 #8是riscv.h定义的常量，表示一个寄存器占据几个字节
    #让栈顶指针向低地址空间延伸 36个寄存器的空间，可以放下一个trapFrame结构体。
    #除了32个通用寄存器，我们还要保存4个和中断有关的CSR

    #依次保存32个通用寄存器。但栈顶指针需要特殊处理。
    #因为我们想在trapFrame里保存分配36个8之前的sp
    #也就是保存之前写到sscratch里的sp的值
    SD x0, 0(sp)
    SD x1, 1*8(sp)
    SD x3, 3*8(sp)
    SD x4, 4*8(sp)
    SD x5, 5*8(sp)
    SD x6, 6*8(sp)
    SD x7, 7*8(sp)
    SD x8, 8*8(sp)
    SD x9, 9*8(sp)
    SD x10, 10*8(sp)
    SD x11, 11*8(sp)
    SD x12, 12*8(sp)
    SD x13, 13*8(sp)
    SD x14, 14*8(sp)
    SD x15, 15*8(sp)
    SD x16, 16*8(sp)
    SD x17, 17*8(sp)
    SD x18, 18*8(sp)
    SD x19, 19*8(sp)
    SD x20, 20*8(sp)
    SD x21, 21*8(sp)
    SD x22, 22*8(sp)
    SD x23, 23*8(sp)
    SD x24, 24*8(sp)
    SD x25, 25*8(sp)
    SD x26, 26*8(sp)
    SD x27, 27*8(sp)
    SD x28, 28*8(sp)
    SD x29, 29*8(sp)
    SD x30, 30*8(sp)
    SD x31, 31*8(sp)
    # RISCV不能直接从CSR写到内存, 需要csrr把CSR读取到通用寄存器，再从通用寄存器STORE到内存
    csrrw s0, sscratch, x0
    csrr s1, sstatus
    csrr s2, sepc
    csrr s3, sbadaddr
    csrr s4, scause

    SD s0, 2*8(sp)
    SD s1, 32*8(sp)
    SD s2, 33*8(sp)
    SD s3, 34*8(sp)
    SD s4, 35*8(sp)



    //mv a0,sp  #pass the parameter ??
     csrr a0,scause
    # 2. call trap_handler
    jal trap_handler  // jal ??
    # 3. restore sepc and 8 registers (x2(sp) should be restore last) from stack
    
    .globl __trapret
__trapret:


    //RESTORE_ALL
    LD s1, 32*8(sp)   // !!!!!!!
    LD s2, 33*8(sp)
    
    # 注意之前保存的几个CSR并不都需要恢
    csrw sstatus, s1
    csrw sepc, s2
    
    # 恢复sp之外的通用寄存器，这时候还需要根据sp来确定其他寄存器数值保存的位置
    LD x1, 1*8(sp)
    LD x3, 3*8(sp)
    LD x4, 4*8(sp)
    LD x5, 5*8(sp)
    LD x6, 6*8(sp)
    LD x7, 7*8(sp)
    LD x8, 8*8(sp)
    LD x9, 9*8(sp)
    LD x10, 10*8(sp)
    LD x11, 11*8(sp)
    LD x12, 12*8(sp)
    LD x13, 13*8(sp)
    LD x14, 14*8(sp)
    LD x15, 15*8(sp)
    LD x16, 16*8(sp)
    LD x17, 17*8(sp)
    LD x18, 18*8(sp)
    LD x19, 19*8(sp)
    LD x20, 20*8(sp)
    LD x21, 21*8(sp)
    LD x22, 22*8(sp)
    LD x23, 23*8(sp)
    LD x24, 24*8(sp)
    LD x25, 25*8(sp)
    LD x26, 26*8(sp)
    LD x27, 27*8(sp)
    LD x28, 28*8(sp)
    LD x29, 29*8(sp)
    LD x30, 30*8(sp)
    LD x31, 31*8(sp)
    # 最后恢复sp
    LD x2, 2*8(sp)


    # 4. return from trap
    sret

    .global __dummy
__dummy:
    la t0,__dummy
    csrrw sepc,t0

    sret

    .global __switch_to
__switch_to:
    sd ra,   5*8(a0)
    sd sp,   6*8(a0)
    sd s0,   7*8(a0)
    sd s1,   8*8(a0)
    sd s2,   9*8(a0)
    sd s3,   10*8(a0)
    sd s4,   11*8(a0)
    sd s5,   12*8(a0)
    sd s6,   13*8(a0)
    sd s7,   14*8(a0)
    sd s8,   15*8(a0)
    sd s9,   16*8(a0)
    sd s10,  17*8(a0)
    sd s11,  18*8(a0)

    ld ra,   5*8(a0)
    ld sp,   6*8(a0)
    ld s0,   7*8(a0)
    ld s1,   8*8(a0)
    ld s2,   9*8(a0)
    ld s3,   10*8(a0)
    ld s4,   11*8(a0)
    ld s5,   12*8(a0)
    ld s6,   13*8(a0)
    ld s7,   14*8(a0)
    ld s8,   15*8(a0)
    ld s9,   16*8(a0)
    ld s10,  17*8(a0)
    ld s11,  18*8(a0)


    sret

