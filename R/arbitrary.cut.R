arbitrary.cut <- function(geno,  upper.cut,  lower.cut) {
  for( i in 1:nrow(geno)) {
    id.h <- which(geno[i, ] >= upper.cut)
    geno[i, id.h] <- "A"
    id.l <- which(geno[i, ] <= lower.cut)
    geno[i, id.l] <- "B"
    id.hl <- which(geno[i, ] > lower.cut & geno[i, ] < upper.cut)
    geno[i, id.hl] <- "H"
    cat(i, "\n")
  }
  return(geno)
}
