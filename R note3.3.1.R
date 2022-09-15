##### 3.3 回归分析 #####
rm(list = ls())  # 清空工作空间

#### 3.3.1 线性回归 ####
###1.数据分析目标
#分析目标就是通过因变量与自变量之间的多元线性回归模型，估计模型系数，检验系数显著性
#以确定自变量是否对因变量有影响，并将自变量新值代入模型预测因变量新值




### 2.数据预处理：
#数据预处理就是整理数据，使之变成可以直接建模分析的数据格式
#在线性回归时就是数据矩阵

#数据矩阵的因变量可以是分类变量或定量变量
#自变量可以是0-1定性变量或定量变量

#例：
##从jobinfo.xlsx 到 数据分析岗位招聘.csv ##

# install.packages(readxl)
library(readxl)
# install.packages(ggplot2)
library(ggplot2)
# install.packages(jiebaR)
library(jiebaR)

# options(scipen = 200)  # 去除科学计数法
jobinfo = read_excel("jobinfo.xlsx")  # 读取原始数据
str(jobinfo)  # 查看数据结构

## (1) 构造因变量：平均薪资的变量 ##
jobinfo$最低薪资 = as.numeric(jobinfo$最低薪资)  # 将最低薪资的字符型变量改为数值型变量
jobinfo$最高薪资 = as.numeric(jobinfo$最高薪资)  # 将最高薪资的字符型变量改为数值型变量
# 在jobinfo中创建平均薪资的变量
jobinfo$平均薪资 = (jobinfo$最高薪资 + jobinfo$最低薪资) / 2

## (2) 按照disctrict向量将地区重新划分为北上深和非北上深两个水平 ##
loc = which(jobinfo$地区 %in% c("北京", "上海", "深圳"))
loc_other = which(!jobinfo$地区 %in% c("北京", "上海", "深圳"))
jobinfo$地区[loc] = 1
jobinfo$地区[loc_other] = 0
jobinfo$地区 = as.numeric(jobinfo$地区)

## (3) 将公司规模转化为因子型变量，便于画图 ##
jobinfo$公司规模 = factor(jobinfo$公司规模, levels = c("少于50人", "50-150人", "150-500人", "500-1000人", "1000-5000人", "5000-10000人", "10000人以上"))
levels(jobinfo$公司规模)[c(2, 3)] = c("50-500人", "50-500人")
# 将50-150人和150-500人合并为一个水平：50-500人

## (4) 将学历转化为因子型变量，便于画图 ##
jobinfo$学历 = factor(jobinfo$学历, levels = c("中专", "高中", "大专", "无", "本科", "硕士", "博士"))

## (5) 匹配各个公司要求的统计软件 ##
# 首先建立software数据框，用于存放各个公司的软件匹配结果
software = as.data.frame(matrix(0, nrow = length(jobinfo$描述), ncol = 12))  # 先建立一个0矩阵，行数为观测数，列数为统计软件的个数，并转化为data frame格式
colnames(software) = c("R", "SPSS", "Excel", "Python", "MATLAB", "Java", "SQL", "SAS", "Stata", "EViews", "Spark", "Hadoop")  # 将software的data frame的列名改为软件名称

mixseg = worker()  # 按照缺省值，设置分词引擎

