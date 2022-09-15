#2.2.2非结构化数据-文本数据读入
rm(list = ls()) #清空工作空间

## 1.读入简单文本数据 ##

#假如数据包含大量经过结构化的文本数据
#只需按照读入csv等标准式数据的方法读入
#例：
novel = read.csv("novel.csv", fileEncoding = "UTF-8")
head(novel)  


## 2.用readtable读入文本 ##

# 文本数据普通读法
test = read.table("weibo.txt", sep = "\t") #错误！
##Error in scan(file = file, what = what, sep = sep, quote = quote, dec = dec,  : 
##line 1 did not have 29 elements

#读入数据时遇到Error，这是因为read.table()只能读入完整的横行数列的数据
# 空字段需要fill参数来填满
#fill=T,让R在所有空字段部分补上一个空格

test = read.table("weibo.txt", sep = "\t", fill = T)#错误!
##Warning message:
##  In scan(file = file, what = what, sep = sep, quote = quote, dec = dec,  :
##            EOF within quoted string

#EOF(end of file)在文件的末尾有一个被引号括起来的字符串有问题
#这里是包含了很多\n\t的换行制表符，原本应该被读入到下面行的记录被莫名其妙地挤在这一个格子（Page102）

#解决办法：将read.table()参数中的quote重新设置为空，即加入quote=""
# 设置quote = ""意思是禁止所有引用符号
#因为R默认取值是quote="\"",将其设置为quote="",表明R完全禁用引用
#而且在R中，单引号被认为是字符串开始或结束的标记
#设置quote="",告诉R不要把"'"识别为一个字符开始或结束的标记

#注意的是，有时R在发生这个错误时不提示Error或者Warning
#实际上读入的数据比真实的数据行数要少
#在将一份数据读入R前，最好能在其他软件中先看看它的行列数

weibo = read.table("weibo.txt", sep = "\t", fill = T, quote = "", fileEncoding = "UTF-8")

# stringsAsFactors将文本转化为字符，strip.white将字符中的前后空格去掉
weibo = read.table("weibo.txt", sep = "\t", fill = T, quote = "", strip.white = T, stringsAsFactors = F, fileEncoding = "UTF-8")
head(weibo)

#异常数据
#查看第75至80行数据,缺失数据
weibo[75:80, ]
#处理缺失数据，用substr()
weibo = weibo[substr(weibo$V1, 1, 2) == "熊粉", ]



## 3.用readLines读入文本 ##
readLines() #将文本按行读入，每一行作为一个字符存储起来，所以整个文件读入就是一个字符串

#例：
# weibo1是个字符向量
weibo1 = readLines("weibo.txt", encoding = "UTF-8")
head(weibo1)

strsplit(x,split) #根据split将x分割，最终分割结果以列表形式输出

#例：
# 使用字符分割函数将weibo1分开
tmp = strsplit(weibo1, " \t") 
class(tmp)
##  [1] "list" #检查是否最终以列表形式输出

tmp[1:2] #查看第一和第二个结果
head(tmp) #查看前六个结果
tmp[[1]] #查看第一个结果
tmp[1] #查看第一个结果



#原始数据中包含许多无用的行，需要先把这些杂乱的行去掉再合并成表
#问题行的特征是，只在第一和第二列有文字，后面指标取值基本全是空白
#查出每个list的元素的长度，来查看异常值
ll = sapply(tmp, length)     

table(ll)
##  ll
##   0  1  7  8  #长度
##   2  3 26 74  #长度为0，1，7，8的行数

# 长度为0和1是异常行，长度为7和8的可以采用，其中7是缺少最后一列描述的行

# 检验是否均在最后一行缺失,hi即储存所有长度为7的行的最后一个元素
hi = c()
for(i in 1:26) #26是因为有26行长度为7
{
  show(i) #显示i相对应的数字，则最后一行缺失，我猜的，没想明白。。。
  hi[i] = tmp[ll == 7][[i]][7]
}

