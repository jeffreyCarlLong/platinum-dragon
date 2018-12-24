#! /usr/bin/env Rscript
# Mon Dec 24 08:26:52 PST 2018
# Jeffrey C. Long

# Package installs

# List of packages
list.of.packages <- c("ggplot2", "Rcpp", "tidyverse", "fs")i

# Compare list of packages with installed packages
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

# Install new packages
if(length(new.packages)) install.packages(new.packages)

