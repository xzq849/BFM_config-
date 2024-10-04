#!/system/bin/sh

SKIPUNZIP=1
SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=false
LATESTARTSERVICE=true

if [ "$BOOTMODE" != true ]; then
  abort "-----------------------------------------------------------"
  ui_print "! Please install in Magisk/KernelSU/APatch Manager -- 请在root管理器中安装"
  ui_print "! Install from recovery is NOT supported --不支持从recovery安装"
  abort "-----------------------------------------------------------"
elif [ "$KSU" = true ] && [ "$KSU_VER_CODE" -lt 10670 ]; then
  abort "-----------------------------------------------------------"
  ui_print "! Please update your KernelSU and KernelSU Manager -- 请更新你的管理器！"
  abort "-----------------------------------------------------------"
fi

# if [ "$API" -lt 28 ]; then
  # ui_print "! Unsupported sdk: $API"
  # abort "! Minimal supported sdk is 28 (Android 9)"
# else
  # ui_print "- Device sdk: $API"
# fi

service_dir="/data/adb/service.d"
if [ "$KSU" = "true" ]; then
  ui_print "- kernelSU version: $KSU_VER ($KSU_VER_CODE)"
  [ "$KSU_VER_CODE" -lt 10683 ] && service_dir="/data/adb/ksu/service.d"
elif [ "$APATCH" = "true" ]; then
  APATCH_VER=$(cat "/data/adb/ap/version")
  ui_print "- APatch version: $APATCH_VER"
else
  ui_print "- Magisk version: $MAGISK_VER ($MAGISK_VER_CODE)"
fi

mkdir -p "${service_dir}"

if [ -d "/data/adb/modules/box_for_magisk" ]; then
  rm -rf "/data/adb/modules/box_for_magisk"
  ui_print "- Old module deleted. 删除旧模块"
fi

ui_print "- Installing Box for Magisk/KernelSU/APatch --安装中......"
unzip -o "$ZIPFILE" -x 'META-INF/*' -x 'webroot/*' -d "$MODPATH" >&2

