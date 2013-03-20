MatchTaxatoEOLID <- function(ListOfTaxa, exact=TRUE){ 
  #Match a search taxon to an EOLID for downloading or storing
  #API can support fuzzy matching up to 30 matches if exact=F, but then pages have to be specified.  Might be a good thing to add later. 
  eolPageNumbers <- c()
  speciesNameForRef <- c()
  searchTaxon <- c()
  for (i in sequence(length(ListOfTaxa))) {  
    taxon <- ListOfTaxa[i]
	web <- paste('http://eol.org/api/search/1.0.xml?q="', taxon, '"&exact=', exact, '&page=1', sep="")	
    a <- getURL(web)
    searchRes <- c()
    searchRes <- xmlToList(xmlRoot(xmlParse(a, getDTD=FALSE)), simplify=FALSE)
    if(searchRes$totalResults == 0)  #didn't match any eol taxa
      searchRes$entry$id <- "No matches"
    eolPageNumbers <- append(eolPageNumbers, searchRes$entry$id)  #there are other matches sometimes as well
    speciesNameForRef <- append(speciesNameForRef, searchRes$entry$title)
  }
  return(cbind(ListOfTaxa, speciesNameForRef, eolPageNumbers))
}


DownloadSearchedTaxa <- function(ListOfTaxa, MyKey=NULL, exact=TRUE, verbose=FALSE) {
  eolPageNumbers <-c()
  speciesNameForRef <- c()
  searchTaxon <- c()
  for (i in sequence(length(ListOfTaxa))){  #First download the search 
    taxon <- ListOfTaxa[i]
    searchTaxon <- append(searchTaxon, taxon)
	web <- paste("http://eol.org/api/search/1.0/", taxon, sep="")	
    a <- getURL(web)
    searchRes <-c()
    searchRes <- xmlToList(xmlRoot(xmlParse(a, getDTD=FALSE)), simplify=FALSE)
    if(searchRes$totalResults == 0)  #didn't match any eol taxa
      searchRes$entry$id <- "No matches"
    eolPageNumbers <- append(eolPageNumbers, searchRes$entry$id)  #there are other matches sometimes as well
    speciesNameForRef <- append(speciesNameForRef, searchRes$entry$title)
    if(searchRes$totalResults > 0)
	  DownloadEOLpages(as.numeric(searchRes$entry$id), MyKey, verbose=F)  
    if(verbose) {
      if(searchRes$totalResults == 0)
        print(paste("Did not download any page for", taxon))
      if(searchRes$totalResults > 0)
        print(paste("Downloaded ", taxon, " to eol", as.numeric(searchRes$entry$id), ".xml", sep=""))
    }
  }
  Sys.sleep(1)
  return(cbind(searchTaxon, speciesNameForRef, eolPageNumbers))
}
