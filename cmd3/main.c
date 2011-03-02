#include <libgen.h>
#include <stdio.h>

int
main(int argc, char *argv[])
{
    int i = 0;

    printf("%s: %d\n", basename(argv[0]), i);
    return 0;
}
