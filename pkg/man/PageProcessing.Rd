\name{PageProcessing}
\alias{PageProcessing}
\title{Process XML Data into tree format}
\description{
	This function will read in the XML data and parse it into a tree structure for R to read. 
}
\usage{
PageProcessing(MyEOL)
}
\arguments{
	\item{MyEOL}{A filename or R object for downloaded EOL pages}
}
\value{
	Returns XML tree as an R object.   
}
\examples{
	#Reads in a file
	#PageProcessing("eol1.xml") 
	
	#or reads in an R object
	#PageProcessing(eol1)
}
