#2.2.1结构化数据读入

#1、创建
#章节2.1.x 对四种基本结构的创建都做了详细介绍

#2、读入
#R可以导入Minitab,SAS,Stata.Sql里的数据
#这里详细说明三种常见的数据格式-txt,csv,xls(xlsx)


## 从txt中读入 ##

read.table(file_name,header=logical_value,sep="") #header默认FALSE
#file_name表示文件名
#header用于设置是否把数据的第一列识别为变量名
#sep用来指定文件中的分隔符

#（一）file_name是数据文件的完整路径
# 输入完整路径，可以顺利读入文件,下面命令可读入存在Downloads文件夹中的movie文件，用户请根据自己的文件路径修改运行
#例：
movie_txt = read.table("C:/Users/PC/Desktop/R/Rsourse/movie.txt", header = T, fileEncoding = "UTF-8")
head(movie_txt)

#（二）file_name只需要简单地写文件名，把数据文件拷贝到工作目录(working directory)

#获取工作目录
getwd()
##[1] "C:/Users/PC/Desktop"

#改变工作目录
setwd("C:\\Users\\PC\\Desktop\\R") #绝对路径
getwd()
##[1] "C:/Users/PC/Desktop/R"

setwd(".\\Rsourse") #相对路径
getwd()
##[1] "C:/Users/PC/Desktop/R/Rsourse"

setwd("..\\") #上一级目录
getwd()
##[1] "C:/Users/PC/Desktop/R"

# 先把movie文件转移到该工作目录下，即可采用以下命令直接用文件名读取
#例：
movie_txt = read.table("movie.txt", header = T, fileEncoding = "UTF-8")
head(movie_txt)



## 从csv中读入 ## (comma separated values,用逗号分隔的文件)
# 一定要设置分隔符sep = ","
tes = read.table("电影数据.csv", header = T, sep = ",", fileEncoding = "UTF-8")
head(tes)
#但是其实读入csv，不用read.table(),以上仅仅阐释分隔符的含义

#专用函数read.csv
read.csv("file_name",header=logical_value) #header默认TRUE
#例：
movie_csv = read.csv("电影数据.csv", fileEncoding = "UTF-8")
head(movie_csv)
#解决文件的编码问题，设定参数fileEncoding 
#无法对文字运用文本函数时，可能是读入时R默认变成了factor，设定参数stringsAsFactors


## 从xls,xlsx中读入数据 ##
#由于xls(xlsx)这种数据格式不如csv跨平台兼容性好
#先将其另存为csv格式，再按照csv读取

# install.packages("readxl")
library("readxl") #读取excel数据的包,read_excal()可读取xls(xlsx)的某个sheet

# 其中col_names参数仍然是为了设定是否把第一行当做变量名
movie_excel = data.frame(read_excel("电影数据.xlsx", col_names = T)); head(movie_excel)





###########################################################
#总结#

read.table(file_name,header=logical_value,sep="") #header默认FALSE
movie_txt = read.table("C:/Users/PC/Desktop/R/Rsourse/movie.txt", header = T, fileEncoding = "UTF-8")
getwd()
setwd("C:\\Users\\PC\\Desktop\\R")
setwd(".\\Rsourse")
setwd("..\\")
movie_txt = read.table("movie.txt", header = T, fileEncoding = "UTF-8")
read.csv("file_name",header=logical_value) #header默认TRUE
movie_csv = read.csv("电影数据.csv", fileEncoding = "UTF-8")
library("readxl") #读取excel数据的包,read_excal()可读取xls(xlsx)的某个sheet
movie_excel = data.frame(read_excel("电影数据.xlsx", col_names = T)); head(movie_excel)


###########################################################

