ProviderCount <- function(MyEOLs, from.file=T, verbose=FALSE) {
  #Returns vector of provider coverage
  results <- GatherProviderDataFrame(MyEOLs, from.file=from.file, extended.output=FALSE)[,-1:-2]
  results <- results[, -dim(results)[2]]
  counts <- apply(results, 2, sum)
  names(counts) <- colnames(results)
  counts <- sort(counts, decreasing=TRUE)
  if (verbose)
    print(t(t(counts)))	
  return(counts)
}

BestProvider <- function(MyEOLs, from.file=T) {
  #Returns the provider with the most taxonomic coverage
  return(names(ProviderCount(MyEOLs, from.file=from.file))[1])	
}


DownloadHierarchy <- function(MyEOLs, from.file=T, to.file=T, database=NULL, verbose=TRUE) {
#MyEOLs can be a file or an R object
#from.file is whether it should find the data via a file (T) or an R object (F)
#to.file is whether you want to save the information as a file (T) or an R object (F)
  #Downloads provider database
  if(is.null(database))
    database <- BestProvider(MyEOLs, from.file)	
  results <- GatherProviderDataFrame(MyEOLs, from.file, extended.output=TRUE)
  column <- which(colnames(results) == paste(database, ".taxonID", sep=""))
  pages <- results[,column] 
  hierpages <- vector("list", length=length(pages))
  for (i in sequence(length(pages))) {
    if (!is.na(pages[i])) {
      pageNum<-pages[i]
      web <- paste("http://eol.org/api/hierarchy_entries/1.0/", pageNum, sep="")
      if(to.file) {
        write(getURL(web), file=paste("hier", pages[i], ".xml", sep=""))
        if(verbose)
          print(paste("Downloaded ", "hier", pages[i], ".xml", sep=""))
      }
      else {
        hierpages[[i]] <- getURL(web)
        names(hierpages)[[i]] <- paste("hier", pages[i], sep="")
        if(verbose)
          print(paste("hier", pages[i], " saved as R object", sep=""))
      }
      Sys.sleep(1)
    }
  }
  if(to.file)
    return(paste("hier", pages, ".xml", sep=""))
  else
    return(hierpages)
}
