GetEOLTree <- function(taxonID, parentID, syns) {
	node.matching<-matrix(nrow=0, ncol=2)
	tree.dataframe<-data.frame()
	ntax<-dim(taxonID)[1]
	tip.label<-rep(NA,ntax)
	for (tip in sequence(dim(taxonID)[1])) {
		for (col in sequence(dim(taxonID)[2])) {
			new.dataframe<-data.frame(parent=parentID[tip, col], node=taxonID[tip,col], name=NA)
			if (col==dim(taxonID)[2]) {
				new.dataframe$name<-FirstTwo(syns[[tip]][[1]])
				node.matching<-rbind(node.matching, c(tip, taxonID[tip,col]))
				tip.label[tip]<-FirstTwo(syns[[tip]][[1]])
			}
			if (tip==1 & col==1) {
				tree.dataframe<-new.dataframe
			}
			else {
				tree.dataframe<-rbind(tree.dataframe, new.dataframe)
			}
		}
	}

	tree.dataframe<-unique(tree.dataframe)
	tree.dataframe<-tree.dataframe[which(tree.dataframe$parent!=0),]
	root.node<-tree.dataframe$parent[!(tree.dataframe$parent %in% tree.dataframe$node)][1] #will appear more than once, only need first one
	node.matching<-rbind(node.matching, c(ntax+1, root.node))
	node.matching<-rbind(node.matching, matrix(c((ntax+2):(1+dim(tree.dataframe)[1]) ,tree.dataframe$node[is.na(tree.dataframe$name)]), ncol=2, byrow=FALSE))
	phy<-stree(ntax, tip.label=tip.label)
	phy$edge<-cbind(node.matching[match(tree.dataframe$parent, node.matching[,2]),1], node.matching[match(tree.dataframe$node, node.matching[,2]),1])
	phy$Nnode<-dim(phy$edge)[1]-ntax+1 
	phy<-collapse.singles(phy)
	phy<-reorder(phy)
	phy<-read.tree(text=write.tree(phy)) #hack gets around ape's issue with how I numbered nodes
	return(phy)
}	
