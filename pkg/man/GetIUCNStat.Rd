\name{GetIUCNStat}
\alias{GetIUCNStat}
\title{Gather IUCN Status for EOL Pages}
\description{
	This function gathers IUCN statuses from EOL pages if they are reported.  
}
\usage{
GetIUCNStat(MyEOLs, from.file=TRUE)
}
\arguments{
	\item{MyEOLs}{A vector of filenames for downloaded EOL pages}
	\item{from.file}{Whether MyEOLs comes from working directory (T) or is an R object (F)}
}
\value{
	Returns a data frame with taxon, eol ID, and IUCN status. 
}
\examples{
	#GetIUCNStat(MyEOLs)
}

