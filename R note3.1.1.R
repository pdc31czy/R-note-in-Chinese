#3.1.1基础描述分析
#如何画基本统计图形

#柱箱点、折直饼：
#柱状图、箱线图、散点图、折线图、直方图、饼图

#（1）描述一个变量还是两个变量或多个变量？
#（2）描述的变量是什么类型，是定性变量还是定量变量？



### 数据准备 ###
# 清空工作空间
rm(list = ls())
# 载入相关包及设定路径
# install.packages(plyr)
library(plyr)
# install.packages("reshape2")
library(reshape2)
# 读入数据
novel = read.csv("novel.csv", fileEncoding = "UTF-8")
# 数据查看与异常处理
head(novel)
novel$小说性质 = as.character(novel$小说性质)
novel = novel[novel$小说性质 != "", ]




#1、单变量作图

#(一)一个定性变量：如性别、国籍这类描述一个事物质的特性的变量，其取值只能是离散的
#如：男、女，中国、美国、英国
#描述一个定性变量的图形：柱状图、饼图

#1）柱状图：展示一个定性变量的频数分布，也可用来观察不同类别样本的分布
barplot(height,names.arg)#height是柱子的高度，names.arg是柱子的名称

#例：
### 单变量 ###

## 定性变量--柱状图 ##
a = table(novel$小说类型)
a = a[order(a, decreasing = T)]
barplot(a[1:5], names.arg = names(a)[1:5], col = rainbow(5, alpha = 0.4), xlab = "小说类型", ylab="频数")
#常用参数：
#names.arg可定义每个柱子的名字，即分类变量的类别名称
#col可定义柱子的颜色
#main可定义图标题
#rainbow()生成彩虹色
#alpha调节透明度

#2）饼图
pie(numerical_vector,labels)#numerical_vector是各类别的频数，labels是每块小饼的标签

#例1：
## 定性变量--饼图 ##
pie(c(4000, 3000, 2000, 1000), labels = c("北京", "天津", "上海", "广州"), main = "熊粉成员分布", col = 2:5)

#例2：
#画饼图常用技巧：合并小类、计算百分比、如何展示各块饼的标签

# 将小说类型进行简要合并
novel$'小说类别' = "其他"
novel$'小说类别'[novel$小说类型 == "都市小说" | novel$小说类型 == "职场小说"] = "都市类小说"
novel$'小说类别'[novel$小说类型 == "科幻小说" | novel$小说类型 == "玄幻小说" | novel$小说类型 == "奇幻小说"] = "幻想类小说"
novel$'小说类别'[novel$小说类型 == "武侠小说" | novel$小说类型 == "仙侠小说"] = "武侠类小说"
# 求出每一类所占百分比
ratio = table(novel$'小说类别') / sum(table(novel$'小说类别')) * 100
# 定义标签
label1 = names(ratio)
label2 = paste0(round(ratio, 2), "%")
# 画饼图
pie(ratio, col = heat.colors(5, alpha = 0.4), labels = paste(label1, label2, sep = "\n"), font = 1)

heat.colors()#“配色模板”，产生类红色的一组邻近色，适用于渐变色场景


#（二）单个定量变量：可以取连续数值的变量，如年龄、收入
#横截面数据（不同对象在该变量上的取值）、时间序列数据（一个变量在不同时期的取值）
#描述单个定量变量：直方图、折线图

#1）直方图：直观地展现数据的分布形态及异常值（针对横截面数据）

hist(x) #画出变量x的直方图
#hist()的常用参数：
#xlab设置直方图的横坐标题目
#ylab设置直方图的纵坐标题目
#breaks设置直方图的组数或分割点

#例：
## 定量变量--直方图 ##
novel$总字数 = novel$总字数 / 10000
par(mfrow = c(1, 2)) #实现一页多图的功能，这里是一行两列，一页两图
chara = sort(novel$总字数)[1:1500]  # 去掉异常值
hist(chara, breaks = 10, xlab = "总字数(万字)", ylab = "频数", main = "", col = "lightblue")
hist(chara, breaks = 100, xlab = "总字数(万字)", ylab = "频数", main = "", col = "lightblue")


#2）折线图：观察该指标随时间变化的趋势（针对时间序列的数据）

#1、如果数据已经是R中的某种数据格式，比如时间序列格式tz，直接采用plot(x)即可
plot(x) 

#例：
## 定量变量--折线图 ##
par(mfrow = c(1, 1))
# 画时间序列图
data(AirPassengers) #data()加载特定的dataset
head(AirPassengers)
##  [1] 112 118 132 129 121 135
class(AirPassengers)
##  [1] "ts"
plot(AirPassengers)


#2、如果数据仅仅是一个普通向量

#如果数据是年、月或者季度数据，采用tz()函数直接转换
tz()

#如果数据是天数据或者不等间隔的时序数据，选用zoo包生成
# install.packages(zoo)
library(zoo)
#生成时间序列数据需两步：
#一：设定好时间标签（如下面例子中的date）
#二：使用zoo()函数将时间标签及对应的数据“组合”在一起
#最后：直接采用plot()函数画出折线图

#例：
# 人民的名义百度搜索指数图

# 将搜索指数index变成时间序列格式
index = c(127910, 395976, 740802, 966845, 1223419, 1465722, 1931489, 2514324, 3024847, 3174056, 3208696, 3644736, 4198117, 3868350, 3576440, 3524784, 3621275, 3695967, 3728965, 3845193, 3525579, 3452680, 3535350, 3655541, 3884779, 3780629) / 10000
date = seq(as.Date("2017-3-28"), length = 26, by = "day")
people_index = zoo(index, date)
class(people_index)
##  [1] "zoo"
plot(people_index, xlab = "时间", ylab = "百度搜索指数（万）", main = "《人民的名义》搜索指数折线图")

