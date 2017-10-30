[![](https://travis-ci.org/Displayr/flipChartTests.svg?branch=master)](https://travis-ci.org/Displayr/flipChartTests/)
[![Coverage Status](https://coveralls.io/repos/github/Displayr/flipChartTests/badge.svg?branch=master)](https://coveralls.io/github/Displayr/flipChartTests?branch=master)
# flipChartTests

This package contains only unit tests for flipStandardChart and flipChart.
Test outputs are machine-specific, so it is recommended that you use 
the image files included inside the repository rather than local versions.

Outputs of tests run in Travis CI can be found inside 
[tests/testthat/snapshots](tests/testthat/snapshots). Diffing files are in the **[diff](tests/testthat/snapshots/diff)** directory and should be compared against files of the same name that are in the **[accepted](tests/testthat/snapshots/accepted)** directory.

Tests can be added to the R files in the [testthat](tests/testthat) and the
user may want to view local copies of them before committing the change, but
the test outputs (i.e. PNG files) should not be commited.


## Running tests locally
Unit tests involve converting the htmlwidget to a htmlfile and then
taking a snapshot using `webtools` to create PNG files.
The packages required for running visual tests can be set up by:
```
install.packages("devtools")
install.packages("testthat")
require(devtools)
install_github("MangoTheCat/visualTest")
install.packages("webshot")
webshot::install_phantomjs()
install_github("Displayr/flipChartTests")
```

To accept new test outputs, simply delete the existing test output inside [tests/testthat/snapshots/accepted](tests/testthat/snapshots/accepted) and the new outputs will saved in that directory next time the tests are run using `devtools::test()`

Note that running `devtools::check()` will give the same error messages as `devtools::test()` but will not generate output PNG files.

[![Displayr logo](https://mwmclean.github.io/img/logo-header.png)](https://www.displayr.com)
