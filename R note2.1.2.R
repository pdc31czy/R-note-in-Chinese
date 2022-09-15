#2.1.2 向量（Vector）
#数据结构：数据元素组织在一起的方式
#四种数据结构：向量、矩阵、数据框、列表

#向量：存储同一种类型数据的一维数组
#向量的样子，例(如下）：存储同种类型-字符型
#"1" "R" "TRUE"

#(一）创建
#采用函数c()

#假如是等差数列，用seq()函数
#假如是从1到10的连续整数，使用1：10
#从一串数字中随机抽取几个数，使用sample()
#用字符串的粘贴功能函数paste0(),可以把字符和数字有规律地结合起来

#例：
h=c(1,1,1,2,3,3,1,2,4,4,5)
##[1] 1 1 1 2 3 3 1 2 4 4 5
class(h)
##[1] "numeric"

c("a","b","c","d")
# "a" "b" "c" "d"
class(c("a","b","c","d"))
##[1] "character"

seq(0,10,by=2) #seq(起始值，终止值，步长)
##[1]  0  2  4  6  8 10

1:10
##[1]  1  2  3  4  5  6  7  8  9 10

#额外备注：set.seed()
#set.seed(123)函数，此函数作用是为了，但你需要使用随机数时，可保证你在执行或者调试后，计算机所创造的随机数保持不变。
#换句话说，如果使用随机函数rnorm(10)之类的函数，每次执行后，结果都是不一样的，
#如果再次之前使用set.seed()函数，则会保证测试数据保持一致

#例:
rnorm(3)
##[1] -1.2070657  0.2774292  1.0844412
rnorm(3)
##[1] -2.3456977  0.4291247  0.5060559

#上面两个随机抽数都是不一样的，但是假如用了set.seed()就会一直都是这个随机数
set.seed(123)
rnorm(3)
##[1] -0.5604756 -0.2301775  1.5587083
set.seed(123)
rnorm(3)
##[1] -0.5604756 -0.2301775  1.5587083 

set.seed(1234)
sample(1:10,5)
##[1] 10  6  5  4  1

paste0("x_",1:5) #可用于批量命名变量时
##[1] "x_1" "x_2" "x_3" "x_4" "x_5"

#（二）引用
#在方括号[]中调用元素所处的位置
#假如不知道在哪里，则需用which()

#例：
#引用x向量中的第5个元素
x <- c(1,1,1,2,3,3)
x[5]
##[1] 3

#想看看x向量中3所在的位置
which(x==3)
##[1] 5 6

#获取最大值和最小值的位置
which.max(x)
##[1] 5
which.min(x)
##[1] 1

#（三）集合运算
#求交集intersect()
#求并集union()
#求差集setdiff()

#例：
intersect(c(1,2,3,3,12,4,123,12),c(1,2,3))
##[1] 1 2 3

union(c("臭宝","是"), c("是","狗"))
##[1] "臭宝" "是"   "狗" 

setdiff(10:2,5:3)
##[1] 10  9  8  7  6  2

#数值向量
#数值向量常用函数
length(vector) #提取向量的长度
max(vector) #提取向量中的最大值
min(vector) #提取向量中的最小值
mean(vector) #提取向量的平均值
median(vector) #提取向量的中位数
quantile(vector,prob=seq(0,1,0.25)) #提取向量的分位数
sort(vector) #将向量重新排序
rank(vector) #返回向量x的秩，即x中数字的大小顺序
order(vector) #返回一个向量升序排序后的数字在原数据中的位置
match(x,y) #在y中逐个查找x，并返回在y中匹配的位置，若无返回NA
cut(x,breaks,label) #将数值型数据分区间转换成因子型数据，即将数值型数据离散化

#例：
x=c(1,1,1,2,3,3,1,2,4,1,2,4,4,2,3,4,1,2,3,4)
sort(x)
##[1] 1 1 1 1 1 1 2 2 2 2 2 3 3 3 3 4 4 4 4 4
rank(x)
##[1]  3.5  3.5  3.5  9.0 13.5 13.5  3.5  9.0 18.0  3.5  9.0 18.0 18.0  9.0 13.5
##[16] 18.0  3.5  9.0 13.5 18.0
order(x)
##[1]  1  2  3  7 10 17  4  8 11 14 18  5  6 15 19  9 12 13 16 20
order(sort(x))
##[1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
x[order(x)] #跟sort()的效果一样
##[1] 1 1 1 1 1 1 2 2 2 2 2 3 3 3 3 4 4 4 4 4

