#make a plot with media values
GatherMedia<-function(MyEOLs){
	TotalNumberOfMedia<-rep(NA, length(MyEOLs))
	RecordedSpecies <- rep(NA, length(MyEOLs))
	for(i in sequence(length(MyEOLs))){
		numberOfMediaPerspecies<-0
		res <- xmlToList(xmlRoot(xmlTreeParse(MyEOLs[i], getDTD=F)))
		if((length(res[[1]])) != 1){
			RecordedSpecies[i]<-res[[1]]$ScientificName
			for(j in sequence(length(res))) {
				if(names(res[[j]])[1]=="dataObjectID")	{
					#replace NA with info
					numberOfMediaPerspecies<-numberOfMediaPerspecies+1
				}
			}
		}
		TotalNumberOfMedia[i]<-numberOfMediaPerspecies
	}
	return(cbind(RecordedSpecies, TotalNumberOfMedia))	
}
