###6.6 R语言爬虫实战

#R爬虫的两个包
#RCurl，rvest

#爬虫是一项系统性工程（“抓”“析”“存”）
#1.如何通过软件与网页进行通信
#2.下载解析网页
#3.从网页中提取目标信息
#4.将抓取到的数据存入本地数据库


##6.6.1 静态网页数据抓取利器-- rvest

#rvest数据抓取的几个核心函数：
read_html(): 下载并解析网页
html_nodes(): 定位并获取节点信息
html_text(): 提取节点属性文本信息

#例：
## 抓取某网页二手房数据 ##
# 加载所需的包
library("xml2")
library("rvest")
library("dplyr")
library("stringr")

# 对爬取页数进行设定并创建数据框
i = 1:100
house_inf = data.frame()

# 利用for循环封装爬虫代码，进行批量抓取
for (i in 1:100) {
  # 发现url规律，利用字符串函数进行url拼接并规定编码
  web = read_html(str_c("http://hz.lianjia.com/ershoufang/pg", i), encoding = "UTF-8")
  # 提取房名信息
  house_name = web %>% html_nodes(".houseInfo a") %>% html_text()
  # 提取房名基本信息并消除空格
  house_basic_inf = web %>% html_nodes(".houseInfo") %>% html_text()
  house_basic_inf = str_replace_all(house_basic_inf, " ", "")
  # 提取二手房地址信息
  house_address = web %>% html_nodes(".positionInfo a") %>% html_text()
  # 提取二手房总价信息
  house_totalprice = web %>% html_nodes(".totalPrice") %>% html_text()
  # 提取二手房单价信息
  house_unitprice = web %>% html_nodes(".unitPrice span") %>% html_text()
  # 创建数据框存储以上信息
  house = data.frame(house_name, house_basic_inf, house_address, house_totalprice, house_unitprice)
  house_inf = rbind(house_inf, house)
}

# 将数据写入csv文档
write.csv(house_inf, file = "./house_inf.csv")


#效果看page334，这里定位HTML节点信息时使用了selectorGadget选择器



##6.6.2 httr包实现对网页动态加载数据的抓取

#httr包相当于RCrul的精简版

#httr包与RCurl的核心函数对比表，page335


#例：
# install.packages(httr)
library(httr)
cookie = ""
headers = c('Accept' = 'application/json',
            'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36',
            'Referer' = 'http://study.163.com/courses',
            'edu-script-token' = '1c1f84a1b85a48aba8a4d440552f5f69',
            'Connection' = 'keep-alive',
            'Cookie' = cookie)
# 构造参数信息
payload = list('pageIndex' = 1, 'pageSize' = 50, 'relativeOffset' = 0,'frontCatgoryId' = '-1')

# 二次请求的实际url
url = "http://study.163.com/p/search/studycourse.json"
# POST方法执行单词请求
result = POST(url, add_headers(.headers = headers), body = payload, encode = "json")
result
##  Response [http://study.163.com/p/search/studycourse.json]
##    Date: 2018-08-01 06:52
##    Status: 200
##    Content-Type: application/json;charset=UTF-8
##    Size: 84.6 kB