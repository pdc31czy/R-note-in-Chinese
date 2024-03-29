#######R语言与非结构化数据分析#######
###4.1 文本分析###

##4.1.1 简单文本-词语

##1.描述分析
table() ##计算频数
boxplot()

##2.回归建模
##处理多水平分类变量
##引入一种变量-哑变量（虚拟变量），即0-1变量（参考本书3.3.1）
relevel()#实现基准组的设定

##哑变量前面的系数解读
##在控制其他变量的情况下，该变量相对于基准组的变化
lm()
summary()


##4.1.2 难度升级-处理长难句

##1.定长度词语提取
str_sub(text,start,end) ##设定所需文本的起始和结束位置来提取text中的相关内容

##2.单个关键词提取
grepl(keywords,text) #包含关键词则返回TRUE，否则返回FALSE

##3.多关键词匹配
ifelse()#实现打标签
#看page230例子

#正则表达式
#普通字符（如英文字母）和特殊字符（如”\""^""$"等）的字符串匹配模式
#例：
#“+”可用于匹配前面的字表达式一次或多次
#“橙子+”能匹配到“橙子”和“橙子大”，但不能匹配“大”


##4.1.3小说文本
readLines()#读入小说数据
grep()#找到包括多个空格的句子的位置，"\s+"为匹配一个或多个空格的正则表达式
cbind()#得到每一段的起始句子的位置
paste()#将属于同一段的句子合并

colSums()#计算列的和
crossprod()#实现矩阵乘法



