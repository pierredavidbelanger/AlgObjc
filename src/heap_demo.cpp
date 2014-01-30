#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "heap.h"

int main()
{	
	using namespace alg;
	int MAXELEMENTS=10;
	Heap<int> heap(MAXELEMENTS);

	int32_t i;
	srand(time(NULL));
	for (i=0;i < MAXELEMENTS; i++) {
		int32_t value = i;
		heap.insert(i, value);
		printf("inserting: %d->%d\n", i, value);
	}

	printf("decrease a value[%d] to %d\n", 5, -1);
	heap.decrease_key(5, -1);
	while(!heap.is_empty()) {
		printf("deleting min: %d->%d\n", heap.min_key(), heap.min_value());
		heap.delete_min();
	}

	return 0;
}
