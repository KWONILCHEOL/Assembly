#define _CRT_SECURE_NO_WARNINGS
#include<cstdio>

int l1, l2, l3;
bool loop() {
	int x;
	printf("input=");
	scanf("%d", &x);
	l1 = x;
	if (l1 < 0)
		return false;

	printf("input=");
	scanf("%d", &x);
	l2 = x;
	l3 = 0;
	return true;
}
void sum() {
	while (l1 <= l2) {
		l3 += l1;
		l1++;
	}
}
int main() {
	while (loop()) {
		sum();
		printf("%d\n", l3);
	}
}