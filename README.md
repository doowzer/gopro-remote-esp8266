# gopro-remote-esp8266

### Hardware
* NodeMCU devkit
* GoPro Hero3 (silver)

### Issues

#### #1 Firmware reflashing 
Made an misstake in the code and the NodeMCU just restarted and restarted. I read that if this happen the NodeMCU need to be reflashed.

There are diffrent ways to reflash the firmware, I tired two diffrent approaches using [esptool](https://github.com/themadinventor/esptool) and [NodeMCU Flasher](https://github.com/nodemcu/nodemcu-flasher). Esptool diden't work for me, I think the main reason is that the NodeMCU must be set to *flash mode* and I failed with that. The other tool is the NodeMCU Flasher, with this tool there is no need to set the devide to *flash mode*, it will do it for you. The hardest part for me was to find a firmware, tried three diffrent approaches:

**1)** Using [NodeMCU custom builds](https://nodemcu-build.com/ "NodeMCU custom builds")

This is a cloud service that will build a custom firmware for you. Select the modules modules to include in the firmware and enter your email address. After a while you will get an email when the build is completed, the email contains two links to download the firmware. 

**2)** Building a custom firmware

This step was pretty time-consuming, had to install all needed dependencies and build the tool-chain for compiling. First clone the repositories [esp-open-sdk](https://github.com/pfalcon/esp-open-sdk) and [nodemcu-firmware](https://github.com/nodemcu/nodemcu-firmware) Start with building the [esp-open-sdk](https://github.com/pfalcon/esp-open-sdk), after that edit the [nodemcu-firmware](https://github.com/nodemcu/nodemcu-firmware) after your needs. 

```app/include/user_modules.h``` - Comment out or uncomment the modules you wan't to in/exclude.

```app/include/user_version.h``` - Change values for ```BUILD_DATE``` and ```NODE_VERSION``` 
 
 **3)** Download [firmware](https://github.com/nodemcu/nodemcu-firmware/releases/download/0.9.6-dev_20150704/nodemcu_float_0.9.6-dev_20150704.bin "NodeMCU 0.9.6-dev")
 
 I found following [firmware](https://github.com/nodemcu/nodemcu-firmware/releases/download/0.9.6-dev_20150704/nodemcu_float_0.9.6-dev_20150704.bin "NodeMCU 0.9.6-dev"). This worked out when flashed with [NodeMCU Flasher](https://github.com/nodemcu/nodemcu-flasher). 

#### #2 Message: *Please run file.remove("user.lua") before first use.*
When starting the NodeMCU devkit for the first time and connected to it following messages was printed:

```Please run file.remove("user.lua") before first use.``` 

Press the RST button and the message disappeared.
