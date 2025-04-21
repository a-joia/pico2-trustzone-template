#include "hardware/structs/sau.h"
#include "hardware/structs/scb.h"
#include "_rp2350.h"


void configure_sau(void)
{
    // Disable SAU before configuring
    SAU->CTRL &= ~SAU_CTRL_ENABLE_Msk;

    // Region 0: Mark FLASH_NSC as NSC (Secure Callable)
    SAU->RNR  = 0;
    SAU->RBAR = 0x100FFC00 & SAU_RBAR_BADDR_Msk;
    SAU->RLAR = (0x100FFFFF & SAU_RLAR_LADDR_Msk) | SAU_RLAR_ENABLE_Msk | SAU_RLAR_NSC_Msk;

    // Region 1: Mark FLASH (excluding NSC) as Secure
    SAU->RNR  = 1;
    SAU->RBAR =  0x10100000 & SAU_RBAR_BADDR_Msk;
    SAU->RLAR = (0x10400000 & SAU_RLAR_LADDR_Msk) | SAU_RLAR_ENABLE_Msk;

    // Region 2: Mark Secure RAM
    SAU->RNR  = 2;
    SAU->RBAR = 0x20012000 & SAU_RBAR_BADDR_Msk;
    SAU->RLAR = (0x20082000 & SAU_RLAR_LADDR_Msk) | SAU_RLAR_ENABLE_Msk;

    // Region 1: Mark FLASH (excluding NSC) as Secure
    SAU->RNR  = 3;
    SAU->RBAR = 0x10000000 & SAU_RBAR_BADDR_Msk;
    SAU->RLAR = (0x100FBFFF & SAU_RLAR_LADDR_Msk) & ~SAU_RLAR_ENABLE_Msk;

    // Region 2: Mark Secure RAM
    SAU->RNR  = 4;
    SAU->RBAR = 0x20000000 & SAU_RBAR_BADDR_Msk;
    SAU->RLAR = (0x20011FFF & SAU_RLAR_LADDR_Msk) & ~SAU_RLAR_ENABLE_Msk;

    // Enable SAU
    SAU->CTRL = SAU_CTRL_ENABLE_Msk;

    __DSB(); 
    __ISB();
}

void system_init(void){

    /* Init float registers */  
    SCB->CPACR |= (0xF << 20);        // Enable CP10 and CP11 full access
    SCB->NSACR |= (0x3 << 10);        // Enable CP10 and CP11 full access in non-secure state
    scb_ns_hw->cpacr |= (0xF << 20);  // Enable CP10 and CP11 full access in non-secure state
  
    /* Enable fault handlers */
    SCB->SHCSR |= SCB_SHCSR_USGFAULTENA_Msk
             |  SCB_SHCSR_BUSFAULTENA_Msk
             |  SCB_SHCSR_MEMFAULTENA_Msk
             |  SCB_SHCSR_SECUREFAULTENA_Msk;
  
    SCB->AIRCR = (0x5FA << SCB_AIRCR_VECTKEY_Pos) | SCB_AIRCR_BFHFNMINS_Msk;

    __DSB(); 
    __ISB();
  }

void sc_trustzone_init(void) {
    
    // Activate TrustZone
    // tzen is already enable from factory i guess

    // Set the SAU regions
    system_init();
    configure_sau();
}


