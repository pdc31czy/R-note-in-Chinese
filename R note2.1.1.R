#2.1.1基本数据类型

class()
#显示一个数据对象的数据类型

as.factor()
#把其他类型数据转换成因子型

as.character()
#把其他类型数据转换成字符型

is.character()
#查看数据类型是否为字符型，同理is.factor()

object.size()
#观察数据大小

#(一)
#数值型（numeric）
a=2; class(a)
#R会把所有超过电脑存储限制的数字当作正无穷，这个限制大约为1.8*10^38
#一旦算式中有正无穷或者负无穷的子项出现，结果就会是无穷或者是NaN（Not a Number）的数
exp(1000)#正无穷
-10/0#负无穷
exp(990)#正无穷
exp(1000)/exp(990)#NaN类型，原本应该是exp（10），但是由于子项都是正无穷

#（二）
#字符型（character）
a="2"
class(a)

b="想你"
class(b)

"1"+"1" 
#错误，non-numeric argument to binary operator

#（三）
#逻辑性（logical）
#TRUE FALSE
#在R中，TRUE对应数字1，FALSE对应数字0
TRUE+FALSE
TRUE>FALSE

#（四）
#因子型数据（factor）
(genders = factor(c("男","女","女","男","男")))
is.factor(genders)
class(genders)

#改变因子型数据各水平的编码顺序
(class=factor(c("Poor","Improved","Excellent"),ordered = T, levels =c("Poor","Improved","Excellent")))

#什么时候需要把字符型数据转换成因子型数据呢？
#定性变量和定序变量
#如：在作图中需要对数据分组，用来分组的变量就应该变成因子型
#如：需要做包含定性变量的回归模型，定性变量就要变成因子型进入模型

#（五）
#时间型数据（Date/POSIXct/POSIXlt)
#以字符串形式输入R中
#Date日期数据，它不包括时间和时区信息
#POSIXct/POSIXlt类型数据，包括日期、时间和时区信息

#Date自动识别以斜杠(2020/12/22)和短横线（2022-12-22）
#用as.Date()转换
#例：
moviedate="2020/12/22"
class(moviedate)
##[1] "character"
moviedate=as.Date(moviedate)
moviedate
##[1] "2020-12-22"
class(moviedate)
##[1] "Date"

#日期格式示意表（《R语言：从数据思维到数据实战》 Page49）
x<-c("1Jan1960","31mar1978")
y<-as.Date(x)
##Error in charToDate(x) : 字符串的格式不够标准明确
y<-as.Date(x,"%d%b%Y")
y
##[1] "1960-01-01""1978-03-31"

dates <- c("02/27/92", "02/27/92")
as.Date(dates, "%m/%d/%y")
##[1] "1992-02-27" "1992-02-27" 

#POSIXct/POSIXlt是精确到秒级的时间戳
#as.POSIXct()
as.POSIXct("2020-12-22 14:05:31")
##[1] "2020-12-22 14:05:31 CST"
as.POSIXct("December-22-2020 14:05:31")
##Error in as.POSIXlt.character(x, tz, ...) : 字符串的格式不够标准明确
as.POSIXct("December-22-2020 14:05:31", format = "%B-%d-%Y %H:%M:%S")
##[1] "2020-12-22 14:05:31 CST"

#format()可以用来更改时间数据的输出格式
#例：
(n=c("2016-03-14","2016-02-08")) #原始日期数据
m<-as.Date(n)
class(m)
##[1] "2016-03-14" "2016-02-08"

format(m,format = "%B %d %Y") #改成月日年的格式
##[1] "三月 14 2016" "二月 08 2016"

format(m,format = "%B %d %Y %A") #加入星期的信息
##[1] "三月 14 2016 星期一" "二月 08 2016 星期一"

format(m,format = "%B") #只提取月份的信息
##[1] "三月" "二月"

Sys.time() #输出系统时间
##[1] "2020-12-22 14:30:19 CST"

class(Sys.time()) #查看时间类型
##[1] "POSIXct" "POSIXt" 

format(Sys.time(),format="%B %d %Y") #提取部分时间信息
##[1] "十二月 22 2020"

format(Sys.time(),format = "%Y %B %a %H:%M:%S") #提取部分时间信息
##[1] "2020 十二月 周二 14:37:21"

#lubridate是一款专门高效处理时间数据的包
#主要有两类函数
#一类处理时点数据
#另一类处理时段数据
#例：
library(lubridate) #加载包
#额外备注：require()和library()都可以加载包，当加载一个不未下载的包时：require()会发出警告但继续执行程序，如果将其赋值给X<-require("xixihaha"),查看X可知返回了FALSE；而library()则会终止运行程序，并报错。因此，写R程序的常用技巧为（举例）：
#额外备注：if(!require("cluster")) install.packages("cluster")
#额外备注：library(cluster)

x= c(20090101,"2009-01-02","2009 01 03","2009-1-4","2009-1,5","Created on 2009 1 6", "200901 !!! 07")
ymd(x)
##[1] "2009-01-01" "2009-01-02" "2009-01-03" "2009-01-04" "2009-01-05" "2009-01-06" "2009-01-07"

mday(as.Date("2020-12-22")) #Get/set days component of a date-time
##[1] 22

wday(as.Date("2020-12-22")) #Get/set days component of a date-time
##[1] 3

hour(as.POSIXct("2020-12-22 14:30:19")) #Get/set hours component of a date-time
##[1] 14

minute(as.POSIXct("2020-12-22 14:30:19")) #Get/set minutes component of a date-time
##[1] 30

#时间型数据的操作
#1、做差
begin=as.Date("2019-11-21")
end=as.Date("2020-12-22")

#方法一：直接相减
#求任意两个距离的天数
(during=end-begin)
##Time difference of 397 days

#方法二：或者用difftime（）函数提取
#求任意两个日期距离的天数、周数和小时数
difftime(end,begin,units="days")
##Time difference of 397 days
difftime(end,begin,units="weeks")
##Time difference of 56.71429 weeks
difftime(end,begin,units="hours")
##Time difference of 9528 hours

#2、排序
#sort()  #将向量重新排序
#order() #返回一个向量升序排序后的数字在原数据中的位置
#具体看Page52


#################################
#总结#

class() #显示一个数据对象的数据类型
as.factor() #把其他类型数据转换成因子型
as.character() #把其他类型数据转换成字符型
is.character() #查看数据类型是否为字符型，同理is.factor()
object.size() #观察数据大小
as.Date() #Date自动识别以斜杠(2020/12/22)和短横线（2022-12-22）
format() #用来更改时间数据的输出格式
as.POSIXct() #POSIXct/POSIXlt是精确到秒级的时间戳
Sys.time() #输出系统时间
require() #加载包
library(lubridate) #加载包 #lubridate是一款专门高效处理时间数据的包
ymd(x) #library(lubridate)
mday(as.Date("2020-12-22")) #Get/set days component of a date-time
wday(as.Date("2020-12-22")) #Get/set days component of a date-time
hour(as.POSIXct("2020-12-22 14:30:19")) #Get/set hours component of a date-time
minute(as.POSIXct("2020-12-22 14:30:19")) #Get/set minutes component of a date-time
difftime() #求任意两个日期距离的天数、周数和小时数

################################








