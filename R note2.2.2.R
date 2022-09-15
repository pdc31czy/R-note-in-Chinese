#2.2.2�ǽṹ������-�ı����ݶ���
rm(list = ls()) #��չ����ռ�

## 1.������ı����� ##

#�������ݰ������������ṹ�����ı�����
#ֻ�谴�ն���csv�ȱ�׼ʽ���ݵķ�������
#����
novel = read.csv("novel.csv", fileEncoding = "UTF-8")
head(novel)  


## 2.��readtable�����ı� ##

# �ı�������ͨ����
test = read.table("weibo.txt", sep = "\t") #����
##Error in scan(file = file, what = what, sep = sep, quote = quote, dec = dec,  : 
##line 1 did not have 29 elements

#��������ʱ����Error��������Ϊread.table()ֻ�ܶ��������ĺ������е�����
# ���ֶ���Ҫfill����������
#fill=T,��R�����п��ֶβ��ֲ���һ���ո�

test = read.table("weibo.txt", sep = "\t", fill = T)#����!
##Warning message:
##  In scan(file = file, what = what, sep = sep, quote = quote, dec = dec,  :
##            EOF within quoted string

#EOF(end of file)���ļ���ĩβ��һ�����������������ַ���������
#�����ǰ����˺ܶ�\n\t�Ļ����Ʊ�����ԭ��Ӧ�ñ����뵽�����еļ�¼��Ī������ؼ�����һ�����ӣ�Page102��

#����취����read.table()�����е�quote��������Ϊ�գ�������quote=""
# ����quote = ""��˼�ǽ�ֹ�������÷���
#��ΪRĬ��ȡֵ��quote="\"",��������Ϊquote="",����R��ȫ��������
#������R�У������ű���Ϊ���ַ�����ʼ������ı��
#����quote="",����R��Ҫ��"'"ʶ��Ϊһ���ַ���ʼ������ı��

#ע����ǣ���ʱR�ڷ����������ʱ����ʾError����Warning
#ʵ���϶�������ݱ���ʵ����������Ҫ��
#�ڽ�һ�����ݶ���Rǰ��������������������ȿ�������������

weibo = read.table("weibo.txt", sep = "\t", fill = T, quote = "", fileEncoding = "UTF-8")

# stringsAsFactors���ı�ת��Ϊ�ַ���strip.white���ַ��е�ǰ��ո�ȥ��
weibo = read.table("weibo.txt", sep = "\t", fill = T, quote = "", strip.white = T, stringsAsFactors = F, fileEncoding = "UTF-8")
head(weibo)

#�쳣����
#�鿴��75��80������,ȱʧ����
weibo[75:80, ]
#����ȱʧ���ݣ���substr()
weibo = weibo[substr(weibo$V1, 1, 2) == "�ܷ�", ]



## 3.��readLines�����ı� ##
readLines() #���ı����ж��룬ÿһ����Ϊһ���ַ��洢���������������ļ��������һ���ַ���

#����
# weibo1�Ǹ��ַ�����
weibo1 = readLines("weibo.txt", encoding = "UTF-8")
head(weibo1)

strsplit(x,split) #����split��x�ָ���շָ������б���ʽ���

#����
# ʹ���ַ��ָ����weibo1�ֿ�
tmp = strsplit(weibo1, " \t") 
class(tmp)
##  [1] "list" #����Ƿ��������б���ʽ���

tmp[1:2] #�鿴��һ�͵ڶ������
head(tmp) #�鿴ǰ�������
tmp[[1]] #�鿴��һ�����
tmp[1] #�鿴��һ�����



#ԭʼ�����а����������õ��У���Ҫ�Ȱ���Щ���ҵ���ȥ���ٺϲ��ɱ�
#�����е������ǣ�ֻ�ڵ�һ�͵ڶ��������֣�����ָ��ȡֵ����ȫ�ǿհ�
#���ÿ��list��Ԫ�صĳ��ȣ����鿴�쳣ֵ
ll = sapply(tmp, length)     

table(ll)
##  ll
##   0  1  7  8  #����
##   2  3 26 74  #����Ϊ0��1��7��8������

# ����Ϊ0��1���쳣�У�����Ϊ7��8�Ŀ��Բ��ã�����7��ȱ�����һ����������

