#2.2.1�ṹ�����ݶ���

#1������
#�½�2.1.x �����ֻ����ṹ�Ĵ�����������ϸ����

#2������
#R���Ե���Minitab,SAS,Stata.Sql�������
#������ϸ˵�����ֳ��������ݸ�ʽ-txt,csv,xls(xlsx)


## ��txt�ж��� ##

read.table(file_name,header=logical_value,sep="") #headerĬ��FALSE
#file_name��ʾ�ļ���
#header���������Ƿ�����ݵĵ�һ��ʶ��Ϊ������
#sep����ָ���ļ��еķָ���

#��һ��file_name�������ļ�������·��
# ��������·��������˳�������ļ�,��������ɶ������Downloads�ļ����е�movie�ļ����û�������Լ����ļ�·���޸�����
#����
movie_txt = read.table("C:/Users/PC/Desktop/R/Rsourse/movie.txt", header = T, fileEncoding = "UTF-8")
head(movie_txt)

#������file_nameֻ��Ҫ�򵥵�д�ļ������������ļ�����������Ŀ¼(working directory)

#��ȡ����Ŀ¼
getwd()
##[1] "C:/Users/PC/Desktop"

#�ı乤��Ŀ¼
setwd("C:\\Users\\PC\\Desktop\\R") #����·��
getwd()
##[1] "C:/Users/PC/Desktop/R"

setwd(".\\Rsourse") #���·��
getwd()
##[1] "C:/Users/PC/Desktop/R/Rsourse"

setwd("..\\") #��һ��Ŀ¼
getwd()
##[1] "C:/Users/PC/Desktop/R"

# �Ȱ�movie�ļ�ת�Ƶ��ù���Ŀ¼�£����ɲ�����������ֱ�����ļ�����ȡ
#����
movie_txt = read.table("movie.txt", header = T, fileEncoding = "UTF-8")
head(movie_txt)



## ��csv�ж��� ## (comma separated values,�ö��ŷָ����ļ�)
# һ��Ҫ���÷ָ���sep = ","
tes = read.table("��Ӱ����.csv", header = T, sep = ",", fileEncoding = "UTF-8")
head(tes)
#������ʵ����csv������read.table(),���Ͻ������ͷָ����ĺ���

#ר�ú���read.csv
read.csv("file_name",header=logical_value) #headerĬ��TRUE
#����
movie_csv = read.csv("��Ӱ����.csv", fileEncoding = "UTF-8")
head(movie_csv)
#����ļ��ı������⣬�趨����fileEncoding 
#�޷������������ı�����ʱ�������Ƕ���ʱRĬ�ϱ����factor���趨����stringsAsFactors


## ��xls,xlsx�ж������� ##
#����xls(xlsx)�������ݸ�ʽ����csv��ƽ̨�����Ժ�
#�Ƚ�������Ϊcsv��ʽ���ٰ���csv��ȡ

# install.packages("readxl")
library("readxl") #��ȡexcel���ݵİ�,read_excal()�ɶ�ȡxls(xlsx)��ĳ��sheet

# ����col_names������Ȼ��Ϊ���趨�Ƿ�ѵ�һ�е���������
movie_excel = data.frame(read_excel("��Ӱ����.xlsx", col_names = T)); head(movie_excel)





###########################################################
#�ܽ�#

read.table(file_name,header=logical_value,sep="") #headerĬ��FALSE
movie_txt = read.table("C:/Users/PC/Desktop/R/Rsourse/movie.txt", header = T, fileEncoding = "UTF-8")
getwd()
setwd("C:\\Users\\PC\\Desktop\\R")
setwd(".\\Rsourse")
setwd("..\\")
movie_txt = read.table("movie.txt", header = T, fileEncoding = "UTF-8")
read.csv("file_name",header=logical_value) #headerĬ��TRUE
movie_csv = read.csv("��Ӱ����.csv", fileEncoding = "UTF-8")
library("readxl") #��ȡexcel���ݵİ�,read_excal()�ɶ�ȡxls(xlsx)��ĳ��sheet
movie_excel = data.frame(read_excel("��Ӱ����.xlsx", col_names = T)); head(movie_excel)


###########################################################
