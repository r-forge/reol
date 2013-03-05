ProviderContributions<-function(Results, verbose=T){
	ProList <- c()
	for(i in 49:59) {
		ProList<- append(ProList, sum(Results[,i]))
	}
	names(ProList)<-names(Results)[49:59]
	if (verbose)
		return(ProList)
	else
		return(names(which(ProList==max(ProList))))	
}

