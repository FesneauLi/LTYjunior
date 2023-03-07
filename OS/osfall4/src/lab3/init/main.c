#include "printk.h"
#include "sbi.h"

extern void test();

int start_kernel() {
    // puti(2022);
    // puts(" Hello RISC-V\n");
    printk("2022");
    test(); // DO NOT DELETE !!!

	return 0;
}
