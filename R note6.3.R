###6.3 HTTP协议

#互联网中进行网络通信的通用语言

#HTTP
#超文本传输协议
#hyper text transfer protocol

#默认端口80（详细看page310）

#HTTP就是浏览器或者爬虫工具接收网页HTML的口令

##6.3.1 略
#Page311 


##6.3.2 URL语法

#网址
#URL
#uniform resource locators
#统一资源定位符


#例：NBA中国官网
https://nbachina.qq.com/a/20170914/004815.htm
#NBA官网采用的模式就是HTTP

#总体的URL例子可以表示为：
scheme://hostname:port/path?querystring#fragment
#scheme表示URL的模式，它定义了浏览器和服务器之间通信所采用的协议
#hostname主机名，主机名提供了存放我们感兴趣资源的服务器的名字，它是一个服务器的唯一识别符
#port端口号，端口号一般默认为80
#主机名和端口号之后的路径用来确定被请求的资源在服务器上的位置，跟文件系统类似，也是用“/”符号来分段的

#另外，URL路径会提供很多补充信息
#比如通过类似"name=value"这样的查询字符串来获取更多的信息
#或者用“#”符号指向网页中特定的部分


#URL是通过ASCII字符集来实现编码的
#所有不在这个字符集中的字符和特殊字符串都需要转义编码为标准的表示法
#URL编码也被称为百分号编码
#因为每个这样的编码都是以“%”开头的


URLencode()
URLdecode()
#在R语言中，可以通过基础函数 URLencode()和URLdecode()函数来对字符串进行编码或者解码

#URL字符串的编码及解码
char = 'Golden states worries is the NBA champion in 2017'
URLencode(char, reserve = TRUE)
##  [1] "Golden%20states%20worries%20is%20the%20NBA%20champion%20in%202017"
URLdecode(char)
##  [1] "Golden states worries is the NBA champion in 2017"

##6.3.3 HTTP消息
#HTTP消息主要分为
#请求消息（即对服务器的请求）
#响应消息（即服务器做出的反馈）


#HTTP消息一般由
#起始行(start line)、标头/消息报头(headers)、正文(body)
#三部分组成

#具体看Page314

#在请求模式中，最常用的请求方法是GET和POST方法

getForm() #RCurl包提供了一些高级函数来执行GET请求
postForm()#POST请求，具体看page315

#常见的HTTP请求方法
GET 从服务器检索资源
POST 利用消息向服务器发送数据，然后从服务器检索资源
HEAD 从服务器检索资源，但只响应起始行和标头
PUT 将请求的正文保存在服务器上
DELETE 从服务器删除一个资源
TRACE 追踪消息到达服务器沿途的路径
OPTIONS 返回支持的HTTP方法清单
CONNECT 建立一个网络连接


#浏览器发送请求后，服务器需要对其进行响应，会在响应的起始行发回一个状态码
#“404”表示服务器无法找到资源的响应状态码
#“200”表示请求成功


#常见的HTTP状态码
1xx: 指示信息，表示请求已接收，继续处理
2xx: 成功，表示请求已被成功接收、理解、接受
3xx: 重定向，要完成请求必须进行进一步操作
4xx: 客户端错误，请求有语法错误或请求无法实现
5xx: 服务器端错误，服务器未能实现合法的请求


#一般来说，200表示成功找到资源，404表示未找到资源，
#500表示服务器内部错误，502表示错误网关等。








