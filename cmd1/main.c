#include <stdio.h>

#include "liba.h"

int
main(int argc, char *argv[])
{
    int i = 0;

    i += a1() + a2();
    i += b1() + b2();
    i += c1() + c2() + c3();

    return i;
}
