#### Colour Palettes #####

# Extracting dominant colours from an image,
# and represent the image as a combination of
# only this limited range of colours

require(jpeg)
require(reshape2)
require(ggplot2)

source('scripts//elementaryFunctions.R')

imageurl <- "http://upload.wikimedia.org/wikipedia/en/8/82/Pulp_Fiction_cover.jpg"
download.file(imageurl, "images/pulpfiction.jpg", mode = "wb")
###

image.base <- LoadImageAsRGB('images/pulpfiction.jpg')
g1 <- ggplot(data=image.base, aes(
	x 	= x,
	y 	= y,
	col = rgb(r,g,b))
) 

set.seed(112)
k <- 6 #Number of colors to split the image into
#As you increase k, the 'simplified' representation gets better and better

cluster.result <- kmeans(image.base[,c("r","g","b")], centers = k)

image.clusters <- data.frame(cluster = cluster.result$cluster)

image.palette.hist <- ggplot(image.clusters,aes(
	x 	 = factor(cluster),
	fill = factor(cluster))
)
image.palette.hist + geom_bar() + scale_fill_manual(values = rgb(cluster.result$centers))
#^ This would have been way easier using qplot, but I prefer this syntax

image.simpler <- cbind(x= image.base$x, y=image.base$y,
					   image.clusters, cluster.result$centers[image.clusters$cluster,])
g2 <- ggplot(data=image.simpler, aes(
	x 	= x,
	y 	= y,
	col = rgb(r,g,b))
) 

g1 + geom_point() + scale_color_identity()
g2 + geom_point() + scale_color_identity()
