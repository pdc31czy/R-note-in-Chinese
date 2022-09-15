#2.1.4数据框（data.frame)
#数据框可以同时存储不同的数据类型，但是每一列必须是同一种数据类型

rm(list = ls())

#额外备注：
ls() #显示当前已有的所有变量
rm() #清空指定内容，这里什么都没删
rm(a) #删除了变量a
rm(list=ls()) #清空工作历史的所有变量

### 1.创建数据框 ###
# 读入一个txt,csv等格式数据,即自成一个数据框
movie = read.csv(file = "C:\\Users\\PC\\Desktop\\R\\Rsourse\\电影数据.csv", fileEncoding = "UTF-8", stringsAsFactors = F)
class(movie)
##  [1] "data.frame"

# 自己创建
#data.frame(col1,col2,col3)
#例：
star1 = c("邓超", "赵丽颖", "郭富城", "周润发", "杰克布莱克", "汤唯", "白敬亭", "陈晓", "梁家辉", "姚晨", "宋茜", "黄宗泽", "黄晓明")
birthyear = c(1979, 1987, 1965, 1955, 1969, 1979, 1993, 1987, 1958, 1979, 1987, 1980, 1977)
gender = c("男", "女", "男", "男", "男", "女", "男", "男", "男", "女", "女", "男", "男")
stars = data.frame(star1, birthyear, gender)
head(stars) #head(x)展示x的前几行（默认前6行），可以通过head(x,n=10)来显示前10行
##         star1 birthyear gender
##  1       邓超      1979     男
##  2     赵丽颖      1987     女
##  3     郭富城      1965     男
##  4     周润发      1955     男
##  5 杰克布莱克      1969     男
##  6       汤唯      1979     女


### 2.汇总 ###

head() #提取数据前6行
str() #展示每列的数据类型
summary() #观察每列数据整体情况、整体的取值范围

#例：
str(movie)
##  'data.frame':   19 obs. of  11 variables:
##   $ name       : chr  "叶问3" "美人鱼" "女汉子真爱公式" "西游记之孙悟空三打白骨精" ...
##   $ boxoffice  : num  77060 338583 6184 119957 111694 ...
##   $ doubanscore: num  6.4 6.9 4.5 5.7 4 7.7 6.5 6.4 5 5.6 ...
##   $ type       : chr  "动作" "喜剧" "喜剧" "喜剧" ...
##   $ duration   : int  105 93 93 120 112 95 131 108 95 102 ...
##   $ showtime   : chr  "2016/3/4" "2016/2/8" "2016/3/18" "2016/2/8" ...
##   $ director   : chr  "叶伟信" "周星驰" "郭大雷" "郑保瑞" ...
##   $ star1      : chr  "甄子丹" "邓超" "赵丽颖" "郭富城" ...
##   $ index1     : int  11385 41310 181979 12227 16731 178 13499 14759 13251 6911 ...
##   $ star2      : chr  "张晋" "林允" "张翰" "巩俐" ...
##   $ index2     : int  4105 9292 44277 8546 30277 1540 77260 755 9549 5614 ...

summary(movie)
##       name             boxoffice         doubanscore        type          
##   Length:19          Min.   :   924.9   Min.   :3.400   Length:19         
##   Class :character   1st Qu.:  3799.5   1st Qu.:4.600   Class :character  
##   Mode  :character   Median : 12561.5   Median :5.300   Mode  :character  
##                      Mean   : 50813.3   Mean   :5.568                     
##                      3rd Qu.: 77700.9   3rd Qu.:6.450                     
##                      Max.   :338583.3   Max.   :8.000                     
##      duration       showtime           director            star1          
##   Min.   : 84.0   Length:19          Length:19          Length:19         
##   1st Qu.: 94.5   Class :character   Class :character   Class :character  
##   Median : 99.0   Mode  :character   Mode  :character   Mode  :character  
##   Mean   :101.5                                                           
##   3rd Qu.:107.5                                                           
##   Max.   :131.0                                                           
##       index1          star2               index2     
##   Min.   :   178   Length:19          Min.   :  521  
##   1st Qu.:  8232   Class :character   1st Qu.: 3650  
##   Median : 12227   Mode  :character   Median : 9292  
##   Mean   : 27861                      Mean   :17369  
##   3rd Qu.: 24663                      3rd Qu.:20763  
##   Max.   :181979                      Max.   :77260

