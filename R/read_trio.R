# read the fixed marker

read_trio <- function(of_id,F_id,M_id,vcf.file,pathout,generate.input=T){
  if(!require(data.table))
    require(data.table)
  if(generate.input){
    cat("1.Format data using python","\n")
    py.script <- paste(system.file(package="GBSA"),"/Read.vcf.py",sep="")
    bash  <- paste(py.script,of_id," ",F_id," ",M_id,vcf.file ," ",pathout,sep="")
    system(bash)
    cat("1.Format completed","\n")
  }else{
    cat("2. Read in data using fread")
    input <- fread(gsub(pattern = "\\s+(.*)",replacement="\\1",pathout))
    colnames(input) <- c("chr","pos","ref","alt","f1","f2","m1","m2","of1","of2")
    return(input)
  }
}
