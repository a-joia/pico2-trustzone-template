# How to use

- Create a openocd server in the host (windows)

example
```
c:/Users/nneto/.pico-sdk/openocd/0.12.0+dev/openocd.exe -c "gdb_port 50000" -c "tcl_port 50001" -c "telnet_port 50002" -s "c:/Users/nneto/.pico-sdk/openocd/0.12.0+dev/scripts" -f "c:/Users/nneto/.vscode/extensions/marus25.cortex-debug-1.12.1/support/openocd-helpers.tcl" -f interface/cmsis-dap.cfg -f target/rp2350.cfg -c "adapter speed 5000" 
```

- Create a docker container sharing the port 50000:50000
- Connect vscode to the remote ssh
- Install the pico extension and check if ~/.pico-sdk was created
- Compile the code with ./compile
- Debug in vscode using "Debug using external openocd" config
