OneFileHierarchy<- function (MyHier) {
	res<-xmlToList(xmlRoot(xmlParse(MyHier, getDTD=FALSE)), simplify=FALSE)
	resTaxonOnly <- which(names(res) == "Taxon")
	resMat <- matrix(nrow=length(resTaxonOnly), ncol=7)
	for(j in resTaxonOnly) {
		a <- res[j]$Taxon$scientificName 
		if (is.null(a))	a <- NA
		b <- res[j]$Taxon$taxonRank
		if (is.null(b))	b <- NA
		c <- res[j]$Taxon$taxonomicStatus
		if (is.null(c))	c <- NA
		d <- res[j]$Taxon$taxonConceptID
		if (is.null(d))	d <- NA
		e <- res[j]$Taxon$parentNameUsageID
		if (is.null(e))	e <- NA
		f <- res[j]$Taxon$taxonID
		if (is.null(f))	f <- NA
		g <- res[j]$Taxon$identifier
		if (is.null(g))	g <- NA
		resMat[j,] <- c(a,b,c,d,e,f,g)
	}
	colnames(resMat) <- c("scientificName", "taxonRank", "taxonomicStatus", "taxonConceptID", "parentNameUsageID", "taxonID", "identifier")
    resMat[,2] <- gsub("\\b(\\w)", "\\U\\1", resMat[,2], perl=T)  #cap all taxon ranks for downstream combining
	return(resMat)		
}
