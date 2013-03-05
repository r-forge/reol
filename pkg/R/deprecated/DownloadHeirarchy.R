DownloadHeirarchy<-function(Results, database="calc"){
# Results should be entire database
# database=c("worms", "ncbi", "itis", "iucn") or calculate which has the most
	if (database == "worms") column<-6
	if (database == "ncbi") column<-10
	if (database == "itis") column<-18
	if (database == "iucn") column<-26
	if (database == "calc") {
		res <- ProviderContributions(Results, verbose=F)
		print(res)
		column <- which(paste(res, ".identifier", sep="") == names(Results))
	}
	pages <- Results[,column] 
	for (i in sequence(length(pages))){
		if (!is.na(pages[i])) {
			pageNum<-pages[i]
			print(i)
			system(paste("curl 'http://eol.org/api/hierarchy_entries/1.0/", pageNum, ".xml'", " -o hier", pageNum,".xml -a", sep=""))
			Sys.sleep(1)
		}
	}
}