# 对每个描述观测进行分词，并存储在software里面，循环次数为总观测数，总观测数可通过length(jobinfo$描述)获取
for (j in 1:length(jobinfo$描述)){
  
  subdata = as.character(jobinfo$描述[j])  # 取出每个观测，保存在subdata变量
  fenci = mixseg[subdata]  # 对取出的观测进行分词，保存在分词变量
  
  # 设置各个软件的判别条件，以R为例，R.indentify表示r或R是否在fenci这个变量里
  R.identify = ("R" %in% fenci) | ("r" %in% fenci)
  SPSS.identify = ("spss" %in% fenci) | ("Spss" %in% fenci) | ("SPSS" %in% fenci)
  Excel.identify = ("excel" %in% fenci) | ("EXCEL" %in% fenci) | ("Excel" %in% fenci)
  Python.identify = ("Python" %in% fenci) | ("python" %in% fenci) | ("PYTHON" %in% fenci)
  MATLAB.identify = ("matlab" %in% fenci) | ("Matlab" %in% fenci) | ("MATLAB" %in% fenci)
  Java.identify = ("java" %in% fenci) | ("JAVA" %in% fenci) | ("Java" %in% fenci)
  SQL.identify = ("SQL" %in% fenci) | ("Sql" %in% fenci) | ("sql" %in% fenci)
  SAS.identify = ("SAS" %in% fenci) | ("Sas" %in% fenci) | ("sas" %in% fenci)
  Stata.identify = ("STATA" %in% fenci) | ("Stata" %in% fenci) | ("stata" %in% fenci)
  EViews.identify = ("EViews" %in% fenci) | ("EVIEWS" %in% fenci) | ("Eviews" %in% fenci) | ("eviews" %in% fenci) 
  Spark.identify = ("Spark" %in% fenci) | ("SPARK" %in% fenci) | ("spark" %in% fenci)
  Hadoop.identify = ("HADOOP" %in% fenci) | ("Hadoop" %in% fenci) | ("hadoop" %in% fenci)
  
  # 判断各个描述变量里面是否有某软件要求，以R为例，第j个描述变量，若R.identify为TRUE时，software的第j行的R变量为1，反之为0；
  # 1表示有要求，0表示无要求
  if (R.identify) software$R[j] = 1
  if (SPSS.identify) software$SPSS[j] = 1
  if (Excel.identify) software$Excel[j] = 1
  if (Python.identify) software$Python[j] = 1
  if (MATLAB.identify) software$MATLAB[j] = 1
  if (Java.identify) software$Java[j] = 1
  if (SQL.identify) software$SQL[j] = 1
  if (SAS.identify) software$SAS[j] = 1
  if (Stata.identify) software$Stata[j] = 1
  if (EViews.identify) software$EViews[j] = 1
  if (Spark.identify) software$Spark[j] = 1
  if (Hadoop.identify) software$Hadoop[j] = 1
}
# 将平均薪资和software这两个数据框合并
jobinfo.new = cbind(jobinfo$平均薪资, software)
colnames(jobinfo.new) = c("平均薪资", colnames(software))

## (6) 加入需要的变量 ##
# 地区
jobinfo.new$地区 = jobinfo$地区
# 公司类别
jobinfo.new$公司类别 = jobinfo$公司类别
# 公司规模
jobinfo.new$公司规模 = jobinfo$公司规模
# 学历
jobinfo.new$学历 = jobinfo$学历
# 要求经验
jobinfo.new$经验要求 = jobinfo$经验
# 行业类别
jobinfo.new$行业类别 = jobinfo$行业类别

## (7) 处理观测：公司类别中，非营利机构与事业单位两子类观测过少，没有对比价值，予以删除 ##
table(jobinfo.new$公司类别)

jobinfo.new = jobinfo.new[-which(jobinfo.new$公司类别 %in% c("非营利机构", "事业单位")), ]

## (8) 重赋列名 ##
colnames(jobinfo.new) = c("aveSalary", colnames(jobinfo.new[2:13]), "area", "compVar", "compScale", "academic", "exp", "induCate")

## (9) 保存做过预处理的数据集 ##
write.csv(jobinfo.new, file = "数据分析岗位招聘.csv", row.names = FALSE)


### 数据集读入与包的加载 ###

# install.packages(showtext)
library(showtext)
# install.packages(plyr)
library(plyr)

dat0 = read.csv("数据分析岗位招聘.csv", header = T)  # 读入清洗过后的数据
dat0 = na.omit(dat0)
n = dim(dat0)[1]  # n是样本量
summary(dat0)  # 查看数据

dat0 = dat0[, -19]  # 去除行业类别一类变量

### 3.数据描述性分析
## (1) 因变量直方图 ##
hist(dat0$aveSalary, xlab = "平均薪资（元/月）", ylab = "频数", main = "", col = "dodgerblue", xlim = c(1500, 11000),
     breaks = seq(0, 500000, by = 1500))
summary(dat0$aveSalary)

