#include <stdio.h>

#include "libA.h"
#include "libB.h"

int
main(int argc, char *argv[])
{
    int i = 0;

    i += a1() + a2();
    i += b1() + b2();

    printf("%s: %d\n", argv[0], i);

    return i;
}
