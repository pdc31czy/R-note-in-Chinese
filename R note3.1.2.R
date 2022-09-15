#3.1.2 ggplot2绘图
#"declaratively" creating graphics
#基于图形语法的陈述式绘图系统

rm(list = ls())
# install.packages(ggplot2)
library(ggplot2)
# install.packages(plyr)
library(plyr)


library(cranlogs)
cran_top_downloads() #查看包的下载排名


#ggplot2采用图层叠加原理画图
#先建立一个坐标轴的图层，即定义好数据及坐标映射
ggplot(data,mapping)

#本章节所用钻石例子数据：
# 加载钻石数据
data("diamonds")
# 抽取前500条数据,且保留6个变量
set.seed(30)
diamond = diamonds[sample(nrow(diamonds), 500), c(1:4, 7, 10)]
head(diamond)
summary(diamond)

#1）为一个定性变量作图

## 柱状图 ##
# 基础柱状图
p = ggplot(data = diamond, mapping = aes(x = clarity)) #先建立第一个图层p
p + geom_bar() #在图层p的基础上叠加柱状图映射命令geom_bar()

# 增加其他映射元素,成为累计柱状图
p = ggplot(data = diamond, mapping = aes(x = clarity, fill = cut))
p + geom_bar()

# 分组柱状图
p = ggplot(data = diamond, mapping = aes(x = clarity, fill = cut))
p + geom_bar(position = "dodge")


## 饼图 ##
#由于ggplot2包没有专门做饼图的命令
#先画直角坐标系中的柱状图
#再将直角坐标系转换为笛卡尔坐标系
#在ggplot2的图形语法中，
#笛卡尔坐标系中的饼图正是直角坐标系中的柱状图

#例：
#步骤：
#step1：统计频数
df1 = ddply(diamond, .(cut), nrow)
(df1 = df1[order(df1$V1, decreasing = T), ])
(pos = (cumsum(df1$V1) - df1$V1/2))

#step2：画出堆积柱状图
ggplot(df1, aes(x="", y = V1, fill = factor(cut))) +
  geom_bar(width = 1,stat = "identity") 
#cut变量来进行颜色区分；
#geom_bar()中设置图形的宽度为1，并设置参数stat = "identity"采用原始未经过变换的数据作图

#step3：变成极坐标，并加比例标签
ggplot(df1, aes(x="", y = V1, fill = factor(cut))) +
  geom_bar(width = 1,stat = "identity") +
  coord_polar(theta = "y") +
  geom_text(aes(y = pos, label = paste(round(V1 / sum(V1) * 100, 2), "%", ""))) +
#使用coord_polar()进行极坐标变换，通过geo_text()来为饼图加标签

#step4：做其他修饰（去框调色）
ggplot(df1, aes(x="", y = V1, fill = factor(cut))) +
  geom_bar(width = 1,stat = "identity") +
  coord_polar(theta = "y") +
  geom_text(aes(y = pos, label = paste(round(V1 / sum(V1) * 100, 2), "%", ""))) +
  scale_fill_manual(values = rainbow(5,alpha = 0.4)) +
  theme(axis.title = element_blank(), axis.text = element_blank(), axis.ticks = element_blank())
#通过scale_fill_manual()手动设定饼图的颜色（其中values用来设定各个颜色的取值）
#通过theme()来把坐标轴、外圈的标记去掉


#2）为一个定量变量作图

## 直方图 ##
geom_histogram() #直方图映射命令

# 基础作图
p = ggplot(data = diamond, mapping = aes(x = price))
p + geom_histogram()

# 调整组距
p = ggplot(data = diamond, mapping = aes(x = price))
p + geom_histogram(binwidth = 500)

# 调整组数
p = ggplot(data = diamond, mapping = aes(x = price))
p + geom_histogram(bins = 100)

# 按照切工分颜色
p = ggplot(data = diamond, mapping = aes(x = price, fill = cut))
p + geom_histogram(binwidth = 500)

# 按照切工画密度曲线
ggplot(data = diamond, mapping = aes(price, colour = cut)) +
  geom_freqpoly(binwidth = 500)

# 分面来看不同切工的对比
p = ggplot(data = diamond, mapping = aes(x = price, fill = cut))
p + geom_histogram() + facet_grid( ~ cut)