# �����Ƿ�������һ��ȱʧ,hi���������г���Ϊ7���е����һ��Ԫ��
hi = c()
for(i in 1:26) #26����Ϊ��26�г���Ϊ7
{
  show(i) #��ʾi���Ӧ�����֣������һ��ȱʧ���Ҳµģ�û�����ס�����
  hi[i] = tmp[ll == 7][[i]][7]
}

tmp[ll == 7][1] #��ʾ���ǣ�����Ϊ7�������ĵ�һ��������
tmp[ll == 7][26] #�ڰ˸��ַ���ȷȱʧ

# �Ժ���7���ַ�����һ�����ַ�,ʹ�����ѡ�����ݿ������
tmp[ll == 7] = lapply(tmp[ll == 7], function(x) c(x, ""))                              
tmp[ll == 7][1] #�Ա�ǰ�棬����ڰ˸��ַ��Ѿ����ˣ��ǿ��ַ�""

#���ⱸע��lapply(x,function) 
#��һ����������Ҫ�����ݣ����������������б�����ʽ
#�ڶ��������Ǻ�����lapply���ص���һ���б�

#����
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


# ��ԭ������7���ַ���8���ַ��ĺ���һ��
infoDf = as.data.frame(do.call(rbind, tmp[ll == 7 | ll == 8]), stringsAsFactors = F)     
colnames(infoDf) = c("name", "location", "gender", "Nfollowers",
                     "Nfollow", "Nweibo", "createTime", "description")               
head(infoDf)



## 4.readLines�������÷� ##
#����
yitian = readLines("����������.Txt", encoding = "UTF-8")
yitian[1:10]

grep(pattern,x) #���ҹ̶�ģʽ����
#����x�����з���patternģʽ���ַ�λ��
#pattern������һЩ�̶��ַ���Ҳ���Բ����������ʽ����

#����
# �ֶ�
# ��ÿ���ַ�����������һ���ո�ı��
para_head = grep("\\s+", yitian,perl = T)
para_head[1:10]
##   [1]  1  2  6 14 20 22 28 55 61 81 
#para_head�����˶��俪ʼ�ط����ڵ�����

#���ⱸע��
#R�������������ʽ
#grep(extended=TRUE)��Ĭ�ϵ�extended�������ʽ
#grep(extended=FALSE)��basic�������ʽ
#grep(perl=TRUE)��perl�������ʽ
help("regex") #�˽��������ʽ

# ���ȹ���һ�����󣬵�һ����һ��֮�׵���ţ��ڶ�����һ��֮β�����
cut_para1 = cbind(para_head[1:(length(para_head) - 1)], para_head[-1] - 1)
head(cut_para1)
##       [,1] [,2]
##  [1,]    1    1
##  [2,]    2    5
##  [3,]    6   13
##  [4,]   14   19
##  [5,]   20   21
##  [6,]   22   27

# ��дһ��������������һ�ε�����ճ������
yitian_para = sapply(1:nrow(cut_para1), function(i) paste(yitian[cut_para1[i, 1]:cut_para1[i, 2]], collapse = ""))
yitian_para[1:4]



###############################################################
#�ܽ�#


weibo = read.table("weibo.txt", sep = "\t", fill = T, quote = "", strip.white = T, stringsAsFactors = F, fileEncoding = "UTF-8")
weibo = weibo[substr(weibo$V1, 1, 2) == "�ܷ�", ]#����ȱʧ����
readLines() #���ı����ж��룬ÿһ����Ϊһ���ַ��洢���������������ļ��������һ���ַ���
strsplit(x,split) #����split��x�ָ���շָ������б���ʽ���
lapply(x,function())
infoDf = as.data.frame(do.call(rbind, tmp[ll == 7 | ll == 8]), stringsAsFactors = F)     
colnames(infoDf) = c("name", "location", "gender", "Nfollowers","Nfollow", "Nweibo", "createTime", "description")  
grep(pattern,x) #���ҹ̶�ģʽ����
#R�������������ʽ
#grep(extended=TRUE)��Ĭ�ϵ�extended�������ʽ
#grep(extended=FALSE)��basic�������ʽ
#grep(perl=TRUE)��perl�������ʽ
help("regex") #�˽��������ʽ
cut_para1 = cbind(para_head[1:(length(para_head) - 1)], para_head[-1] - 1)
yitian_para = sapply(1:nrow(cut_para1), function(i) paste(yitian[cut_para1[i, 1]:cut_para1[i, 2]], collapse = ""))


###############################################################







