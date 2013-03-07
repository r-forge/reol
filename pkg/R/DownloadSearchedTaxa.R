DownloadSearchedTaxa <- function(ListOfTaxa, MyKey=NULL, verbose=T) {
  eolPageNumbers <-c()
  speciesNameForRef <- c()
  searchTaxon <- c()
  for (i in sequence(length(ListOfTaxa))){  #First download the search 
    taxon <- ListOfTaxa[i]
    searchTaxon <- append(searchTaxon, taxon)
	web <- paste("http://eol.org/api/search/1.0/", taxon, sep="")	
    a <- getURL(web)
    searchRes <-c()
    searchRes <- xmlToList(xmlRoot(xmlTreeParse(a, getDTD=F)))
    if(searchRes$totalResults==0)  #didn't match any eol taxa
      searchRes$entry$id <- "No matches"
    eolPageNumbers <- append(eolPageNumbers, searchRes$entry$id)  #there are other matches sometimes as well
    speciesNameForRef <- append(speciesNameForRef, searchRes$entry$title)
    if(searchRes$totalResults>0)
	  DownloadEOLpages(as.numeric(searchRes$entry$id), MyKey)  
    if(verbose) {
      if(searchRes$totalResults==0)
        print(paste("Did not download any page for", taxon))
      if(searchRes$totalResults>0)
        print(paste("Downloaded ", taxon, " to eol", as.numeric(searchRes$entry$id), ".xml", sep=""))
    }
  }
  Sys.sleep(1)
  return(cbind(searchTaxon, speciesNameForRef, eolPageNumbers))
}
