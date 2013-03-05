GetKingdoms <- function(MyHiers){
library(XML)
#Get a list of taxonIDs that were downloaded pages
	HierPages <- gsub("eol", "", MyHiers)
	HierPages <- gsub("hier", "", MyHiers)
	HierPages <- as.numeric(gsub(".xml", "", HierPages))
	Kingdoms<- rep(NA, length(HierPages))
	for (i in sequence(length(MyHiers))){
    	resOneFile <- OneFileHierarchy(MyHiers[i])
    	Kingdoms[i] <- resOneFile[1,1]
	}
	return(Kingdoms)
}
