


DownloadSearchedTaxa<- function(ListOfTaxa, MyKey) {
#Download xml page content  #now full content using X=75
	for (i in sequence(length(ListOfTaxa))){  #First download the search 
		taxon <- ListOfTaxa[i]
		system(paste("curl 'http://eol.org/api/search/1.0/", taxon, ".xml'", " -o search", taxon,".xml -a", sep=""))
		Sys.sleep(1)
	}
	MySearches<-system("ls -1 search*.xml", intern=T) #load search xmls
	eolPagesToDownload<-c()
	speciesNameForRef <- c()
	for(i in sequence(length(MySearches))){
		res <- xmlToList(xmlRoot(xmlTreeParse(MySearches[i], getDTD=F)))
		eolPagesToDownload<-append(eolPagesToDownload, res$entry$id)
		speciesNameForRef <- append(speciesNameForRef, res$entry$title)
	}
	DownloadEOLpages(eolPagesToDownload, MyKey)
	return(list(speciesNameForRef, eolPagesToDownload))
}
