MakeDataFromHeirarchy<-function(MyFiles){
	# Read in all the info
	#ListancDesc <- vector("list")
	taxonID <- data.frame()
	parentID <- data.frame()
	syns <- list()
	for(i in sequence(length(MyFiles))){
		res<-xmlToList(xmlRoot(xmlTreeParse(MyFiles[i], getDTD=F)))
		tax <- c()
		parentTax <- c()
		syns[[i]] <- res$Taxon$scientificName
		for(j in 1:7){
			tax <- c(tax, res[j]$Taxon$taxonID)	
			parentTax <- c(parentTax, res[j]$Taxon$parentNameUsageID)	
		}
		if(length(res) > 9){
			for(k in 9:length(res)){
				syns[[i]]<-append(syns[[i]], res[k]$Taxon$scientificName)   #records synonyms		
			}
		}
		taxonID <- rbind(taxonID, as.numeric(tax)) 
		parentID <- rbind(parentID, as.numeric(parentTax)) 
		#ListancDesc[[i]] <- ancDesc
	}
	colnames(taxonID)<- c("kingdom", "phylum", "class", "order", "family", "genus", "species")
	colnames(parentID)<- c("kingdom", "phylum", "class", "order", "family", "genus", "species")
	return(list(taxonID, parentID, syns))
}