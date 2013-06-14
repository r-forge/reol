\name{CollectDataforWeb}
\alias{CollectDataforWeb}
\alias{PageProcessing}
\alias{DataProcessing}
\alias{CNCount}
\alias{DOCount}
\alias{providerCount}

\title{Collect Data from EOL Pages for Website}
\description{
	    These functions will readin, and scrape content off the downloaded EOL pages.  This is for building the data table on eoldata.org.    
}
\usage{
CollectDataforWeb(MyEOL)
PageProcessing(MyEOL)
CNCount(res)
DOCount(res)
providerCount(res)
DataProcessing(res)
}
\arguments{
	\item{MyEOL}{A single filename for downloaded EOL pages}
	\item{res}{XML object}
}
\value{
	Appends EOL data to a table. 
}
\examples{
	#CollectDataforWeb(MyEOL)
}
