createExact <- function(cutoffLevel,pedigreeTable,matchingNames,bin.size,pathout){
  #py.script <- paste(system.file(package="GBSA"),"/read.vcf.grand.p.py",sep="")
  #all.chr  <- read.table(matchingNames, stringsAsFactors = FALSE, header = TRUE, sep = "\t")
  all.chr <- matchingNames
  chroms <- all.chr$INSDC
  chroms.len <- all.chr$Size.Mb.*1e6
  ##cut.number <- 20 # cutoff on each bin
  cut.number <- cutoffLevel
  #bin.size <- 1e6 # size of each bin

  ## get.info is in Functions.AIL.input.R
  out.info <- get.info(chroms = chroms, chroms.len = chroms.len, bin.size = bin.size)
  ## create the big data.frame,  store each row for individual and each col for genotype in a bin
  f2.id  <- pedigreeTable$id.f2 #gsub(pattern = "(.*)_(S|m).*", replacement = "\\1", x = f2)
  genotype.hap1 <- data.frame(array(NA, dim = c(length(f2.id), max(out.info$index$end))))
  rownames(genotype.hap1) <- f2.id
  colnames(genotype.hap1) <- out.info$chr.loca
  markers.hap1 <- data.frame(array(NA, dim = c(length(f2.id), max(out.info$index$end))))
  rownames(markers.hap1) <- f2.id
  colnames(markers.hap1) <- out.info$chr.loca
  ## here only hap1 data is stored because hap1+hap2 =1
  ## 208 is empty
  # data1List is a list with all the individuals !
  #data1List <- read_grand.p(pedigreeTable, vcf.file = vcf.file.f2, pathout = outFolder, py = py.script, generate.input = FALSE)
  # createPath <- function(x){return(paste0(pathout, "/", x, ".vcf"))}
  # pathList <- lapply(pedigreeTable$id.f2, createPath)
  all.vcf <- list.files(path =pathout,pattern = ".vcf" )

  for (i in  1:nrow(pedigreeTable)) {
    #data1 <- data1List[[i]]
    file_path.now <-  paste0(pathout, "/", all.vcf[i])

    data1 <- readFile(file_path.now)
    ## loop individual first so we read in each individual only once
    for (k in 1:length(chroms) ) {
      chr  <- chroms[k]
      setkey(data1, chr)
      data.now <- data1[chr] # extract mrk from this chromsome
      trac.now <- tracing_physical(input = data.frame(data.now), bin = bin.size, chr.len = chroms.len[k], cut = cut.number)
      ## location at current loop
      loca.now <- out.info$loca[out.info$loca.chr == chr]
      idx.now <- c(out.info$index$start[k]:out.info$index$end[k])
      index.rep <- idx.now[findInterval(trac.now$loca/bin.size, loca.now)]
      genotype.hap1[i, index.rep] <- trac.now$f
      markers.hap1[i, index.rep] <- trac.now$fn
    }
    cat("\n", i, "-", pedigreeTable$id.f2[i], "done", "\n")
  }
  #dim(genotype.hap1)
  write.table(genotype.hap1,  file = paste0(pathout,  "Genotype.exact.csv"), quote = FALSE, sep = "\t")
  write.table(markers.hap1,  file = paste0(pathout,  "Genotype.markers.csv"), quote = FALSE, sep = "\t")
  return(list("genotype"=genotype.hap1,"num.marker"=markers.hap1))
}
