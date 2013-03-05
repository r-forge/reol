GetParentID<-function(MyFiles){
#Use hierarchies
	allRanks <- c()
	taxonList <- list()
	for(i in sequence(length(MyFiles))){
		resOneFile <- OneFileHierarchy(MyFiles[i])
		taxon <- resOneFile[,5][which(!is.na(resOneFile[, 2]))]
		names(taxon) <- resOneFile[,2][which(!is.na(resOneFile[,2]))]
		taxonList[[i]] <- taxon[!duplicated(names(taxon))]   ##get rid of duplicates (annoying)
		allRanks <- append(allRanks, names(taxonList[[i]]))
	}
	uniqueRanks <- unique(allRanks)
	parentID <- matrix(nrow=length(MyFiles), ncol=length(uniqueRanks))
	colnames(parentID)<-uniqueRanks
	for (row in sequence(length(taxonList))){
		for(j in sequence(length(taxonList[[row]]))) {
			col <- which(colnames(parentID) == names(taxonList[[row]])[j])
			parentID[row, col] <- taxonList[[row]][j]
		}
	}
	return(parentID)  
}		
