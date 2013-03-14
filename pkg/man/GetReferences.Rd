\name{GetReferences}
\alias{GetReferences}
\title{Gather EOL References}
\description{
	This function gathers the references on the EOL pages (not the references on the provider pages). 
}
\usage{
GetReferences(MyFiles, output=1)
}
\arguments{
	\item{MyFiles}{A vector of filenames for downloaded EOL pages}
	\item{output}{Value of 1 or 2.  output=1 is default and will return a data frame with eolID and reference.  output=2 will return a dataframe with  eol taxon name, eol ID, and number of references.}
}
\value{
	Returns a data frame with taxon, eol ID, common name, and language. 
}
\examples{
	#GetReferences(myFiles)
	#GetReferences(myFiles, output=2)
}
