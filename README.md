# Box for Root config

## 快速介绍🚀️

> [副规则集合来源](https://github.com/xkww3n/Rules)每天12：00更新

> [主要ruleset来源](https://github.com/Loyalsoldier/clash-rules)每天6：30更新

> [Geo数据库来源](https://github.com/DustinWin/ruleset_geodata?tab=readme-ov-file)每天2：00更新

DIY规则在我右上角的DIY规则库里，正在施工中...............

运行action即可及时更新规则

[点击我检测DNS泄露情况](https://www.browserscan.net/zh/dns-leak)


<p align="center">
    <a href="https://github.com/LIghtJUNction/box_for_magisk_config-bfmc-/blob/master/box/clash/config.yaml">
    <img src="https://github.com/LIghtJUNction/CONFIG_RULE_DIY/actions/workflows/hiclick%20me(config).yml/badge.svg" />
    </a>
    <h1>config.yaml</h1>
</p>


# 更新记录🎉️

0.1.5 --- 修改ksu内置网页为yacd 以及同步上游更新

0.1.4 --- 同步上游更新

... --- 初始化版本

# 使用教程👀️

刷入模块，选择否即可  否则考虑到国内网络环境，大概率下载失败--目前仅针对mihomo内核适配

其他设置 进入[yacd](https://yacd.haishan.me/)网站设置

查询我的公众号：lightjunction 获取提示 -- -- 新项目！[公众号接入ai实现ai 全程免费]()

[酷安链接🔗](https://www.coolapk.com/feed/56727271?shareKey=NzU4YjA5ZTZlMDhkNjY3ODg0Njc~&shareUid=17845477&shareFrom=com.coolapk.market_14.2.3)

```
short.weixin.qq.com
dns.weixin.qq.com.cn
long.weixin.qq.com
```

~~这三个走代理即可让微信走fcm推送~~

##### 为什么创建这个项目

> 每次打开手机Gemini语音助手显示你当前地区不支持，让我很烦，官方配置功能又不能满足我的要求。于是我花了一下午开始自己编写，顺便发布出来给有相同需求的人使用，如果你还有什么好点子欢迎提出。规则来自另一个项目

# 亲测可以使用chatgpt手机版！

经过我的测试catgpt手机版会检测以下

* 1.手机是否开启vpn软件----有两种方法，使用lsp模块hook掉chatgpt，屏蔽其对vpn的检测----二，使用本模块开启tun模式，tun模式更底层，chatgpt包括银行类软件不会检测
* 2.手机的dns泄露情况，这里解决方案就是修改配置，注意！请使用[点击我检测DNS泄露情况](https://www.browserscan.net/zh/dns-leak)网站检测里面出现的国家是否为同一个国家，如果不是，请去yacd网站-可以从ksu的内置网页打开--修改代理组--确保一致且非国内即可

# 鸣谢

[BOX_FOR_ROOT](https://github.com/taamarin/box_for_magisk) -- 上游项目

以及以下的规则集

> [副规则集合来源](https://github.com/xkww3n/Rules)每天12：00更新

> [主要ruleset来源](https://github.com/Loyalsoldier/clash-rules)每天6：30更新

> [Geo数据库来源](https://github.com/DustinWin/ruleset_geodata?tab=readme-ov-file)每天2：00更新
>





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
