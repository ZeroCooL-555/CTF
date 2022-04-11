#include <stdio.h>

int add(int num1, int num2) {
	int sum;
	int i;
	sum = num1;
	for (i = 0; i < 5; i++) {
		sum = sum + num2;
	}
	return sum;
}

int main() {
	printf("[+] FLAG: gg{%d}", add(0x10d4e, 0xbeef));
	return 0;
}
