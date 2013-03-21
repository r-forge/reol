GatherSynonyms <- function(MyHiers, output=c("detail", "counts")) {
	#change this to option1 or 2 like others
	#option 1 will return a dataframe with each syn and option 2 will return a count list
  output <- match.arg(output)
  syns <- c()
  SynCounts <- c()
  for(i in sequence(length(MyHiers))){
    resOneFile <- OneFileHierarchy(MyHiers[i])
    whichSpecies <- c(which(resOneFile[,2] == "Species"), which(resOneFile[,2] == "species"))
    whichSyn <- c(which(resOneFile[,3] == "Synonym"), which(resOneFile[,3] == "synonym"))
    if(length(whichSpecies) > 0)
      SynCounts <- rbind(SynCounts, c(resOneFile[whichSpecies[1], 1], resOneFile[whichSpecies[1], 6], length(whichSyn)))
    if(length(whichSyn) > 0) {
      synonym <- c()
      for(j in sequence(length(whichSyn))) {
        synonym <- c(resOneFile[whichSpecies[1], 1], resOneFile[whichSpecies[1], 6], resOneFile[whichSyn[j], 1])
      }
    syns <- rbind(syns, synonym)
    }
      
  }
  colnames(syns) <- c("Taxon", "hierID", "Synonym")
  colnames(SynCounts) <- c("Taxon", "hierID", "NumberOfSynonyms")
  if(output == "detail")
    return(syns)
  if(output == "counts")
    return(SynCounts)
}