
#include "_rp2350.h"


void hard_fault_handler_c(uint32_t* stack)
{
    uint32_t r0  = stack[0];
    uint32_t r1  = stack[1];
    uint32_t r2  = stack[2];
    uint32_t r3  = stack[3];
    uint32_t r12 = stack[4];
    uint32_t lr  = stack[5];
    uint32_t pc  = stack[6];  // <- Where the fault occurred
    uint32_t psr = stack[7];

    volatile uint32_t _CFSR  = SCB->CFSR;   // Configurable Fault Status Register
    volatile uint32_t _HFSR  = SCB->HFSR;   // HardFault Status Register
    volatile uint32_t _MMAR  = SCB->MMFAR;  // MemManage Fault Address
    volatile uint32_t _BFAR  = SCB->BFAR;   // BusFault Address
    volatile uint32_t _SHCSR = SCB->SHCSR;

    // You can place a breakpoint here
    while (1);  // halt for inspection
}


__attribute__((naked)) void HardFault_Handler(void)
{
    __asm volatile (
        "tst lr, #4          \n"  // Check EXC_RETURN
        "ite eq              \n"
        "mrseq r0, msp       \n"  // If equal, use MSP
        "mrsne r0, psp       \n"  // Else use PSP
        "b hard_fault_handler_c \n"
    );
}

// void HardFault_Handler(void) {
//     // Handle HardFault exception
//     // This is a placeholder function. Actual implementation will depend on the specific requirements.
//     while(1){}
// }

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
    __asm volatile (
        "tst lr, #4          \n"  // Check EXC_RETURN
        "ite eq              \n"
        "mrseq r0, msp       \n"  // If equal, use MSP
        "mrsne r0, psp       \n"  // Else use PSP
        "b hard_fault_handler_c \n"
    );
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

void SVC_Handler(void) {
    // Handle Supervisor Call (SVC)
    // This is a placeholder function. Actual implementation will depend on the specific requirements.
    while(1){}
}
void PendSV_Handler(void) {
    // Handle PendSV exception
    // This is a placeholder function. Actual implementation will depend on the specific requirements.
    while(1){}
}
void SysTick_Handler(void) {
    // Handle SysTick timer interrupt
    // This is a placeholder function. Actual implementation will depend on the specific requirements.
    while(1){}
}

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

/////////////////////////////////////////////////////////////////////////////////////////

/*
Generic interrupt control funtions
*/
void enable_interrupt(IRQn_Type irq) {
    NVIC_EnableIRQ(irq);
}

void disable_interrupt(IRQn_Type irq) {
    NVIC_DisableIRQ(irq);
}



