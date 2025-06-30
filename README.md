
<!-- README.md is generated from README.Rmd. Please edit that file -->

# A Unified Event Detection Dataset (UniTED) powered by DAL

<!-- badges: start -->

![GitHub Repo stars](https://github.com/cefet-rj-dal/united)
<!-- badges: end -->

The Unified Event Detection Dataset (UniTED), powered by DAL, is a
curated repository of datasets for the development and evaluation of
time series event detection methods. It primarily includes labeled
datasets, enabling consistent benchmarking and performance assessment
across experiments. While the datasets can be accessed via raw files, it
is recommended to use them through this R package, following the usage
guidelines provided in the next section.

------------------------------------------------------------------------

## Dataset Description

Full dataset description is available at:
<https://github.com/cefet-rj-dal/united/wiki>

------------------------------------------------------------------------

## Examples

Usage: <https://github.com/cefet-rj-dal/united/tree/main/examples/>

The examples are organized according to available datasets.

``` r
library(united)
#> Registered S3 method overwritten by 'quantmod':
#>   method            from
#>   as.zoo.data.frame zoo
#> Registered S3 methods overwritten by 'forecast':
#>   method  from 
#>   head.ts stats
#>   tail.ts stats
```

------------------------------------------------------------------------

## Installation

You can install the published version of UniTED package from GitHub
<https://github.com/cefet-rj-dal/united> with:

``` r
timeout <- options()$timeout
options(timeout=1200)
devtools::install_github("cefet-rj-dal/united", upgrade="never")
options(timeout=timeout)
```

## Bugs and new features request

<https://github.com/cefet-rj-dal/united/issues>
