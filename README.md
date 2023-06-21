# Egg_Demo  

## 项目简介 

1、简介： 
*   使用Eggjs + Ouath2 + Swagger + Sequlize（ORM框架）实现注册登录的后端项目demo，数据库选用MySQL实现。
*   Eggjs: 一个基于Node.js的服务端框架
*   Ouath2：实现认证授权的协议，本项目中支持authorization_code（授权码登录）、password（密码登录）登录方式
*   Swagger: 本项目采用egg-swagger-doc作为swagger2的接口文档
*   Sequlize：本项目采用Sequlize实现对数据库的操作，数据库为mysql数据库

2、场景：
*   该项目为一般网站项目中必备功能（即包含全套的登录、注册，并选用流行的Ouath2开发）可作为二次开发使用。

## 所需环境

1、安装node v16.20.0及以上     
*   node下载： [node下载](https://nodejs.cn/download/)  
*   注意需要设置环境变量在path中

2、安装MySQL
*   MySQL下载： [MySQL下载](https://www.mysql.com/downloads/)
*   注意需要设置环境变量在path中

3、安装HeidSQL（连接SQL客户端，也可用Navicat、DBeaver等客户端工具）
*   HeidSQL下载：[HeidSQL下载](https://www.heidisql.com/download.php#google_vignette)

## 相关配套前端项目

*   本项目只更新注册登录这一块逻辑，会搭配[vue_login](https://github.com/lp970703/vue_login)项目一起更新，vue_login使用vue2开发的一套注册登录前端UI

## 相关学习文档

<!-- add docs here for user -->
*   node安装及官网：[node官网](https://nodejs.cn/) 

*   egg官网快速开始：[egg 官网](https://www.eggjs.org/zh-CN/)

*   swagger相关：[swagger-jsdoc](https://github.com/Surnet/swagger-jsdoc) 

*   sequlize相关：[sequlize官网](https://www.sequelize.cn/)  

*   ouath2相关：[egg搭建ouath2](https://www.jianshu.com/p/1fe043a700bf)

## 项目启动

1、配置数据库（配置数据库前先根据npm install）：

*   将sqldata中的最新版ouath.sql导入到HeidSQL中
*   ctrl+F搜索，将数据库名字重命名（将"chat_work"全部替换自己项目的名字），修改完成后运行
    ![](https://github.com/lp970703/egg-demo/raw/master/app/public/%E6%9C%AC%E5%9C%B0sql%E6%96%87%E4%BB%B6%E5%8A%A0%E8%BD%BD%E5%88%B0HeidSQL%E6%88%AA%E5%9B%BE.png)
*   回到项目中去，修改config.default.js数据库连接的信息，修改config.sequelize对象
*   新建.sequelizerc（项目若有就不用新建了），并修改生成model的位置
*   运行下面代码，初始化Migrations 配置文件和目录

```bash
    npx sequelize init:config
    npx sequelize init:migrations
```
*   运行代码后会生成database文件夹，找到该文件夹下的config.json后修改连接数据库的信息，分别对应开发环境、测试环境、生产环境
*   修改package.json中下面代码，分别修改-o(将数据库的表反向生成model的地址),-h(ip地址),-p(端口号),-d(数据库名称),-u(数据库连接账号),-x(数据库连接密码),-e(数据库类型)
```bash
    "dev_db": "egg-sequelize-auto -o ./app/model -h 127.0.0.1 -p 3306 -d chat_work -u root -x lupeng0703 -e mysql",
    "test_db": "egg-sequelize-auto -o ./app/model -h 127.0.0.1 -p 3306 -d dev_db -u root -x 111111 -e mysql",
    "pord_db": "egg-sequelize-auto -o ./app/model -h 127.0.0.1 -p 3306 -d dev_db -u root -x 111111 -e mysql"
```
*   运行npm run dev_db则会在本地-o目录下生成model，生成后如果某些字段用到了sequelize对象，记得要引用该模块const sequelize = require('sequelize');

2、启动项目：

```bash
# 进入相关项目文件
$ cd xxx

# 安装依赖
$ npm install  

# 启动项目
$ npm run start

```
