#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

MODULE_LICENSE("Proprietary");
MODULE_AUTHOR("Marek Bulatek");
MODULE_DESCRIPTION("Driver for SPI EKG module");
MODULE_VERSION("0.1");


static int __init ekg_init(void){
   printk(KERN_INFO "EKG inserted successfuly\n");
   return 0;
}

static void __exit ekg_exit(void){
   printk(KERN_INFO "EKG removed successfuly\n");
}

module_init(ekg_init);
module_exit(ekg_exit);
