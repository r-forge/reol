\name{GatherDataObjectInformation}
\alias{GatherDataObjectInformation}
\title{Gather Data Object Information}
\description{
	This function gathers data entries from a single EOL page.  It is used as an internal function for calculating types of objects, but can also be used to examine which data objects are available for a single EOL page.    
}
\usage{
GatherDataObjectInformation(MyFile)
}
\arguments{
	\item{MyFile}{A single of filename for downloaded EOL page}
}
\value{
	Returns a data frame where each row is a single data object entry. 
}
\examples{
	#GatherDataObjectInformation(myFiles[1])
}
