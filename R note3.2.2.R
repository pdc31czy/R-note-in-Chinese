#3.2.2 两总体均值对比

#t.test()默认两总体方差是不等的
#如果两总体方差相等，在t.test()里添加var.equal=TRUE即可
#做t检验一定要有的意识：
#是不是正态分布？是不是满足方差齐性的假设？

#两配对总体均值的检验
#t.test()里设置paired=TRUE
#检验之前分清是独立总体还说配对总体很重要

#两总体均值t检验的目的是检验两个正态分布总体的均值之间是否有显著差异



#Welch Two Sample t-test
data("iris")
x = iris[iris$Species == 'setosa', 3]
y = iris[iris$Species == 'versicolor', 3]
t.test(x, y)


data(sleep)
head(sleep)

#Welch Two Sample t-test
x = sleep[sleep$group == 1, 1]
y = sleep[sleep$group == 2, 1]
t.test(x, y)

#Paired t-test
x = sleep[sleep$group == 1, 1]
y = sleep[sleep$group == 2, 1]
t.test(x, y, paired = TRUE)

#配对总体均值t检验和单总体均值t检验完全等价
#One Sample t-test
x = sleep[sleep$group == 1, 1]
y = sleep[sleep$group == 2, 1]
t.test(x - y)


# 两总体的t检验，比较的是总体均值。一般情况下，我们想比较的是两总体均值是否相等，说专业一点叫做是否有显著差异，这时原假设是H0:μ1=μ2。如果你有特定的研究目的，也可以检验它们的差异是否等于某个特定的值，即H0:μ1???μ2=Δ。
# 
# 做检验的时候，一定要搞清楚数据是独立还是配对，两种情况下使用的检验统计量不同，得到的结论也有差异。在t.test()里面，可以非常容易地用paired=TRUE来指定配对数据的情形。
# 
# 大家在学习t检验的时候，会学习各种假设各种情形，比如总体是正态分布，两总体方差已知、未知、比值已知等。学习理论知识的时候，搞清楚这些事情非常有必要，帮你形成完整的知识体系，打下坚实的理论基础。但是在做实际数据分析的时候，往往就是“臣妾做不到”，假设不满足。在大样本的情况下，我们也就直接使用这些统计方法了。
# 
# 另外要注意的是，在推论时一定要记住统计具有不确定性，即任何推论都是假定的，都是有一定概率性的，即有可能对也有可能错，所以下结论时切忌使用“肯定”、“一定”等词语。如果样本量非常小，通常推论就会犯错误。






