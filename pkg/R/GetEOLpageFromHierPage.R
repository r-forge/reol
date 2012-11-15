GetEOLpageFromHierPage<-function(HierPage){
	resOneFile<-OneFileHierarchy(paste("eol", HierPage, ".xml", sep=""))
	resOneFile[which(resOneFile[,6] == HierPage), 4]  #returns ConceptID number from taxonID number
}
