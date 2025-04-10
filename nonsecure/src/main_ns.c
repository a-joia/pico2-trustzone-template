
#include <stdio.h>
#include "pico/stdlib.h"
#include "nsc.h"

int main(){
        while(1){
                // printf("Hello from non-secure world\n");
                Secure_Test_Call();
                sleep_ms(3000);
        }
}