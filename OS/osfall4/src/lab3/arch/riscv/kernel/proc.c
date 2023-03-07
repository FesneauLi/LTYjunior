//arch/riscv/kernel/proc.c
#include "proc.h"
#include "mm.h"
extern void __dummy();

struct task_struct* idle;           // idle process
struct task_struct* current;        // 指向当前运行线程的 `task_struct`
struct task_struct* task[NR_TASKS]; // 线程数组, 所有的线程都保存在此

void task_init() {
    int i;
    uint64 addr;
    struct task_struct* temp;
    // 1. 调用 kalloc() 为 idle 分配一个物理页
    addr = kalloc();
    temp = (struct task_struct*)addr;
    temp->state = TASK_RUNNING;
    temp->counter = 0;
    temp->priority = 0;
    temp->pid = 0;
    idle = current = task[0] = temp;
    // 2. 设置 state 为 TASK_RUNNING;
    // idle->state = TASK_RUNNING; 
    // 3. 由于 idle 不参与调度 可以将其 counter / priority 设置为 0
    for(i=1;i<NR_TASKS;i++){
        addr = kalloc();
        temp= (struct task_struct*)addr;
        temp->state = TASK_RUNNING;
        temp->counter = 0;
        temp->priority = rand()%PRIORITY_MAX +1;
        temp->pid = (uint64)i;
        (temp->thread).ra = (uint64)&__dummy;
        (temp->thread).sp = addr + 4096;
        task[i] = temp;
    }
    // 4. 设置 idle 的 pid 为 0
    
    // 5. 将 current 和 task[0] 指向 idle

    /* YOUR CODE HERE */

    // 1. 参考 idle 的设置, 为 task[1] ~ task[NR_TASKS - 1] 进行初始化
    // 2. 其中每个线程的 state 为 TASK_RUNNING, counter 为 0, priority 使用 rand() 来设置, pid 为该线程在线程数组中的下标。
    // 3. 为 task[1] ~ task[NR_TASKS - 1] 设置 `thread_struct` 中的 `ra` 和 `sp`,
    // 4. 其中 `ra` 设置为 __dummy （见 4.3.2）的地址,  `sp` 设置为 该线程申请的物理页的高地址

    /* YOUR CODE HERE */

    printk("...proc_init done!\n");
}
    void dummy(){
        uint64 MOD = 1000000007;
        uint64 auto_inc_local_var = 0;
        int last_counter = -1;
        while(1){
            if(last_counter == -1 || current->counter != last_counter){
                last_counter = current->counter;
                auto_inc_local_var = (auto_inc_local_var + 1)% MOD;
                printk("[PID = %d] is running,auto_inc_local_var = %d\n",
                current->pid,auto_inc_local_var);
            }
        }
    }
    void switch_to(struct task_struct* next){
        if(next != current){
            printk("switch process\n");
            printk("from [PID = %d COUNTER = %d PRIORITY = %d]\n",current->pid,current->counter,current->priority);
            printk("to [PID = %d COUNTER = %d PRIORITY = %d]",next->pid,next->counter,next->priority);
            struct task_struct* old_cur = current;
            current = next;
            __switch_to(old_cur,next);
        }
    }
    void schedule(){
        int i;
        int all_zero = 1;
        for(i=1;i<NR_TASKS;i++){
            if(task[i]->counter != 0){
                all_zero = 0;
                break;
            }
        }
        if(all_zero == 1){
            printk("\n");
            for(i=1;i<NR_TASKS;i++){
                task[i]->counter = rand()% 32 + 1;

            }
            printk("\n");
        }
    }   
    #ifdef SJF 
        int min_i = 1;
        unint min_time = MAX_TASK_TIME + 1;
        for(i=1;i<NR_TASKS;i++){
            if(task[i]->counter!=0 && task[i]->counter < min_time){
                min_i = i;
                min_time = task[i]->counter;
            }
        }
        switch_to(task[min_i]);
    #endif