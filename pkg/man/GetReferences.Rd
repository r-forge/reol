\name{GetReferences}
\alias{GetReferences}
\title{Gather EOL References}
\description{
	This function gathers the references on the EOL pages (not the references on the provider pages). 
}
\usage{
GetReferences(MyEOLs, from.file=TRUE, output = c("detail", "counts"))
}
\arguments{
	\item{MyEOLs}{A vector of filenames for downloaded EOL pages}
	\item{from.file}{Whether MyEOLs comes from working directory (T) or is an R object (F)}
	\item{output}{"detail" will return a data frame with eolID and reference; "counts" will return a dataframe with  eol taxon name, eol ID, and number of references.}
}
\value{
	Returns a data frame with taxon, eol ID, common name, and language. 
}
\examples{
	#GetReferences(MyEOLs)
	#GetReferences(MyEOLs, output="counts")
}
