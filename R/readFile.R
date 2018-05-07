readFile <- function(pathFile){
  if(!require(data.table))
      require(data.table)
      if (file.size(pathFile) > 0){
        print(pathFile)
        input <- fread(pathFile)
        colnames(input) <- c("chr","pos","ref","alt","f1","f2","m1","m2","of1","of2")
        return(input)
      }else {
        return(NA)
        }
    }
# createPath <- function(x){return(paste0(pathout, "/", x, ".vcf"))}
# pathList <- lapply(pedigreeTable$id.f2, createPath)
# #pathList <- list.files(pathout, pattern = ".vcf$", full.names = TRUE)
# inputList <- lapply(pathList, readFile)
# return(inputList)
