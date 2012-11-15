GatherResultsDataFrame<-function(MyFiles) {	
	library(XML)
	library(R.oo) 
	Results <- data.frame(matrix(nrow=1, ncol=3))
	for(i in sequence(length(MyFiles))) {
		res <- xmlToList(xmlRoot(xmlTreeParse(MyFiles[i], getDTD=F))[[1]], simplify = T)  #got it!! But note that the data objects come in after [[1]]
		eolID <- res$taxonConceptID
		if (is.null(eolID)) eolID <- NA
		sn <- res$ScientificName
		if (is.null(sn)) sn <- NA
		#rank <- 
		richness <- try(res$additionalInformation$richness_score, silent=T)  
		if (is.null(richness)) richness <- NA
		#NCBI number
	
		#Results[i,] <- c(eolID, sn, richness)
		if (i==1) {
			Results<-data.frame(as.numeric(eolID), sn, as.numeric(richness))
		}
		else {
			Results<-rbind(Results, data.frame(as.numeric(eolID), sn, as.numeric(richness)))
		}
	}  #works but has weird errors...
	colnames(Results)<-c("eolID", "name.scientific.full", "richness")
	TaxonNames<-sapply(Results[,2], FirstTwo)
	names(TaxonNames)<-NULL

	Results<-cbind(Results, name.scientific.short=TaxonNames)
	provider.vector<-c()
	provider.dataframe<-Results
	for(row.num in sequence(dim(Results)[1])){
		print(row.num)
		res<-xmlToList(xmlRoot(xmlTreeParse(MyFiles[row.num], getDTD=F))[[1]], simplify = T)
		whichTaxon<-which(names(res$additionalInformation)=="taxon")
		for (i in sequence(length(whichTaxon))) {
			source<-NULL
			try(source<-res$additionalInformation[[whichTaxon[i]]]$nameAccordingTo)
			if (!is.null(source)) {
				identifier<-NULL
				taxonID<-NULL
				scientificName<-NULL
				taxonRank<-NULL
				try(identifier<-res$additionalInformation[[whichTaxon[i]]]$identifier)
				try(taxonID<-res$additionalInformation[[whichTaxon[i]]]$taxonID)
				try(scientificName<-res$additionalInformation[[whichTaxon[i]]]$scientificName)
				try(taxonRank<-res$additionalInformation[[whichTaxon[i]]]$taxonRank)
				if(sum(grepl(paste(source,'*',sep=""), colnames(Results)))==0) {
					provider.dataframe<-cbind(provider.dataframe, rep(0, dim(provider.dataframe)[1]))
					colnames(provider.dataframe)[dim(provider.dataframe)[2]]<-source
					provider.vector<-append(provider.vector, source)
					Results<-cbind(Results, rep(NA,dim(Results)[1]))
					colnames(Results)[dim(Results)[2]]<-paste(source,".identifier",sep="")
					Results<-cbind(Results, rep(NA,dim(Results)[1]))
					colnames(Results)[dim(Results)[2]]<-paste(source,".taxonID",sep="")
					Results<-cbind(Results, rep(NA,dim(Results)[1]))
					colnames(Results)[dim(Results)[2]]<-paste(source,".scientificName",sep="")
					Results<-cbind(Results, rep(NA,dim(Results)[1]))
					colnames(Results)[dim(Results)[2]]<-paste(source,".taxonRank",sep="")
				}
				provider.dataframe[row.num, which(colnames(provider.dataframe)==source)]<-1
				if (!is.null(identifier)) Results[row.num, which(colnames(Results)==paste(source,".identifier",sep=""))]<-identifier
				if (!is.null(taxonID)) Results[row.num, which(colnames(Results)==paste(source,".taxonID",sep=""))]<-taxonID
				if (!is.null(scientificName)) Results[row.num, which(colnames(Results)==paste(source,".scientificName",sep=""))]<-scientificName
				if (!is.null(taxonRank)) Results[row.num, which(colnames(Results)==paste(source,".taxonRank",sep=""))]<-taxonRank
			}
		}
	}

	provider.dataframe<-cbind(provider.dataframe, number.sources=apply(provider.dataframe[,5:dim(provider.dataframe)[2]], 1, sum))

	Results<-cbind(Results, provider.dataframe[,5:dim(provider.dataframe)[2]])
	Results<-Results[which(!is.na(Results$eolID)),]
	return(Results)
}