head(movie)
##                        name boxoffice doubanscore type duration  showtime
##  1                    叶问3  77060.44         6.4 动作      105  2016/3/4
##  2                   美人鱼 338583.26         6.9 喜剧       93  2016/2/8
##  3           女汉子真爱公式   6184.45         4.5 喜剧       93 2016/3/18
##  4 西游记之孙悟空三打白骨精 119956.51         5.7 喜剧      120  2016/2/8
##  5               澳门风云三 111693.89         4.0 喜剧      112  2016/2/8
##  6                功夫熊猫3  99832.53         7.7 喜剧       95 2016/1/29
##    director      star1 index1        star2 index2
##  1   叶伟信     甄子丹  11385         张晋   4105
##  2   周星驰       邓超  41310         林允   9292
##  3   郭大雷     赵丽颖 181979         张翰  44277
##  4   郑保瑞     郭富城  12227         巩俐   8546
##  5     王晶     周润发  16731       刘德华  30277
##  6   吕寅荣 杰克布莱克    178 安吉丽娜朱莉   1540


### 3.变大--数据框的增列、合并 ###

#增列：
dat$column_name=vector #在数据框后面增加新列

#例：
# 添加一列数据prefer
prefer = 1:19
movie$pre = prefer
head(movie)
##                        name boxoffice doubanscore type duration  showtime
##  1                    叶问3  77060.44         6.4 动作      105  2016/3/4
##  2                   美人鱼 338583.26         6.9 喜剧       93  2016/2/8
##  3           女汉子真爱公式   6184.45         4.5 喜剧       93 2016/3/18
##  4 西游记之孙悟空三打白骨精 119956.51         5.7 喜剧      120  2016/2/8
##  5               澳门风云三 111693.89         4.0 喜剧      112  2016/2/8
##  6                功夫熊猫3  99832.53         7.7 喜剧       95 2016/1/29
##    director      star1 index1        star2 index2 pre
##  1   叶伟信     甄子丹  11385         张晋   4105   1
##  2   周星驰       邓超  41310         林允   9292   2
##  3   郭大雷     赵丽颖 181979         张翰  44277   3
##  4   郑保瑞     郭富城  12227         巩俐   8546   4
##  5     王晶     周润发  16731       刘德华  30277   5
##  6   吕寅荣 杰克布莱克    178 安吉丽娜朱莉   1540   6


#合并数据框：
merge(x,y,by) #x,y分别是要合并的两个数据框，by是它们共有的列
#备注：假如共有的列在两个数据框中名字不同，需通过by.x,by.y分别定义识别
#假如两个数据框中匹配列的值域并不相同，需要用all类的参数设置以哪个所包含的值域为准

#例：
# merge实现的效果是：将movie和stars按照列star1匹配并合并起来
movie[1:3, ]
##name boxoffice doubanscore type duration  showtime director  star1 index1 star2 index2
##1          叶问3  77060.44         6.4 动作      105  2016/3/4   叶伟信 甄子丹  11385  张晋   4105
##2         美人鱼 338583.26         6.9 喜剧       93  2016/2/8   周星驰   邓超  41310  林允   9292
##3 女汉子真爱公式   6184.45         4.5 喜剧       93 2016/3/18   郭大雷 赵丽颖 181979  张翰  44277

stars
##star1 birthyear gender
##1        邓超      1979     男
##2      赵丽颖      1987     女
##3      郭富城      1965     男
##4      周润发      1955     男
##5  杰克布莱克      1969     男
##6        汤唯      1979     女
##7      白敬亭      1993     男
##8        陈晓      1987     男
##9      梁家辉      1958     男
##10       姚晨      1979     女
##11       宋茜      1987     女
##12     黄宗泽      1980     男
##13     黄晓明      1977     男


