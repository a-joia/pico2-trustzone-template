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


# Config environment (ubuntu24)

Necessary hardware:
- Raspberry pico 2
- Raspberry debug probe

### Compiling the code

1. Install vscode
2. Install raspberry pi pico extension
3. Install sdk and toolchains
    - One easy way install everything is to create a new project from example using the pico extension, then open the project. This should automatically install the pico-sdk and the toolchain at `~/.pico-sdk`
4. Clone this repo 
5. run ./compile.sh 

### Flashing / Debugging

Configure the vscode launcher

1. Configure the file `.vscode/launch.json`
    - Change `cwd` , `serverpath`, `gdbPath` from "Pico Debug (Cortex-Debug)"  with your path

Now we need to make the debug probe accessible by the user.


Create a new group that will have access to the debug probe (this is not necessary, you can just use any group that you already have)

Create group:
```
sudo groupadd debugprobe
```

Add user to group:
```
sudo usermod -aG debugprobe $USER
``` 

Test if the user is in the group
```
groups $USER
```

### 1. Create udev rule 
```
sudo vim /etc/udev/rules.d/60-cmsis-dap.rules
```

### 2.  Add the following line
```
SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", MODE="0666", GROUP="debugprobe"
```

### 3. Reload udev rules and replug the device
```
sudo udevadm control --reload-rules
sudo udevadm trigger
```

### 4.  You may need install this library or other libraries
```
sudo apt install libhidapi-hidraw0
```
### 5. Run vscode debug using the "Pico Debug (Cortex-Debug)"  launcher
