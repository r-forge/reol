\name{GetIUCNStat}
\alias{GetIUCNStat}
\title{Gather IUCN Status for EOL Pages}
\description{
	This function gathers IUCN threat statuses from EOL pages if they are reported.  
}
\usage{
GetIUCNStat(MyEOLs)
}
\arguments{
	\item{MyEOLs}{A vector of filenames or a list of XMLs for downloaded EOL pages}
}
\value{
	Returns a data frame with taxon, eol ID, and IUCN status. 
}
\examples{
data(MyEOLs)
GetIUCNStat(MyEOLs)
}

