#include <stdio.h>

#define NSIZES 37

void initialize_size_array(size_t *sizes) {
  size_t i, j;
  size_t mult = 1;
  for (i = 0; i < 4; i++) {
    for (j = 1; j < 10; j++)
      sizes[9 * i + (j - 1)] = mult * j;
    mult *= 10;
  }
  sizes[9 * i] = mult;
}
