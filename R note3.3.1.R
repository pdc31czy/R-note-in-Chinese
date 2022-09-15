##### 3.3 �ع���� #####
rm(list = ls())  # ��չ����ռ�

#### 3.3.1 ���Իع� ####
###1.���ݷ���Ŀ��
#����Ŀ�����ͨ����������Ա���֮��Ķ�Ԫ���Իع�ģ�ͣ�����ģ��ϵ��������ϵ��������
#��ȷ���Ա����Ƿ���������Ӱ�죬�����Ա�����ֵ����ģ��Ԥ���������ֵ




### 2.����Ԥ������
#����Ԥ���������������ݣ�ʹ֮��ɿ���ֱ�ӽ�ģ���������ݸ�ʽ
#�����Իع�ʱ�������ݾ���

#���ݾ��������������Ƿ��������������
#�Ա���������0-1���Ա�����������

#����
##��jobinfo.xlsx �� ���ݷ�����λ��Ƹ.csv ##

# install.packages(readxl)
library(readxl)
# install.packages(ggplot2)
library(ggplot2)
# install.packages(jiebaR)
library(jiebaR)

# options(scipen = 200)  # ȥ����ѧ������
jobinfo = read_excel("jobinfo.xlsx")  # ��ȡԭʼ����
str(jobinfo)  # �鿴���ݽṹ

## (1) �����������ƽ��н�ʵı��� ##
jobinfo$���н�� = as.numeric(jobinfo$���н��)  # �����н�ʵ��ַ��ͱ�����Ϊ��ֵ�ͱ���
jobinfo$���н�� = as.numeric(jobinfo$���н��)  # �����н�ʵ��ַ��ͱ�����Ϊ��ֵ�ͱ���
# ��jobinfo�д���ƽ��н�ʵı���
jobinfo$ƽ��н�� = (jobinfo$���н�� + jobinfo$���н��) / 2

## (2) ����disctrict�������������»���Ϊ������ͷǱ���������ˮƽ ##
loc = which(jobinfo$���� %in% c("����", "�Ϻ�", "����"))
loc_other = which(!jobinfo$���� %in% c("����", "�Ϻ�", "����"))
jobinfo$����[loc] = 1
jobinfo$����[loc_other] = 0
jobinfo$���� = as.numeric(jobinfo$����)

## (3) ����˾��ģת��Ϊ�����ͱ��������ڻ�ͼ ##
jobinfo$��˾��ģ = factor(jobinfo$��˾��ģ, levels = c("����50��", "50-150��", "150-500��", "500-1000��", "1000-5000��", "5000-10000��", "10000������"))
levels(jobinfo$��˾��ģ)[c(2, 3)] = c("50-500��", "50-500��")
# ��50-150�˺�150-500�˺ϲ�Ϊһ��ˮƽ��50-500��

## (4) ��ѧ��ת��Ϊ�����ͱ��������ڻ�ͼ ##
jobinfo$ѧ�� = factor(jobinfo$ѧ��, levels = c("��ר", "����", "��ר", "��", "����", "˶ʿ", "��ʿ"))

## (5) ƥ�������˾Ҫ���ͳ������ ##
# ���Ƚ���software���ݿ����ڴ�Ÿ�����˾������ƥ����
software = as.data.frame(matrix(0, nrow = length(jobinfo$����), ncol = 12))  # �Ƚ���һ��0��������Ϊ�۲���������Ϊͳ�������ĸ�������ת��Ϊdata frame��ʽ
colnames(software) = c("R", "SPSS", "Excel", "Python", "MATLAB", "Java", "SQL", "SAS", "Stata", "EViews", "Spark", "Hadoop")  # ��software��data frame��������Ϊ��������

mixseg = worker()  # ����ȱʡֵ�����÷ִ�����

# ��ÿ�������۲���зִʣ����洢��software���棬ѭ������Ϊ�ܹ۲������ܹ۲�����ͨ��length(jobinfo$����)��ȡ
for (j in 1:length(jobinfo$����)){
  
  subdata = as.character(jobinfo$����[j])  # ȡ��ÿ���۲⣬������subdata����
  fenci = mixseg[subdata]  # ��ȡ���Ĺ۲���зִʣ������ڷִʱ���
  
  # ���ø����������б���������RΪ����R.indentify��ʾr��R�Ƿ���fenci���������
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
  
  # �жϸ����������������Ƿ���ĳ����Ҫ����RΪ������j��������������R.identifyΪTRUEʱ��software�ĵ�j�е�R����Ϊ1����֮Ϊ0��
  # 1��ʾ��Ҫ��0��ʾ��Ҫ��
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
# ��ƽ��н�ʺ�software���������ݿ�ϲ�
jobinfo.new = cbind(jobinfo$ƽ��н��, software)
colnames(jobinfo.new) = c("ƽ��н��", colnames(software))

## (6) ������Ҫ�ı��� ##
# ����
jobinfo.new$���� = jobinfo$����
# ��˾���
jobinfo.new$��˾��� = jobinfo$��˾���
# ��˾��ģ
jobinfo.new$��˾��ģ = jobinfo$��˾��ģ
# ѧ��
jobinfo.new$ѧ�� = jobinfo$ѧ��
# Ҫ����
jobinfo.new$����Ҫ�� = jobinfo$����
# ��ҵ���
jobinfo.new$��ҵ��� = jobinfo$��ҵ���

## (7) �����۲⣺��˾����У���Ӫ����������ҵ��λ������۲���٣�û�жԱȼ�ֵ������ɾ�� ##
table(jobinfo.new$��˾���)

jobinfo.new = jobinfo.new[-which(jobinfo.new$��˾��� %in% c("��Ӫ������", "��ҵ��λ")), ]

## (8) �ظ����� ##
colnames(jobinfo.new) = c("aveSalary", colnames(jobinfo.new[2:13]), "area", "compVar", "compScale", "academic", "exp", "induCate")

## (9) ��������Ԥ���������ݼ� ##
write.csv(jobinfo.new, file = "���ݷ�����λ��Ƹ.csv", row.names = FALSE)


### ���ݼ���������ļ��� ###

# install.packages(showtext)
library(showtext)
# install.packages(plyr)
library(plyr)

dat0 = read.csv("���ݷ�����λ��Ƹ.csv", header = T)  # ������ϴ���������
dat0 = na.omit(dat0)
n = dim(dat0)[1]  # n��������
summary(dat0)  # �鿴����

dat0 = dat0[, -19]  # ȥ����ҵ���һ�����

### 3.���������Է���
## (1) �����ֱ��ͼ ##
hist(dat0$aveSalary, xlab = "ƽ��н�ʣ�Ԫ/�£�", ylab = "Ƶ��", main = "", col = "dodgerblue", xlim = c(1500, 11000),
     breaks = seq(0, 500000, by = 1500))
summary(dat0$aveSalary)

## (2) ƽ��н�� ~ ����Ҫ�� ##
dat0$exp_level = cut(dat0$exp, breaks = c(-0.01, 3.99, 6, max(dat0$exp)))
dat0$exp_level = factor(dat0$exp_level,levels = levels(dat0$exp_level), labels = c("���飺0-3��", "���飺4-6��", "���飺>6��"))

# Ϊ��ͼ�۲����ƣ���ʱ�����±���������������Ҫ�󻮷�Ϊ(-0.01, 3.99], (3.99, 6], >6��������������Ҫ��0~3, 4~6, 6~10 ��������
boxplot(aveSalary ~ exp_level, data = dat0, col = "dodgerblue", ylab = "ƽ��н�ʣ�Ԫ/�£�", ylim = c(0, 45000))

summary(lm(aveSalary ~ exp_level, data = dat0))

table(dat0$exp_level)  # �������ֲ�
dat0 = dat0[, -which(colnames(dat0) == "exp_level")]  # ɾȥ��ʱ��exp_level����

## (3) ƽ��н�� ~ ѧ�� ##
summary(lm(aveSalary ~ academic, data = dat0))  # Ĭ�ϻ�׼��Ϊ�����ơ�

dat0$academic = factor(dat0$academic, levels = c("��", "��ר", "����", "��ר", "����", "˶ʿ", "��ʿ"))  
dat0$compVar = factor(dat0$compVar, levels = c("��Ӫ��˾", "��ҵ��˾", "����", "����", "���й�˾", "����"))
# �ı�ˮƽ˳�򣬻�׼����Ϊ���ޡ�������Ӫ��˾��
boxplot(aveSalary ~ academic, data = dat0, col = "dodgerblue", ylab = "ƽ��н�ʣ�Ԫ/�£�", ylim = c(0, 45000))

summary(lm(aveSalary ~ academic, data = dat0))
table(dat0$academic)  # �������ֲ�


### 4.����ֱ�ӽ����ع�ģ��
lm()#ʹ������ֱ�ӵõ���ģ����Լ�ģ���������۵����ָ��
#���Իع�ģ��ϵ���Ļ������壺�ڿ��������Ա�������������£�ĳ���Ա���ÿ�仯1����λ����������仯��ƽ��ֵ��

lm1 = lm(aveSalary ~., data = dat0)
summary(lm1)  # �ع���չʾ

#1�����ݽ������Page178

#2��ģ�ͼ��飬��page178
##1��ģ�����������Լ��飺F����(pֵԶС��0.05��˵����ģ���������Թ�ϵ��0.05������ˮƽ����������)
##2��ģ����������Ч��������R�������̻�ģ������Ч��
##3������ϵ�������Լ��飺��***���ı�����ʾ����0.001������ˮƽ��������ͬ����**����ʾ0.01��������*����ʾ0.05��������."��ʾ0.1������


### 5.�ع���� ###

## (1)���Իع�ģ�� ##
lm1 = lm(aveSalary ~., data = dat0)

par(mfrow = c(2, 2))  # ��2*2��ͼ
plot(lm1, which = c(1:4))  # ģ�����ͼ�����ڷ���̬���쳣�������Ƚ������̬�ԣ��������ȡ����

## (2)�ع���ϼ����� ##

#1�����ģ��(Residuals vs Fitted)�����ֵY��в�֮���ɢ��ͼ��Y�����ֵ��ͨ��X�ļ�Ȩ��ϵõ��ģ�
#�в�ͼ������֢״��1���в�ľ�ֵ�������ֵ�ı仯����ϵͳ�Թ��ɱ仯��˵��ģ���趨�����⣬�������Ա�����2�����©��
#�в�ͼ������֢״��2���в�Ĳ����ԣ�����������ֵ�ı仯����ϵͳ�Թ��ɱ仯��˵���������췽�����⣬ͨ������������б任ʵ�֡����Ρ������õı任�Ƕ����任

#2���������(Cook's distance)��Cook����ͼ����������飬���Ƿ����ǿӰ���
#һ����ΪCook����>1����>4/nΪǿӰ���

#3�����X����
vif()#��������Ա�����VIFֵ
#��VIF�������������ӣ��ҳ�ĳЩX�����Ƿ���ڶ��ع�����
#(R^2)jΪ���Ա���(X)j�����������Ա������Իع���õ���R��
#���(R^2)jΪ100%����˵����������ȫ������X�������棬��Ӧ��VIFΪ�����
#(VIF)j=1/(1-(R^2)j)
#���ĳ���Ա�����VIF=5��������Ա����������Ա����ع��R���ߴ�0.8
#һ����ԣ�VIF����5����10������Ϊ�������ض��ع�����

#����
# install.packages(rms)
library(rms)
vif(lm1)  # ����VIF��>5���������Խϴ󣨶������Ա����ع��R^2>80%��

# ȥ�����������أ���VIF�ϴ�ļ������׼��ϲ�Ϊһ��
# dat0$compVar = as.character(dat0$compVar)  # ��ת�����ַ��ͣ������滻ʱ����ִ���
# dat0[which(dat0$compVar %in% c("����", "����", "��Ӫ��˾", "��ҵ��˾")), "compVar"] = "����"
# dat0$compVar = factor(dat0$compVar, levels = c("����", "����", "���й�˾", "��ҵ��λ", "��Ӫ������" ))  
# lm1 = lm(aveSalary ~., data = dat0)
# summary(lm1)
# vif(lm1) 

#4���������(Normal Q-Q)
#��Q-Qͼ����һ��ֱ��ʱ��˵����������������̬�Լ���
#����Q-Qͼ������һ��ֱ�ߣ�һ�����ͨ���������Yȡ����

## (3) ��������ģ�ͣ�ȥ������̬Ӱ�죩 ##

#�����鱾������ģ�ͻ����������и�Сë��--����̬������
lm(log())
#����
lm2 = lm(log(aveSalary) ~., data = dat0)
summary(lm2)  # �ع���չʾ

par(mfrow = c(2, 2))  # ��2*2��ͼ
plot(lm2, which = c(1:4))  # ģ�����ͼ

# ɾ������쳣�㣬�������ģ����Ϲ���
# cook = cooks.distance(lm2)
# cook = sort(cook, decreasing = T)
# cook_point = names(cook)[1]
# cook_delete = which(rownames(dat0) %in% cook_point)
# dat0 = dat0[-cook_delete, ]

# ���
# lm3 = lm(log(aveSalary) ~., data = dat0)
# par(mfrow = c(2, 2))  # ��2*2��ͼ
# plot(lm3, which = c(1:4))  # ģ�����ͼ


### 6.����ģ�ͽ��ͼ�Ԥ�� ###

#Ϊģ�����ӿ��ܶ��������Ӱ��Ľ�������������Ա����ĳ˻���Ϊһ���µ��Ա�������ģ�ͣ�
#����AICԭ���ģ�ͽ��б���ѡ��Ҳ��������׼�����BIC����ѡ��
step()#���AIC����
#AICԭ��������ģ�ͼ�ࣨ�Ա�������Խ��Խ�ã���ģ�;��ȣ�������ԽСԽ�ã�֮���ҵ�һ������ƽ���


## (1) ����ģ�ͣ��н�����Ķ�������ģ�� ##

#��һ������ģ�Ͳ�ͬ����������ģ�͵�ϵ�������ǡ������ʡ�
#�����������Ա�������������£�ĳ���Ա���ÿ�仯1����λ���������������

lm4=lm(log(aveSalary)~. + compScale*area,data=dat0)  # �����빫˾��ģ֮��Ľ�������
summary(step(lm4))  # ����ѡ��step AIC

## (2) Ԥ�� ##
predict()
exp(predict())#���������е����ջع�ģ��������ǽ��ж����任��Ľ������Ҫ��ģ��Ԥ�����ָ���任

# Ԥ��1������r��python�����Ʊ�ҵ���޹������飬��˾λ���Ϻ�����ģ87�ˣ����й�˾

# ����һ����Ϊnew.data1��data frame
new.data1 = matrix(c(1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, "���й�˾", "50-500��", "����", 0), 1, 17) 
new.data1 = as.data.frame(new.data1)
colnames(new.data1) = names(dat0)[-1]  # ��data frame����
for(i in 1:13){
  new.data1[, i] = as.numeric(as.character(new.data1[, i]))
}
new.data1$exp = as.numeric(as.character(new.data1$exp))  # ��factor���͸�Ϊ��ֵ��
exp(predict(lm4, new.data1))  # Ԥ��ֵ
##         1 
##  9625.873

# Ԥ��2������r��java��sas��python����ʿ��ҵ��7�깤�����飬��˾λ�ڱ�������С�͹�˾����ģ150-500�ˣ�����ҵ��˾

# ����һ����Ϊnew.data2��data frame
new.data2 = matrix(c(1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, "���й�˾", "50-500��", "��ʿ", 7), 1, 17)
new.data2 = as.data.frame(new.data2)
colnames(new.data2) = names(dat0)[-1]  # ��data frame����
for(i in 1:13){
  new.data2[, i] = as.numeric(as.character(new.data2[, i]))
}
new.data2$exp = as.numeric(as.character(new.data2$exp))  # ��factor���͸�Ϊ��ֵ��
exp(predict(lm4, new.data2))  # Ԥ��ֵ
##        1 
##  43886.5

# Ԥ��3��û��ѧ����΢���Ĺ��������顢�����κ�ͳ������

# ����һ����Ϊnew.data3��data frame
new.data3 = matrix(c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "����", "����50��", "��", 0), 1, 17)
new.data3 = as.data.frame(new.data3)
colnames(new.data3) = names(dat0)[-1]  #��data frame����
for(i in 1:13){
  new.data3[, i] = as.numeric(as.character(new.data3[, i]))
}
new.data3$exp = as.numeric(as.character(new.data3$exp))  # ��factor���͸�Ϊ��ֵ��
exp(predict(lm4, new.data3))  # Ԥ��ֵ
##         1 
##  4206.697