#match()
#match(x,y) #在y中逐个查找x，并返回在y中匹配的位置，若无返回NA
#例1：
(y=letters[x]) #letters是一个内置字符串，里面存储26个字母字符
##[1] "a" "a" "a" "b" "c" "c" "a" "b" "d" "a" "b" "d" "d" "b" "c" "d" "a" "b" "c"
##[20] "d"
(z=letters[1:4])
##[1] "a" "b" "c" "d"
match(y,z)
##[1] 1 1 1 2 3 3 1 2 4 1 2 4 4 2 3 4 1 2 3 4

#例2：
p<-c("Ziyan","Zain")
i<-c("Ziyan","love","miss","Zain")
match(p,i)
##[1] 1 4
match(i,p)
##[1]  1 NA NA  2

#例3：
k<-c("c","x","z","y")
match(k,letters[1:26])
##[1]  3 24 26 25

#cut() 连续数据离散化
#cut(x,breaks,label) #将数值型数据分区间转换成因子型数据，即将数值型数据离散化

#例1：
(Age=sample(21:100,20,replace=T))
## [1] 25 58 36 24 90 99 98 34 76 82 24 24 41 60 76 87 25 86 67 60
#将年龄数据离散化
label=c('壮年','中年','长辈','老年')
(ages=cut(Age,breaks=c(20,30,50,70,100),labels=label))
##[1] 老年 壮年 中年 长辈 长辈 老年 壮年 老年 壮年 老年 中年 中年 壮年 长辈 老年
##[16] 中年 长辈 老年 老年 老年
##Levels: 壮年 中年 长辈 老年

#例2：
j1<-c(23,62,72,80,59,82,90,43,94)
break1<-fivenum(j1) ##breaks:采用fivenum():返回五个数据：最小值、下四分位数、中位数、上四分位数、最大值
break1
##[1] 23 59 72 82 94
labels = c("差", "中", "良", "优")
j2<-cut(j1,break1,labels,ordered_result = T)
j2
##[1] <NA> 中   中   良   差   良   优   差   优  
##Levels: 差 < 中 < 良 < 优

##cut():切割将x的范围划分为时间间隔，并根据其所处的时间间隔对x中的值进行编码
##参数：breaks:两个或更多个唯一切割点或单个数字（大于或等于2）的数字向量，给出x被切割的间隔的个数
##labels：为区间数，打标签
##ordered_result:逻辑：结果应该是一个有序的因素吗？

#字符向量
#字符向量处理函数
nchar(vector) #提取字符串的长度
substr(char1,begin,end) #从字符串char1提取子字符串
paste(char1,char2) #粘贴两个字符串
grep(char1,x) #查找字符向量x中字符串char1的位置
gsub(char1,char2,x) #将字符向量x中的字符char1替换为字符char2

#nchar()用来提取字符串的长度
#例：
nchar("臭屁宝")
##[1] 3
nchar("I Love You")
##[1] 10

#substr()对字符进行切分
#substr("char",begin_position,end_position)
#例：
substr("宝宝是臭屁宝",4,6)
##[1] "臭屁宝"
substr("I miss you so much",1,10)
##[1] "I miss you"

#paste()把字符变大
#例：
paste(c("臭宝","是个","大傻逼"), collapse = "")
##[1] "臭宝是个大傻逼"
paste("D",1:5)
##[1] "D 1" "D 2" "D 3" "D 4" "D 5"

#collapse是用来给结果的各个元素加连接符的参数
#sep也是一个连接参数
#观察区别
#例1：
paste(1:5,collapse ="" ) #collapse把向量内部的元素粘连起来
##[1] "12345"
paste(1:5,sep="")  #seq适用于把不同向量分别粘起来，所以在这里没起作用
##[1] "1" "2" "3" "4" "5"

paste(1:5,collapse = "_")
##[1] "1_2_3_4_5"
paste(1:5,seq = "_")
##[1] "1 _" "2 _" "3 _" "4 _" "5 _"

paste("D",1:5)
##[1] "D 1" "D 2" "D 3" "D 4" "D 5"
paste("D",1:5,sep="")
##[1] "D1" "D2" "D3" "D4" "D5"
paste("D",1:5,collapse = "")
##[1] "D 1D 2D 3D 4D 5"

