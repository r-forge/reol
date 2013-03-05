GetRichnessScore <- function(Results, HierPages){
	RichnessScores <- rep(NA, length(HierPages))
	for(i in sequence(length(HierPages))) {
		eolPage<-GetEOLpageFromHierPage(HierPages[i])
		RichnessScores[i] <- Results[which(Results[,1] == eolPage), 3]
	}
	return(RichnessScores)
}