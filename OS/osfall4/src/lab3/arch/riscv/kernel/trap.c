// trap.c 
#include <printk.h>
#include <clock.h>
// #include <stdint.h>
void trap_handler(unsigned long scause, unsigned long sepc) {
    // 通过 `scause` 判断trap类型
    // if((long)scause < 0) {
    //     long cause = (scause<<1)>>1;  // remomve the highest bit 1 
    //     switch(cause){
        if(scause == 0x8000000000000005 ){
            //case 5:// time interrupt 
            printk("[S] Supervisor Mode Timer Interrupt");
            clock_set_next_event();
            printk("[S] next event setted");
            // break;
            // default: break;
        }
    // }
    // 1. 如果是interrupt 判断是否是timer interrupt
    // 1.1 如果是timer interrupt 则打印: "[S] Supervisor Mode Timer Interrupt"
    //     并通过 `clock_set_next_event()` 设置下一次时钟中断
    //     关于 `clock_set_next_event()` 见 4.5 节
    // 1.2 & 2. 其他interrupt / exception 可以直接忽略
    
    // YOUR CODE HERE
}