tmp[ll == 7][1] #表示的是，长度为7的行数的第一个输出结果
tmp[ll == 7][26] #第八个字符的确缺失

# 对含有7个字符补充一个空字符,使得最后选择数据框较完整
tmp[ll == 7] = lapply(tmp[ll == 7], function(x) c(x, ""))                              
tmp[ll == 7][1] #对比前面，这里第八个字符已经有了，是空字符""

#额外备注：lapply(x,function) 
#第一个参数是需要的数据，可以是向量或者列表的形式
#第二个参数是函数，lapply返回的是一个列表

#例：
a<-c(1,2,3)
lapply(a,function(x)x^2)
##[[1]]
##[1] 1
##
##[[2]]
##[1] 4
##
##[[3]]
##[1] 9


# 将原来含有7个字符和8个字符的合在一起
infoDf = as.data.frame(do.call(rbind, tmp[ll == 7 | ll == 8]), stringsAsFactors = F)     
colnames(infoDf) = c("name", "location", "gender", "Nfollowers",
                     "Nfollow", "Nweibo", "createTime", "description")               
head(infoDf)



## 4.readLines的其他用法 ##
#例：
yitian = readLines("倚天屠龙记.Txt", encoding = "UTF-8")
yitian[1:10]

grep(pattern,x) #查找固定模式数据
#查找x向量中符合pattern模式的字符位置
#pattern可以是一些固定字符，也可以采用正则表达式规则

#例：
# 分段
# 在每个字符中找至少有一个空格的标号
para_head = grep("\\s+", yitian,perl = T)
para_head[1:10]
##   [1]  1  2  6 14 20 22 28 55 61 81 
#para_head给出了段落开始地方所在的行数

#额外备注：
#R有三类正则表达式
#grep(extended=TRUE)是默认的extended正则表达式
#grep(extended=FALSE)是basic正则表达式
#grep(perl=TRUE)是perl正则表达式
help("regex") #了解正则表达式

# 首先构造一个矩阵，第一列是一段之首的序号，第二列是一段之尾的序号
cut_para1 = cbind(para_head[1:(length(para_head) - 1)], para_head[-1] - 1)
head(cut_para1)
##       [,1] [,2]
##  [1,]    1    1
##  [2,]    2    5
##  [3,]    6   13
##  [4,]   14   19
##  [5,]   20   21
##  [6,]   22   27

# 编写一个函数，将属于一段的文字粘贴起来
yitian_para = sapply(1:nrow(cut_para1), function(i) paste(yitian[cut_para1[i, 1]:cut_para1[i, 2]], collapse = ""))
yitian_para[1:4]



###############################################################
#总结#


weibo = read.table("weibo.txt", sep = "\t", fill = T, quote = "", strip.white = T, stringsAsFactors = F, fileEncoding = "UTF-8")
weibo = weibo[substr(weibo$V1, 1, 2) == "熊粉", ]#处理缺失数据
readLines() #将文本按行读入，每一行作为一个字符存储起来，所以整个文件读入就是一个字符串
strsplit(x,split) #根据split将x分割，最终分割结果以列表形式输出
lapply(x,function())
infoDf = as.data.frame(do.call(rbind, tmp[ll == 7 | ll == 8]), stringsAsFactors = F)     
colnames(infoDf) = c("name", "location", "gender", "Nfollowers","Nfollow", "Nweibo", "createTime", "description")  
grep(pattern,x) #查找固定模式数据
#R有三类正则表达式
#grep(extended=TRUE)是默认的extended正则表达式
#grep(extended=FALSE)是basic正则表达式
#grep(perl=TRUE)是perl正则表达式
help("regex") #了解正则表达式
cut_para1 = cbind(para_head[1:(length(para_head) - 1)], para_head[-1] - 1)
yitian_para = sapply(1:nrow(cut_para1), function(i) paste(yitian[cut_para1[i, 1]:cut_para1[i, 2]], collapse = ""))


###############################################################








