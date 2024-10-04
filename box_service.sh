#!/system/bin/sh

# This script waits for the Android boot animation to stop before executing a custom startup script.
# It runs in the background as a separate process.
#
# Steps:
# 1. Continuously checks the property 'init.svc.bootanim' until its value is "stopped".
# 2. Once the boot animation has stopped, it checks if the file '/data/adb/box/scripts/start.sh' exists.
# 3. If the file exists, it changes the permissions of all files in the '/data/adb/box/scripts/' directory to be executable.
# 4. Executes the 'start.sh' script.
# 5. If the 'start.sh' script is not found, it prints an error message.
# 该脚本在执行自定义启动脚本之前等待 Android 启动动画停止。
# 它作为一个单独的进程在后台运行。
#
# 步骤：
# 1. 不断检查属性 'init.svc.bootanim' 直到其值为 "stopped"。
# 2. 一旦启动动画停止，它会检查文件 '/data/adb/box/scripts/start.sh' 是否存在。
# 3. 如果文件存在，它会将 '/data/adb/box/scripts/' 目录中的所有文件权限更改为可执行。
# 4. 执行 'start.sh' 脚本。
# 5. 如果未找到 'start.sh' 脚本，它会打印错误信息。

(
    until [ $(getprop init.svc.bootanim) = "stopped" ]; do
        sleep 10
    done

    if [ -f "/data/adb/box/scripts/start.sh" ]; then
        chmod 755 /data/adb/box/scripts/*
        /data/adb/box/scripts/start.sh
    else
        echo "File '/data/adb/box/scripts/start.sh' not found"
    fi
)&