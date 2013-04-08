\name{MakeEdgeLabels}
\alias{MakeEdgeLabels}
\alias{getTipList}
\alias{whichEdge}


\title{Creates Edge Labels for Hierarchy Trees}
\description{
	These functions will create edge labels for hierarchy trees. 
}
\usage{
getTipList(phy)
whichEdge(phy, taxa)
MakeEdgeLabels(MyHiers, label="all")
}
\arguments{
	\item{phy}{phylogenetic tree in the class phylo}	
	\item{MyHiers}{A vector of hier pages}
	\item{Taxa}{Vector of tip taxa}
	\item{label}{Which hierarchical units should be included in the edge labels}
}
\value{
	MakeEdgeLabels returns a vector of "edges" and their clade names to be used in apes edgeLabels function.  getTipList and whichEdge are internal functions for MakeEdgeLabel. 
}
\details{
	Note that "edges" in the edgeLabels function is not the actual edge number, but the row.  Our functions reflect this.    
}
\examples{
	#getTipList(phy)
	#whichEdge(phy, taxa=c("Pomoxis annularis", "Pomoxis nigromaculatus"))
	#EdgeLabels <- MakeEdgeLabels(MyHiers)
	
	#plot(phy)
	#edgelabels(text=names(EdgeLabels), edge=EdgeLabels)  #there are lots of plotting options, but see ape for details

}
