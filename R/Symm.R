#  Copyright (C) 2005, 2006, 2008 David Firth and Heather Turner
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 or 3 of the License
#  (at your option).
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  A copy of the GNU General Public License is available at
#  http://www.r-project.org/Licenses/

Symm <- function(..., separator = ":"){
    if (!(is.character(separator) && nchar(separator) > 0)) stop(
		 "separator must be a non-empty character string") 
    dots <- list(...)
    if (any(diff(vapply(dots, length, 1)) != 0)) stop(
                "arguments to Symm() must all have same length")
    dots <- lapply(dots, as.factor)
    Levels <- levels(dots[[1]])
    check <- vapply(dots[-1], function(x) identical(levels(x), Levels), 
                    TRUE)
    if (!all(check)) stop("factors must have the same levels")
    facMatrix <- vapply(dots, unclass, numeric(length(dots[[1]])))
    f <- function(row){
        string <- paste(Levels[sort(row)], collapse = separator)
        if (any(is.na(row))) is.na(string) <- TRUE
        string
    }
    n <- length(Levels)
    seqn <- seq_len(n)
    factor(apply(facMatrix, 1, f),
           paste(Levels[rep(seqn, rev(seqn))],
                 Levels[unlist(lapply(seqn, function(x) seq(x, n)))],
                 sep = separator))
}
