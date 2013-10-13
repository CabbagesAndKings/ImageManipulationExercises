#Basic Image Manipulation

# Load an image, display it
# Perform basic manipulations

library(jpeg)
library(reshape2)
library(ggplot2)

imageurl <- "http://farm4.staticflickr.com/3724/9416396550_2d5770cffa_b.jpg"
download.file(imageurl, "images/baseimage.jpg", mode = "wb")

source('scripts/elementaryFunctions.R')
image.base <- LoadImageAsRGB("images/baseimage.jpg") #y,x,r,g,b


#### Plot the same image ####
with(image.base, plot(x, y, col = rgb(r,g,b), asp = 1, pch = "."))

#which is short for:
plot(image.base$x, image.base$y,
	 col = rgb(image.base$r,image.base$g,image.base$b),
	 asp = 1, pch = ".")

#Or, in ggplot2:
g1 <- ggplot(data=image.base, aes(
			x 	= x,
			y 	= y,
			col = rgb(r,g,b))
	   ) 
g1 + geom_point() + scale_color_identity()


#### Add jitter/impressionism ####

image.impressionist 	 <- image.base
image.impressionist$x 	 <- jitter(image.impressionist$x)
image.impressionist$y 	 <- jitter(image.impressionist$y)
image.impressionist$size <- runif(1:nrow(image.impressionist), 0, 2) 

with(image.impressionist, plot(x, y,
							   col = rgb(r,g,b), asp = 1,
							   cex = size)
	 )
#Or, in ggplot2:
g2 <- ggplot(data=image.impressionist, aes(
	x 	 = x,
	y 	 = y,
	size = size,
	col  = rgb(r, g, b))
) 
g2 + geom_point() + scale_color_identity() +
	theme(legend.position = "none") 



