getTipList <- function(phy) {
  tipList <- cbind(phy$edge, phy$edge[,2] %in% phy$edge[,1], rep(0, dim(phy$edge)[1]))
  tips <- which(tipList[,3] == 0)
  tipList[tips,3] <- "tip"
  tipList[tips,4] <- phy$tip.label[as.numeric(tipList[tips,2])]
  ints <- which(tipList[,3] == 1)
  tipList[ints,3] <- "internal"
  return(data.frame(tipList, stringsAsFactors=F))
}

whichEdge <- function(phy, taxa) {
  tipList <- getTipList(phy)
  return(min(as.numeric(tipList[tipList[,4] %in% taxa, 1])))
}

MakeEdgeLabels <- function(MyHiers, label="all"){
  NodeLabelList <- NodeLabelList(MyHiers)
  phy <- MakeHierarchyTree(MyHiers, includeNodeLabels=FALSE)
  tipList <- getTipList(phy)
  edges <- c(lapply(NodeLabelList, whichEdge, phy=phy), recursive=T)
  for(i in 1:length(edges)){
    tipList[which(tipList[,2] == edges[i]),4] <- names(edges[i])  #will write over tax set group names
  }
  justInts <- which(tipList[,3] == "internal")   #to get row to use in ape
  names(justInts) <- tipList[tipList[,3] == "internal",4]  #associate taxon name with row
  return(justInts)
}
