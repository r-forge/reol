ProviderCount <- function(MyFiles, verbose=FALSE) {
	results <- 	GatherProviderDataFrame(MyFiles, extended.output=FALSE)[,-1:-2]
	results <- results[, -dim(results)[2]]
	counts <- apply(results, 2, sum)
	names(counts) <- colnames(results)
	counts <- sort(counts, decreasing=TRUE)
	if (verbose) {
		print(t(t(counts)))	
	}
	return(counts)
}

BestProvider <- function(MyFiles) {
	return(names(ProviderCount(MyFiles))[1])	
}




DownloadHierarchy <- function(MyFiles, database=NULL, verbose=TRUE){
	if(is.null(database)) {
		database <- BestProvider(MyFiles)	
	}
  Results <- GatherProviderDataFrame(MyFiles, extended.output=TRUE)
  column  <- which(colnames(Results) == paste(database, ".taxonID", sep=""))
  pages <- Results[,column] 
  for (i in sequence(length(pages))){
    if (!is.na(pages[i])) {
      pageNum<-pages[i]
      web <- paste("http://eol.org/api/hierarchy_entries/1.0/", pageNum, sep="")
      write(getURL(web), file=paste("hier", pages[i], ".xml", sep=""))
      if(verbose) {
        print(paste("Downloaded ", "hier", pages[i], ".xml", sep=""))
      }
      Sys.sleep(1)
    }
  }
}