## (2) 平均薪资 ~ 经验要求 ##
dat0$exp_level = cut(dat0$exp, breaks = c(-0.01, 3.99, 6, max(dat0$exp)))
dat0$exp_level = factor(dat0$exp_level,levels = levels(dat0$exp_level), labels = c("经验：0-3年", "经验：4-6年", "经验：>6年"))

# 为画图观察趋势，临时生成新变量，将经验年限要求划分为(-0.01, 3.99], (3.99, 6], >6三个档。即经验要求：0~3, 4~6, 6~10 年三个档
boxplot(aveSalary ~ exp_level, data = dat0, col = "dodgerblue", ylab = "平均薪资（元/月）", ylim = c(0, 45000))

summary(lm(aveSalary ~ exp_level, data = dat0))

table(dat0$exp_level)  # 样本量分布
dat0 = dat0[, -which(colnames(dat0) == "exp_level")]  # 删去临时的exp_level变量

## (3) 平均薪资 ~ 学历 ##
summary(lm(aveSalary ~ academic, data = dat0))  # 默认基准组为“本科”

dat0$academic = factor(dat0$academic, levels = c("无", "中专", "高中", "大专", "本科", "硕士", "博士"))  
dat0$compVar = factor(dat0$compVar, levels = c("民营公司", "创业公司", "国企", "合资", "上市公司", "外资"))
# 改变水平顺序，基准组设为“无”，“民营公司”
boxplot(aveSalary ~ academic, data = dat0, col = "dodgerblue", ylab = "平均薪资（元/月）", ylim = c(0, 45000))

summary(lm(aveSalary ~ academic, data = dat0))
table(dat0$academic)  # 样本量分布


### 4.数据直接建立回归模型
lm()#使用命令直接得到建模结果以及模型整体评价的相关指标
#线性回归模型系数的基本含义：在控制其他自变量不变的条件下，某个自变量每变化1个单位导致因变量变化的平均值。

lm1 = lm(aveSalary ~., data = dat0)
summary(lm1)  # 回归结果展示

#1）数据解读，看Page178

#2）模型检验，看page178
##1、模型整体显著性检验：F检验(p值远小于0.05，说明该模型整体线性关系在0.05显著性水平下是显著的)
##2、模型整体的拟合效果：调整R方用来刻画模型整体效果
##3、各个系数显著性检验：“***”的变量表示其在0.001显著性水平下显著，同理“**”表示0.01显著，“*”表示0.05显著，“."表示0.1显著。


### 5.回归诊断 ###

## (1)线性回归模型 ##
lm1 = lm(aveSalary ~., data = dat0)

par(mfrow = c(2, 2))  # 画2*2的图
plot(lm1, which = c(1:4))  # 模型诊断图，存在非正态、异常点现象，先解决非正态性：对因变量取对数

## (2)回归诊断及处理 ##

#1、检查模型(Residuals vs Fitted)：拟合值Y与残差之间的散点图（Y的拟合值是通过X的加权组合得到的）
#残差图常见“症状”1：残差的均值随着拟合值的变化呈现系统性规律变化，说明模型设定有问题，可能是自变量的2次项被遗漏了
#残差图常见“症状”2：残差的波动性（方差）随着拟合值的变化呈现系统性规律变化，说明出现了异方差问题，通过对因变量进行变换实现”诊治“，常用的变换是对数变换

#2、检查样本(Cook's distance)对Cook距离图进行样本检查，看是否存在强影响点
#一般认为Cook距离>1或者>4/n为强影响点

#3、检查X变量
vif()#求出各个自变量的VIF值
#用VIF（方差膨胀因子）找出某些X变量是否存在多重共线性
#(R^2)j为把自变量(X)j对其余所有自变量线性回归而得到的R方
#如果(R^2)j为100%，则说明它可以完全由其他X变量代替，相应的VIF为无穷大
#(VIF)j=1/(1-(R^2)j)
#因此某个自变量的VIF=5，则这个自变量对其余自变量回归的R方高达0.8
#一般而言，VIF大于5或者10，则认为存在严重多重共线性

#例：
# install.packages(rms)
library(rms)
vif(lm1)  # 计算VIF，>5代表共线性较大（对其他自变量回归的R^2>80%）

