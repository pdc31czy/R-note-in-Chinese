##### 5.3 模型训练与调参 #####

##5.3.1 模型调参
#（1）确定一个参数池（模型参数值的可选范围）
#（2）从参数池中挑选出不同的参数组合，对每个组合都计算其预测精度
#（3）选取预测精度最高的参数组合

#常见的调参方法：网格搜索，随机搜索




###########################略过####################################


### 载入数据和相应包 ###
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



### 2.变量选择 ###
## 封装法 rfe: Recursive feature selection ##

subsets = c(2, 5, 10, 15, 20)
# 要选择的变量个数
ctrl = rfeControl(functions = rfFuncs, method = "cv")
# 首先定义控制参数，functions是确定用什么样的模型进行自变量排序，本例选择的模型是随机森林
# 根据目标函数（通常是预测效果评分），每次选择若干特征。
# method是确定用什么样的抽样方法，本例使用cv，即交叉检验
x = trainTransformed [, -which(colnames(trainTransformed) %in% "决定")]
y = trainTransformed [, "决定"]
Profile = rfe(x, y, sizes = subsets, rfeControl = ctrl)
Profile$optVariables  # 筛选出15个变量
##   [1] "吸引力"           "好感"             "共同爱好"        
##   [4] "成功率自估"       "幽默"             "从事领域"        
##   [7] "对种族的看重程度" "对宗教的看重程度" "种族"            
##  [10] "性别"             "年龄"             "日常出门频率"    
##  [13] "吸引力得分"       "日常约会频率"     "真诚"

### 3.模型训练及调参 ###
# 选择包含显著变量的数据框
# selected_var = Profile$optVariables
selected_var = c("吸引力", "好感", "共同爱好", "成功率自估", "幽默", "从事领域", "对种族的看重程度", "对宗教的看重程度", "种族", "性别", "年龄", "日常出门频率", "吸引力得分", "日常约会频率", "真诚")
dat.train = trainTransformed[, c(selected_var, "决定")]
dat.test = testTransformed[, c(selected_var, "决定")]



###########################从下面开始看####################################





## (1) 网格调参 ##

#第一步
set.seed(825) #设置随机种子，保证实验的可重复性

#第二步
traincontrol()#设置模型训练时用到的参数
#其中method表示重抽样方法，"cv"表示交叉验证
#number表示几折交叉验证，本例表示10折交叉验证
#10折交叉验证表示，首先将样本分为10个组，每次训练时抽取其中9组作为训练集，剩下的1组作为测试集
#classProbs表示是否计算类别概率，如果评价指标为AUC，那么这里一定要设置为TRUE
#由于因变量为两水平变量，summaryFunction = twoClassSummary


fitControl = trainControl(method = "cv",
                          number = 10,
                          # Estimate class probabilities
                          classProbs = TRUE,
                          # Evaluate performance using the following function
                          summaryFunction = twoClassSummary)

#第三步

#设置网格搜索的参数池，也就是设定参数的选择范围
#gbm (gradient boosting machine)模型
#interaction.depth 树的复杂度
#n.trees 迭代次数
#shrinkage 学习率
#n.minobsinnode 训练样本的最小数目


gbmGrid = expand.grid(interaction.depth = c(1, 5, 9), 
                      n.trees = (1:20) * 50, 
                      shrinkage = 0.1,
                      n.minobsinnode = 20)

nrow(gbmGrid) #这里设定了60组参数组合
##  [1] 60


#第四步
train()#进行模型训练及得到最优参数组合
#该函数会遍历第三步得到的所有参数组合，并得到使评价指标最大的参数组合作为输出
#method表示使用的模型，本例使用机器学习中的gbm模型
#使用的评价指标为ROC曲线面积（即AUC值）


gbmFit2 = train(决定 ~., data = dat.train, 
                  method = "gbm", 
                  trControl = fitControl, 
                  verbose = FALSE, 
                  tuneGrid = gbmGrid,metric = "ROC")
gbmFit2

#第五步
#模型会自动确定ROC曲线面积最大（即AUC值最高）的参数组合

# 画图
trellis.par.set(caretTheme())
plot(gbmFit2)



## (2) 随机调参 ##

#第一步
#设定随机种子
set.seed(825)

#第二步
#利用trainControl()函数设定模型训练的参数，但是多了一项：search = "random"

fitControl = trainControl(method = "cv",
                          number = 10,
                          # Estimate class probabilities
                          classProbs = TRUE,
                          # Evaluate performance using the following function
                          summaryFunction = twoClassSummary,
                          search = "random")

#第三步
#超参数在随机搜索中不受约束，所有无须设置tuneGrid参数
#只需要设置参数tuneLength（随机搜索多少组）

gbmFit3 = train(决定 ~., data = dat.train, 
                  method = "gbm", 
                  trControl = fitControl, 
                  verbose = FALSE, 
                  metric = "ROC",
                  tuneLength = 30)
gbmFit3


#第四步 （略）看page286

# 画图
# trellis.par.set(caretTheme())
# plot(gbmFit3)

## (3) 选择最优的参数组合 ##
# whichTwoPct = tolerance(gbmFit3$results, metric = "ROC", 
#                         tol = 2, maximize = TRUE)  
# gbmFit3$results[whichTwoPct, 1:6]




##5.3.2模型预测

predict()#只要输入模型及测试集，就可以预测
confusionMatrix()#输入真实的Y与预测的Y，就可以得到混淆矩阵（confusion Matrix)



# 网格搜索
data.predict = predict(gbmFit2, newdata = dat.test)
confusionMatrix(data.predict, dat.test$决定)


# 随机搜索
data.predict = predict(gbmFit3, newdata = dat.test)
confusionMatrix(data.predict, dat.test$决定)









































