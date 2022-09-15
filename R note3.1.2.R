#3.1.2 ggplot2��ͼ
#"declaratively" creating graphics
#����ͼ���﷨�ĳ���ʽ��ͼϵͳ

rm(list = ls())
# install.packages(ggplot2)
library(ggplot2)
# install.packages(plyr)
library(plyr)


library(cranlogs)
cran_top_downloads() #�鿴������������


#ggplot2����ͼ�����ԭ����ͼ
#�Ƚ���һ���������ͼ�㣬����������ݼ�����ӳ��
ggplot(data,mapping)

#���½�������ʯ�������ݣ�
# ������ʯ����
data("diamonds")
# ��ȡǰ500������,�ұ���6������
set.seed(30)
diamond = diamonds[sample(nrow(diamonds), 500), c(1:4, 7, 10)]
head(diamond)
summary(diamond)

#1��Ϊһ�����Ա�����ͼ

## ��״ͼ ##
# ������״ͼ
p = ggplot(data = diamond, mapping = aes(x = clarity)) #�Ƚ�����һ��ͼ��p
p + geom_bar() #��ͼ��p�Ļ����ϵ�����״ͼӳ������geom_bar()

# ��������ӳ��Ԫ��,��Ϊ�ۼ���״ͼ
p = ggplot(data = diamond, mapping = aes(x = clarity, fill = cut))
p + geom_bar()

# ������״ͼ
p = ggplot(data = diamond, mapping = aes(x = clarity, fill = cut))
p + geom_bar(position = "dodge")


## ��ͼ ##
#����ggplot2��û��ר������ͼ������
#�Ȼ�ֱ������ϵ�е���״ͼ
#�ٽ�ֱ������ϵת��Ϊ�ѿ�������ϵ
#��ggplot2��ͼ���﷨�У�
#�ѿ�������ϵ�еı�ͼ����ֱ������ϵ�е���״ͼ

#����
#���裺
#step1��ͳ��Ƶ��
df1 = ddply(diamond, .(cut), nrow)
(df1 = df1[order(df1$V1, decreasing = T), ])
(pos = (cumsum(df1$V1) - df1$V1/2))

#step2�������ѻ���״ͼ
ggplot(df1, aes(x="", y = V1, fill = factor(cut))) +
  geom_bar(width = 1,stat = "identity") 
#cut������������ɫ���֣�
#geom_bar()������ͼ�εĿ���Ϊ1�������ò���stat = "identity"����ԭʼδ�����任��������ͼ

#step3����ɼ����꣬���ӱ�����ǩ
ggplot(df1, aes(x="", y = V1, fill = factor(cut))) +
  geom_bar(width = 1,stat = "identity") +
  coord_polar(theta = "y") +
  geom_text(aes(y = pos, label = paste(round(V1 / sum(V1) * 100, 2), "%", ""))) +
#ʹ��coord_polar()���м�����任��ͨ��geo_text()��Ϊ��ͼ�ӱ�ǩ

#step4�����������Σ�ȥ���ɫ��
ggplot(df1, aes(x="", y = V1, fill = factor(cut))) +
  geom_bar(width = 1,stat = "identity") +
  coord_polar(theta = "y") +
  geom_text(aes(y = pos, label = paste(round(V1 / sum(V1) * 100, 2), "%", ""))) +
  scale_fill_manual(values = rainbow(5,alpha = 0.4)) +
  theme(axis.title = element_blank(), axis.text = element_blank(), axis.ticks = element_blank())
#ͨ��scale_fill_manual()�ֶ��趨��ͼ����ɫ������values�����趨������ɫ��ȡֵ��
#ͨ��theme()���������ᡢ��Ȧ�ı��ȥ��


#2��Ϊһ������������ͼ

## ֱ��ͼ ##
geom_histogram() #ֱ��ͼӳ������

# ������ͼ
p = ggplot(data = diamond, mapping = aes(x = price))
p + geom_histogram()

# �������
p = ggplot(data = diamond, mapping = aes(x = price))
p + geom_histogram(binwidth = 500)

# ��������
p = ggplot(data = diamond, mapping = aes(x = price))
p + geom_histogram(bins = 100)

# �����й�����ɫ
p = ggplot(data = diamond, mapping = aes(x = price, fill = cut))
p + geom_histogram(binwidth = 500)

# �����й����ܶ�����
ggplot(data = diamond, mapping = aes(price, colour = cut)) +
  geom_freqpoly(binwidth = 500)

# ����������ͬ�й��ĶԱ�
p = ggplot(data = diamond, mapping = aes(x = price, fill = cut))
p + geom_histogram() + facet_grid( ~ cut)


## ����ͼ ##
geom_line()#����ͼӳ������

#����
# ������ָ��index���ʱ�����и�ʽ
index = c(127910, 395976, 740802, 966845, 1223419, 1465722, 1931489, 2514324, 3024847, 3174056, 3208696, 3644736, 4198117, 3868350, 3576440, 3524784, 3621275, 3695967, 3728965, 3845193, 3525579, 3452680, 3535350, 3655541, 3884779, 3780629) / 10000
dat = seq(as.Date("2017/3/28"), length = 26, by = "day")
people_index = data.frame(date = dat, index = index)
p = ggplot(people_index, mapping = aes(x = date, y = index))
p + geom_line()

#ͨ������colour������+geom_area()�������������ͼ
p + geom_line(colour = "green") + geom_area(colour = "green", alpha = 0.2)


#3)Ϊ����������ͼ

## ����ͼ ##
#���Ա����붨������--����ͼ
geom_boxplot()#����ͼӳ������

# ��������ͼ
ggplot(diamond) + geom_boxplot(aes(x = cut, y = price, fill = cut))
#��a����Ͱ�aes()�е�x����Ϊa
#̽�������b�ķֲ��Ͱ�aes()�е�y����Ϊb
#ͨ��fill�����ӵ����ɫӳ��Ϊ�������

# �����Զ�����ɫ
ggplot(diamond) + geom_boxplot(aes(x = cut, y = price, fill = cut)) + scale_fill_manual(values = c("lightpink", "lightyellow", "lightgreen", "lightblue", "mediumpurple1"))
#������Ϊ�ʺ�ɫrainbow()
ggplot(diamond) + geom_boxplot(aes(x = cut, y = price, fill = cut)) + scale_fill_manual(values = rainbow(5, alpha = 0.4))


## ɢ��ͼ ##
#������������--ɢ��ͼ
geom_point()#ɢ��ͼӳ������

# ������ͼ
p = ggplot(data = diamond, mapping = aes(x = carat, y = price))
p + geom_point()

# ����ӳ��Ԫ��
# ���ݶ��Ա�����ʶ��ͬ��ɫ
p = ggplot(data = diamond, mapping = aes(x = carat, y = price, colour = cut))
p + geom_point()

# ���ݶ���������ʶ��ͬ��ɫ
p = ggplot(data = diamond, mapping = aes(x = carat, y = price, colour = z))
p + geom_point()

# ����ͳ�Ʊ任
p = ggplot(diamond, aes(x = carat, y = price)) + geom_point()
p + scale_y_log10()

# �����������
p = ggplot(diamond, aes(x = carat, y = price)) + geom_point()
p + scale_y_log10() + stat_smooth()

# ����cut�ֿ�
p = ggplot(diamond, aes(x = carat, y = price)) + geom_point() + scale_y_log10() + stat_smooth()
p + facet_grid( ~ cut)


## ��״ͼ ##
#�������Ա���--��״ͼ

#��������ӳ��Ԫ�أ���Ϊ�ۼ���״ͼ
p=ggplot(data=diamond,mapping=aes(x=clarity,fill=cut))
p+geom_bar()


#������״ͼ
p=ggplot(data=diamond,mapping=aes(x=clarity,fill=cut))
p+geom_bar(position="dodge")









###################################
#�ܽ�#

library(ggplot2)
library(plyr)

library(cranlogs)
cran_top_downloads() #�鿴������������

#1��Ϊһ�����Ա�����ͼ
#��״ͼ 
ggplot(data,mapping) ##�Ƚ���һ���������ͼ��
geom_bar()#������״ͼӳ������
#��ͼ
ddply()
coord_polar()#���м�����任
geo_text()#Ϊ��ͼ�ӱ�ǩ
scale_fill_manual()#�ֶ��趨��ͼ����ɫ
theme()#�������ᡢ��Ȧ�ı��ȥ��

#2��Ϊһ������������ͼ
#ֱ��ͼ
geom_histogram() #ֱ��ͼӳ������
geom_freqpoly() #binwidth,bins
facet_grid( ~ cut) #����cut�ֿ�

#����ͼ
geom_line()#����ͼӳ������
geom_area()#�������ͼ

#3)Ϊ����������ͼ

#���Ա����붨������--����ͼ
geom_boxplot()#����ͼӳ������

#������������--ɢ��ͼ
geom_point()#ɢ��ͼӳ������
p + scale_y_log10()# ����ͳ�Ʊ任
stat_smooth()# �����������

#�������Ա���--��״ͼ
p=ggplot(data=diamond,mapping=aes(x=clarity,fill=cut)) #��������ӳ��Ԫ�أ���Ϊ�ۼ���״ͼ
p+geom_bar(position="dodge") #������״ͼ


###################################