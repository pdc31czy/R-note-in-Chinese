##### 3.3 回归分析 #####
rm(list = ls())  # 清空工作空间

#### 3.3.2 逻辑回归(logistic regression) ####

#额外备注：线性回归主要用来解决因变量是连续变量时的分析问题（比如薪酬、房价等）
#逻辑回归是处理二分类的因变量与自变量之间关系的模型


# 加载所需R包
# install.packages("ggplot2")
library(ggplot2)
# 读入数据
dat1 = read.csv("JuneTrain.csv")
dat2 = read.csv("JulyTest.csv")
head(dat1)  # 查看数据的前几行

# 重新命名数据以及排列
dat1 = dat1[, c("tenure", "expense", "COUNT", "perperson", "entropy", "chgexpense", "chgcount", "churn")]
colnames(dat1) = c("tenure", "expense", "count", "perperson", "entropy", "chgexpense", "chgcount", "churn")
dat2 = dat2[, c("tenure", "expense", "COUNT", "perperson", "entropy", "chgexpense", "chgcount", "churn")]
colnames(dat2) = c("tenure", "expense", "count", "perperson", "entropy", "chgexpense", "chgcount", "churn")

# churn:是否流失;tenure:在网时长;expense:当月话费;count:通话人数;
# perperson:人均通话时长;entropy:通话时长分布;chgexpense:花费变化率;chgcount:通话人数变化率

# 描述分析，用ggplot2画对比箱线图。
# 描述分析内容 "tenure"     "expense"    "count"      "perperson"  "entropy"    "chgexpense" "chgcount"
# tenure和是否流失
p1 = ggplot(dat1, aes(x = as.factor(churn), y = tenure, fill = as.factor(churn)))  + geom_boxplot() +
  guides(fill = FALSE) + theme_minimal() + xlab("是否流失") + ylab("在网时长") +
  theme(axis.title.x = element_text(size = 16, face = "bold"),
        axis.text.x = element_text(size = 12, face = "bold"),
        axis.title.y = element_text(size = 16, face = "bold"),
        axis.text.y = element_text(size = 12, face = "bold")) +
  scale_fill_hue(c = 45, l = 80)
# expense和是否流失
p2 = ggplot(dat1, aes(x = as.factor(churn), y = expense, fill = as.factor(churn)))  + geom_boxplot() +
  guides(fill = FALSE) + theme_minimal() + xlab("是否流失") + ylab("当月话费") +
  theme(axis.title.x = element_text(size = 16, face = "bold"),
        axis.text.x = element_text(size =12, face = "bold"),
        axis.title.y = element_text(size = 16, face = "bold"),
        axis.text.y = element_text(size = 12, face = "bold")) +
  scale_fill_hue(c = 45, l = 80)

#还有很多，具体看书和给出的例子，这里不写了





# 加载所需R包
# install.packages("gridExtra")
library(gridExtra)
# 将2张图并列输出
grid.arrange(p1,p2,ncol = 2) #因为ggplot()直接将两张图分别输出，而gridExtra中的grid.arrange()将2张图并列输出


#逻辑回归是解决分类问题的一种分类模型
glm()#逻辑回归建模最常用的是广义线性回归语句
#glm()与lm()不同之处就在于参数family
#逻辑回归的family=binomial(link=logit)，表示引用了二项分布族binomial中的logit连接函数
#glm()也包含了泊松回归等，family取值不一样


# 建立模型
lm1 = glm(churn ~., data = dat1, family = binomial())
summary(lm1)
#解读Page200

#训练集，测试集

#对测试集进行预测
predict(object,newdata = NULL,type = c("link","response","terms"))
#object指所需的回归模型；newdata指用于测试的数据集
#type指选择预测的类型，由于是二分类变量，所以选择reponse，表示输出结果预测响应变量为1的概率

# 模型预测
Yhat = predict(lm1, newdata = dat2, type = "response")
ypre1 = 1 * (Yhat > 0.5)
table(ypre1, dat2$churn)
##       
##  ypre1     0     1
##      0 46001   447
ypre2 = 1 * (Yhat > mean(dat2$churn))
table(ypre2, dat2$churn)
##       
##  ypre2     0     1
##      0 27242   108
##      1 18759   339

# 覆盖率捕获率曲线
sub = seq(0, 1, 1 / 7)
tol = sum(dat2$churn)
catch = sapply(sub, function(s) {
  ss = quantile(Yhat, 1 - s)
  res = sum(dat2$churn[Yhat > ss]) / tol
  return(res)
})
plot(sub, catch, type = "l", xlab = "覆盖率", ylab = "捕获率")


# 系数图示
coef = lm1$coefficients[-1]
coef = sort(coef)
barplot(coef, col = rainbow(10), width = 1)


# 加载所需R包
# install.packages("pROC")
library(pROC)
# 生成ROC曲线
plot.roc(dat2$churn, Yhat, col = "red", lwd = 2, xaxs = "i", yaxs = "i")


# 比较ROC曲线优劣
lm2 = glm(churn ~ chgcount, data = dat1, family = binomial())
Yhat2 = predict(lm2, newdata = dat2, type = "response")
plot.roc(dat2$churn, Yhat2, col = "blue", lwd = 2, xaxs = "i", yaxs = "i")
lines.roc(dat2$churn, Yhat, col = "red", lwd = 2)

# auc曲线
auc(dat2$churn, Yhat)



###############################
#总结#


library(gridExtra)
grid.arrange()#因为ggplot()直接将两张图分别输出，而gridExtra中的grid.arrange()将图并列输出
glm()#逻辑回归建模最常用的是广义线性回归语句
predict()
library(pROC)
# 生成ROC曲线
plot.roc()
auc()


#############################




