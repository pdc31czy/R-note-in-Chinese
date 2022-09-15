##### 3.4 代码规范与文档撰写 #####
##3.4.1 R语言代码规范

#1.注释

##文件注释，就是在文件代码开始前需要声明的内容
##比如
##什么环境下运行本代码，使用哪个版本的RStudio
##约定编码方式（通常是 utf-8 )
##以及这个代码文件主要是用来干什么的
##通常文件注释开始用两个#

#例：
## --*-- coding: utf-8 --*--
## exploratory data analysis of nba shooting data

##代码块注释通常也算使用两个#开头

#2.命名规范

#变量
#不同单词间可以用"."或者"_"来连接

#函数则尽量不要用东西连接

#例：
#变量
#正例：shooting_distance  shooting.distance
#反例：ShootingDistance

#函数
#正例：GetShootingEff
#反例：getshootingeff Get_Shooting_Eff

#3.代码组织
#（1）版权声明
#（2）编码和环境声明
#（3）作者注释
#（4）文件说明
#（5）项目目的
#（6）输入与输出说明
#（7）函数定义说明
#（8）其他


#4.R语言编程的一般约定
#（1）每行不要超80个字符
#（2）不用用Tab 键，用空格键空两格  进行缩进
#（3）使用二次运算符（+ - = <- )时两端要空一格
#（4）逗号, 前不用空格，逗号后一定要空一格
#（5）不用用分号;
#（6）花括号{} 左花括号不换行，右花括号独占一行
#（7）少用attach()函数
#（8）小括号 ()在前括号加一个空格，但调用函数时除外，比如if()
#（9）全部代码约定应保持一致，全部有空格最好

#例：
##正例：
# 自定义函数对gglpot.box进行简单封装
MyStyle <- function(xName, yName, groupName){
  ggplot2.boxplot(data = doc, xName, yName, groupName,
                  showLegend = False, na.rm = TRUE)
}

##反例：
# 自定义函数对gglpot.box进行简单封装
MyStyle<-function(xName,yName,groupName){
  ggplot2.boxplot(data=doc,xName,yName,groupName,
                  showLegend=False,na.rm = TRUE)}



#5.测试代码效率并优化
#Debug检测代码正确与否
#Profile检测代码效率如何


##3.4.2 R Markdown文档撰写 （page211）
install.packages("rmarkdown")

render#为了生成想要的Rmd结果，需要对创建的文件对象执行render命令
knitr#按钮，将Rmd生成想要的格式，如HTML，PDF，word等，默认HTML输出

knitr#由纯文本和代码交织在一起的文档
(.md)#新的Markdown文件
pandoc#一种标记语言转换工具

#基于shiny做出了的Rmd交互式文档展示（page220）
