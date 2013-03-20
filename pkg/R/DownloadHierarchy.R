ProviderCount <- function(MyFiles, verbose=FALSE) {
  #Returns vector of provider coverage
  results <- GatherProviderDataFrame(MyFiles, extended.output=FALSE)[,-1:-2]
  results <- results[, -dim(results)[2]]
  counts <- apply(results, 2, sum)
  names(counts) <- colnames(results)
  counts <- sort(counts, decreasing=TRUE)
  if (verbose)
    print(t(t(counts)))	
  return(counts)
}

BestProvider <- function(MyFiles) {
  #Returns the provider with the most taxonomic coverage
  return(names(ProviderCount(MyFiles))[1])	
}


DownloadHierarchy <- function(MyFiles, database=NULL, verbose=TRUE) {
  #Downloads provider database
  if(is.null(database))
    database <- BestProvider(MyFiles)	
  results <- GatherProviderDataFrame(MyFiles, extended.output=TRUE)
  column <- which(colnames(results) == paste(database, ".taxonID", sep=""))
  pages <- results[,column] 
  for (i in sequence(length(pages))) {
    if (!is.na(pages[i])) {
      pageNum<-pages[i]
      web <- paste("http://eol.org/api/hierarchy_entries/1.0/", pageNum, sep="")
      write(getURL(web), file=paste("hier", pages[i], ".xml", sep=""))
      if(verbose)
        print(paste("Downloaded ", "hier", pages[i], ".xml", sep=""))
      Sys.sleep(1)
    }
  }
}
