arbitrary.cut.missing <- function(geno, upper.cut, lower.cut, missing.upper, missing.lower) {
  for( i in 1:nrow(geno)) {
    ##set homo
    id.h <- which(geno[i, ] >= upper.cut)
    geno[i, id.h] <- 1
    id.l <- which(geno[i, ] <= lower.cut)
    geno[i, id.l] <- -1
    ## set het
    id.hl <- which(geno[i, ] >= missing.lower & geno[i, ] <= missing.upper)
    geno[i, id.hl] <- 0
    ## set missing
    id.missing1 <- which(geno[i, ] > missing.upper & geno[i, ] < upper.cut)
    geno[i, id.missing1] <- NA
    id.missing2 <- which(geno[i, ] > lower.cut & geno[i, ] < missing.lower)
    geno[i, id.missing2] <- NA

    cat(i, "\n")
  }
  return(geno)
}