axis() #通过参数tick和label_name自定义横轴显示时间的格式
#例：
# 更改坐标轴显示内容
plot(people_index, xaxt = "n", xlab = "时间", ylab = "百度搜索指数（万）", main = "《人民的名义》搜索指数折线图")
times = date #or directly times = x.Date
ticks = seq(times[1], times[length(times)], by = "weeks")  # month, weeks, year etc.
label_name = c("3月28日", "4月4日", "4月11日", "4月18日")
axis(1, at = ticks, labels = label_name, tcl = -0.3)




### 两个变量 ###

#（1）切分画板
par(mfrow=c(a,b)) #将画图的屏幕切分成a行b列个小格子


#1）定性与定量变量--分组箱线图
boxplot(y~x) #画分组箱线图，参数用“公式形式”，其中y是要对比的定量变量，x是分组变量
#表示将y按照x分组，分别画箱线图

#例：
# 将画板分成1行2列
par(mfrow = c(1, 2))  
# 不同性质的小说总点击数和评论数有差别吗
boxplot(log(总点击数) ~ 小说性质, data = novel, col = rainbow(2, alpha = 0.3), ylab = "总点击数对数")
boxplot(log(评论数) ~ 小说性质, data = novel, col = rainbow(2, alpha = 0.3), ylab = "总评论数对数")


#2) 两个定量变量--散点图
plot(x,y) #画散点图
#参数main为图加标题，text在图上添加文本，xlab、ylab设置坐标轴,col设置点的颜色，pch设定点的形状，cex设定符号的大小

#例：（想看看小说的总点击数和评论数有何关联）
# 将画板恢复
par(mfrow = c(1, 1))    
# 去除较大的异常值后画图
test = novel[novel$评论数 < 8000 & novel$总点击数 < 200000, ]
x = test$总点击数
y = test$评论数
plot(x, y, pch = 1, cex = 0.6, xlab = "总点击数", ylab = "评论数")

#假如散点图显示的相关程度并不高，可以把某个连续变量离散化（分组），变成定性变量
#例：
# 分组做分组箱线图
aa = cut(x, breaks = c(0, 50000, 100000, 150000, 200000), labels = c("(0-5w]", "(5w-10w]", "(10w-15w]", "(15w-20w]"))
boxplot(y ~ aa, col = rainbow(4, alpha = 0.4), xlab = "总点击数", ylab = "评论数")


#一次性观察所有变量的相关关系
plot(data.frame) #输出一个散点图矩阵
#例：
plot(iris[, 1:4])

#3）两个定性变量--堆积柱状图和并列（分组）柱状图
barplot()#添加参数beside=T画出并列柱状图，beside=F画出堆积柱状图

#备注：单变量柱状图需要输入一个向量，或类似向量的数据（如用table()函数生成的table类数据）
#而画堆积或并列柱状图，需要输入矩阵


#例：
a = ddply(novel, .(小说类别,小说性质), nrow)
d = dcast(a, 小说性质 ~ 小说类别)[, -1]
##  Using V1 as value column: use value.var to override.
rownames(d) = c("VIP作品", "大众作品")
(d = as.matrix(d))
##           都市类小说 幻想类小说 其他 武侠类小说
##  VIP作品          34         45  188         18
##  大众作品        339        404  370        149

# beside = T，按列累计
barplot(d, beside = F, col = rainbow(2, alpha = 0.3))
legend("topright", legend = c("VIP作品", "大众作品"),
       fill = rainbow(2, alpha = 0.3), cex = 0.8)

# beside = F，按列并列
barplot(d, beside = T, col = rainbow(2, alpha = 0.3))
legend("topright",legend= c("VIP作品", "大众作品"),
       fill = rainbow(2, alpha = 0.3), cex = 0.8)


################################################################
#总结#

#基本统计图形：柱状图、箱线图、散点图、折线图、直方图、饼图
library(plyr) #plyr包的主函数是**ply形式的
library(reshape2)

### 单个变量 ###
#(1)单个定性变量--柱状图
barplot(height,names.arg)#height是柱子的高度，names.arg是柱子的名称

#常用参数：
#names.arg可定义每个柱子的名字，即分类变量的类别名称
#col可定义柱子的颜色
#main可定义图标题
#rainbow()生成彩虹色
#alpha调节透明度

#(2)单个定性变量--饼图
pie(numerical_vector,labels)#numerical_vector是各类别的频数，labels是每块小饼的标签

heat.colors()#“配色模板”，产生类红色的一组邻近色，适用于渐变色场景

#(3)单个定量变量--直方图
hist(x) 
#hist()的常用参数：
#xlab设置直方图的横坐标题目
#ylab设置直方图的纵坐标题目
#breaks设置直方图的组数或分割点

#(4)单个定量变量--折线图
plot(x) 
#如果数据是年、月或者季度数据，采用tz()函数直接转换
tz()
#如果数据是天数据或者不等间隔的时序数据，选用zoo包生成
library(zoo)
axis() #通过参数tick和label_name自定义横轴显示时间的格式

### 两个变量 ###
par(mfrow=c(a,b)) #将画图的屏幕切分成a行b列个小格子

#(5)定性与定量变量--分组箱线图
boxplot(y~x) #表示将y按照x分组，分别画箱线图

#(6)两个定量变量--散点图
plot(x,y) #参数main为图加标题，text在图上添加文本，xlab、ylab设置坐标轴,col设置点的颜色，pch设定点的形状，cex设定符号的大小

#一次性观察所有变量的相关关系
plot(data.frame) #输出一个散点图矩阵

#(7)两个定性变量--堆积柱状图和并列（分组）柱状图
barplot()#添加参数beside=T画出并列柱状图，beside=F画出堆积柱状图

################################################################

