#include "_rp2350.h"

void HardFault_Handler(void) {
    // Handle HardFault exception
    // This is a placeholder function. Actual implementation will depend on the specific requirements.
    while(1){}
}

void MemoryManagementFault_Handler(void) {
    // Handle Memory Management Fault exception
    // This is a placeholder function. Actual implementation will depend on the specific requirements.
    while(1){}
}

void BusFault_Handler(void) {
    // Handle Bus Fault exception
    // This is a placeholder function. Actual implementation will depend on the specific requirements.
    while(1){}
}

void UsageFault_Handler(void) {
    // Handle Usage Fault exception
    // This is a placeholder function. Actual implementation will depend on the specific requirements.
    while(1){}
}
void SecureFault_Handler(void) {
    // Handle Secure Fault exception
    // This is a placeholder function. Actual implementation will depend on the specific requirements.
    while(1){}
}

void Default_Handler(void) {
    // Handle Default exception
    // This is a placeholder function. Actual implementation will depend on the specific requirements.
    while(1){}
}


// FreeRTOS declares it 
// void SVC_Handler(void) {
//     // Handle Supervisor Call (SVC)
//     // This is a placeholder function. Actual implementation will depend on the specific requirements.
//     while(1){}
// }

// FreeRTOS declares it 
// void PendSV_Handler(void) {
//     // Handle PendSV exception
//     // This is a placeholder function. Actual implementation will depend on the specific requirements.
//     while(1){}
// }

// FreeRTOS declares it 
// void SysTick_Handler(void) {
//     // Handle SysTick timer interrupt
//     // This is a placeholder function. Actual implementation will depend on the specific requirements.
//     while(1){}
// }

void NMI_Handler(void) {
    // Handle Non-Maskable Interrupt (NMI)
    // This is a placeholder function. Actual implementation will depend on the specific requirements.
    while(1){}
}

void DebugMonitor_Handler(void) {
    // Handle Debug Monitor exception
    // This is a placeholder function. Actual implementation will depend on the specific requirements.
    while(1){}
}