# 去除共线性因素，把VIF较大的几项与基准组合并为一项
# dat0$compVar = as.character(dat0$compVar)  # 先转换成字符型，否则替换时会出现错误
# dat0[which(dat0$compVar %in% c("合资", "外资", "民营公司", "创业公司")), "compVar"] = "其他"
# dat0$compVar = factor(dat0$compVar, levels = c("其他", "国企", "上市公司", "事业单位", "非营利机构" ))  
# lm1 = lm(aveSalary ~., data = dat0)
# summary(lm1)
# vif(lm1) 

#4、其他检查(Normal Q-Q)
#当Q-Q图近似一条直线时，说明数据满足误差的正态性假设
#假如Q-Q图并不是一天直线，一般可以通过对因变量Y取对数

## (3) 对数线性模型（去除非正态影响） ##

#例：书本中例子模型基本健康，有个小毛病--非正态性问题
lm(log())
#例：
lm2 = lm(log(aveSalary) ~., data = dat0)
summary(lm2)  # 回归结果展示

par(mfrow = c(2, 2))  # 画2*2的图
plot(lm2, which = c(1:4))  # 模型诊断图

# 删除库克异常点，至此完成模型诊断工作
# cook = cooks.distance(lm2)
# cook = sort(cook, decreasing = T)
# cook_point = names(cook)[1]
# cook_delete = which(rownames(dat0) %in% cook_point)
# dat0 = dat0[-cook_delete, ]

# 检查
# lm3 = lm(log(aveSalary) ~., data = dat0)
# par(mfrow = c(2, 2))  # 画2*2的图
# plot(lm3, which = c(1:4))  # 模型诊断图


### 6.最终模型解释及预测 ###

#为模型添加可能对因变量有影响的交互项（即将两个自变量的乘积作为一个新的自变量引入模型）
#并用AIC原则对模型进行变量选择（也可用其他准则比如BIC进行选择）
step()#完成AIC步骤
#AIC原则力求在模型简洁（自变量个数越少越好）与模型精度（拟合误差越小越好）之间找到一个最优平衡点


## (1) 最终模型：有交互项的对数线性模型 ##

#与一般线性模型不同，对数线性模型的系数含义是”增长率“
#即控制其他自变量不变的条件下，某个自变量每变化1个单位，因变量的增长率

lm4=lm(log(aveSalary)~. + compScale*area,data=dat0)  # 地区与公司规模之间的交互作用
summary(step(lm4))  # 变量选择：step AIC

## (2) 预测 ##
predict()
exp(predict())#由于例子中的最终回归模型因变量是进行对数变换后的结果，需要将模型预测进行指数变换

# 预测1：会用r和python，本科毕业，无工作经验，公司位于上海，规模87人，上市公司

# 创建一个名为new.data1的data frame
new.data1 = matrix(c(1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, "上市公司", "50-500人", "本科", 0), 1, 17) 
new.data1 = as.data.frame(new.data1)
colnames(new.data1) = names(dat0)[-1]  # 对data frame命名
for(i in 1:13){
  new.data1[, i] = as.numeric(as.character(new.data1[, i]))
}
new.data1$exp = as.numeric(as.character(new.data1$exp))  # 将factor类型改为数值型
exp(predict(lm4, new.data1))  # 预测值
##         1 
##  9625.873

# 预测2：会用r，java，sas和python，博士毕业，7年工作经验，公司位于北京，中小型公司（规模150-500人），创业公司

# 创建一个名为new.data2的data frame
new.data2 = matrix(c(1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, "上市公司", "50-500人", "博士", 7), 1, 17)
new.data2 = as.data.frame(new.data2)
colnames(new.data2) = names(dat0)[-1]  # 对data frame命名
for(i in 1:13){
  new.data2[, i] = as.numeric(as.character(new.data2[, i]))
}
new.data2$exp = as.numeric(as.character(new.data2$exp))  # 将factor类型改为数值型
exp(predict(lm4, new.data2))  # 预测值
##        1 
##  43886.5

# 预测3：没有学历、微弱的国企工作经验、不会任何统计软件

