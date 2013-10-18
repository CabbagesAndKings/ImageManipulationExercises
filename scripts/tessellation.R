### Tessellation

require(jpeg)
require(reshape2)
require(ggplot2)

source('scripts//elementaryFunctions.R')

imageurl <- "http://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Johannes_Vermeer_%281632-1675%29_-_The_Girl_With_The_Pearl_Earring_%281665%29.jpg/335px-Johannes_Vermeer_%281632-1675%29_-_The_Girl_With_The_Pearl_Earring_%281665%29.jpg"
download.file(imageurl, "images/pearlearring.jpg", mode = "wb")
###

image.base <- LoadImageAsRGB('images/pearlearring.jpg')

g1 <- ggplot(data=image.base, aes(
	x 	= x,
	y 	= y,
	col = rgb(r,g,b))
) 

set.seed(761)

nRegions <- 300
cluster.result <- kmeans(image.base, centers = nRegions, iter.max = 50)
image.tessellated <- cbind(image.base[,1:2], cluster.result$centers[cluster.result$cluster, c("r","g","b")] )

g2 <- ggplot(data=image.tessellated, aes(
	x 	= x,
	y 	= y,
	col = rgb(r,g,b))
) 


g1 + geom_point() + scale_color_identity()
g2 + geom_point() + scale_color_identity()




