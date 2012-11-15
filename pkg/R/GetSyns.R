
GetSyns<-function(Results, MyHiers, returnSyns=FALSE){
	syns <- vector("list")
	eolNumber <- c()
	for(i in sequence(length(MyHiers))){
		res <- xmlToList(xmlRoot(xmlTreeParse(MyHiers[i], getDTD=F)))
		resOneFile <- OneFileHierarchy(MyHiers[i])
		syns[[i]] <- resOneFile[which(resOneFile[,4] %in% Results[,1])]
		eolNumber[i] <- resOneFile[which(resOneFile[,4] %in% Results[,1]), 4][[1]]
		for(k in sequence(dim(resOneFile)[1])) {
			if(!is.na(any(resOneFile[k,2]=="Species") || any(resOneFile[k,2]=="species") || any(resOneFile[k,3]=="valid") || any(resOneFile[k,3]=="synonym"))) {
				syns[[i]]<-append(syns[[i]], resOneFile[k,1])
			}
		}
	}
	for(syn in sequence(length(syns))){
		syns[[syn]]<-unique(syns[[syn]])  #delete repeats
		if(length(syns[[syn]]) == 0) syns[[syn]]<-NA
	}
	if(returnSyns)
		return(syns)
	else {
		
		return(cbind(eolNumber, sapply(syns, length)))
	}
}		

