GatherSynonyms <- function(MyHiers, output=c("detail", "counts")) {
  if(any(is.na(GetHierID(MyHiers)))) {
  	whichNAs <- which(is.na(names(MyHiers)))
  	MyHiers <- MyHiers[-whichNAs]
  }
  output <- match.arg(output)
  syns <- matrix(ncol=3, nrow=0)
  colnames(syns) <- c("Taxon", "hierID", "Synonym")
  SynCounts <- matrix(nrow=length(MyHiers), ncol=3)
  colnames(SynCounts) <- c("Taxon", "hierID", "NumberOfSynonyms")
  for(i in sequence(length(MyHiers))){
    resOneFile <- OneFileHierarchy(MyHiers[i])
    whichSpecies <- c(which(resOneFile[,2] == "Species"), which(resOneFile[,2] == "species"), which(resOneFile[,2] == "Sp."), which(resOneFile[,2] == "sp."), which(resOneFile[,2] == "Sp"), which(resOneFile[,2] == "sp"), which(resOneFile[,2] == "SP"))
    whichSyn <- c(which(resOneFile[,3] == "Synonym"), which(resOneFile[,3] == "synonym"))
    if(length(whichSpecies) > 0)
      SynCounts[i,] <- c(resOneFile[whichSpecies[1], 1], resOneFile[whichSpecies[1], 6], length(whichSyn))
    if(length(whichSyn) > 0) {
      for(j in sequence(length(whichSyn))) {
        syns <- data.frame(rbind(syns, c(resOneFile[whichSpecies[1], 1], resOneFile[whichSpecies[1], 6], resOneFile[whichSyn[j], 1])), stringsAsFactors=FALSE) 
      }
    }
  }
  SynCounts <- data.frame(SynCounts, stringsAsFactors=FALSE)
  SynCounts[,3] <- as.numeric(SynCounts[,3])
  if(output == "detail")
    return(syns)
  if(output == "counts")
    return(SynCounts)
}
