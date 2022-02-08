#include <stdio.h>
#include <sys/io.h>

int main(int argc, int** argv)
{
    int ret;
    unsigned char res;
    ret = ioperm(0x60, 1, argv[0] - '0');
    ret = ioperm(0x64, 1, argv[0] - '0');
    if (ret < 0) {
            perror("ioperm");
            return 1;
    }
    res = inb(0x60);
    printf("res value 60 :%d \n", res);
    res = inb(0x64);
    printf("res value 64 :%d \n", res);
    if ( res & 0x17 ){
        ioperm(0x60, 1, 0);
        ioperm(0x64, 1, 0);
        return 1;
    }
    else{
        ioperm(0x60, 1, 0);
        ioperm(0x64, 1, 0);
        return 2;
    }
}
