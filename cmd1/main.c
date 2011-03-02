#include <stdio.h>

#include "libA.h"
#include "libB.h"
#include "libC.h"

int
main(int argc, char *argv[])
{
    int i = 0;

    i += a1() + a2();
    i += b1() + b2();
    i += c1() + c2() + c3();

    printf("%s: %d\n", argv[0], i);

    return i;
}
