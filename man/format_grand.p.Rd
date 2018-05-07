\name{format_grand.p}
\alias{format_grand.p}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  format the genotype in the vcf file
}
\description{
Give four grand parental ID in a divergent cross, this function screen the fixed sites within family and extract those called sites in an offspring.
}
\usage{
read_grand.p(pedigreeTable, vcf.file, pathout,Core=5,pattern=paste("(^F2_",of_id,".*)|(^",of_id,"_F2.*)",sep=""))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{pedigreeTable}{ a data.frame with 7 columns with names as id.f2, id.f2.ma, id.f2.fa, fa.h, ma.h, ma.l, fa.l. Those are F2 id, corresponding
    mother id,father id and grand parent ids, fa.h,ma.h must come from one line and ma.l, fa.l. from another divergent line}
  \item{vcf.file}{the input vcf, this file should be filtered in advance to  make sure only fixed sites between lines are included}
  \item{pathout}{output path}
  \item{pattern}{the pattern used for mathing individual names in vcf files, eg. we have a individual named as 350 in pedigree file, but named as F2_350_S73_L001.variant462.variant2.variant in vcf file}
 %% \item{generate.input}{ T means only generate intermediate files, F means read in the intermediate file}
}
\details{
}
\value{
this would write out a few intermediate files
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
