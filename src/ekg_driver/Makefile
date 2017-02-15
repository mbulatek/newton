TARGET = ekg

obj-m += $(TARGET).o

ekg-objs := main.o


 
all:
	make -C $(PP_KERNEL_DIR) M=$(PWD) modules
clean:
	make -C $(PP_KERNEL_DIR) M=$(PWD) clean
