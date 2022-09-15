##### 5.2 数据预处理 #####

#数据分割、缺失值处理、剔除近零方差变量、剔除高度线性相关变量、数据标准化



### 载入数据和相应包 ###
# 清空工作目录
rm(list = ls())
# 加载机器学习包
# install.packages(caret)
library(caret)


##1.读入数据
# 加载数据
dat = read.csv('相亲数据2.csv', fileEncoding = "UTF-8")
dim(dat)
head(dat)


##2.分割训练集和测试集

#(1)留出法
#将样本分为两个互斥的子集，80%为训练集，剩下20%为测试集


createDatePartition()
#保证训练集和测试集中Y的比例是一致的
#按照Y进行分层抽样

## 按照因变量进行分层抽样 ##
# 数据划分为训练集和测试集

# 设置随机种子
set.seed(1234)
# 将数据集的80%划分为训练集，20%划分为测试集
trainIndex = createDataPartition(dat$决定, p = .8, 
                                 list = FALSE, 
                                 times = 1)
# createDataPartition会自动从y的各个level随机取出等比例的数据来，组成训练集,可理解为分层抽样；
datTrain = dat[trainIndex, ]
# 训练集
datTest = dat[-trainIndex, ]
# 测试集


#(2)交叉验证法
#将原始数据分成K组（一般是均分）
#每次训练将其中一组作为测试集，另外K-1组作为训练集

set.seed(1234)
index = createFolds(dat$决定, k = 3, list = FALSE, returnTrain = TRUE)
index 
##   [1] 2 3 2 1 1 1 1 3 2 1 3 3 2 3 2
testIndex = which(index == 1)
datTraincv = dat[-testIndex, ]
# 训练集
datTestcv = dat[testIndex, ]
# 测试集


#(3)Bootstrap法
#Bootstrap抽样
#从给定训练集中有放回的均匀抽样

createResample()#times参数用于设定生成几份随机样本

set.seed(1234)
createResample(dat$决定, times = 3, list = F)


#(4)分割时间序列

createTimesSlices()
#initialWindow参数表示第一个训练集中的样本数
#horizon参数表示每个测试集中的样本数
#fixedWindow参数表示每个训练集中的样本数是否相同


# 加载数据
growdata = read.csv('水哥成长日记.csv', fileEncoding = "UTF-8")
head(growdata)

(timeSlices = createTimeSlices(1:nrow(growdata), 
                               initialWindow = 5, horizon = 2, fixedWindow = TRUE))
# 5表示初始的window，2表示测试集是训练集后的2位；fixedwindow表示都是训练集宽度一致，如果想递每次都从第一个样本开始，那么就得设置为FALSE，默认为TRUE。


##3.处理缺失值
preProcess()#该函数提供了三种缺失值填补的方法，即K近邻方法、Bagging树集成方法和中位数法
# 需要注意的是，采用K近邻方法时，会对原始数据进行标准化，如果需要返回原始值，还需将标准化公式倒推回来；
# 使用Bagging树集成方法，理论上对缺失值的填补更权威，但其效率比较低；
# 使用中位数方法，速度非常快，但填补的准确率有待验证。
# 如果你想使用多重插补法，不妨也可以试试mice包，其操作原理是基于MC（蒙特卡洛模拟法）。
# preProcess can be used to impute data sets based only on information in the training #set，注意只能用训练集信息。


#(1) 中位数法 ##
#用训练集的中位数代替缺失值

imputation_k = preProcess(datTrain,method = 'medianImpute')
datTrain1 = predict(imputation_k, datTrain)
(datTest1 = predict(imputation_k, datTest))


median(datTrain$智力, na.rm = T)
# 显然中位数这个填补方法不太合理，除非样本取值比较均匀;注意这里用的也是训练集的中位数


#(2) K近邻方法 ##
#对于需要插值的记录，基于欧氏距离计算k个和它最近的观测，
#然后利用k个近邻的数据来填补缺失值


imputation_k = preProcess(datTrain, method = 'knnImpute')
##  Warning in preProcess.default(datTrain, method = "knnImpute"): These
##  variables have zero variances: 是否喜欢矮矬穷, 对方是否喜欢矮矬穷
datTrain1 = predict(imputation_k, datTrain)
datTest1 = predict(imputation_k, datTest)
datTrain$智力 = datTrain1$智力 * sd(datTrain$智力, na.rm = T) + mean(datTrain$智力, na.rm = T)
datTest$智力 = datTest1$智力 * sd(datTrain$智力, na.rm = T) + mean(datTrain$智力, na.rm = T)
datTest
# 注意，这里自动用的是训练集的mean和sd对测试集进行标准化
#所以最后得到的数据是标准化之后的
#如果想看原始值，那么还需要将其去标准化倒推回去


##4.处理0方差变量（删除近零方差）
nearZeroVar()#找出近零方差的变量


dim(datTrain)
(nzv = nearZeroVar(datTrain))
datTrain = datTrain[, -nzv]


##5.删除共线性变量
findCorrelation()#自动找到高度共线性的变量，并给出建议剔除的变量
#数据中不能有缺失值
#只能包含数值型变量


# 数据中不能有NA
datTrain1 = datTrain[, -c(1, 6)]
(descrCor = cor(datTrain1))

highlyCorDescr = findCorrelation(descrCor, cutoff = .75, names = F, verbose = T)
highlyCorDescr
filteredTrain = datTrain1[, -highlyCorDescr]
# input只能是numeric型的dataframe或者matrix，且无缺失值(在此之前必须处理缺失值)



##6.标准化
preProcValues = preProcess(datTrain, method = c("center", "scale"))
trainTransformed = predict(preProcValues, datTrain)
testTransformed = predict(preProcValues, datTest)
# 利用训练集的均值和方差对测试集进行标准化







