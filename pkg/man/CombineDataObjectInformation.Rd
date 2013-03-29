\name{CombineDataObjectInformation}
\alias{CombineDataObjectInformation}
\title{Combine Data Object Information}
\description{
	This function collects data object information across multiple files.  Missing information is coded as NA.  This function is used internally by other functions for amassing data, but can also be used independently to examine group information.      
}
\usage{
CombineDataObjectInformation(MyEOLs, verbose=T)
}
\arguments{
	\item{MyEOLs}{A vector of filenames for downloaded EOL pages}
	\item{verbose}{An optional print statement while combining}	
}
\value{
	Returns a data frame where each row is a single data object entry. 
}
\examples{
	#CombineDataObjectInformation(MyEOLs)
}
