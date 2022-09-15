###6.2 XML与XPath表达式以及R爬虫应用

##6.2.1 XML
#XML
#可扩展标记语言
#eXtensible markup language

#和HTML不同的是，
#XML是被设计用来传输和存储数据的
#“网络数据交换最流行格式”

#看page304的代码sample

#一个XML文档永远以声明该文档属性的一行代码来开头
## <?xml version="1.0" encoding="ISO-8859-1"?>
#version = "1.0" 用来声明该XML文档的版本号，目前有1.0和1.1两个版本
#encoding="ISO-8859-1"用来声明编码格式

#XML文档必须有一个根元素，这个根元素包裹了整个文档

# https://www.xml.com/

#参考XML官网查看注释、特殊字符命名、事件驱动等细节知识




##6.2.2 如何在R语言中解析XML

#XML文件的符号序列会被读取并从元素中创建层次化的C语言树形数据结构
#这个数据结构会通过处理器翻译为R语言的数据结构

xmlParse()#解析XML

#例：
library(XML)
nbadata = xmlParse(file = "./nbaplayer.xml")
nbadata

##  <?xml version="1.0" encoding="ISO-8859-1"?>
##  <nbaplayer>
##    <team>
##      <city name="houston"> rockets</city>
##      <player> james harden</player>
##    </team>
##    <team>
##      <city name="boston"> celtics</city>
##      <player> kyrie irving</player>
##    </team>
##    <team>
##      <city name="goldenstates"> worriors</city>
##      <player> stephen curry</player>
##    </team>
##  </nbaplayer>
##  






##6.2.3 XPath表达式

#提取HTML和XML中的数据信息
#查询标记语言的方法

#Xpath表达式就是选取XML或者HTML文件中节点的方法
#节点就是XML/HTML文档中的元素

#XPath通过路径表达式(path expression)来选择节点信息
#跟文件系统路径一样使用"/"符号来分割路径

nodename:选择该节点的所有子节点
"/":选择根节点
"//":选择任意节点
"@":选择属性

#install.packages(rvest)
library(rvest) #利用rvest包提取信息

# install.packages(xml2)
library(xml2)

# install.packages(dplyr)
library(dplyr)

read_html('http://movie.douban.com/subject/26862829/') %>% html_nodes(xpath = "//h1//span")
##  {xml_nodeset (2)}
##  [1] <span property="v:itemreviewed">芳华</span>
##  [2] <span class="year">(2017)</span>




##6.2.4 SelectorGadget 自动生成XPath表达式

#Chrome插件：SelectorGadget
#快速定位节点信息的CSS选择器插件
#方便快捷地生成网页中想要提取的信息的XPath表达式

#怎么下载和使用看page309



