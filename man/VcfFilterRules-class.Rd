\name{VcfFilterRules-class}
\docType{class}

% Class
\alias{class:VcfFilterRules}
\alias{VcfFilterRules-class}

% Constructors/Methods:
\alias{VcfFilterRules}
%\alias{VcfFilterRules,ANY-method}
\alias{initialize,VcfFilterRules-method}

% Accessor methods:
\alias{type,VcfFilterRules-method}
\alias{vep,VcfFilterRules-method}
\alias{vep<-,VcfFilterRules,character-method}

% Subsetter methods:
% [
\alias{[,VcfFilterRules,ANY,ANY,ANY-method}
\alias{[,VcfFilterRules,ANY,ANY,logical-method}
\alias{[,VcfFilterRules,ANY,ANY,missing-method}
% [[
\alias{[[,VcfFilterRules,ANY,ANY-method}

% Replacement methods:
% [[<-
\alias{[[<-,VcfFilterRules,ANY,ANY-method}
% [<-
\alias{[<-,VcfFilterRules,numeric,missing,VcfFilterRules-method}
\alias{[<-,VcfFilterRules,numeric,missing,VcfVepRules-method}
\alias{[<-,VcfFilterRules,numeric,missing,VcfInfoRules-method}
\alias{[<-,VcfFilterRules,numeric,missing,VcfFixedRules-method}

% Combine methods:
\alias{c,VcfFilterRules-method}
\alias{append,VcfFilterRules,FilterRules-method}

% Evaluation:
\alias{eval,VcfFilterRules,VCF-method}

\title{VcfFilterRules class objects}

\description{
The \code{VcfFilterRules} class can stores multiple types of filters
applicable to various slots of \code{VCF} objects.
}

\details{
All arguments must be \code{VcfFixedRules}, \code{VcfInfoRules},
\code{VcfVepRules}, \code{VcfFilterRules} of \code{FilterRules} objects.
}

\section{Accessor methods}{
In the following code snippets \code{x} is a \code{VcfFilterRules} object.
\describe{
\item{\code{active(x)}, \code{active(x)<-}}{
    Get or set the active state of each filter rule in \code{x}.
    Inherited from \code{\linkS4class{FilterRules}}
    }
    \item{\code{vep(x)}, \code{vep(x)<- }}{
    Gets or sets the INFO key where the Ensembl VEP predictions to use
    for filtering are stored.
    }
    \item{\code{type(x)}}{
    Gets the type of each filter stored in a \code{VcfFilterRules} object.
    \emph{Read-only}.
    }
}
}

\section{Constructors}{
\itemize{
\item{
    \code{VcfFilterRules(...)}
    constructs an \code{VcfFilterRules} object from
    \code{VcfFixedRules}, \code{VcfInfoRules}, \code{VcfVepRules},
    and \code{VcfFilterRules} objects in \code{...}.
}
}
}

\section{Subsetting and Replacement}{
In the code snippets below, \code{x} is a \code{VcfFilterRules} object.

\itemize{
    \item{
    \code{x[i, drop = TRUE]}: Subsets the filter rules using the
    same interface as for \code{\linkS4class{Vector}}.
    If all filter rules are of the same type and \code{drop=TRUE} (default),
    the resulting object is re-typed to the most specialised class,
    if possible. In other words, if all remaining filter rules are of
    type \code{"vep"}, the object will be type as \code{VcfVepRules}.
    }
    \item{
    \code{x[[i]]}: Extracts an expression or function via the same interface
    as for \code{\linkS4class{List}}.
    }
    \item{
    \code{x[i] <- value}: Replaces a filter rule by one of any valid class
    (\code{VcfFixedRules}, \code{VcfInfoRules}, \code{VcfVepRules}, or
    \code{VcfFilterRules}).
    The active state(s), name(s), and type(s) (if applicable)
    are transferred from \code{value}.
    }
    \item{
    \code{x[[i]] <- value}: The same interface as for
    \code{\linkS4class{List}}. The default active state for new
    rules is \code{TRUE}.
    }
}
}

\section{Combining}{
In the following code snippets \code{x} is an object of class
\code{VcfFilterRules},
while \code{values} and \code{...} are objects from any of the
classes \code{VcfFixedRules}, \code{VcfInfoRules}, \code{VcfVepRules},
or \code{VcfFilterRules}:

\itemize{
    \item{
    \code{append(x, values, after = length(x))}:
    Appends the values onto \code{x} at the index given by \code{after}.
    }
    \item{
    \code{c(x, ...,)}:
    Concatenates the filters objects in \code{...} onto the end of \code{x}.
    }
}
}

\section{Evaluating}{
As described in the \code{S4Vectors} documentation:
\itemize{
    \item{
        \code{eval(expr, envir, enclos)}
        Evaluates each active rule in a \code{VcfFilterRules} instance
        (passed as the \code{expr} argument)
        in their respective context of a \code{VCF} object
        (passed as the \code{envir} argument).
    }
    \item{
        \code{evalSeparately(expr, envir, enclos)}:

        \code{subsetByFilter(x, filter)}

        \code{summary(object)}

        See \code{\link{eval,FilterRules,ANY-method}} for details.
    }
}
}

\author{
Kevin Rue-Albrecht
}

\seealso{
\code{\linkS4class{FilterRules}},
\code{\linkS4class{VcfFixedRules}},
\code{\linkS4class{VcfInfoRules}},
\code{\linkS4class{VcfVepRules}},
and \code{\linkS4class{VCF}}.
}

\examples{
# Constructors ----

fixedR <- VcfFixedRules(list(
    pass = expression(FILTER == "PASS"),
    qual = expression(QUAL > 20)
    ))
fixedR

infoR <- VcfInfoRules(list(
    common = expression(MAF > 0.1), # minor allele frequency
    present = expression(ALT + HET > 0) # count of non-REF homozygotes
    ))
# ...is synonym to...
infoR <- VcfInfoRules(list(
    common = expression(MAF > 0.1), # minor allele frequency
    present = expression(ALT > 0 | HET > 0)
    ))
infoR

vepR <- VcfVepRules(list(
    missense = expression(Consequence \%in\% c("missense_variant")),
    CADD = expression(CADD_PHRED > 15)
    ))
vepR

vcfRules <- VcfFilterRules(fixedR, infoR, vepR)
vcfRules


# Accessors ----

## Type of each filter stored in the VcfFilterRules object
type(vcfRules)


# Example data ----

# VCF file
vcfFile <- system.file("extdata", "moderate.vcf", package = "TVTB")

# TVTB parameters
tparam <- TVTBparam(Genotypes("0|0", c("0|1", "1|0"), "1|1"))

# Pre-process variants
vcf <- VariantAnnotation::readVcf(vcfFile, param = tparam)
vcf <- VariantAnnotation::expand(vcf, row.names = TRUE)
vcf <- addOverallFrequencies(vcf, tparam)


# Applying filters to VCF objects ----

## Evaluate filters
eval(vcfRules, vcf)

## Evaluate filters separately
as.data.frame(evalSeparately(vcfRules, vcf))

# Interestingly, the only common missense variant has a lower CADD score
## Deactivate the CADD score filter
active(vcfRules)["CADD"] <- FALSE

## Subset VCF by filters (except CADD, deactivated above)
subsetByFilter(vcf, vcfRules)


# Subsetting and Replacement ----

v123 <- vcfRules[1:3]

# Extract the expression
v5expr <- vcfRules[[5]]
# Subset the object
v5obj <- vcfRules[5]

# Replace the expression (active reset to TRUE, original name retained)
v123[[2]] <- v5expr

# Replace the rule (active state and name transferred from v5obj)
v123[2] <- v5obj
}
