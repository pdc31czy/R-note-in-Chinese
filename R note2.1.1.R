#2.1.1������������

class()
#��ʾһ�����ݶ������������

as.factor()
#��������������ת����������

as.character()
#��������������ת�����ַ���

is.character()
#�鿴���������Ƿ�Ϊ�ַ��ͣ�ͬ��is.factor()

object.size()
#�۲����ݴ�С

#(һ)
#��ֵ�ͣ�numeric��
a=2; class(a)
#R������г������Դ洢���Ƶ����ֵ��������������ƴ�ԼΪ1.8*10^38
#һ����ʽ������������߸������������֣�����ͻ������������NaN��Not a Number������
exp(1000)#������
-10/0#������
exp(990)#������
exp(1000)/exp(990)#NaN���ͣ�ԭ��Ӧ����exp��10�����������������������

#������
#�ַ��ͣ�character��
a="2"
class(a)

b="����"
class(b)

"1"+"1" 
#����non-numeric argument to binary operator

#������
#�߼��ԣ�logical��
#TRUE FALSE
#��R�У�TRUE��Ӧ����1��FALSE��Ӧ����0
TRUE+FALSE
TRUE>FALSE

#���ģ�
#���������ݣ�factor��
(genders = factor(c("��","Ů","Ů","��","��")))
is.factor(genders)
class(genders)

#�ı����������ݸ�ˮƽ�ı���˳��
(class=factor(c("Poor","Improved","Excellent"),ordered = T, levels =c("Poor","Improved","Excellent")))

#ʲôʱ����Ҫ���ַ�������ת���������������أ�
#���Ա����Ͷ������
#�磺����ͼ����Ҫ�����ݷ��飬��������ı�����Ӧ�ñ��������
#�磺��Ҫ���������Ա����Ļع�ģ�ͣ����Ա�����Ҫ��������ͽ���ģ��

#���壩
#ʱ�������ݣ�Date/POSIXct/POSIXlt)
#���ַ�����ʽ����R��
#Date�������ݣ���������ʱ���ʱ����Ϣ
#POSIXct/POSIXlt�������ݣ��������ڡ�ʱ���ʱ����Ϣ

#Date�Զ�ʶ����б��(2020/12/22)�Ͷ̺��ߣ�2022-12-22��
#��as.Date()ת��
#����
moviedate="2020/12/22"
class(moviedate)
##[1] "character"
moviedate=as.Date(moviedate)
moviedate
##[1] "2020-12-22"
class(moviedate)
##[1] "Date"

#���ڸ�ʽʾ�������R���ԣ�������˼ά������ʵս�� Page49��
x<-c("1Jan1960","31mar1978")
y<-as.Date(x)
##Error in charToDate(x) : �ַ����ĸ�ʽ������׼��ȷ
y<-as.Date(x,"%d%b%Y")
y
##[1] "1960-01-01""1978-03-31"

dates <- c("02/27/92", "02/27/92")
as.Date(dates, "%m/%d/%y")
##[1] "1992-02-27" "1992-02-27" 

#POSIXct/POSIXlt�Ǿ�ȷ���뼶��ʱ���
#as.POSIXct()
as.POSIXct("2020-12-22 14:05:31")
##[1] "2020-12-22 14:05:31 CST"
as.POSIXct("December-22-2020 14:05:31")
##Error in as.POSIXlt.character(x, tz, ...) : �ַ����ĸ�ʽ������׼��ȷ
as.POSIXct("December-22-2020 14:05:31", format = "%B-%d-%Y %H:%M:%S")
##[1] "2020-12-22 14:05:31 CST"

#format()������������ʱ�����ݵ������ʽ
#����
(n=c("2016-03-14","2016-02-08")) #ԭʼ��������
m<-as.Date(n)
class(m)
##[1] "2016-03-14" "2016-02-08"

format(m,format = "%B %d %Y") #�ĳ�������ĸ�ʽ
##[1] "���� 14 2016" "���� 08 2016"

