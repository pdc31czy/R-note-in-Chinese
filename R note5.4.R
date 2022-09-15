##### 5.4 模型训练与集成 #####




###########################略过####################################


### 载入数据和相应 ###
# 清空工作目录
rm(list = ls())
# 加载机器学习包
# install.packages(caret)
library(caret)
# 加载数据
dat0 = read.csv('相亲数据.csv', fileEncoding = "UTF-8")
head(dat0)

### 1.数据预处理及数据分割 ###
## (1) 缺失值处理 ##
nrow(dat0)
##  [1] 8378
dat = na.omit(dat0)
nrow(dat)
##  [1] 5723

## (2) 将定性变量转换为因子性变量 ##

# 转换数据类型
dat$决定 = factor(dat$决定, levels = c(0, 1), labels = c("拒绝", "接收"))
dat$性别 = factor(dat$性别, levels = c(0, 1), labels = c("女", "男"))
dat$种族 = factor(dat$种族, levels = c(1, 2, 3, 4, 6), labels = c("非洲裔", "欧洲裔", "拉丁裔", "亚裔", "其他"))
dat$从事领域 = factor(dat$从事领域, levels = 1:18, 
                  labels = c("法律", "数学", "社会科学或心理学",
                             "医学或药物学或生物技术", "工程学", "写作或新闻",
                             "历史或宗教或哲学", "商业或经济或金融", "教育或学术",
                             "生物科学或化学或物理", "社会工作", "大学在读或未择方向",
                             "政治学或国际事务", "电影", "艺术管理",
                             "语言", "建筑学", "其他"))
dat$对方决定 = factor(dat$对方决定, levels = c(0, 1), labels = c("拒绝", "接收"))
dat$对方种族 = factor(dat$对方种族, levels = c(1, 2, 3, 4, 6),
                  labels = c("非洲裔", "欧洲裔", "拉丁裔", "亚裔", "其他"))
dat$是否同一种族 = factor(dat$是否同一种族, levels = c(0, 1), labels = c("非同一种族", "同一种族"))

## (3) 数据划分为训练集和测试集 ##

# 设置随机种子
set.seed(1234)
# 将数据集的80%划分为训练集，20%划分为测试集
trainIndex = createDataPartition(dat$决定, p = .8, 
                                 list = FALSE, 
                                 times = 1)
# createDataPartition会自动从y的各个level随机取出等比例的数据来，组成训练集，可理解为分层抽样；
datTrain = dat[trainIndex, ]
# 训练集
datTest = dat[-trainIndex, ]
# 测试集
table(dat$决定) / nrow(dat)  # 全集上因变量各个水平的比例
##  
##      拒绝     接收 
##  0.560021 0.439979
table(datTrain$决定) / nrow(datTrain)  # 训练集上因变量各个水平的比例
##  
##       拒绝      接收 
##  0.5599476 0.4400524
table(datTest$决定) / nrow(datTest)  # 测试集上因变量各个水平的比例
##  
##       拒绝      接收 
##  0.5603147 0.4396853

## (4) 标准化处理 ##

preProcValues = preProcess(datTrain, method = c("center", "scale"))
trainTransformed = predict(preProcValues, datTrain)
testTransformed = predict(preProcValues, datTest)
# 利用训练集的均值和方差对测试集进行标准化

### 2.模型训练 ###
# 选择包含显著变量的数据框
# selected_var = Profile$optVariables
selected_var = c("吸引力", "好感", "共同爱好", "成功率自估", "幽默", "从事领域", "对种族的看重程度", "对宗教的看重程度", "种族", "性别", "年龄", "日常出门频率", "吸引力得分", "日常约会频率", "真诚")
dat.train = trainTransformed[, c(selected_var, "决定")]
dat.test = testTransformed[, c(selected_var, "决定")]




###########################从下面开始看####################################










###5.4.1逻辑回归
#逻辑回归是最基础的分类模型，它度量的是Y=1的可能性

## (1) 使用经典的逻辑回归预测 ##

fit1 = train(决定 ~., data = dat.train, 
               method = "glm",
               family ="binomial")  # 训练模型
pstate1 = predict(fit1, newdata = dat.test)  # 在测试集上预测
confusionMatrix(pstate1, dat.test$决定)  # 利用混淆矩阵评估模型



###5.4.2决策树
#决策树是机器学习中常用的基础树模型

## (2) 使用决策树预测 ##
#在caret包中如何实现决策树呢？
#method设置参数为"rpart"

fit2 = train(决定 ~ ., data = dat.train, 
               method = "rpart")  # 训练模型
pstate2 = predict(fit2, newdata = dat.test)  # 在测试集上预测
confusionMatrix(pstate2, dat.test$决定)  # 利用混淆矩阵评估模型



##5.4.3随机森林
#随机森林是通过多棵决策树集成的一种算法，它的基本单元为决策树

## (3) 使用随机森林预测 ##
#在caret包中实现随机森林，method设置为"rf"(randon forest)

set.seed(1234)
fit3 = train(决定 ~., data = dat.train, 
               method = "rf")  # 训练模型
pstate3 = predict(fit3, newdata = dat.test)  # 在测试集上预测
confusionMatrix(pstate3, dat.test$决定)  # 利用混淆矩阵评估模型



##5.4.4模型集成
### 3.模型集成 ###

## (1) 投票法 ##
#适用于分类问题

#可以是不同的分类器，看Page293图5-14

results = data.frame(pstate1, pstate2, pstate3)
results = apply(results, 2, as.character)
major_results = apply(results, 1, function(x) {
  tb = sort(table(x), decreasing = T)
  if(tb[1] %in% tb[2]) {
    return(sample(c(names(tb)[1], names(tb)[2]), 1))
  } else {
    return(names(tb)[1])
  }
})
major_results = factor(major_results, levels = c("拒绝", "接收"))
confusionMatrix(major_results, dat.test$决定)



## (2) 堆叠集成法 ##

#模型拟合，看Page294

set.seed(1234)
combPre = data.frame(pstate1, pstate2, pstate3, 决定 = dat.test$决定)
combfit = train(决定~., method = "rf", data = combPre)
##  note: only 2 unique complexity parameters in default grid. Truncating the grid to 2 .
combpstate = predict(combfit, newdata = dat.test)
confusionMatrix(combpstate, dat.test$决定)



## (3) 使用平均法（boosting）预测 ##
#平均法使用于回归问题，可采用简单平均和加权平均

#对训练精度低的样本赋予更大的权重，看page295

set.seed(1234)
fit4 = train(决定 ~., data = dat.train, 
               method = "gam")  # 训练模型
pstate4 = predict(fit4, newdata = dat.test)  # 在测试集上预测
confusionMatrix(pstate4, dat.test$决定)  # 利用混淆矩阵评估模型




















