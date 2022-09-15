#######R语言与非结构化数据分析#######
###4.2 图像分析###
# 清空工作空间 
rm(list = ls())

# 引入所需要的package
# install.packages(knitr)
require(knitr)
# install.packages(jpeg)
library(jpeg)
# install.packages(png)
library(png) 
# 安装EBImage包，只安装一次即可
source("http://bioconductor.org/biocLite.R") 
biocLite("EBImage") 
library(EBImage)
# install.packages(RgoogleMaps)
library(RgoogleMaps)
# install.packages(magick)
library(magick) 

###1. 读取、储存图像
##jpg,png,tiff,bmp分别对应jpeg,png,tiff,bmp等包
##读取函数 readJPEG()或readPNG()
##写函数 writeJPEG(),writePNG()



data1 = readJPEG("bear_1.jpg")  # 读入jpg格式的图像
writeJPEG(data1, target = "bear_jpg_saved.jpg", quality = 1)  # 存储图像

data2 = readPNG("bear_1_png.png")  # 读入png格式的图像
writePNG(data2, target = "bear_png_saved.png")  # 存储图像

#批量读入图像
fileName = dir("bear_family/")  # 读取图像名
for (i in 1:length(fileName)){
  # 读入其中一张图像
  # 在这行代码之后可以输入具体的图像处理函数从而实现批量处理
  file_image_data = readJPEG(paste("bear_family/", fileName[i], sep = ''))
}

#EBImage是为医学图像分析准备的
readImage()#图片读入，支持jpg,tiff,png格式
resize()#自由变换图像尺寸
display()#将图片对象便利地绘制在R中的图形设备上


###2.三原色RGB
#三通道取值范围[0,255]之间整数
#R默认把数值转换为[0,1]之间
rgb()#看不同强度的三通道会是什么颜色
#三个通道都为0时，就是#000000黑色
#三个通道都为1时，就是#FFFFFF白色
#提取图片中各个通道的颜色，将其他通道的数值设置为0即可

#提取图像的三基色通道
X1 = readImage("bear_1.jpg")  # 读入图像
n.size = 300 
X1 = resize(X1, n.size, n.size)  # 修整图像尺寸，为下面的处理做准备

X11 = X1; X11[, , 1] = 0 * X11[, , 1]; X11[, , 2] = 0 * X11[, , 2]; display(X11)  # 提取蓝色通道的图像
X12 = X1; X12[, , 1] = 0 * X12[, , 1]; X12[, , 3] = 0 * X12[, , 3]; display(X12)  # 提取绿色通道的图像
X13 = X1; X13[, , 2] = 0 * X13[, , 2]; X13[, , 3] = 0 * X13[, , 3]; display(X13)  # 提取红色通道的图像

display(X11 + X12)  # 蓝色熊大+绿色熊大
display(X11 + X13)  # 蓝色熊大+红色熊大
display(X12 + X13)  # 绿色熊大+红色熊大




###3.灰度图

#颜色由红绿蓝三原色按比例混合而成的图像称为RGB图
#把白色与黑色之间按对数关系分为若干等级，称为灰度，分为256阶

#RGB图存储了3个大小为图像尺寸的矩阵
#灰度图只存储了1个矩阵

gray_image = channel(data1, "gray")  # 用EBImage包转灰度图
gray_image = RGB2GRAY(data1)  # 用RgoogleMaps包转灰度图


###4.分辨率

Y1 = readJPEG("bear_1_green.jpg")  # 读入图像
gray_image = RGB2GRAY(Y1)  # 转灰度图

# 画图展示图像分割
plot_jpeg = function(M, add = FALSE)  # 画图函数
{
  res = dim(M)[1:2]  # get the resolution
  if (!add)  # initialize an empty plot area if add == FALSE
    plot(1, 1, xlim = c(1, res[1]), ylim = c(1, res[2]), type = "n", asp = 1,
         xlab = '', ylab = '', bty = 'n', xaxs = 'i', yaxs = 'i', xaxt = 'n', yaxt = 'n')
  rasterImage(M, 1, 1, res[1], res[2])
  axis(1, at = (1:9) * 30, tick = T);
  axis(2, at = (1:9) * 30, tick = T);
  abline(h = (1:9) * 30, v = (1:9) * 30, col = "yellow", lty = 2)
}
plot_jpeg(gray_image)

# 将每个分割的小块像素归一
index_group = cut(1:300, seq(0, 300, 30))
lev = levels(index_group)
M1 = matrix(0, nrow = length(lev), ncol = length(lev))
for (i in 1:length(lev))
{
  for (j in 1:length(lev))
  {
    M1[i, j] = mean(gray_image[index_group == lev[i], index_group == lev[j]])  # M1即为10*10的图像
  }
} 



###5.图像运算


display(X1 + 0.5)  # 熊大+0.5

display(X1 - 0.5)  # 熊大-0.5

display(X1 * 2)  # 熊大*2

display(X1 / 2)  # 熊大/2

display(1 - X1)  # 1-熊大

display(X1 ^ 10)  # 熊大^10


X2 = readImage("bear_2.jpg");
X2 = resize(X2, n.size, n.size)  # 读入熊二的图像
display(X2)

display(X1 + X2)  # 熊大+熊二

display(X1 - X2)  # 熊大-熊二


###6. magick包
data1 = image_read("bear_1.jpg")  # 读入图像
image_crop(data1, "100 x 150 + 50")  # 剪切图像

image_border(data1, "black", "10 x 10")  # 加边框

image_rotate(data1, 45)  # 旋转45度

image_flip(data1)  # 上下翻转

image_flop(data1)  # 左右翻转

image_negate(data1)  # 反色


# 加标签
image_annotate(data1, "CONFIDENTIAL", size = 30, color = "red", boxcolor = "pink", degrees = 60, location = "+ 50 + 100")


image_noise(data1)  # 噪点


image_charcoal(data1)  # 素描风格




