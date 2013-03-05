GetTaxonID<-function(MyFiles){
#Use hierarchies
#could make all three a single function by appending the list
	allRanks <- c()
	taxonList <- list()
	for(i in sequence(length(MyFiles))){
		resOneFile <- OneFileHierarchy(MyFiles[i])
		taxon <- resOneFile[,6][which(!is.na(resOneFile[, 2]))]
		names(taxon) <- resOneFile[,2][which(!is.na(resOneFile[,2]))]
		taxonList[[i]] <- taxon[!duplicated(names(taxon))]   ##get rid of duplicates (annoying)
		allRanks <- append(allRanks, names(taxonList[[i]]))
	}
	uniqueRanks <- unique(allRanks)
	taxonID <- matrix(nrow=length(MyFiles), ncol=length(uniqueRanks))
	colnames(taxonID)<-uniqueRanks
	for (row in sequence(length(taxonList))){
		for(j in sequence(length(taxonList[[row]]))) {
			col <- which(colnames(taxonID) == names(taxonList[[row]])[j])
			taxonID[row, col] <- taxonList[[row]][j]
		}
	}
	return(taxonID)  
}		


