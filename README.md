Temporary Template of Trustzone on Raspberry Pico 2. NOT for production.

# Config 

(Install Pico SDK extension from vscode and compile any program using  the extension template to install the libraries) 

-> todo

# Run 


Compile with the following script

```
./compile.sh
```

(VSCode) -> Launch Debbuger with the Pico Debugger (Cortex-Debug) Launcher 


# Main dirs

Secure World Code

```
secure/*

```

NonSecure World Code

```
nonsecure/*

```





# Binding Windows USB to docker 

1- Install usbipd-win

```
winget install dorssel.usbipd-win
```

2- List devices
```
usbipd list
```

3- Attach device to wsl

```
usbipd attach --wsl --busid <bus-id> --auto-attach
```


---

Run openocd on Windows
```
c:/Users/nneto/.pico-sdk/openocd/0.12.0+dev/openocd.exe -c "gdb_port 50000" -c "tcl_port 50001" -c "telnet_port 50002" -s "c:/Users/nneto/.pico-sdk/openocd/0.12.0+dev/scripts" -f "c:/Users/nneto/.vscode/extensions/marus25.cortex-debug-1.12.1/support/openocd-helpers.tcl" -f interface/cmsis-dap.cfg -f target/rp2350.cfg -c "adapter speed 5000" 
```