\name{GatherProviderDataFrame}
\alias{GatherProviderDataFrame}
\title{Gather EOL Provider Information}
\description{
	This function will read in the downloaded xml files and amass a data frame with provider information.  Information will include taxon name, eol number, and information from each provider in the following order: provider taxon, provider taxon ID, provider scientific name, provider taxonomy rank.  
}
\usage{
GatherProviderDataFrame(MyFiles)
}
\arguments{
	\item{MyFiles}{A list of filenames for downloaded EOL pages}
}
\value{
	Returns a data frame with provider information
}
\examples{
	#myFiles <- system("grep -l xml *", intern=T)
	#GatherProviderDataFrame(myFiles)
}
