##### 3.3 �ع���� #####
rm(list = ls())  # ��չ����ռ�

#### 3.3.2 �߼��ع�(logistic regression) ####

#���ⱸע�����Իع���Ҫ����������������������ʱ�ķ������⣨����н�ꡢ���۵ȣ�
#�߼��ع��Ǵ������������������Ա���֮���ϵ��ģ��


# ��������R��
# install.packages("ggplot2")
library(ggplot2)
# ��������
dat1 = read.csv("JuneTrain.csv")
dat2 = read.csv("JulyTest.csv")
head(dat1)  # �鿴���ݵ�ǰ����

# �������������Լ�����
dat1 = dat1[, c("tenure", "expense", "COUNT", "perperson", "entropy", "chgexpense", "chgcount", "churn")]
colnames(dat1) = c("tenure", "expense", "count", "perperson", "entropy", "chgexpense", "chgcount", "churn")
dat2 = dat2[, c("tenure", "expense", "COUNT", "perperson", "entropy", "chgexpense", "chgcount", "churn")]
colnames(dat2) = c("tenure", "expense", "count", "perperson", "entropy", "chgexpense", "chgcount", "churn")

# churn:�Ƿ���ʧ;tenure:����ʱ��;expense:���»���;count:ͨ������;
# perperson:�˾�ͨ��ʱ��;entropy:ͨ��ʱ���ֲ�;chgexpense:���ѱ仯��;chgcount:ͨ�������仯��

# ������������ggplot2���Ա�����ͼ��
# ������������ "tenure"     "expense"    "count"      "perperson"  "entropy"    "chgexpense" "chgcount"
# tenure���Ƿ���ʧ
p1 = ggplot(dat1, aes(x = as.factor(churn), y = tenure, fill = as.factor(churn)))  + geom_boxplot() +
  guides(fill = FALSE) + theme_minimal() + xlab("�Ƿ���ʧ") + ylab("����ʱ��") +
  theme(axis.title.x = element_text(size = 16, face = "bold"),
        axis.text.x = element_text(size = 12, face = "bold"),
        axis.title.y = element_text(size = 16, face = "bold"),
        axis.text.y = element_text(size = 12, face = "bold")) +
  scale_fill_hue(c = 45, l = 80)
# expense���Ƿ���ʧ
p2 = ggplot(dat1, aes(x = as.factor(churn), y = expense, fill = as.factor(churn)))  + geom_boxplot() +
  guides(fill = FALSE) + theme_minimal() + xlab("�Ƿ���ʧ") + ylab("���»���") +
  theme(axis.title.x = element_text(size = 16, face = "bold"),
        axis.text.x = element_text(size =12, face = "bold"),
        axis.title.y = element_text(size = 16, face = "bold"),
        axis.text.y = element_text(size = 12, face = "bold")) +
  scale_fill_hue(c = 45, l = 80)

#���кܶ࣬���忴��͸��������ӣ����ﲻд��





# ��������R��
# install.packages("gridExtra")
library(gridExtra)
# ��2��ͼ�������
grid.arrange(p1,p2,ncol = 2) #��Ϊggplot()ֱ�ӽ�����ͼ�ֱ��������gridExtra�е�grid.arrange()��2��ͼ�������


#�߼��ع��ǽ�����������һ�ַ���ģ��
glm()#�߼��ع齨ģ��õ��ǹ������Իع����
#glm()��lm()��֮ͬ�������ڲ���family
#�߼��ع��family=binomial(link=logit)����ʾ�����˶���ֲ���binomial�е�logit���Ӻ���
#glm()Ҳ�����˲��ɻع�ȣ�familyȡֵ��һ��


# ����ģ��
lm1 = glm(churn ~., data = dat1, family = binomial())
summary(lm1)
#���Page200

#ѵ���������Լ�

#�Բ��Լ�����Ԥ��
predict(object,newdata = NULL,type = c("link","response","terms"))
#objectָ����Ļع�ģ�ͣ�newdataָ���ڲ��Ե����ݼ�
#typeָѡ��Ԥ������ͣ������Ƕ��������������ѡ��reponse����ʾ������Ԥ����Ӧ����Ϊ1�ĸ���

# ģ��Ԥ��
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

# �����ʲ���������
sub = seq(0, 1, 1 / 7)
tol = sum(dat2$churn)
catch = sapply(sub, function(s) {
  ss = quantile(Yhat, 1 - s)
  res = sum(dat2$churn[Yhat > ss]) / tol
  return(res)
})
plot(sub, catch, type = "l", xlab = "������", ylab = "������")


# ϵ��ͼʾ
coef = lm1$coefficients[-1]
coef = sort(coef)
barplot(coef, col = rainbow(10), width = 1)


# ��������R��
# install.packages("pROC")
library(pROC)
# ����ROC����
plot.roc(dat2$churn, Yhat, col = "red", lwd = 2, xaxs = "i", yaxs = "i")


# �Ƚ�ROC��������
lm2 = glm(churn ~ chgcount, data = dat1, family = binomial())
Yhat2 = predict(lm2, newdata = dat2, type = "response")
plot.roc(dat2$churn, Yhat2, col = "blue", lwd = 2, xaxs = "i", yaxs = "i")
lines.roc(dat2$churn, Yhat, col = "red", lwd = 2)

# auc����
auc(dat2$churn, Yhat)



###############################
#�ܽ�#


library(gridExtra)
grid.arrange()#��Ϊggplot()ֱ�ӽ�����ͼ�ֱ��������gridExtra�е�grid.arrange()��ͼ�������
glm()#�߼��ع齨ģ��õ��ǹ������Իع����
predict()
library(pROC)
# ����ROC����
plot.roc()
auc()


#############################



