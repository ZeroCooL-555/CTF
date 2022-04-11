#include <stdio.h>
#include <stdlib.h>

long gen_flag(ulong param_1)

{
	char *alloc_mem;
	int i;
	
	alloc_mem = malloc(9);
	for (i = 0; i < 8; i = i + 1) {
		*(char *)((long)alloc_mem + (long)(7 - i)) = (char)(param_1 >> ((int)(i << 3) & 0x3f));
	}
	*(long *)((long)alloc_mem + 8) = 0;
	return alloc_mem;
}

int main() {
	printf("[+] FLAG: gg{%s}", gen_flag(8101803640625587823));
	return 0;
}