if [ -d "/data/adb/box" ]; then
  ui_print "- Backup box"
  temp_bak=$(mktemp -d "/data/adb/box/box.XXXXXXXXXX")
  temp_dir="${temp_bak}"
  mv /data/adb/box/* "${temp_dir}/"
  mv "$MODPATH/box/"* /data/adb/box/
  backup_box="true"
else
  mv "$MODPATH/box" /data/adb/
fi

ui_print "- Create directories"
mkdir -p /data/adb/box/
mkdir -p /data/adb/box/run/
mkdir -p /data/adb/box/bin/xclash/

ui_print "- Extract the files uninstall.sh and box_service.sh into the $MODPATH folder and ${service_dir} -- 将文件uninstall.sh和box_service.sh提取到$MODPATH文件夹和${service_dir}文件夹中"
unzip -j -o "$ZIPFILE" 'uninstall.sh' -d "$MODPATH" >&2
unzip -j -o "$ZIPFILE" 'box_service.sh' -d "${service_dir}" >&2

ui_print "- Setting permissions -- 设置权限"
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm_recursive /data/adb/box/ 0 3005 0755 0644
set_perm_recursive /data/adb/box/scripts/  0 3005 0755 0700
set_perm ${service_dir}/box_service.sh  0  0  0755
set_perm $MODPATH/uninstall.sh  0  0  0755
set_perm /data/adb/box/scripts/  0  0  0755

# fix "set_perm_recursive /data/adb/box/scripts" not working on some phones.
chmod ugo+x ${service_dir}/box_service.sh
chmod ugo+x $MODPATH/uninstall.sh
chmod ugo+x /data/adb/box/scripts/*

ui_print "-----------------------------------------------------------"
ui_print "- Do you want to download Kernel(xray hysteria clash v2fly sing-box) and GeoX(geosite geoip mmdb)? size: ±100MB.--下载内核（xray+hysteria+clash+sing-box）和GeoX（geosite+geoip+mmdb）"
ui_print "- Make sure you have a good internet connection.--确保有良好的网络连接"
ui_print "- [ Vol UP(+): Yes ] -- 按音量上（+）键下载内核（xray+hysteria+clash+sing-box）和GeoX（geosite+geoip+mmdb）（与当前定制版不兼容）"
ui_print "- [ Vol DOWN(-): No ] -- 按音量下（-）键取消下载（已经内置）"

START_TIME=$(date +%s)
while true ; do
  NOW_TIME=$(date +%s)
  timeout 1 getevent -lc 1 2>&1 | grep KEY_VOLUME > "$TMPDIR/events"
  if [ $(( NOW_TIME - START_TIME )) -gt 9 ] ; then
    ui_print "- No input detected after 10 seconds -- 10秒后没有输入"
    break
  else
    if $(cat $TMPDIR/events | grep -q KEY_VOLUMEUP) ; then
      ui_print "- It will take a while.... -- 祝你好运，下载中...记得改下config文件..你干脆去下载原版吧"
      /data/adb/box/scripts/box.tool all
      break
    elif $(cat $TMPDIR/events | grep -q KEY_VOLUMEDOWN) ; then
      ui_print "- Skip download Kernel and Geox --欢迎使用本模块！马上就绪"
      break
    fi
  fi
done

if [ "${backup_box}" = "true" ]; then
  ui_print "- Restore configuration xray, hysteria, clash, sing-box, and v2fly -- 恢复配置文件，xray,clash,sing-box,v2fly"
  restore_config() {
    config_dir="$1"
    if [ -d "${temp_dir}/${config_dir}" ]; then
      cp -rf "${temp_dir}/${config_dir}/"* "/data/adb/box/${config_dir}/"
    fi
  }

  restore_config "clash"
  restore_config "xray"
  restore_config "v2fly"
  restore_config "sing-box"
  restore_config "hysteria"

  restore_kernel() {
    kernel_name="$1"
    if [ ! -f "/data/adb/box/bin/$kernel_name" ] && [ -f "${temp_dir}/bin/${kernel_name}" ]; then
      ui_print "- Restore ${kernel_name} kernel -- 恢复${kernel_name}内核"
      cp -rf "${temp_dir}/bin/${kernel_name}" "/data/adb/box/bin/${kernel_name}"
    fi
  }

  restore_kernel "curl"
  restore_kernel "yq"
  restore_kernel "xray"
  restore_kernel "sing-box"
  restore_kernel "v2fly"
  restore_kernel "hysteria"
  restore_kernel "xclash/mihomo"
  restore_kernel "xclash/premium"

  ui_print "- Restore logs, pid and uid.list -- 恢复日志，pid和uid.list"
  cp "${temp_dir}/run/"* "/data/adb/box/run/"
fi

if [ -z "$(find /data/adb/box/bin -type f)" ]; then
  sed -Ei 's/^description=(\[.*][[:space:]]*)?/description=[ 😱 Module installed but you need to download Kernel(xray hysteria clash v2fly sing-box) and GeoX(geosite geoip mmdb) manually ] /g' $MODPATH/module.prop
fi

if [ "$KSU" = "true" ]; then
  sed -i "s/name=.*/name=Box for KernelSU/g" $MODPATH/module.prop
  unzip -o "$ZIPFILE" 'webroot/*' -d "$MODPATH" >&2
elif [ "$APATCH" = "true" ]; then
  sed -i "s/name=.*/name=Box for APatch/g" $MODPATH/module.prop
  unzip -o "$ZIPFILE" 'webroot/*' -d "$MODPATH" >&2
else
  sed -i "s/name=.*/name=Box for Magisk/g" $MODPATH/module.prop
fi

ui_print "- Delete leftover files -- 删除临时文件"
rm -rf /data/adb/box/bin/.bin
rm -rf $MODPATH/box
rm -f $MODPATH/box_service.sh

ui_print "- Installation is complete, reboot your device -- 安装完成，重启设备"


# 下面是我的自定义执行的部分，欢迎来学习如何跳转至其他应用执行操作

start(){
pkg="$1"

if [ -n "$pkg" ];then
r=$(am start -d "$url" -p "$pkg" -a android.intent.action.VIEW 2>&1)
else
r=$(am start -d "$url" -a android.intent.action.VIEW 2>&1)
fi
echo "$r" | grep -q -v "Error"
return $?
}

loc=$(getprop persist.sys.locale)

if echo "$loc" | grep -q "zh" && echo "$loc" | grep -q "CN"; then
url="https://github.com/LIghtJUNction/BFM_config-"
pkg1="com.github.android"
else
url="https://github.com/taamarin/box_for_magisk"
pkg1="com.github.android"
un_print "This module is for Chinese people , do you want to install ?" 
fi

start $pkg1 || start com.android.browser || start || abort "failed to install"

ui_print "来给我github点个star吧，谢谢！关注我的公众号/加入我的qq群/关注我的酷安号：LIghtJUNction/获取支持"