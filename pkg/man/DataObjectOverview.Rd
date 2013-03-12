\name{DataObjectOverview}
\alias{DataObjectOverview}
\title{Data Object  Overview Information}
\description{
	This function gathers information about the number of kinds of data objects.  For example, it will tell you that there are 3 gifs 12 jpgs, and 34 text objects, but it will not provide specific information beyond that.        
}
\usage{
DataObjectOverview(MyFiles, verbose=T)
}
\arguments{
	\item{MyFiles}{A vector of filenames for downloaded EOL pages}
	\item{verbose}{An optional print statement while combining}	
}
\value{
	Returns a data frame where each row is a single taxon and columns are a type of data object. 
}
\examples{
	#DataObjectOverview(myFiles)
}