#############################################################
#�ܽ�#

# install.packages(readxl) #��ȡExcel�ļ��İ�
library(readxl)
# install.packages(ggplot2) #ggplot2��ͼ��
library(ggplot2)
# install.packages(jiebaR) #���ķִʰ�
library(jiebaR)
# install.packages(showtext)#֧�ָ���������ʽ�͸����ͼ���豸
library(showtext)
# install.packages(plyr)#��������**ply��ʽ�ģ���������ĸ������(d��l��a)���ڶ�����ĸ������(d��l��a��)����ͬ����ĸ��ʾ��ͬ�����ݸ�ʽ��d��ʾ���ݿ��ʽ��l��ʾ�б���a��ʾ���飬���ʾû���������һ����ĸ��ʾ����Ĵ����������ݸ�ʽ���ڶ�����ĸ��ʾ��������ݸ�ʽ������ddply����������ʾ����һ�����ݿ����Ҳ��һ�����ݿ�
library(plyr)
# install.packages(rms)#���ƾ�������ͼ����������logisticģ�ͣ���cox���ձ���ģ�ͣ�����C-index�Ķ��ַ�����ʾ�� Calibration Curve��У׼���߻������ڲ���֤
library(rms)

###1.���ݷ���Ŀ��

###2.����Ԥ����

###3.���������Է���

###4.����ֱ�ӽ����ع�ģ��
lm()
##1�����ݽ������Page178
##2��ģ�ͼ��飬��page178
#1��ģ�����������Լ��飺F����(pֵԶС��0.05��˵����ģ���������Թ�ϵ��0.05������ˮƽ����������)
#2��ģ����������Ч��������R�������̻�ģ������Ч��
#3������ϵ�������Լ��飺��***���ı�����ʾ����0.001������ˮƽ��������ͬ����**����ʾ0.01��������*����ʾ0.05��������."��ʾ0.1������

###5.�ع����
##1�����ģ��(Residuals vs Fitted)�����ֵY��в�֮���ɢ��ͼ��Y�����ֵ��ͨ��X�ļ�Ȩ��ϵõ��ģ�
#�в�ͼ������֢״��1���в�ľ�ֵ�������ֵ�ı仯����ϵͳ�Թ��ɱ仯��˵��ģ���趨�����⣬�������Ա�����2�����©��
#�в�ͼ������֢״��2���в�Ĳ����ԣ�����������ֵ�ı仯����ϵͳ�Թ��ɱ仯��˵���������췽�����⣬ͨ������������б任ʵ�֡����Ρ������õı任�Ƕ����任

##2���������(Cook's distance)��Cook����ͼ����������飬���Ƿ����ǿӰ���
#һ����ΪCook����>1����>4/nΪǿӰ���

##3�����X����
vif()#��������Ա�����VIFֵ
#��VIF�������������ӣ��ҳ�ĳЩX�����Ƿ���ڶ��ع�����
#(R^2)jΪ���Ա���(X)j�����������Ա������Իع���õ���R��
#���(R^2)jΪ100%����˵����������ȫ������X�������棬��Ӧ��VIFΪ�����
#(VIF)j=1/(1-(R^2)j)
#���ĳ���Ա�����VIF=5��������Ա����������Ա����ع��R���ߴ�0.8
#һ����ԣ�VIF����5����10������Ϊ�������ض��ع�����

##4���������(Normal Q-Q)
#��Q-Qͼ����һ��ֱ��ʱ��˵����������������̬�Լ���
#����Q-Qͼ������һ��ֱ�ߣ�һ�����ͨ���������Yȡ����

###6.����ģ�ͽ��ͼ�Ԥ��
#Ϊģ�����ӿ��ܶ��������Ӱ��Ľ�������������Ա����ĳ˻���Ϊһ���µ��Ա�������ģ�ͣ�
#����AICԭ���ģ�ͽ��б���ѡ��Ҳ��������׼�����BIC����ѡ��
step()#���AIC����
#AICԭ��������ģ�ͼ�ࣨ�Ա�������Խ��Խ�ã���ģ�;��ȣ�������ԽСԽ�ã�֮���ҵ�һ������ƽ���

## (1) ����ģ�ͣ��н�����Ķ�������ģ�� ##
lm(log())
#��һ������ģ�Ͳ�ͬ����������ģ�͵�ϵ�������ǡ������ʡ�
#�����������Ա�������������£�ĳ���Ա���ÿ�仯1����λ���������������

## (2) Ԥ�� ##
predict()
exp(predict())#���������е����ջع�ģ��������ǽ��ж����任��Ľ������Ҫ��ģ��Ԥ�����ָ���任

#############################################################