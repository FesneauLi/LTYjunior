.extern start_kernel

    .section .text.init
    .globl _start
_start:
    # YOUR CODE HERE        
    # set stvec = _traps

     la t0,_traps
     csrrw zero,stvec,t0

    # set sie[STIE] = 1
     li t2,32// 32    100000
     csrrs zero,sie,t2

    # set first time interrupt
     li a7,0
     li a6,0
     rdtime a0  //相对S
     li t1,10000000
     add a0,t1,a0
     li a1,0
     li a2, 0
     li a3, 0
     li a4, 0
     li a5, 0
     ecall

    # set sstatus[SIE] = 1
     li t3,2  // ....10  = 2 
     csrrs zero,sstatus,t3   // !!!!!!!!!!!!!!!

    la sp, boot_stack_top

    call mm_init
    call task_init
    j start_kernel

    .section .bss.stack
    .globl boot_stack   // whether is needed ??
boot_stack:
    .space 4096*4 # <-- change to your stack size

    .globl boot_stack_top
boot_stack_top: