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
	\item{MyHiers}{A vector of hier pages OR a list of XMLs as an R object}
	\item{taxa}{Vector of tip taxa}
	\item{label}{Which hierarchical units should be included in the edge labels}
}
\value{
	\code{MakeEdgeLabels} returns a vector of "edges" and their clade names to be used in apes edgeLabels function.  \code{getTipList} and \code{whichEdge} are internal functions for \code{MakeEdgeLabel}. 
}
\details{
	Note that "edges" are slightly different than node labels, in that edges are plotted along the center of the branch rather than at a node.  Plotting both is redundant, but one or the other may look better aesthetically. 
	Also "edges" in the edgeLabels function is not the actual edge number, but the row.  Our functions reflect this.    
}
\seealso{
\code{MakeHierarchyTree}
}
\examples{
data(MyHiers)
Tree <- MakeHierarchyTree(MyHiers, includeNodeLabels=FALSE)
edges <- MakeEdgeLabels(MyHiers)
	
plot(Tree)
edgelabels(text=names(edges), edge=edges)  

}