(movie.star = merge(movie[1:3, ], stars,by = "star1")) 
##star1           name boxoffice doubanscore type duration  showtime director index1 star2 index2 birthyear gender
##1   邓超         美人鱼 338583.26         6.9 喜剧       93  2016/2/8   周星驰  41310  林允   9292      1979     男
##2 赵丽颖 女汉子真爱公式   6184.45         4.5 喜剧       93 2016/3/18   郭大雷 181979  张翰  44277      1987     女

# all.x=T,即取前一个数据框movie中star1列所有的值做合并，匹配不到赋值NA
(movie.star = merge(movie[1:3, ], stars[1:5, ], by = "star1", all.x = T))
##star1           name boxoffice doubanscore type duration  showtime director index1 star2 index2 birthyear gender
##1   邓超         美人鱼 338583.26         6.9 喜剧       93  2016/2/8   周星驰  41310  林允   9292      1979     男
##2 赵丽颖 女汉子真爱公式   6184.45         4.5 喜剧       93 2016/3/18   郭大雷 181979  张翰  44277      1987     女
##3 甄子丹          叶问3  77060.44         6.4 动作      105  2016/3/4   叶伟信  11385  张晋   4105        NA   <NA>




### 4.变小--数据的筛选、引用 ###

# 引用
A[i,j] #提取A中的第i行第j个元素

#例：
movie[3, ]  # 查看第3行的电影信息
##              name boxoffice doubanscore type duration  showtime director
##  3 女汉子真爱公式   6184.45         4.5 喜剧       93 2016/3/18   郭大雷
##     star1 index1 star2 index2 pre
##  3 赵丽颖 181979  张翰  44277   3
movie[, 8]  # 查看第8列主演者的名字
##   [1] "甄子丹"     "邓超"       "赵丽颖"     "郭富城"     "周润发"    
##   [6] "杰克布莱克" "汤唯"       "白敬亭"     "陈晓"       "梁家辉"    
##  [11] "姚晨"       "宋茜"       "黄宗泽"     "黄晓明"     "洪金宝"    
##  [16] "陈坤"       "陶泽如"     "刘亦菲"     "何润东"


# 筛选
#选列， 用$符号配列名即可实现（如用movie$name可以提取name这一列）
#选行，通过行号，或条件语句返回一个逻辑结果向量，而后R把其中为TRUE的行摘出来

#例：
movie$star1  # 用$符号通过列名引用
##   [1] "甄子丹"     "邓超"       "赵丽颖"     "郭富城"     "周润发"    
##   [6] "杰克布莱克" "汤唯"       "白敬亭"     "陈晓"       "梁家辉"    
##  [11] "姚晨"       "宋茜"       "黄宗泽"     "黄晓明"     "洪金宝"    
##  [16] "陈坤"       "陶泽如"     "刘亦菲"     "何润东"
(action = movie[movie$type == "动作", ])  # 选择数据中的动作电影
##             name boxoffice doubanscore type duration  showtime director
##  1         叶问3  77060.44         6.4 动作      105  2016/3/4   叶伟信
##  10     冰河追凶   4262.14         5.6 动作      102 2016/4/15     徐伟
##  15 我的特工爷爷  32009.37         5.3 动作       99  2016/4/1   洪金宝
##  19         钢刀    924.86         4.3 动作       94 2016/5/20     阿甘
##      star1 index1  star2 index2 pre
##  1  甄子丹  11385   张晋   4105   1
##  10 梁家辉   6911 佟大为   5614  10
##  15 洪金宝   9148 刘德华  30277  15
##  19 何润东  11822 李学东    521  19
(action_long = movie[movie$type == "动作" & movie$duration > 100, ])  # 放映时间超过100分钟的动作电影
##         name boxoffice doubanscore type duration  showtime director  star1
##  1     叶问3  77060.44         6.4 动作      105  2016/3/4   叶伟信 甄子丹
##  10 冰河追凶   4262.14         5.6 动作      102 2016/4/15     徐伟 梁家辉
##     index1  star2 index2 pre
##  1   11385   张晋   4105   1
##  10   6911 佟大为   5614  10


