##### 3.4 ����淶���ĵ�׫д #####
##3.4.1 R���Դ���淶

#1.ע��

##�ļ�ע�ͣ��������ļ����뿪ʼǰ��Ҫ����������
##����
##ʲô���������б����룬ʹ���ĸ��汾��RStudio
##Լ�����뷽ʽ��ͨ���� utf-8 )
##�Լ���������ļ���Ҫ��������ʲô��
##ͨ���ļ�ע�Ϳ�ʼ������#

#����
## --*-- coding: utf-8 --*--
## exploratory data analysis of nba shooting data

##�����ע��ͨ��Ҳ��ʹ������#��ͷ

#2.�����淶

#����
#��ͬ���ʼ������"."����"_"������

#����������Ҫ�ö�������

#����
#����
#������shooting_distance  shooting.distance
#������ShootingDistance

#����
#������GetShootingEff
#������getshootingeff Get_Shooting_Eff

#3.������֯
#��1����Ȩ����
#��2������ͻ�������
#��3������ע��
#��4���ļ�˵��
#��5����ĿĿ��
#��6�����������˵��
#��7����������˵��
#��8������


#4.R���Ա�̵�һ��Լ��
#��1��ÿ�в�Ҫ��80���ַ�
#��2��������Tab �����ÿո��������  ��������
#��3��ʹ�ö����������+ - = <- )ʱ����Ҫ��һ��
#��4������, ǰ���ÿո񣬶��ź�һ��Ҫ��һ��
#��5�������÷ֺ�;
#��6��������{} �����Ų����У��һ����Ŷ�ռһ��
#��7������attach()����
#��8��С���� ()��ǰ���ż�һ���ո񣬵����ú���ʱ���⣬����if()
#��9��ȫ������Լ��Ӧ����һ�£�ȫ���пո����

#����
##������
# �Զ��庯����gglpot.box���м򵥷�װ
MyStyle <- function(xName, yName, groupName){
  ggplot2.boxplot(data = doc, xName, yName, groupName,
                  showLegend = False, na.rm = TRUE)
}

##������
# �Զ��庯����gglpot.box���м򵥷�װ
MyStyle<-function(xName,yName,groupName){
  ggplot2.boxplot(data=doc,xName,yName,groupName,
                  showLegend=False,na.rm = TRUE)}



#5.���Դ���Ч�ʲ��Ż�
#Debug��������ȷ���
#Profile������Ч�����


##3.4.2 R Markdown�ĵ�׫д ��page211��
install.packages("rmarkdown")

render#Ϊ��������Ҫ��Rmd�������Ҫ�Դ������ļ�����ִ��render����
knitr#��ť����Rmd������Ҫ�ĸ�ʽ����HTML��PDF��word�ȣ�Ĭ��HTML���

knitr#�ɴ��ı��ʹ��뽻֯��һ����ĵ�
(.md)#�µ�Markdown�ļ�
pandoc#һ�ֱ������ת������

#����shiny�����˵�Rmd����ʽ�ĵ�չʾ��page220��