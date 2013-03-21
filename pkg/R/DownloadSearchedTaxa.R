URLencodeTaxa <- function(taxon) {
  taxon <- gsub("_", " ", taxon)
  taxon <- gsub("'+'", " ", taxon)  #doesn't work
  taxon <- gsub("'.'", " ", taxon)  #doesn't work
  return(URLencode(taxon))
}


MatchTaxatoEOLID <- function(ListOfTaxa, exact=TRUE){ 
  #Match a search taxon to an EOLID for downloading or storing
  #API can support fuzzy matching up to 30 matches if exact=F, but then pages have to be specified.  Might be a good thing to add later. 
  eolPageNumbers <- c()
  speciesNameForRef <- c()
  searchTaxon <- c()
  for (i in sequence(length(ListOfTaxa))) {  
    taxon <- URLencodeTaxa(ListOfTaxa[i])
	web <- paste('http://eol.org/api/search/1.0.xml?q=%22', taxon, '%22&exact=', exact, '&page=1', sep="")	#Partly fixed by url encoding, but still won't work if species name has a + or . in it instead of spaces or _.  
print(web)
    a <- getURL(web)
    searchRes <- c()
    searchRes <- xmlToList(xmlRoot(xmlParse(a, getDTD=FALSE)), simplify=FALSE)
    if(searchRes$totalResults == 0)  #didn't match any eol taxa
      searchRes$entry$id <- NA
    eolPageNumbers <- append(eolPageNumbers, searchRes$entry$id)  #there are other matches sometimes as well
    speciesNameForRef <- append(speciesNameForRef, searchRes$entry$title)
  }
  return(cbind(ListOfTaxa, speciesNameForRef, eolPageNumbers))
}


DownloadSearchedTaxa <- function(ListOfTaxa, MyKey=NULL, exact=TRUE, verbose=TRUE) {
  matches <- MatchTaxatoEOLID(ListOfTaxa, exact=exact)
  PagesToDownload <- unique(matches[,3])
  if(any(!is.na(PagesToDownload))) {
    DownloadEOLpages(as.numeric(PagesToDownload), MyKey, verbose=verbose)  
  }
}
