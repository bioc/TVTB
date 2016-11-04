.override.TVTBparam <- function(param, ...){
    dots <- list(...)
    n <- names(dots)

    if ("ref" %in% n)
        hRef(param)[[1]] <- dots[["ref"]]

    if ("het" %in% n)
        het(param)[[1]] <- dots[["het"]]

    if ("alt" %in% n)
        hAlt(param)[[1]] <- dots[["alt"]]

    if ("ranges" %in% n)
        ranges(param) <- dots[["ranges"]]

    if ("aaf" %in% n)
        aaf(param) <- dots[["aaf"]]

    if ("maf" %in% n)
        maf(param) <- dots[["maf"]]

    if ("vep" %in% n)
        vep(param) <- dots[["vep"]]

    if ("bp" %in% n)
        bp(param) <- dots[["bp"]]

    validObject(param)
    return(param)
}

# Constructors ----

setMethod(
    f = "initialize",
    signature = c("TVTBparam"),
    definition = function(
        .Object, genos,
        ranges = GRanges(),
        aaf = "AAF", maf = "MAF", vep = "CSQ", bp = SerialParam()){

        # Fill slots with data
        .Object@genos <- genos
        .Object@ranges <- ranges
        .Object@aaf <- aaf
        .Object@maf <- maf
        .Object@vep <- vep
        .Object@bp <- bp

        validObject(.Object)

        return(.Object)
    })

# genos = list
setMethod(
    f = "TVTBparam",
    signature = c(genos="list"),
    definition = function(
        genos,
        ranges = GRanges(),
        aaf = "AAF", maf = "MAF", vep = "CSQ", bp = SerialParam()){

        if (is.null(names(genos))){
            names(genos) <- c("REF", "HET", "ALT")
        } else {
            if (any(names(genos) == "")){
                stop("All elements of genos must be named, or none")
            }
        }

        new(
            Class = "TVTBparam",
            genos = genos, ranges = ranges,
            aaf = aaf, maf = maf, vep = vep, bp = bp)
    }
)

# genos = missing
setMethod(
    f = "TVTBparam",
    signature = c(genos="missing"),
    definition = function(
        ref, het, alt,
        ranges = GRanges(),
        aaf = "AAF", maf = "MAF", vep = "CSQ", bp = SerialParam()){

        genos <- list(REF = ref, HET = het, ALT = alt)

        new(
            Class = "TVTBparam",
            genos = genos, ranges = ranges,
            aaf = aaf, maf = maf, vep = vep, bp = bp)
    }
)

# Getters and Setters ----

### genos
setMethod(
    f = "genos",
    signature = c("TVTBparam"),
    definition = function(x)
        slot(x, "genos")
)

setReplaceMethod(
    f = "genos", c("TVTBparam", "list"),
    function(x, value){

        # Must be all named, or none
        if (is.null(names(value)))
            names(value) <- names(slot(x, "genos"))
        else {
            if (any(names(value) == ""))
                stop("All elements of genos must be named, or none")
        }

        slot(x, "genos") <- value
        validObject(x)
        return(x)
    }
)

### ranges
setMethod(
    f = "ranges",
    signature = c("TVTBparam"),
    definition = function(x)
        slot(x, "ranges")
)

setReplaceMethod(
    f = "ranges", c("TVTBparam", "GRanges"),
    function(x, value){
        slot(x, "ranges") <- value
        x
    }
)

### aaf
setMethod(
    f = "aaf",
    signature = c("TVTBparam"),
    definition = function(x)
        slot(x, "aaf")
)

setReplaceMethod(
    f = "aaf", c("TVTBparam", "character"),
    function(x, value){
        if (length(value) != 1)
            stop("length(value) must equal 1")
        slot(x, "aaf") <- value
        x
    }
)

### maf
setMethod(
    f = "maf",
    signature = c("TVTBparam"),
    definition = function(x)
        slot(x, "maf")
)

setReplaceMethod(
    f = "maf", c("TVTBparam", "character"),
    function(x, value){
        if (length(value) != 1)
            stop("length(value) must equal 1")
        slot(x, "maf") <- value
        x
    }
)

### vep
setMethod(
    f = "vep",
    signature = c("TVTBparam"),
    definition = function(x)
        c(slot(x, "vep"))
)

setReplaceMethod(
    f = "vep", c("TVTBparam", "character"),
    function(x, value){
        if (length(value) != 1)
            stop("length(value) must equal 1")
        slot(x, "vep") <- value
        x
    }
)

### hRef
setMethod(
    f = "hRef",
    signature = c("TVTBparam"),
    definition = function(x)
        slot(x, "genos")[1]
)

setReplaceMethod(
    f = "hRef", c("TVTBparam", "list"),
    function(x, value){

        slot(x, "genos")[1] <- value

        # If named, overwrite existing name
        if (!is.null(names(value)))
            names(slot(x, "genos")[1]) <- names(value)

        validObject(x)
        return(x)
    }
)

setReplaceMethod(
    f = "hRef", c("TVTBparam", "character"),
    function(x, value){
        slot(x, "genos")[[1]] <- value
        x
    }
)

### het
setMethod(
    f = "het",
    signature = c("TVTBparam"),
    definition = function(x)
        slot(x, "genos")[2]
)

setReplaceMethod(
    f = "het", c("TVTBparam", "list"),
    function(x, value){

        slot(x, "genos")[2] <- value

        # If named, overwrite existing name
        if (!is.null(names(value)))
            names(slot(x, "genos")[2]) <- names(value)

        validObject(x)
        return(x)
    }
)

setReplaceMethod(
    f = "het", c("TVTBparam", "character"),
    function(x, value){
        slot(x, "genos")[[2]] <- value
        x
    }
)

### hAlt
setMethod(
    f = "hAlt",
    signature = c("TVTBparam"),
    definition = function(x)
        slot(x, "genos")[3]
)

setReplaceMethod(
    f = "hAlt", c("TVTBparam", "list"),
    function(x, value){

        slot(x, "genos")[3] <- value

        # If named, overwrite existing name
        if (!is.null(names(value)))
            names(slot(x, "genos")[3]) <- names(value)

        x
    }
)

setReplaceMethod(
    f = "hAlt", c("TVTBparam", "character"),
    function(x, value){
        slot(x, "genos")[[3]] <- value
        x
    }
)

### carrier
setMethod(
    f = "carrier",
    signature = c("TVTBparam"),
    definition = function(x)
        slot(x, "genos")[2:3]
)

setReplaceMethod(
    f = "carrier", c("TVTBparam", "list"),
    function(x, value){

        # If unnamed, use current names
        if (is.null(names(value)))
            names(value) <- names(slot(x, "carrier"))
        else{
            if (any(names(value) == ""))
                stop("All elements of genos must be named, or none")
        }

        # If named, overwrite existing name
        if (!is.null(names(value)))
            if (any(names(value) == ""))
                stop("All elements of genos must be named, or none")
            else
                names(slot(x, "genos")[2:3]) <- names(value)

        slot(x, "genos")[2:3] <- value
        validObject(x)
        return(x)
    }
)

### bp (BiocParallel)
setMethod(
    f = "bp",
    signature = c("TVTBparam"),
    definition = function(x)
        c(slot(x, "bp"))
)

setReplaceMethod(
    f = "bp", c("TVTBparam", "BiocParallelParam"),
    function(x, value){

        slot(x, "bp") <- value
        x
    }
)