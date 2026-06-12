## 注意：项目不再维护
> 因项目时间久远，所涉及的技术已过于陈旧，加上本人已没有精力在本项目上进行更新，现决定归档本项目，大家可以使用其他替代项目。
>
> 如您还需要继续使用本项目，目前最好的方式是在 Docker 里使用 2.94 版本，然后设定环境变量指定WebUI，具体可参考（https://www.cnblogs.com/ronggang/p/18788723 ）；或者使用其他已集成的项目。
>
> 感谢大家长期以来的支持。
> 
> 2025.06.01 栽培者 

----

<p align="center">
<img src="https://github.com/ronggang/transmission-web-control/raw/master/src/tr-web-control/logo.png"><br/>
<a href="https://github.com/ronggang/transmission-web-control/releases" title="GitHub Releases"><img src="https://img.shields.io/github/release/ronggang/transmission-web-control.svg"></a>
<img src="https://img.shields.io/badge/transmission-%3E=2.40%20(RPC%20%3E14)-green.svg" title="Support Transmission Version">
<a href="https://github.com/ronggang/transmission-web-control/LICENSE" title="GitHub license"><img src="https://img.shields.io/github/license/ronggang/transmission-web-control.svg"></a>
<a href="https://t.me/transmission_web_control"><img src="https://img.shields.io/badge/Telegram-Chat-blue.svg?logo=telegram" alt="Telegram"/></a>
</p>

----
## [English Introduction](https://github.com/ronggang/transmission-web-control/wiki)

## 国内镜像源
- https://gitee.com/culturist/transmission-web-control

## 关于
本项目主要目的是想加强[Transmission](https://www.transmissionbt.com/) Web的操作能力，本项目原本在[Google Code](https://code.google.com/p/transmission-control/)托管，现迁移至GitHub。
本项目设计之初仅针对PT站，因此增加了 Tracker 服务器分组及状态，但这不并适用于普通BT种子。

另外，本项目仅为一套自定义的WebUI，不能代替 Transmission 工作，用户需要自行安装 Transmission 后才可正常使，Transmission 安装方法请移步至官网：https://www.transmissionbt.com/

## 界面预览
![screenshots](https://user-images.githubusercontent.com/8065899/38598199-0d2e684c-3d8e-11e8-8b21-3cd1f3c7580a.png)

## 安装方法及更多内容，请参考：[中文帮助](https://github.com/ronggang/transmission-web-control/wiki/Home-CN) 
### DSM7.0
在这个版本中，需要额外修改权限以实现自动更新的功能
在 `root` 权限下执行以下命令，其中：
 - `YOUR_USERNAME` 替换为你登录和更新脚本时候选择的用户
 - `/var/packages/transmission/target/share/transmission/web/` 这串路径为 transmission 的安装路径（默认应该是这个）
```shell
sed -i '/sc-transmission/s/$/YOUR_USERNAME/' /etc/group
chown sc-transmission:sc-transmission /var/packages/transmission/target/share/transmission/web/* -R
chmod 774 /var/packages/transmission/target/share/transmission/web/* -R
```

## 开发说明

### 目录结构
项目的 JS 源文件位于 `src/tr-web-control/script/`，但 `src/index.html` 实际加载的是 `src/tr-web-control/script/min/` 下的压缩版本。两个目录的对应关系如下：

| 源文件 | 压缩文件（实际加载） |
|--------|---------------------|
| `script/transmission.js` | `script/min/transmission.min.js` |
| `script/transmission.torrents.js` | `script/min/transmission.torrents.min.js` |
| `script/system.js` | `script/min/system.min.js` |
| `script/FileSaver.js` | `script/min/FileSaver.min.js` |
| `script/public.js` | `script/min/public.min.js` |
| `script/system.mobile.js` | `script/min/system.mobile.min.js` |

### ⚠️ 修改代码后必须同步 min 文件

修改 `script/*.js` 源文件后，**必须**将改动同步到对应的 `min/` 文件，否则浏览器不会加载最新代码。

需要先安装 `uglify-js`：
```bash
npm install -g uglify-js
```

然后执行以下命令压缩并同步：
```bash
cd src/tr-web-control/script
uglifyjs transmission.js          -o min/transmission.min.js          -c -m
uglifyjs transmission.torrents.js -o min/transmission.torrents.min.js -c -m
uglifyjs system.js                -o min/system.min.js                -c -m
```

### 打包发布

项目根目录提供了 `build.sh` 打包脚本，会自动完成压缩、剔除冗余源文件、打包三步：

```bash
bash build.sh
```

执行后在项目根目录生成 `transmission-web-control.tar.gz`，解压后将内容部署到 Transmission 的 web 目录即可。

## 更新日志 [查看](https://github.com/ronggang/transmission-web-control/blob/master/CHANGELOG.md)

## 项目日常维护
* 栽培者
* DarkAlexWang
