#看看有哪些包
search()

#从Github里下载包
library(devtools)
install_github("gaborcsardi/praise") 
#gaborcsardi 是GitHub的作者名字,praise 是包的名称

#更新包
update.packages()

#调用包，其中一个就可
library("package_name")
require("package_name")

#寻找一个好包
# http://cran.r-project.org/web/views/
# http: // www.crantastic.org/popcon

#包的使用方法
help(package = "package_name")

#查看某个函数的使用样例
demo("function_name")

#想看某些统计方法及数据操作的样例
# http :// www.statmethods.net/index.html

#read.csv() 读入csv格式数据的函数
read.csv file header = TRUE 
#参数file用来输入要读入的文件名
#header用来告诉电脑是否把读入文件的第一行识别为变量名，而不是数据

#例子:读入一张存有“全国各省份与东西部地区对应数据”的表格
#westeast=read.csv("Province_Section.csv",header = T)错了
#正确的是
westeast=read.csv("Province_Section.csv",header=T,fileEncoding = "GBK")
head(westeast)
#将参数fileEncoding设置为能够读取汉语的编码方式，比如“GBK”

