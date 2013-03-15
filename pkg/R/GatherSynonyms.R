GatherSynonyms <- function(MyHiers, output=1) {
	#change this to option1 or 2 like others
	#option 1 will return a dataframe with each syn and option 2 will return a count list
  syns <- vector("list")
  for(i in sequence(length(MyHiers))){
    resOneFile <- OneFileHierarchy(MyHiers[i])
    synonyms <- c()
    ProviderTaxonID <- c()
    for(k in sequence(dim(resOneFile)[1])) {
      if(!is.na(any(resOneFile[k,2] == "Species") || any(resOneFile[k,2] == "species") || any(resOneFile[k,3] == "valid") || any(resOneFile[k,3] == "synonym"))) {
        synonyms <- append(synonyms, resOneFile[k,1])
        ProviderTaxonID <- append(ProviderTaxonID, resOneFile[k,6])
      }
    }
    syns[[i]] <- synonyms
    names(syns[[i]]) <- ProviderTaxonID
  }
  return(syns)
}