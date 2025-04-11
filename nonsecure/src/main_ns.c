
#include <stdio.h>
#include "pico/stdlib.h"
#include "nsc.h"

int main(){
        stdio_init_all();
        while(1){
                Secure_Test_Call();
           
                // sleep_ms(10);
           
                printf("Hello from non-secure world\n");
        }
}