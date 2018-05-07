export2rqtl <- function(genoFile,phenoFile,matchingNames,output.name=paste0("/Users/yanjunzan//Documents/impute/results/GBSA.test/",  "F2_827.within.fam.bins",  20,  "completes.",  Sys.Date())){
  # check if the id are the same
  if(!identical(rownames(genoFile),as.character(phenoFile$ID)))
    stop("individual id coded in rownames(genoFile) and phenoFile$ID much match")
  # check if the chromsome is all numeric
  if(any(is.na(suppressWarnings(as.numeric(matchingNames$Name)))))
    warning("Non-numeric chromsome name detected,Please make sure autosome chromsome name are coded as numeric")

  # recode autosome name
  all.chr  <-matchingNames
  ## CAREFUL: Remove a.b from the end (after the -), carreful that the name still have this form
  chr <- sapply(strsplit(colnames(genoFile), split='-', fixed=TRUE), function(x) (x[1]))
  #chr <- gsub(pattern = "(.*\\.{1}\\d+)\\.\\d{1, 3}\\.\\d", replacement = "\\1", x = colnames(genoCut))
  chr <- all.chr$Name[ match(chr, all.chr$INSDC)]
  chr[grep(pattern = "W", chr)] <- "34"
  chr[grep(pattern = "Z", chr)] <- "35"
  chr[grep(pattern = "LGE64", chr)] <- "36"
  chr[grep(pattern = "MT", chr)] <- "37"
  #
  line1 <- c(colnames(pheFile), colnames(genoCut))
  line2 <- c(rep("", length(colnames(phenoFile))), chr)
  test2 <- data.frame(array(NA, dim = c(nrow(genoFile)+2, length(line1))))
  test2[1, ] <- line1
  test2[2, ] <- line2
  test2[3:nrow(test2), 5:length(line1)] <- genoFile
  test2[3:nrow(test2), 1] <- rownames(genoFile)
  test2[3:nrow(test2),2:4] <- phenoFile[,2:4]
  write.table(test2, file = paste0(output.name,  ".csv"), quote = FALSE, sep = ";", row.names = FALSE, col.names = FALSE)
  #cat("file", paste0(output.name,  ".csv"),"generated","\n" )
}