### 5.变序--数据框的内部排序 ###
用参数decreasing来设置按升序还是降序排列

#例：
# 按照票房降序排列
movie = movie[order(movie$boxoffice, decreasing = T), ]; head(movie) 
##                        name boxoffice doubanscore type duration  showtime
##  2                   美人鱼 338583.26         6.9 喜剧       93  2016/2/8
##  4 西游记之孙悟空三打白骨精 119956.51         5.7 喜剧      120  2016/2/8
##  5               澳门风云三 111693.89         4.0 喜剧      112  2016/2/8
##  6                功夫熊猫3  99832.53         7.7 喜剧       95 2016/1/29
##  7 北京遇上西雅图之不二情书  78341.38         6.5 喜剧      131 2016/4/29
##  1                    叶问3  77060.44         6.4 动作      105  2016/3/4
##    director      star1 index1        star2 index2 pre
##  2   周星驰       邓超  41310         林允   9292   2
##  4   郑保瑞     郭富城  12227         巩俐   8546   4
##  5     王晶     周润发  16731       刘德华  30277   5
##  6   吕寅荣 杰克布莱克    178 安吉丽娜朱莉   1540   6
##  7   薛晓路       汤唯  13499       吴秀波  77260   7
##  1   叶伟信     甄子丹  11385         张晋   4105   1
# 先按电影类型排序，再按照豆瓣评分排序
movie = movie[order(movie$type, movie$doubanscore, decreasing = T), ]; head(movie)
##                         name boxoffice doubanscore type duration  showtime
##  6                 功夫熊猫3  99832.53         7.7 喜剧       95 2016/1/29
##  2                    美人鱼 338583.26         6.9 喜剧       93  2016/2/8
##  7  北京遇上西雅图之不二情书  78341.38         6.5 喜剧      131 2016/4/29
##  4  西游记之孙悟空三打白骨精 119956.51         5.7 喜剧      120  2016/2/8
##  13                 刑警兄弟   3005.96         5.2 喜剧       97 2016/4/22
##  3            女汉子真爱公式   6184.45         4.5 喜剧       93 2016/3/18
##     director      star1 index1        star2 index2 pre
##  6    吕寅荣 杰克布莱克    178 安吉丽娜朱莉   1540   6
##  2    周星驰       邓超  41310         林允   9292   2
##  7    薛晓路       汤唯  13499       吴秀波  77260   7
##  4    郑保瑞     郭富城  12227         巩俐   8546   4
##  13   戚家基     黄宗泽   9823         金刚   4010  13
##  3    郭大雷     赵丽颖 181979         张翰  44277   3


### 6.变形--长宽表互换 ###


# install.packages(reshape)
library(reshape)
# install.packages(reshape2)
library(reshape2) #把宽表整理成长表，需要使用reshape2包中的melt()函数

## (1) 宽表变长表 ##  

#例：
mWide = data.frame(Name = c("熊大", "水妈"), Type = c("帅哥", "美女"),
                   GF2013 = c(300, 100), GF2014 = c(500, 350), GF2015 = c(1000, 886))
# 由于构造数据框时列名不可以为纯数字，在数字前添加GF

# 将列名中的GF去掉
colnames(mWide)[3:5] = gsub("GF", "", colnames(mWide)[3:5])

mWide #查看原表
##    Name Type 2013 2014 2015
##  1 熊大 帅哥  300  500 1000
##  2 水妈 美女  100  350  886

melt(需要变形的数据框,id.vars=c("a","b"),variable.names="c")#专门把宽表收起来，id.vars用来设定要把哪列定住不动，其他列就会自动收入这一列，参数variable_name用来设定这个新列的列名
(mLong = melt(mWide, id.vars = c("Name", "Type"), variable_name = "Year")) #Name和Type不定，新增一列Year
##    Name Type Year value
##  1 熊大 帅哥 2013   300
##  2 水妈 美女 2013   100
##  3 熊大 帅哥 2014   500
##  4 水妈 美女 2014   350
##  5 熊大 帅哥 2015  1000
##  6 水妈 美女 2015   886

