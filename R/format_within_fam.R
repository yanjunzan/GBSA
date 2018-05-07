format_within_fam <- function(pedigreeTable, vcf.file, pathout,Core=5,pattern=paste("(^F2_",of_id,".*)|(^",of_id,"_F2.*)",sep="")) { #generate.input = TRUE
    if(!require(dplyr))
       require(dplyr)
    if(!require(pbmcapply))
      require(pbmcapply)

    # define python script location after installation
    py <- paste("python3 ",system.file(package="GBSA"),"/read.vcf.grand.p.py",sep="")
    tmp = group_by(pedigreeTable, fa.h, ma.h, ma.l, fa.l) %>% summarise()
    getFamily <- function(i){
      val <- filter(pedigreeTable, fa.h == tmp[i,]$'fa.h' & ma.h == tmp[i,]$'ma.h' & ma.l == tmp[i,]$'ma.l' & fa.l == tmp[i,]$'fa.l')
      of_id <- val$id.f2
      of_id.1 <- pattern
      header.f2 <- vcf.header(vcf = vcf.file)
      of_id.2 <- c()
      for(j in 1:length(of_id)){
        of_id.2 <- c(of_id.2,header.f2[grep(pattern = of_id.1[j],x = header.f2)])
      }
      F_id_h <- paste(".*", tmp[i,]$fa.h, ".*", sep = "")
      M_id_h <- paste(".*", tmp[i,]$ma.h, ".*", sep = "")
      F_id_l <- paste(".*", tmp[i,]$fa.l, ".*", sep = "")
      M_id_l <- paste(".*", tmp[i,]$ma.l, ".*", sep = "")
      return(list("of_id" = of_id.2, "F_id_h" = F_id_h, "M_id_h" = M_id_h, "F_id_l" = F_id_l, "M_id_l" = M_id_l))
    }
    families = lapply(1:nrow(tmp), getFamily)
    #print(families)
    callScript <- function(family){
      cmd <- paste(py, "--ID_of", paste(family$of_id, collapse = " "), "--", family$F_id_h, family$M_id_h, family$F_id_l, family$M_id_l, vcf.file, pathout,sep = " ")
      print(cmd)
      system(cmd)
    }
    pbmclapply(families, callScript, mc.cores = getOption("mc.cores", Core))
  # }else{
  #   readFile <- function(pathFile){
  #     if (file.size(pathFile) > 0){
  #       print(pathFile)
  #       input <- fread(pathFile)
  #       colnames(input) <- c("chr","pos","ref","alt","f1","f2","m1","m2","of1","of2")
  #       return(input)
  #     }else {return(NA)}
  #   }
  #   createPath <- function(x){return(paste0(pathout, "/", x, ".vcf"))}
  #   pathList <- lapply(pedigreeTable$id.f2, createPath)
  #   #pathList <- list.files(pathout, pattern = ".vcf$", full.names = TRUE)
  #   inputList <- lapply(pathList, readFile)
  #   return(inputList)
  # }
}
