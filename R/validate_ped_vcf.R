#vcf <- vcf.file
#ped <- pedigreeTable
validate_ped_vcf <- function(vcf,ped,pattern.vcf="F2_(.*)_(S|m).*"){
  cat("validating if all the individuals in pedigree file are in vcf files","\n")
  cat("This function is dependent on the name of individuals in your pipine","which should be specified in pattern.vcf argument","\n")
  header.f2 <- vcf.header(vcf = vcf) # check the vcf to getout the sample ID. there might be a broken pipe error,  but ignore it
  f2 <- header.f2[grep(pattern = "F2.*",x = header.f2)] ## will be all F2 in the end, for now a subset since all not available
  id2 <- gsub(replacement = "\\1",pattern = "F2_(.*)_(S|m).*",x = f2)
  id3<- as.numeric(gsub(replacement = "\\1",pattern = "(.*)_F2_(S|m).*",x = id2))

  ##id3 <- as.numeric(gsub(replacement = "\\1", pattern = "(.*)_F2_(S|m).*", x = id2)) # FAIL IF THE NAMES ARE xxx.yy
  f2.sub <- ped[trimws(ped$id.f2) %in% id3,]
  return(f2.sub)
}
