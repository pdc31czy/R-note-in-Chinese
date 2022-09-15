#3.1.3 �������ݿ��ӻ�
#plotly�Ǹ�����ʽ���ӻ��ĵ�������
#http://plot.ly/

plot_ly(x,y,type) #ͨ���������еĲ���type���任ͼ������

## ��ȡ���� ##
rm(list = ls())
# install.packages("plotly")
library(plotly) #ʵ�ֽ������ӻ�
# install.packages(plyr)
library(plyr)
# install.packages("reshape")
library(reshape)

#���½�������������
load("AAPL.rda")
load("pm2.5.rda")
novel = read.csv("novel.csv", fileEncoding = "UTF-8", stringsAsFactors = F)
names(beijing) = iconv(names(beijing), "utf-8", "gbk")  # ���Windows�û������������⣬Mac�û�������
head(AAPL)
head(beijing)


### �������� ###

## ��״ͼ ##
#(1)�������Ա���--��״ͼ
plot_ly(x,y,type="bar")#�����״ͼ
#����
(region = colnames(beijing))
(ave = colMeans(beijing, na.rm = TRUE))
(p = plot_ly(x = region, y = ave, type = "bar"))

#ͨ��marker�е�color���������������Ӷ�Ӧ����ɫ
#����Ҫ����ɫ��RGBֵ�Լ�alpha͸����ֵ����rgba�Ϳ��ԴﵽĿ��
#����
(p = plot_ly(x = region, y = ave, type = "bar",
             marker = list(color = c('rgba(204,204,204,1)', 'rgba(204,204,204,1)', 'rgba(204,204,204,1)',
                                     'rgba(204,204,204,1)', 'rgba(204,204,204,1)', 'rgba(204,204,204,1)',
                                     'rgba(204,204,204,1)', 'rgba(222,45,38,0.8)'))
))


## ��ͼ ##
#(2)�������Ա���--��ͼ
plot_ly(pieData, values = ~ value, labels = ~ group, type = "pie") 
#labels ��������������ƣ�values����ָ������Ƶ��
#����
(pieData = data.frame(value = c(10, 30, 40), group = c("A", "B", "C")))
(p = plot_ly(pieData, values = ~ value, labels = ~ group, type = "pie"))

