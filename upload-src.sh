#!/bin/bash

PORT=`dmesg | grep 'cp210x converter now attached to' | tail -1 | awk '{ print $9 }'` 

if [ -z $1 ]
then
    echo "USAGE: $0 /dev/ttyUSBX"
    if [ ! -z "$PORT" ] 
    then 
        echo "It seams that MCU is/was connected to /dev/$PORT"
    fi
    exit
fi    

if [ ! -e ./tools/luatool/luatool/luatool.py ]
then 
    echo "Please run install-tools.sh"   
    exit
fi

python ./tools/luatool/luatool/luatool.py --port $1 --src ./src/config.lua --dest config.lua --verbose
python ./tools/luatool/luatool/luatool.py --port $1 --src ./src/init.lua --dest init.lua --verbose
python ./tools/luatool/luatool/luatool.py --port $1 --src ./src/main.lua --dest main.lua --verbose