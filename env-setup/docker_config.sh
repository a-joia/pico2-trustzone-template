#!/bin/bash

touch /etc/udev/rules.d/60-openocd.rules

filetext=$(cat <<EOF
SUBSYSTEM=="usb", ATTR{idVendor}=="2e8a", ATTR{idProduct}=="000c", MODE="0666"
EOF
)

echo "$filetext" |  tee /etc/udev/rules.d/60-openocd.rules > /dev/null

udevadm control --reload-rules
udevadm trigger





/home/neto/Workspace/git/pico2-trustzone-template/tools/openocd/openocd/0.12.0+dev/openocd -c "gdb_port 50000" -c "tcl_port 50001" -c "telnet_port 50002" -s /home/neto/Workspace/git/pico2-trustzone-template/tools/openocd/openocd/0.12.0+dev/scripts -f /home/neto/.vscode-server/extensions/marus25.cortex-debug-1.12.1/support/openocd-helpers.tcl -f interface/cmsis-dap.cfg -f target/rp2350.cfg -c "adapter speed 1000"