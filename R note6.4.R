###6.4 AJAX与网页动态加载

#rvest包作为一款简单易用的R爬虫包，对静态网页的抓取非常适用
#但对于有些会“动”的网页来说，rvest就不再有效

#AJAX
#Asynchronous JavaScript and XML
#异步JacaScript和XML

#它是一组技术
#不同的浏览器有自己的AJAX实现组件



##6.4.1 从HTML到DHTML

#前端技术：HTML，CSS和JavaScript

#JavaScript
#最流行的Web编程脚本语言
#起到一些效果渲染的作用

#JavaScript对于HTML的三种改进方法
#（1）以HTML中的<script>标签为固定位置进行代码内嵌
#（2）对<script>元素中的src属性路径引用一个存放在外部的JavaScript代码文件
#（3）JavaScript代码直接出现在特定HTML元素属性里，也叫事件处理器


#DOM操作（文档对象模型）


##6.4.2 网页动态加载中数据的获取机制

#JavaScript将HTML变成DHTML
#XHR则将传统的HTTP协议同步请求通信变成异步发起HTTP请求

#异步通信支持在浏览器与Web服务器之间进行持续的信息交换的方法
#就是所谓的XHR(XML Http Request)


##6.4.3 使用Web开发者工具辅助动态爬取


#在浏览的网页上单击鼠标右键
#审查元素
#WDT(web development tools)界面

#元素(Elements)
#控制台(Console)
#来源(Sources)
#网络(Network)
#时间线(Timeline)
#远行概况(Profiles)
#安全(Security)
#审计(Audits)

#对于网络数据爬取，只需要关注 元素和网络 这两大面板

#元素面板包含网页HTML结构信息，
#对于查看特定的HTML代码及其在网页视图中对应的图形化表现之间的联系特别有用

#网络面板会提供实时的网络请求和下载的相关信息


#具体看书吧~~~Page320










