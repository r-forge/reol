GetHierID <- function(MyHier){
  conceptID <- gsub("hier", "", MyHier)
  conceptID <- gsub(".xml", "", conceptID)
  return(conceptID)
}