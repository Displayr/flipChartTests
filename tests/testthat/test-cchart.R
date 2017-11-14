context("CChart substitutions")
library("flipChart")

set.seed(1234567)
xx <- rnorm(20)
names(xx) <- LETTERS[1:20]

for (func in c("Column", "Bar", "Distribution"))
{
    filestem <- paste("cchart", tolower(func), "axistitle", sep="-")
    test_that(filestem, {
        expect_error(pp <- suppressWarnings(CChart("Column", xx, categories.title = "Categories", 
                                  values.title = "Values")), NA)
        expect_true(TestWidget(pp, filestem))
    })
}