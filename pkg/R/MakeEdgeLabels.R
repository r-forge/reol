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
  nodes <- tipList[tipList[, 4] %in% taxa, 1]
  if(length(unique(nodes)) == 1)  #works for finding tip ancestors
    return(as.numeric(unique(nodes)))
  else {
    while(length(unique(nodes)) > 1) {
      rows <- suppressWarnings(which(tipList[,2] == nodes))
      nodes <- as.numeric(tipList[rows, 1])
    }
  return(as.numeric(unique(nodes)))
  }  
}

MakeEdgeLabels <- function(MyHiers, label="all"){
  if(any(is.na(GetHierID(MyHiers)))) {
  	whichNAs <- which(is.na(names(MyHiers)))
  	MyHiers <- MyHiers[-whichNAs]
  }
  nodeList <- NodeLabelList(MyHiers)
  if(length(nodeList) == 0)
    stop("Node Labels can not be created, because hierarchy information doesn't overlap")
  phy <- MakeHierarchyTree(MyHiers, includeNodeLabels=FALSE)
  tipList <- getTipList(phy)
  edges <- c(lapply(nodeList, whichEdge, phy=phy), recursive=T)
  for(i in 1:length(edges)){
    tipList[which(tipList[,2] == edges[i]),4] <- names(edges[i])  #will write over tax set group names
  }
  justInts <- which(tipList[,3] == "internal")   #to get row to use in ape
  names(justInts) <- tipList[tipList[,3] == "internal",4]  #associate taxon name with row
  if(any(names(justInts) == 0))
    justInts <- justInts[-which(names(justInts) == 0)]
  return(justInts)
}
