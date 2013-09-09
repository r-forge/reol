GetHierID <- function(MyHier){
  if(class(MyHier) == "list")
    conceptID <- gsub("^\\D+|\\D+$", "", names(MyHier))
  if(class(MyHier) == "character")
    conceptID <- gsub("^\\D+|\\D+$", "", MyHier)
  return(conceptID)
}