## 折线图 ##
geom_line()#折线图映射命令

#例：
# 将搜索指数index变成时间序列格式
index = c(127910, 395976, 740802, 966845, 1223419, 1465722, 1931489, 2514324, 3024847, 3174056, 3208696, 3644736, 4198117, 3868350, 3576440, 3524784, 3621275, 3695967, 3728965, 3845193, 3525579, 3452680, 3535350, 3655541, 3884779, 3780629) / 10000
dat = seq(as.Date("2017/3/28"), length = 26, by = "day")
people_index = data.frame(date = dat, index = index)
p = ggplot(people_index, mapping = aes(x = date, y = index))
p + geom_line()

#通过添加colour参数及+geom_area()函数来绘制面积图
p + geom_line(colour = "green") + geom_area(colour = "green", alpha = 0.2)


#3)为两个变量画图

## 箱线图 ##
#定性变量与定量变量--箱线图
geom_boxplot()#箱线图映射命令

# 分组箱线图
ggplot(diamond) + geom_boxplot(aes(x = cut, y = price, fill = cut))
#用a分组就把aes()中的x设置为a
#探求因变量b的分布就把aes()中的y设置为b
#通过fill把柱子的填充色映射为分类变量

# 增加自定义配色
ggplot(diamond) + geom_boxplot(aes(x = cut, y = price, fill = cut)) + scale_fill_manual(values = c("lightpink", "lightyellow", "lightgreen", "lightblue", "mediumpurple1"))
#或设置为彩虹色rainbow()
ggplot(diamond) + geom_boxplot(aes(x = cut, y = price, fill = cut)) + scale_fill_manual(values = rainbow(5, alpha = 0.4))


## 散点图 ##
#两个定量变量--散点图
geom_point()#散点图映射命令

# 基础作图
p = ggplot(data = diamond, mapping = aes(x = carat, y = price))
p + geom_point()

# 添加映射元素
# 根据定性变量标识不同颜色
p = ggplot(data = diamond, mapping = aes(x = carat, y = price, colour = cut))
p + geom_point()

# 根据定量变量标识不同颜色
p = ggplot(data = diamond, mapping = aes(x = carat, y = price, colour = z))
p + geom_point()

# 增加统计变换
p = ggplot(diamond, aes(x = carat, y = price)) + geom_point()
p + scale_y_log10()

# 增加拟合曲线
p = ggplot(diamond, aes(x = carat, y = price)) + geom_point()
p + scale_y_log10() + stat_smooth()

# 基于cut分块
p = ggplot(diamond, aes(x = carat, y = price)) + geom_point() + scale_y_log10() + stat_smooth()
p + facet_grid( ~ cut)


## 柱状图 ##
#两个定性变量--柱状图

#增加其他映射元素，成为累计柱状图
p=ggplot(data=diamond,mapping=aes(x=clarity,fill=cut))
p+geom_bar()


#分组柱状图
p=ggplot(data=diamond,mapping=aes(x=clarity,fill=cut))
p+geom_bar(position="dodge")









###################################
#总结#

library(ggplot2)
library(plyr)

library(cranlogs)
cran_top_downloads() #查看包的下载排名

#1）为一个定性变量作图
#柱状图 
ggplot(data,mapping) ##先建立一个坐标轴的图层
geom_bar()#叠加柱状图映射命令
#饼图
ddply()
coord_polar()#进行极坐标变换
geo_text()#为饼图加标签
scale_fill_manual()#手动设定饼图的颜色
theme()#把坐标轴、外圈的标记去掉

#2）为一个定量变量作图
#直方图
geom_histogram() #直方图映射命令
geom_freqpoly() #binwidth,bins
facet_grid( ~ cut) #基于cut分块

#折线图
geom_line()#折线图映射命令
geom_area()#绘制面积图

#3)为两个变量画图

#定性变量与定量变量--箱线图
geom_boxplot()#箱线图映射命令

#两个定量变量--散点图
geom_point()#散点图映射命令
p + scale_y_log10()# 增加统计变换
stat_smooth()# 增加拟合曲线

#两个定性变量--柱状图
p=ggplot(data=diamond,mapping=aes(x=clarity,fill=cut)) #增加其他映射元素，成为累计柱状图
p+geom_bar(position="dodge") #分组柱状图


###################################