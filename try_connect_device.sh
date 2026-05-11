#!/bin/bash
# Device Connection Troubleshooting Script
# Checks probe connection and attempts to connect to RP2350

set +e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  RP2350 Device Connection Diagnostic                   ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}\n"

# Step 1: Check for CMSIS-DAP probe
echo -e "${BLUE}[1/3] Checking for CMSIS-DAP probe...${NC}"
PROBE_INFO=$(lsusb -v 2>/dev/null | grep -A 5 "2e8a:000c")

if [ -z "$PROBE_INFO" ]; then
    echo -e "${RED}✗ CMSIS-DAP probe NOT FOUND${NC}"
    echo ""
    echo -e "${YELLOW}Main Cause: Probe is not connected or recognized${NC}"
    echo ""
    echo "Possible reasons:"
    echo "  1. Probe is not connected to USB"
    echo "  2. Probe is not powered"
    echo "  3. Probe driver not installed (Windows/Mac may need driver)"
    echo ""
    echo "Solutions:"
    echo "  • Verify USB cable is connected to probe AND computer"
    echo "  • Check if probe lights up (usually has LED indicator)"
    echo "  • Try different USB port"
    echo "  • On Windows/Mac, install CMSIS-DAP drivers"
    exit 1
else
    echo -e "${GREEN}✓ CMSIS-DAP probe FOUND${NC}"
    SERIAL=$(echo "$PROBE_INFO" | grep -i serial | head -1)
    echo "  $SERIAL"
    echo ""
fi

# Step 2: Attempt OpenOCD connection
echo -e "${BLUE}[2/3] Attempting OpenOCD connection to RP2350...${NC}\n"

OPENOCD_OUTPUT=$(tools/openocd/openocd/0.12.0+dev/openocd \
  -c "adapter speed 5000" \
  -s tools/openocd/openocd/0.12.0+dev/scripts \
  -f interface/cmsis-dap.cfg \
  -f target/rp2350.cfg 2>&1)

echo "$OPENOCD_OUTPUT"

# Step 3: Diagnose the result
echo -e "\n${BLUE}[3/3] Analyzing connection result...${NC}\n"

if echo "$OPENOCD_OUTPUT" | grep -q "Error: Error connecting DP"; then
    echo -e "${RED}✗ Connection Failed${NC}"
    echo ""
    echo -e "${YELLOW}Main Cause: Target chip not responding (cannot read IDR)${NC}"
    echo ""
    echo "Possible reasons:"
    echo "  1. SWD wires not properly connected (SWCLK, SWDIO, GND)"
    echo "  2. Target board is not powered"
    echo "  3. Wiring is loose or broken"
    echo "  4. RP2350 chip is in low-power/sleep mode"
    echo "  5. RP2350 chip may be damaged"
    echo ""
    echo "Troubleshooting steps:"
    echo "  ① Check physical SWD connections:"
    echo "     - SWCLK pin → SWCLK on board"
    echo "     - SWDIO pin → SWDIO on board"
    echo "     - GND pin  → GND on board"
    echo "  ② Verify board power:"
    echo "     - Check if board has power LED (lit?)"
    echo "     - Test with multimeter: GND to 3.3V rail"
    echo "  ③ Power cycle the target board"
    echo "  ④ Check for loose connectors or cold solder joints"
    echo ""
    exit 1
    
elif echo "$OPENOCD_OUTPUT" | grep -q "Interface ready"; then
    echo -e "${GREEN}✓ Connection Successful!${NC}"
    echo ""
    echo "RP2350 target is responding correctly!"
    echo "You can now launch the debugger in VS Code (Press F5)"
    exit 0
    
elif echo "$OPENOCD_OUTPUT" | grep -q "Cannot open FTDI device\|Permission denied"; then
    echo -e "${RED}✗ USB Permission Error${NC}"
    echo ""
    echo -e "${YELLOW}Main Cause: Missing USB permissions for probe${NC}"
    echo ""
    echo "Solution:"
    echo "  ${BLUE}sudo usermod -a -G dialout \$USER${NC}"
    echo "  ${BLUE}newgrp dialout${NC}"
    exit 1
    
else
    echo -e "${YELLOW}⚠ Unknown error state${NC}"
    echo ""
    echo "Check output above for 'Error:' or 'Warn:' messages"
    exit 1
fi