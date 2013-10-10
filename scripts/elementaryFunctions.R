

LoadImageAsRGB <- function(imagefile){
	baseimage <- readJPEG(imagefile)
	#This is a height x width x 3(rgb) array
	longimage <- melt(baseimage, varnames=c("y","x","rgb"), value.name="value" )
	rgbimage <- reshape(longimage, timevar = "rgb",
						idvar = c("x", "y"), direction = "wide")
	colnames(rgbimage) <- c("y","x","r","g","b")
	rgbimage$y <- -rgbimage$y #plotting axes have origin on bottom-left
	rgbimage
}
