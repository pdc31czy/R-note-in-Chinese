###6.1 HTML 基础与R语言解析

#额外备注：Python中的scrapy框架，爬虫

#HTML
#hyper text markup language
#超文本标记语言

##6.1HTML的语法规则

#单击鼠标右键，查看源文件/审查元素


##1.标签、元素和属性

#标签，以一对"< >"符号包括起来
#元素，起始标签、内容和终止标签组合成为元素

#终止标签会有一个"/"符号
#<br>标签表示换行，不需要</br>标签来表示终止

<a> 定义锚
<meta> 定义关于HTML文档的元信息
<link> 定义文档与外部资源的关系
<code> 定义计算机代码文本
<p> 定义段落
<h1>-<h6> 定义HTML标题
<div> 定义文档中的节
<span> 定义文档中的节
<form> 定义供用户输入的HTML表单
<script> 定义客户端脚本


#属性就是让标签能够描述其内容处理方式的选项
#具体属性的作用则根据相应的标签来定

#属性总是处于起始标签的内部、标签名的右侧
#一个标签拥有多个属性也是常见操作，多个属性之间用空格分开



##2.树形结构

#例：
<dl class="">
    <dt>
        <a href="https://www.baidu.com">
           <img src="https://imgs.doubanio.com/viw/photo/abcd" alt="菇宝" class=""/>
        </a>
    </dt>
    <dd>
        <a href="https://blabla" >
    </dd>
</dl>
          

#第一个元素是<dl>,在这个元素的起始和终止标签内，
#又有几个标签分别起始和终止：<dt>,<a>和<dd>。
#<dt>和<dd>标签作为同级标签都包含在<dl>元素内，
#<a>标签则包含在<dt>标签内。
  
          
#HTML还有注释、保留字符和特殊字符、文档定义类型等        
          
          
##6.1.2 R语言中HTML的解析
      
#对于HTML，R语言无法直接分析，需要先转换，这个过程就是HTML解析
          
#为了将HTML文件转换为结构化数据
#需运用一种能够理解HTML结构含义的程序
#并重建HTML文件隐含的层次结构
#使得HTML内容转变为R语言可以分析的形式
        
        
#在R语言中，通常使用XML包中的htmlParse()函数来解析HTML文件
#XML有着以C语言为基础的libxml2库的接口
        
        
#install.packages(XML)        
library(XML)        
#install.packages(bitops)       
library(bitops)        
#install.packages(RCurl)        
library(RCrul)        
 
temp = getURL('http://movie.douban.com.subject/blabla')        
fanghua = htmlParse(temp)        
fanghua        
        
##  <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
##  <html>
##  <head><title>301 Moved Permanently</title></head>
##  <body bgcolor="white">
##  <center><h1>301 Moved Permanently</h1></center>
##  <hr>
##  <center>nginx</center>
##  </body>
##  </html>
##          
        
        
   
        
          
          






