#��������Щ��
search()

#��Github�����ذ�
library(devtools)
install_github("gaborcsardi/praise") 
#gaborcsardi ��GitHub����������,praise �ǰ�������

#���°�
update.packages()

#���ð�������һ���Ϳ�
library("package_name")
require("package_name")

#Ѱ��һ���ð�
# http://cran.r-project.org/web/views/
# http: // www.crantastic.org/popcon

#����ʹ�÷���
help(package = "package_name")

#�鿴ĳ��������ʹ������
demo("function_name")

#�뿴ĳЩͳ�Ʒ��������ݲ���������
# http :// www.statmethods.net/index.html

#read.csv() ����csv��ʽ���ݵĺ���
read.csv file header = TRUE 
#����file��������Ҫ������ļ���
#header�������ߵ����Ƿ�Ѷ����ļ��ĵ�һ��ʶ��Ϊ������������������

#����:����һ�Ŵ��С�ȫ����ʡ���붫����������Ӧ���ݡ��ı���
#westeast=read.csv("Province_Section.csv",header = T)����
#��ȷ����
westeast=read.csv("Province_Section.csv",header=T,fileEncoding = "GBK")
head(westeast)
#������fileEncoding����Ϊ�ܹ���ȡ����ı��뷽ʽ�����硰GBK��
