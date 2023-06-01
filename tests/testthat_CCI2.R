## Old travis timings from
## https://app.travis-ci.com/github/Displayr/flipChartTests3/builds/260585134
## test-axislabels.R: 78s
## test-background.R: 1541
## test-basicexample.R: 84
## test-cchart.R: 10.5
## test-colsecondary.R: 77
## test-hover.R: 96
## test-palm.R: 66
## radar: 161
## test-timeseries.R: 1
if (identical(Sys.getenv("CIRCLECI"), "true"))
{
    if (!dir.exists("reports"))
        dir.create("reports")
    out.file <- paste0("reports/test_results", Sys.getenv("CIRCLE_NODE_INDEX"), ".xml")
    exit.code <- flipDevTools::RunTestsOnCircleCI(filter = "^background2",
                                                  load_package = "none", output_file = out.file)
    ## Ignore exit code so job continues to save snapshot step
    ## q(status = exit.code, save = "no")
}
