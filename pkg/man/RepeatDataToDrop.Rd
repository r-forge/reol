\name{RepeatDataToDrop}
\alias{RepeatDataToDrop}
\title{Repeat Data To Drop}
\description{
	This internal function determines columns of data that are either all the same (thus providing no hierarchical information) or contain NAs.
}
\usage{
RepeatDataToDrop(TreeData)
}
\arguments{
	\item{TreeData}{A data frame from }
}
\value{
	Returns boolean response of whether to drop data or not.
}
