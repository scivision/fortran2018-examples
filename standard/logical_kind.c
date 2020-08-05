#include <stdbool.h>
#include <stdio.h>

int main(void){
bool L;
if (sizeof(L) != 1) {
  fprintf(stderr, "expected boolean to be 8 bits per element");
  return 1;
}
return 0;
}
