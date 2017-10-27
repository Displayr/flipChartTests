[![](https://travis-ci.org/Displayr/flipChartTests.svg?branch=master)](https://travis-ci.org/Displayr/flipChartTests/)
[![Coverage Status](https://coveralls.io/repos/github/Displayr/flipChartTests/badge.svg?branch=master)](https://coveralls.io/github/Displayr/flipChartTests?branch=master)
# flipChartTests

Contains unit tests for flipStandardChart and flipChart.

## To install from GitHub
```
require(devtools)
install_github("Displayr/flipChartTests")
```

## Running tests
Unit tests for flipChartTests include generating pngs of some files and
comparing against previous pngs. The packages required for running
visual tests can be set up by:
```
install.packages("devtools")
install.packages("testthat")
install_github("MangoTheCat/visualTest")
install.packages("webshot")
webshot::install_phantomjs()
```

[![Displayr logo](https://mwmclean.github.io/img/logo-header.png)](https://www.displayr.com)
