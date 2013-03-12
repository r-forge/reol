\name{GetCommonNames}
\alias{GetCommonNames}
\title{Gather Common Name Information}
\description{
	This function gathers each species common names and the language with which they are associated. 
}
\usage{
GetCommonNames(MyFiles)
}
\arguments{
	\item{MyFile}{A single of filename for downloaded EOL page}
}
\value{
	Returns a data frame with taxon, eol ID, common name, and language. 
}
\examples{
	#GetCommonNames(myFiles)
}
