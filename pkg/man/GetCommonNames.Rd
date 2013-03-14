\name{GetCommonNames}
\alias{GetCommonNames}
\title{Gather Common Name Information}
\description{
	This function gathers each species common names and the language with which they are associated. 
}
\usage{
GetCommonNames(MyFiles, output=1)
}
\arguments{
	\item{MyFiles}{A vector of filenames for downloaded EOL pages}
	\item{output}{Value of 1 or 2.  output=1 is default and will return a data frame with common names and their language.  output=2 will return a dataframe with each taxon and language counts for common names.}
}
\value{
	Returns a data frame with taxon, eol ID, common name, and language. 
}
\examples{
	#GetCommonNames(myFiles)
	#GetCommonNames(myFiles, output=2)
}