paste("D",1:5,sep="_")
##[1] "D_1" "D_2" "D_3" "D_4" "D_5"
paste("D",1:5,collapse = "_")
##[1] "D 1_D 2_D 3_D 4_D 5"

#例2：
paste(LETTERS[1:4],1:4,collapse="")
##[1] "A 1B 2C 3D 4"
paste(LETTERS[1:4],1:4)
##[1] "A 1" "B 2" "C 3" "D 4"
paste(LETTERS[1:4],1:4,sep="_")
##[1] "A_1" "B_2" "C_3" "D_4"
paste(LETTERS[1:4],1:4,collapse="|")
##[1] "A 1|B 2|C 3|D 4"
paste(LETTERS[1:4],1:4,sep="_",collapse="|")
##[1] "A_1|B_2|C_3|D_4"

#查找替换函数
#用来查找的函数grep()
#用来替换的函数gsub()
#例1：
txt=c("臭屁宝","Zain","Nov4","生日")
grep("Zain",txt) #返回含有关键字的字符位置
##[1] 2
gsub("生日","Birthday",txt)
##[1] "臭屁宝"   "Zain"     "Nov4"     "Birthday"

#例2：
# grep返回movie的name中包含“青春”的行号8，movie[8, ]即提取出movie数据集的第8行
(index = grep("青春", movie$name))
##  [1] 8
(young = movie[index, ])
##              name boxoffice doubanscore type duration  showtime director
##  8 谁的青春不迷茫  17798.89         6.4 爱情      108 2016/4/22   姚婷婷
##     star1 index1  star2 index2
##  8 白敬亭  14759 郭姝彤    755
# 看看它的豆瓣评分和票房处于我们电影数据集中的什么位置
young$doubanscore > mean(movie$doubanscore)
##  [1] TRUE
young$boxoffice > mean(movie$boxoffice)
##  [1] FALSE

#例3：把薪酬从文本转换成数值，计算平均值和中位数
salary = c("22万", "30万", "50万", "120万", "11万")
(salary0 = gsub("万", "0000", salary))
##  [1] "220000"  "300000"  "500000"  "1200000" "110000"
mean(as.numeric(salary0))
##  [1] 466000
median(as.numeric(salary0))  # 结果是科学计数法的形式
##  [1] 3e+05


##########################
#总结#

seq() #seq(起始值，终止值，步长)
set.seed()
rnorm()
sample()
paste0() #可用于批量命名变量时
which(x==3) #想看看x向量中3所在的位置
which.max(x)#获取最大值的位置
which.min(x)#获取最小值的位置
intersect()#求交集
union()#求并集
setdiff()#求差集

#数值向量常用函数
length(vector) #提取向量的长度
max(vector) #提取向量中的最大值
min(vector) #提取向量中的最小值
mean(vector) #提取向量的平均值
median(vector) #提取向量的中位数
quantile(vector,prob=seq(0,1,0.25)) #提取向量的分位数
sort(vector) #将向量重新排序
rank(vector) #返回向量x的秩，即x中数字的大小顺序
order(vector) #返回一个向量升序排序后的数字在原数据中的位置
match(x,y) #在y中逐个查找x，并返回在y中匹配的位置，若无返回NA
cut(x,breaks,label) #将数值型数据分区间转换成因子型数据，即将数值型数据离散化

letters[x] #letters是一个内置字符串，里面存储26个字母字符
fivenum() #返回五个数据：最小值、下四分位数、中位数、上四分位数、最大值

#字符向量处理函数
nchar(vector) #提取字符串的长度
substr(char1,begin,end) #从字符串char1提取子字符串
paste(char1,char2) #粘贴两个字符串
grep(char1,x) #查找字符向量x中字符串char1的位置
gsub(char1,char2,x) #将字符向量x中的字符char1替换为字符char2

#########################


#额外补充
#DataCamp的笔记
# Poker and roulette winnings from Monday to Friday:
poker_vector <- c(140, -50, 20, -120, 240)
roulette_vector <- c(-24, -50, 100, -350, 10)
days_vector <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
names(poker_vector) <- days_vector
names(roulette_vector) <- days_vector

# Which days did you make money on poker?
selection_vector <- poker_vector > 0

# Select from poker_vector these days
poker_winning_days <- poker_vector[selection_vector]

poker_winning_days