format(m,format = "%B %d %Y %A") #�������ڵ���Ϣ
##[1] "���� 14 2016 ����һ" "���� 08 2016 ����һ"

format(m,format = "%B") #ֻ��ȡ�·ݵ���Ϣ
##[1] "����" "����"

Sys.time() #���ϵͳʱ��
##[1] "2020-12-22 14:30:19 CST"

class(Sys.time()) #�鿴ʱ������
##[1] "POSIXct" "POSIXt" 

format(Sys.time(),format="%B %d %Y") #��ȡ����ʱ����Ϣ
##[1] "ʮ���� 22 2020"

format(Sys.time(),format = "%Y %B %a %H:%M:%S") #��ȡ����ʱ����Ϣ
##[1] "2020 ʮ���� �ܶ� 14:37:21"

#lubridate��һ��ר�Ÿ�Ч����ʱ�����ݵİ�
#��Ҫ�����ຯ��
#һ�ദ��ʱ������
#��һ�ദ��ʱ������
#����
library(lubridate) #���ذ�
#���ⱸע��require()��library()�����Լ��ذ���������һ����δ���صİ�ʱ��require()�ᷢ�����浫����ִ�г���������丳ֵ��X<-require("xixihaha"),�鿴X��֪������FALSE����library()�����ֹ���г��򣬲���������ˣ�дR����ĳ��ü���Ϊ����������
#���ⱸע��if(!require("cluster")) install.packages("cluster")
#���ⱸע��library(cluster)

x= c(20090101,"2009-01-02","2009 01 03","2009-1-4","2009-1,5","Created on 2009 1 6", "200901 !!! 07")
ymd(x)
##[1] "2009-01-01" "2009-01-02" "2009-01-03" "2009-01-04" "2009-01-05" "2009-01-06" "2009-01-07"

mday(as.Date("2020-12-22")) #Get/set days component of a date-time
##[1] 22

wday(as.Date("2020-12-22")) #Get/set days component of a date-time
##[1] 3

hour(as.POSIXct("2020-12-22 14:30:19")) #Get/set hours component of a date-time
##[1] 14

minute(as.POSIXct("2020-12-22 14:30:19")) #Get/set minutes component of a date-time
##[1] 30

#ʱ�������ݵĲ���
#1������
begin=as.Date("2019-11-21")
end=as.Date("2020-12-22")

#����һ��ֱ�����
#�������������������
(during=end-begin)
##Time difference of 397 days

#��������������difftime����������ȡ
#�������������ھ����������������Сʱ��
difftime(end,begin,units="days")
##Time difference of 397 days
difftime(end,begin,units="weeks")
##Time difference of 56.71429 weeks
difftime(end,begin,units="hours")
##Time difference of 9528 hours

#2������
#sort()  #��������������
#order() #����һ����������������������ԭ�����е�λ��
#���忴Page52


#################################
#�ܽ�#

class() #��ʾһ�����ݶ������������
as.factor() #��������������ת����������
as.character() #��������������ת�����ַ���
is.character() #�鿴���������Ƿ�Ϊ�ַ��ͣ�ͬ��is.factor()
object.size() #�۲����ݴ�С
as.Date() #Date�Զ�ʶ����б��(2020/12/22)�Ͷ̺��ߣ�2022-12-22��
format() #��������ʱ�����ݵ������ʽ
as.POSIXct() #POSIXct/POSIXlt�Ǿ�ȷ���뼶��ʱ���
Sys.time() #���ϵͳʱ��
require() #���ذ�
library(lubridate) #���ذ� #lubridate��һ��ר�Ÿ�Ч����ʱ�����ݵİ�
ymd(x) #library(lubridate)
mday(as.Date("2020-12-22")) #Get/set days component of a date-time
wday(as.Date("2020-12-22")) #Get/set days component of a date-time
hour(as.POSIXct("2020-12-22 14:30:19")) #Get/set hours component of a date-time
minute(as.POSIXct("2020-12-22 14:30:19")) #Get/set minutes component of a date-time
difftime() #�������������ھ����������������Сʱ��

################################







