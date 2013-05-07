MatchHierPageToEOLdata <- function(MyHiers, EOLdata){
  if(any(MyHiers == "hierNA.xml"))
  	MyHiers <- MyHiers[-which(MyHiers == "hierNA.xml")]
  matchedData <- matrix(nrow=length(MyHiers), ncol=3)
  #colnames(matchedData) <- c( "HierTaxon", "HierID", "eolID")
  matchedData[,2] <- as.character(sapply(MyHiers, GetHierID))
  for(i in sequence(length(MyHiers))) {
    resOneFile<-OneFileHierarchy(MyHiers[i])
    matchedData[i,1] <- resOneFile[which(matchedData[i,2]==resOneFile[,6]), 1]
    matchedData[i,3] <- resOneFile[which(matchedData[i,2]==resOneFile[,6]), 4]
  }
  matches <- match(matchedData[,3], EOLdata[,2])
  matchedData <- cbind(matchedData, EOLdata[matches, 3:dim(EOLdata)[2]])
  colnames(matchedData) <- c( "HierTaxon", "HierID", "eolID", colnames(EOLdata[3:dim(EOLdata)[2]]))
  matchedData <- data.frame(matchedData, row.names=1, stringsAsFactors=FALSE)
  return(matchedData)
}
