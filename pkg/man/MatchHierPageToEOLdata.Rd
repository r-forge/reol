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
	\item{MyHiers}{A vector of filenames for downloaded hierarchy pages}
	\item{EOLdata}{Any output dataframe from Reol functions}
}
\value{
	Returns a data frame where each row is a taxonomic unit. 
}
\examples{
	#MatchHierPageToEOLdata(MyHiers, GetRichnessScores(MyEOLs))
	
	#dataOverview<-DataObjectOverview(MyEOLs)
	#MatchHierPageToEOLdata(MyHiers, dataOverview)
}
