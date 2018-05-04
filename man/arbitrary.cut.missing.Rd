\name{arbitrary.cut.missing}
\alias{arbitrary.cut.missing}

\title{
A function transform the averaged score in to genotypes based on arbitrary cutoff.
}
\description{
unlike function arbitrary.cut . This function is a 4 point cut, which means uncertain region are leaved as missing.
}
\usage{
arbitrary.cut.missing(geno, upper.cut, lower.cut, missing.upper, missing.lower)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{geno}{ the genotype matrix returned from creatExact function}
  \item{ upper.cut}{ threshold for calling  homozygous genotype}
  \item{ lower.cut}{ threshold for calling  homozygous alternative genotype}
  \item{ lower.cut}{ threshold for calling  homozygous alternative genotype}
  \item{ missing.upper}{ bins with a averaged score below upper.cut but above missing.upper will be marked as missing.}
  \item{ missing.lower}{ bins with a averaged score above lower.cut but below missing.lower will be marked as missing.}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
Updating
}
\value{
return a data.frame with each bin transformed to "A" for homozygous and "B" for alternative genotype, "H" for heterozygous, NA for uncertain region
}
\references{
Yanjun Zan, Thibaut Payen, Leif Andersson, Paul B. Siegel and Örjan Carlborg;Whole-genome QTL mapping in experimental pedigrees from outbred founders utilizing low coverage individual based sequencing 2018
}
\author{
Yanjun Zan, Thibaut Payen
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
See the package tutorial
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