## (2) 长表变宽表 ##
dcast()#在reshape2包中的dcast()函数，让长表变成宽表
#第一个参数是要变形的数据框
#第二个采用了公式参数(公式的左边每个变量都会作为结果中的一列，而右边的变量被当为因子类型，每个水平值都会在结果中新生成一个单独列)

# 将列Year从字符型变成数值型
mLong$Year = as.numeric(mLong$Year)

# 长表变宽表
dcast(mLong, Name + Type ~ Year) 
##    Name Type   1   2    3
##  1 水妈 美女 100 350  886
##  2 熊大 帅哥 300 500 1000


### 7.R中的数据透视表-神奇的ddply ###
# install.packages(plyr)
library(plyr)
#plyr包中的ddply()函数完成类似数据透视表的分组计算不同量的功能（常用于数据整理汇总）

ddply(.data,.variables,.fun=NULL) #第一个参数是要处理的数据框，第二个参数是分组标记，第三个参数是函数
#处理逻辑：按照第二个参数定义的分组变量把数据框分组成多个子数据框，然后作为第三个函数的输入

#额外备注：base包中的by()与ddply()类似，它可以被转换为向量但却无法轻易变成数据框对象

#例：

# 根据电影类型进行分组，查看不同类型电影票房的平均水平
popular_type = ddply(movie, .(type), function(x) {mean(x$boxoffice)}); head(popular_type)
##    type       V1
##  1 爱情 11206.95
##  2 动作 28564.20
##  3 犯罪 36624.84
##  4 剧情  6671.91
##  5 喜剧 95116.85

# 根据电影类型和电影时长同时分组，查看电影票房的平均水平
long = ddply(movie, .(type,duration), function(x) {mean(x$index1)}); head(long)
##    type duration    V1
##  1 爱情       84 58355
##  2 爱情       95 13251
##  3 爱情      108 14759
##  4 动作       94 11822
##  5 动作       99  9148
##  6 动作      102  6911





#######################################
#总结#

ls() #显示当前已有的所有变量
rm() #清空指定内容，这里什么都没删
rm(a) #删除了变量a
rm(list=ls()) #清空工作历史的所有变量

# 读入一个txt,csv等格式数据,即自成一个数据框
movie = read.csv(file = "C:\\Users\\PC\\Desktop\\R\\电影数据.csv", fileEncoding = "UTF-8", stringsAsFactors = F)

data.frame(col1,col2,col3) ## 自己创建数据框
head(x) #展示x的前几行（默认前6行），可以通过head(x,n=10)来显示前10行
str() #展示每列的数据类型
summary() #观察每列数据整体情况、整体的取值范围（数据分析最重要的一个函数！要经常用这个）

dat$column_name=vector #在数据框后面增加新列
merge(x,y,by="same",all.x = T) #x,y分别是要合并的两个数据框，by是它们共有的列,all.x=T,即取前一个数据框x中same列所有的值做合并，匹配不到赋值NA

#引用
A[i,j] #提取A中的第i行第j个元素

# 筛选
#选列， 用$符号配列名即可实现（如用movie$name可以提取name这一列）
#选行，通过行号，或条件语句返回一个逻辑结果向量，而后R把其中为TRUE的行摘出来

#变序
用参数decreasing来设置按升序还是降序排列

library(reshape)
library(reshape2) #把宽表整理成长表，需要使用reshape2包中的melt()函数
melt(需要变形的数据框,id.vars=c("a","b"),variable.names="c")#专门把宽表收起来，id.vars用来设定要把哪列定住不动，其他列就会自动收入这一列，参数variable_name用来设定这个新列的列名
dcast(需要变形的数据框,a+b~c)#在reshape2包中的dcast()函数，让长表变成宽表，具体使用看例子

library(plyr) #plyr包中的ddply()函数完成类似数据透视表的分组计算不同量的功能（常用于数据整理汇总）
ddply(.data,.variables,.fun=NULL) #第一个参数是要处理的数据框，第二个参数是分组标记，第三个参数是函数
ddply()#“高效分组，同步计算”

by()#base包中的与ddply()类似的，但无法轻易变成数据框对象

#######################################
