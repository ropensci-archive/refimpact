
## Test environments

* local OS X install, R 3.3.2
* Ubuntu 12.04 (on travis-ci), R 3.3.2, R 3.2.5, R-devel.
* Windows (on AppVeyor), R 3.3.2, R 3.2.5, R-devel

## R CMD check results

0 ERRORs | 0 WARNINGs | 1 NOTE

* checking data for non-ASCII characters ... NOTE
  Note: found 85 marked UTF-8 strings
  
  These strings are from the ref_tags dataset, included in the data/ folder. The
  UTF-8 character are required as several institutions in this list have names
  which cannot be represented faithfully in ASCII.

## Downstream dependencies

There are currently no downstream dependencies for this package.
