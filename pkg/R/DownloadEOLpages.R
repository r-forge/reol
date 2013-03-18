DownloadEOLpages <- function(pages, MyKey=NULL, verbose=TRUE) {
#Download xml page content  #now full content using X=75
  for (i in sequence(length(pages))) {
    pageNum <- pages[i]
    web <- paste("http://eol.org/api/pages/", pageNum, ".xml?images=75&amp;videos=75&amp;sounds=75&amp;maps=75&amp;text=75&amp;iucn=true&amp;subjects=all&amp;details=true&amp;common_names=true&amp;references=true", sep="")	
	if(!is.null(MyKey))
      web <- paste(web, "&amp;key=", MyKey, sep="")
    write(getURL(web), file=paste("eol", pages[i], ".xml", sep=""))
    if(verbose)
      print(paste("Downloaded ", "eol", pages[i], ".xml", sep=""))
    Sys.sleep(1)
  }
}