layout()#��������
#����
layout(p,
       xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
       yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
#xaxis,yaxis������������������
#showgrid����ΪFALSE����ȥ��ͼ�����������
#zeroline����ΪFALSE��������ʾ�ᣨ�ݣ������������
#showticklabels����ΪFALSE��������ԭ�ȷֲ����������ϵ�����


## ֱ��ͼ ##
#(3)������������--ֱ��ͼ
head(AAPL)
plot_ly(AAPL, x = ~ Volume, type = "histogram")#��ʾ��Volume����ӳ�䵽x����

# ���������ἰ������Ϣ
p = plot_ly(AAPL, x = ~ Volume, type = "histogram")
#����ͼ�εı���ͺ�����������Ҫ�������layout()����������
layout(p,
       title = "ƻ����Ʊ�ɽ����ֲ�ֱ��ͼ", 
       xaxis = list( title = "��Ʊ�ɽ���", showgrid = F),     
       yaxis = list( title = "Ƶ��"),    
       margin = list(l = 50, r = 50, b = 50, t = 50, pad = 4)
)
#margin�����˶�ͼ���������ϱ߽������


## ����ͼ ##
#(4)������������--����ͼ
plot_ly(mat, x = ~ Date, y = ~ AAPL, type = 'scatter', mode = 'lines')
#�ؼ�������������type="scatter",mode="lines"

# ƻ����˾�ɼ۱仯ͼ��DateΪʱ�䣬Adj.CloseΪ��Ʊÿ�յĵ������̼�
mat = data.frame(Date = AAPL$Date, 
                 AAPL = round(AAPL$Adj.Close, 2))
p = plot_ly(mat, x = ~ Date, y = ~ AAPL, type = 'scatter', mode = 'lines')
layout(p, xaxis = list(title = " ", showticklabels = TRUE, tickfont = list(size = 8)))


# ����С��ҵ�����ӷ���������(page157)
# ����ƻ�����������ڣ�����%>%Ϊ�ܵ����ţ�����ǰ��Ľ��������Ϊ���ź��溯���ĵ�һ����������
apple = data.frame(Date = AAPL$Date,
                   price = round(AAPL$Adj.Close, 2))
rownames(apple) = AAPL$Date

annouced = c("2010-06-07", "2011-10-04", "2012-09-12", "2013-09-10", "2014-09-09", "2015-09-09", "2016-09-08")
product = c("iPhone 4", "iPhone 4s", "iPhone 5", "iPhone 5s", "iPhone 6", "iPhone 6s", "iPhone 7")
(p = plot_ly(apple,x = ~ Date) %>% 
    add_trace(y = ~ price, type = 'scatter', mode = 'lines', name = "��Ʊ�۸�") %>%
    add_trace(x = annouced, y = apple[annouced, "price"], type = 'scatter', mode = 'text', text = product, textposition = 'down', showlegend = FALSE ) %>% 
    add_trace(x = annouced, y = apple[annouced, "price"], type = 'scatter', mode = 'markers', name = "������" ) %>% 
    layout(title = "ƻ����Ʊ�۸�����ƻ���ֻ��ķ���", 
           xaxis = list(title = " ", showticklabels = TRUE, tickfont = list(size = 8)),
           yaxis = list(title = "�������̼ۣ���Ԫ��"),
           margin = list(l = 50, r = 50, b = 50, t = 50, pad = 4)))



### �������� ###

## ����ͼ ##
#(5)�����붨������--��������ͼ
plot_ly(novel_finish, y = ~ ������, color = ~ С˵����, type = "box")

        
#����
# ѡ���Ѿ����С˵
novel_finish = novel[novel$д������ %in% c("�Ѿ��걾", "�ӽ�β��", "������"), ]
medi = ddply(novel_finish, .(С˵����), function(x) {median(x$������)})
medi = medi[order(medi$V1, decreasing = T), ]
novel_finish$С˵���� = factor(novel_finish$С˵����, levels = medi$С˵����)
(p = plot_ly(novel_finish, y = ~ ������, color = ~ С˵����, type = "box"))

## ɢ��ͼ ##
#(6)������������--ɢ��ͼ
(p = plot_ly(novel, x = ~ �ܵ����, y = ~ ������, type = "scatter", mode = "markers"))


## ��������ͼ ##
#(7)�������Ա���--������״ͼ
plot_ly(novel, x = ~ С˵����, color = ~ С˵����, type = "histogram")
#��������״ͼӦ����type="histogram"

#����
novel = novel[!novel$С˵���� == "", ]
p = plot_ly(novel, x = ~ С˵����, color = ~ С˵����, type = "histogram")
layout(p,
       title = "��ͬС˵����Ʒ���ͷֲ�", 
       xaxis = list( title = "С˵����", showgrid = F, showticklabels = TRUE, tickfont = list(size = 10)),     
       yaxis = list( title = "Ƶ��"),    
       margin = list(l = 50, r = 50, b = 50, t = 50, pad = 4)
)





######################################################
#�ܽ�#

library(plotly) #ʵ�ֽ������ӻ�
library(plyr)
library(reshape)

plot_ly(x,y,type) #ͨ���������еĲ���type���任ͼ������

### �������� ###
#(1)�������Ա���--��״ͼ
plot_ly(x,y,type="bar")#�����״ͼ
rgba() #����������ɫ�Լ�͸����

#(2)�������Ա���--��ͼ
plot_ly(pieData, values = ~ value, labels = ~ group, type = "pie")#labels ��������������ƣ�values����ָ������Ƶ�� 
layout()#�������֣����غ�����

#(3)������������--ֱ��ͼ
plot_ly(AAPL, x = ~ Volume, type = "histogram")
layout()#����ͼ�εı���ͺ�����������Ҫ�������layout()����������

#(4)������������--����ͼ
plot_ly(mat, x = ~ Date, y = ~ AAPL, type = 'scatter', mode = 'lines')#�ؼ�������������type="scatter",mode="lines"

### �������� ###

#(5)�����붨������--��������ͼ
plot_ly(novel_finish, y = ~ ������, color = ~ С˵����, type = "box")

#(6)������������--ɢ��ͼ
plot_ly(novel, x = ~ �ܵ����, y = ~ ������, type = "scatter", mode = "markers")

#(7)�������Ա���--������״ͼ
plot_ly(novel, x = ~ С˵����, color = ~ С˵����, type = "histogram")#��������״ͼӦ����type="histogram"

######################################################