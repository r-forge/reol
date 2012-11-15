GetNumberSources <- function(Results, HierPages){
	NumberSources <- rep(NA, length(HierPages))
	for(i in sequence(length(HierPages))) {
		eolPage<-GetEOLpageFromHierPage(HierPages[i])
		NumberSources[i] <- Results[which(Results[,1] == eolPage), 60]
	}
	return(NumberSources)
}
