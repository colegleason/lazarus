OBJECTS = boot.o console.o main.o string.o

CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -g -O0 -Wall -Wextra
LDFLAGS = -arch i386 -T link.ld
ASFLAGS = -f elf

kernel: $(OBJECTS) link

clean:
	rm *.o kernel

build:
	fab build

link:
	ld $(LDFLAGS) -o kernel $(OBJECTS)

.s.o:
	nasm $(ASFLAGS) $<

qemu: build
	qemu-system-i386 -kernel kernel

gdb: build
	qemu-system-i386 -S -s -kernel kernel

test: build
	make -C tests test

