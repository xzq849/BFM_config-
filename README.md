# Box for Root config
<h1>检测DNS泄露情况</h1>

<br>检测DNS泄露情况<br>
<br>https://www.browserscan.net/zh/dns-leak<br>
<p align="center">
    <a href="https://github.com/LIghtJUNction/box_for_magisk_config-bfmc-/blob/master/box/clash/config.yaml">
    <img src="https://github.com/zhanyeye/clash-rules-lite/actions/workflows/release.yml](https://github.com/LIghtJUNction/box_for_magisk_config-bfmc-/blob/master/box/clash/config.yaml)/badge.svg" />
    </a>
</p>


# 更新记录
<br>v1.0 可以运行<br>
<br>v2.0 初步解决了DNS泄露问题<br>
<br>v3.0 重新排布拉了一下并且删除多余部分<br>

<br>先刷入模块，然后替换config重启，在管理器中查看和管理<br>

# 为什么创建这个项目
<br>每次打开手机Gemini语音助手显示你当前地区不支持，让我很烦，官方配置功能又不能满足我的要求。于是我花了一下午开始自己编写，顺便发布出来给有相同需求的人使用，如果你还有什么好点子欢迎提出。规则来自另一个项目<br>https://github.com/Loyalsoldier/clash-rules<br> <br>

[![ID](https://img.shields.io/badge/id-blue.svg?style=for-the-badge)](docs/index_id.md) [![EN](https://img.shields.io/badge/en-blue.svg?style=for-the-badge)](docs/index_en.md) [![CN](https://img.shields.io/badge/cn-blue.svg?style=for-the-badge)](docs/index_cn.md)

<h1 align="center">
  <img src="https://github.com/LIghtJUNction/box_for_magisk_config-bfmc-/releases/download/v1.0/like.this.jpg" alt="BOX" width="200">
  <br>如图所示，如果自动下载出现问题可以试试<br>
</h1>

<h1 align="center">
  <img src="https://github.com/LIghtJUNction/box_for_magisk_config-bfmc-/releases/download/v2.0/test.jpg" alt="BOX" width="200">
  <br>测试对比结果<br>
</h1>
<h4 align="center">Transparent Proxy for Android(root)</h4>


## Apk Manager
BFR Manager [Download](https://github.com/taamarin/box.manager) optional
> note: notifications will appear continuously, to fix this open Magisk Manager, Click SuperUser, search BoxForRoot, disable logs and notifications 

## Module Directory
MODDIR=/data/adb/box
MODLOG=/data/adb/box/run
SETTINGS=/data/adb/box/settings.ini
> notes: before editing the file **/data/adb/box/settings.ini**, make sure BFR is turned off

## Manage service start / stop
The following core services are collectively referred to as BFR

BFR service is auto-run after system boot up by default.
You can use Magisk/KernelSU Manager App to manage it. Starting the service may take a few seconds, stopping it may take effect immediately.

> notes: if it doesn't work you can use the command:
```bash
# start
su -c /data/adb/box/scripts/box.service start &&  su -c /data/adb/box/scripts/box.iptables enable

# stop
su -c /data/adb/box/scripts/box.iptables disable && su -c /data/adb/box/scripts/box.service stop
```

## Credits
- [CHIZI-0618/box4magisk](https://github.com/CHIZI-0618/box4magisk)
