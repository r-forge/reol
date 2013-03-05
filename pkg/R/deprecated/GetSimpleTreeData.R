GetSimpleTreeData <- function(MyHiers){
library(XML)
#Get a list of taxonIDs that were downloaded pages
	pages <- gsub("eol", "", MyHiers)
	pages <- as.numeric(gsub(".xml", "", pages))
	SimpleTreeData<-matrix(nrow=length(pages), ncol=4)
	colnames(SimpleTreeData ) <- c("focalNodeID", "parentNodeID", "name", "rank")
	for (i in sequence(length(MyHiers))){
		resOneFile <- OneFileHierarchy(MyHiers[i])
		FocalNode <- resOneFile[which(resOneFile[,6] %in% pages),]
		SimpleTreeData[i,] <- c(FocalNode[6], FocalNode[5], FocalNode[1], FocalNode[2])
	}
	return(SimpleTreeData)
}