# 创建一个名为new.data3的data frame
new.data3 = matrix(c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "国企", "少于50人", "无", 0), 1, 17)
new.data3 = as.data.frame(new.data3)
colnames(new.data3) = names(dat0)[-1]  #对data frame命名
for(i in 1:13){
  new.data3[, i] = as.numeric(as.character(new.data3[, i]))
}
new.data3$exp = as.numeric(as.character(new.data3$exp))  # 将factor类型改为数值型
exp(predict(lm4, new.data3))  # 预测值
##         1 
##  4206.697



#############################################################
#总结#

# install.packages(readxl) #读取Excel文件的包
library(readxl)
# install.packages(ggplot2) #ggplot2绘图包
library(ggplot2)
# install.packages(jiebaR) #中文分词包
library(jiebaR)
# install.packages(showtext)#支持更多的字体格式和更多的图形设备
library(showtext)
# install.packages(plyr)#主函数是**ply形式的，其中首字母可以是(d、l、a)，第二个字母可以是(d、l、a、)，不同的字母表示不同的数据格式，d表示数据框格式，l表示列表，a表示数组，则表示没有输出。第一个字母表示输入的待处理的数据格式，第二个字母表示输出的数据格式。例如ddply函数，即表示输入一个数据框，输出也是一个数据框
library(plyr)
# install.packages(rms)#绘制经典列线图，构建基于logistic模型，及cox风险比例模型，计算C-index的多种方法演示。 Calibration Curve：校准曲线绘制做内部验证
library(rms)

###1.数据分析目标

###2.数据预处理

###3.数据描述性分析

###4.数据直接建立回归模型
lm()
##1）数据解读，看Page178
##2）模型检验，看page178
#1、模型整体显著性检验：F检验(p值远小于0.05，说明该模型整体线性关系在0.05显著性水平下是显著的)
#2、模型整体的拟合效果：调整R方用来刻画模型整体效果
#3、各个系数显著性检验：“***”的变量表示其在0.001显著性水平下显著，同理“**”表示0.01显著，“*”表示0.05显著，“."表示0.1显著。

###5.回归诊断
##1、检查模型(Residuals vs Fitted)：拟合值Y与残差之间的散点图（Y的拟合值是通过X的加权组合得到的）
#残差图常见“症状”1：残差的均值随着拟合值的变化呈现系统性规律变化，说明模型设定有问题，可能是自变量的2次项被遗漏了
#残差图常见“症状”2：残差的波动性（方差）随着拟合值的变化呈现系统性规律变化，说明出现了异方差问题，通过对因变量进行变换实现”诊治“，常用的变换是对数变换

##2、检查样本(Cook's distance)对Cook距离图进行样本检查，看是否存在强影响点
#一般认为Cook距离>1或者>4/n为强影响点

##3、检查X变量
vif()#求出各个自变量的VIF值
#用VIF（方差膨胀因子）找出某些X变量是否存在多重共线性
#(R^2)j为把自变量(X)j对其余所有自变量线性回归而得到的R方
#如果(R^2)j为100%，则说明它可以完全由其他X变量代替，相应的VIF为无穷大
#(VIF)j=1/(1-(R^2)j)
#因此某个自变量的VIF=5，则这个自变量对其余自变量回归的R方高达0.8
#一般而言，VIF大于5或者10，则认为存在严重多重共线性

##4、其他检查(Normal Q-Q)
#当Q-Q图近似一条直线时，说明数据满足误差的正态性假设
#假如Q-Q图并不是一天直线，一般可以通过对因变量Y取对数

###6.最终模型解释及预测
#为模型添加可能对因变量有影响的交互项（即将两个自变量的乘积作为一个新的自变量引入模型）
#并用AIC原则对模型进行变量选择（也可用其他准则比如BIC进行选择）
step()#完成AIC步骤
#AIC原则力求在模型简洁（自变量个数越少越好）与模型精度（拟合误差越小越好）之间找到一个最优平衡点

## (1) 最终模型：有交互项的对数线性模型 ##
lm(log())
#与一般线性模型不同，对数线性模型的系数含义是”增长率“
#即控制其他自变量不变的条件下，某个自变量每变化1个单位，因变量的增长率

## (2) 预测 ##
predict()
exp(predict())#由于例子中的最终回归模型因变量是进行对数变换后的结果，需要将模型预测进行指数变换

#############################################################
