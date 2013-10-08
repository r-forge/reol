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
  rootNode <- Ntip(phy) +1
  tipList <- getTipList(phy)
  nodes <- tipList[tipList[, 4] %in% taxa, 1]
  if(length(unique(nodes)) == 1)  
    return(as.numeric(unique(nodes)))
  if(length(unique(nodes)) > 1) {
    if(rootNode %in% nodes)
      nodes <- nodes[-which(nodes==rootNode)]
    return(min(as.numeric(unique(nodes))))
  } 
}

WhatToDoWithDuplicateEdgeNames <- function(edgeLabels, duplicateEdgeLabels){
  if(duplicateEdgeLabels == "recent")
    return(names(edgeLabels[length(edgeLabels)]))
  if(duplicateEdgeLabels == "oldest")
    return(names(edgeLabels[1]))
  if(duplicateEdgeLabels == "combined")
    return(paste(names(edgeLabels), sep="", collapse="."))
}

MakeEdgeLabels <- function(MyHiers, label="all", duplicateEdgeLabels="recent"){
  if(any(is.na(GetHierID(MyHiers)))) {
  	whichNAs <- which(is.na(GetHierID(MyHiers)))
  	MyHiers <- MyHiers[-whichNAs]
  }
  nodeList <- NodeLabelList(MyHiers, label="all")
  if(length(nodeList) == 0)
    stop("Node Labels can not be created, because hierarchy information doesn't overlap")
  phy <- MakeHierarchyTree(MyHiers, includeNodeLabels=FALSE)
  tipList <- getTipList(phy)
  edges <- c(lapply(nodeList, whichEdge, phy=phy), recursive=T)
  for(i in sequence(length(edges))){
    #reduce duplicate edge labels to either recent/ancestral/combined names  
    if(length(edges[which(edges == edges[i])]) >= 2) {
      duplicateEdges <- edges[which(edges == edges[i])]
      names(edges)[i] <- WhatToDoWithDuplicateEdgeNames(duplicateEdges, duplicateEdgeLabels)
    }
  tipList[which(tipList[,2] == edges[i]),4] <- names(edges)[i]
  }
  if(any(duplicated(names(edges))))
    edges <- edges[-which(duplicated(names(edges)))]
  justInts <- which(tipList[,3] == "internal")   #to get row to use in ape
  names(justInts) <- tipList[tipList[,3] == "internal",4]  #associate taxon name with row
  if(any(names(justInts) == 0))
    justInts <- justInts[-which(names(justInts) == 0)]
  return(justInts)
}













