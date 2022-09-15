### 6.5 正则表达式与字符串处理函数

#对网页HTML完成下载解析：
#利用R中的RCurl组件或Python中的BeautifulSoup库

#HTML/XML专用工具XPath表达式
#正则表达式：更为通用、更加底层的文本信息提取工具


#正则表达式：使用一个字符串来描述、匹配一系列某个语法规则
#通过特定的字母、数字以及特殊符号的灵活组合即可完成对任意字符串的匹配，从而达到提取相应文本信息的目的


#R默认的正则表达式：基础文本处理函数，stringr包中的文本处理函数
#Perl正则表达式




##6.5.1 基本的正则表达式语法


#邮箱账户的正则表达式：
[A-Za-z0-9\._+]+@[A-Za-z0-9]+\.(com|org|edu|net)



#[A-Za-z0-9\._+]
#"A-Z"表示匹配任意的A~Z大写字母，所有可能的组合放在中括号里表示可以匹配其中的任一个；
#加号表示任意字符可以出现一次或者多次；
#“\”表示转义，因为“."在正则表达式中有特殊含义，想要正常地表示”."号必须使用转义符
#@是邮箱必需的一个符号
#@符号后必须有一个包含运营商信息的字符串
#\.表示邮箱地址中必须要有的一个点号
#(com|org|edu|net)列出邮箱地址可能的域名系统，括号内表示分组处理，“|”符号表示“或”的含义



#正则表达式速查表，page325


#6.5.2 R中正则表达式的使用方法


#文本处理函数 

#基础文本处理函数|stringr包处理函数|含义

#支持正则表达式的函数

#Regmatches() str_extract() 提取匹配特征的第一个字符串
#regmatches() str_extract_all() 提取匹配特征的所有字符串
#regexpr() str_locate() 返回一个特征匹配的位置
#gregexpr() str_locate_all() 返回所有特征匹配的位置
#sub() str_replace() 替换第一个特征的匹配
#gsub() str_replace_all() 替换所有特征的匹配
#strsplit() str_split() 在特征匹配的位置拆分字符串
#           str_split_fixed() 将字符串拆分为固定块数
#grepl() str_detect() 在字符串里检验特征是否存在
#        str_count() 检验特征出现的次数


#其他函数

#regmatches() str_sub() 根据位置提取字符串
#             str_dup() 复制字符串
#nchr() str_length() 返回字符串长度
#       str_pad() 给字符串留空
#       str_trim() 去掉字符串两端的空白
#paste/paste0() str_c() 拼接多个字符串


#例：
#基础字符处理函数的正则表达式应用
example_text1 = c("2333#RRR#PP", "3555#CCCC", "ziyan2021")

#以#进行字符串切分
unlist(strsplit(example_text1, "#"))
#[1] "2333"      "RRR"       "PP"        "3555"      "CCCC"      "ziyan2021"

#以空字符集进行字符串切分
unlist(strsplit(example_text1, "//s"))
#[1] "2333#RRR#PP" "3555#CCCC"   "ziyan2021" 

#以空字符替换字符串第一个#匹配
sub("#", "", example_text1)
#[1] "2333RRR#PP" "3555CCCC"   "ziyan2021" 

#以空字符替換字符串全部#匹配
gsub("#", "", example_text1)
#[1] "2333RRRPP" "3555CCCC"  "ziyan2021"

#查詢字符串中是否存在333或555的特征并返回所在位置
grep("[35]{3}", example_text1)
#[1] 1 2

#查詢字符串中是否存在333或555的特征并返回逻辑值
grepl("[35]{3}", example_text1)
#[1]  TRUE  TRUE FALSE




#例：
#stringr包函数的正则表达式应用
example_text2 = "1. A small sentence. -2. Another tint sentence."

#install.packages(stringr)
library(stringr)

#提取samll特征字符
str_extract(example_text2, "small")
##[1] "small"


# 提取包含sentence特征的全部字符串
unlist(str_extract_all(example_text2, "sentence"))
##  [1] "sentence" "sentence"

# 提取以1开始的字符串
str_extract(example_text2, "^1")
##  [1] "1"

# 提取以句号结尾的字符
unlist(str_extract_all(example_text2, ".$"))
##  [1] "."

# 提取包含tiny或者sentence特征的字符串
unlist(str_extract_all(example_text2, "tiny|sentence"))
##  [1] "sentence" "tiny"     "sentence"

# 点号进行模糊匹配
str_extract(example_text2, "sm.ll")
##  [1] "small"

# 中括号表示可选字符串
str_extract(example_text2, "sm[abc]ll")
##  [1] "small"
str_extract(example_text2, "sm[a-p]ll")
##  [1] "small"



#R中的字符集
[:digit:] 数字：0 ~9
[:lower:] 小写字母a~z
[:upper:] 大写字母A~Z
[:alpha:] 字母字符a~z A~Z
[:alnum:] 数字和字母字符
[:punct:] 标点符号集
[:graph:] 图形字符包括[:alnum:]和[:punct:]
[:blank:] 空格字符：空格和制表
[:space:] 空字符：空格、制表、换行和其他空字符
[:print:] 可打印字符：[:alnum:] [:punct:][:space:]



#R中正则表达式的简化形式
\w 单词字符：[[:alnum:]_]
\W 非单词字符：[^[:almun:]_]
\s 空字符：[[:blank:]]
\S 非空字符：[^[:blank:]]
\d 数字：[[:digit:]]
\D 非数字：[^[:digit:]]
\b 单词边界
\B 非单词边界
\< 单词的起始
\> 单词的结尾



#例：
# 提取全部单词字符
unlist(str_extract_all(example_text2, "\\w+"))
##  [1] "1"        "A"        "small"    "sentence" "2"        "Another" 
##  [7] "tiny"     "sentence"



#网络数据爬取的三种信息提取方式：
#正则表达式、XPath表达式和CSS选择器























