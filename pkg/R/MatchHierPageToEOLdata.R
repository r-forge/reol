MatchHierPageToEOLdata <- function(MyHiers, EOLdata){
  if(any(is.na(names(MyHiers)))) {
  	whichNAs <- which(is.na(names(MyHiers)))
  	MyHiers <- MyHiers[-whichNAs]
  }
  if(class(MyHiers) == "list")
    fileNames <- names(MyHiers)
  else
    fileNames <- MyHiers
  matchedData <- matrix(nrow=length(MyHiers), ncol=3)
  matchedData[,2] <- as.character(sapply(fileNames, GetHierID))
  for(i in sequence(length(MyHiers))) {
    resOneFile<-OneFileHierarchy(MyHiers[i])
    matchedData[i,1] <- resOneFile[which(matchedData[i,2]==resOneFile[,6]), 1] #taxonName
    matchedData[i,3] <- resOneFile[which(matchedData[i,2]==resOneFile[,6]), 4] #HierID
  }
  matches <- match(matchedData[,3], EOLdata[,2])
  matchedData <- cbind(matchedData, EOLdata[matches, 3:dim(EOLdata)[2]])
  colnames(matchedData) <- c( "HierTaxon", "HierID", "eolID", colnames(EOLdata[3:dim(EOLdata)[2]]))
  matchedData <- data.frame(matchedData, row.names=1, stringsAsFactors=FALSE)
  return(matchedData)
}
