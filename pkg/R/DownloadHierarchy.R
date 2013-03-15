DownloadHierarchy <- function(MyFiles, database="calc", verbose=T){
# Results should be entire database
# database=c("worms", "ncbi", "itis", "iucn") or calculate which has the most
  Results <- GatherProviderDataFrame(MyFiles, F)[,-1:-2]
  NumberOfPages <- apply(Results, 2, sum)[-dim(Results)[2]]
  if (database == "calc") {  #calculate the database with the most taxonomic coverage
    ProviderToUse <- names(which(NumberOfPages == max(NumberOfPages))[1]) #[1] extract first if several max
    print(paste("using ", ProviderToUse, "as the hierarchy provider"))
  }
  if (database == "user.defined") { #User required input for choice
    print(cbind(NumberOfPages, choose=1:length(NumberOfPages)))
    ProviderToUse <- names(NumberOfPages)[as.numeric(readline(prompt="Which provider database would you like to download?"))]
    print(paste("using ", ProviderToUse, "as the hierarchy provider"))
  }
  Results <- GatherProviderDataFrame(MyFiles, T)
  column  <- which(colnames(Results) == paste(ProviderToUse, ".taxonID", sep=""))
  pages <- Results[,column] 
  for (i in sequence(length(pages))){
    if (!is.na(pages[i])) {
      pageNum<-pages[i]
      web <- paste("http://eol.org/api/hierarchy_entries/1.0/", pageNum, sep="")
      write(getURL(web), file=paste("hier", pages[i], ".xml", sep=""))
      if(verbose)
        print(paste("Downloaded ", "hier", pages[i], ".xml", sep=""))
    }
  Sys.sleep(1)
  }
}
