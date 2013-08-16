\name{MatchHierPageToEOLdata}
\alias{MatchHierPageToEOLdata}
\title{Match Hierarchy Pages to EOL Data}
\description{
	This function matches hierarchy concept IDs with EOL page data.    
}
\usage{
MatchHierPageToEOLdata(MyHiers, EOLdata)
}
\arguments{
	\item{MyHiers}{A vector of filenames for downloaded hierarchy pages or a list of XML data stored as an R object}
	\item{EOLdata}{Any output dataframe from Reol functions}
}
\value{
	Returns a data frame where each row is a taxonomic unit. This is especially helpful if you wish to plot EOL data on a taxonomic tree (see example).
}
\examples{
#plotting richness scores
data(MyEOLs)
data(MyHiers)
Tree <- MakeHierarchyTree(MyHiers, includeNodeLabels=FALSE)  
MyData <- MatchHierPageToEOLdata(MyHiers, GetRichnessScores(MyEOLs))
plot(Tree, label.offset=1, x.lim=10)
tiplabels(round(as.numeric(MyData[,3])), 1:6, col="Blue", frame="none", bg="clear",adj = -0.5)
title(main="Richness scores")
}
