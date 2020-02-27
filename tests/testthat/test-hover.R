context("Mouse interactions")
library(flipStandardCharts)

set.seed(245788)
xmat <- matrix(rpois(60, 4), 20, 3, dimnames = list(letters[1:20], c("Alpha", "Beta", "Gamma")))
xx <- c(a = 0.001, b = 3, c = 4, d = 5, e = 6, f = 7, g = 8, h = 9,  i = 10)
x2d <- cbind(Cat = (1:9) + 5, Dog = xx)

test_that("Tooltips shown for small values",
{
    pp <- Bar(xx)
    expect_true(TestWidget(pp, "hover-smallvals-bar", mouse.xpos = 0.09, mouse.ypos = 0.1))
    
    pp <- Bar(xx[1:4])
    expect_true(TestWidget(pp, "hover-wide-bar", mouse.xpos = 0.08, mouse.ypos = 0.1))
    
    pp <- Bar(x2d, type = "Stacked", data.label.show = TRUE)
    expect_true(TestWidget(pp, "hover-smallvals-stackedbar", mouse.xpos = 0.27, mouse.ypos = 0.1))
    
    pp <- Column(xx)
    expect_true(TestWidget(pp, "hover-smallvals-column", mouse.xpos = 0.1, mouse.ypos = 0.97))
    
    pp <- Pyramid(xx, data.label.show = TRUE)
    expect_true(TestWidget(pp, "hover-smallvals-pyramid", mouse.xpos = 0.531, mouse.ypos = 0.1))
    
    pp <- SmallMultiples(x2d, "Pyramid", data.label.show = TRUE)
    expect_true(TestWidget(pp, "hover-smallvals-pyramid-smallmult", mouse.xpos = 0.541, mouse.ypos = 0.561))
    
})

test_that("Legend toggle",
{
    pp <- Bar(xmat, type = "Stacked", data.label.show = TRUE)
    expect_true(TestWidget(pp, "legend-disabled-stacked-bar", mouse.doubleclick = TRUE,
        mouse.xpos = 0.97, mouse.ypos = 0.08, delay = 2))
    
    pp <- Bar(xmat, type = "Stacked", data.label.show = FALSE)
    expect_true(TestWidget(pp, "legend-notdisabled-stacked-bar", mouse.doubleclick = TRUE,
        mouse.xpos = 0.97, mouse.ypos = 0.08, delay = 2))
    
    pp <- Column(xmat, type = "Stacked", data.label.show = TRUE)
    expect_true(TestWidget(pp, "legend-disabled-stacked-column", mouse.doubleclick = TRUE,
        mouse.xpos = 0.97, mouse.ypos = 0.08, delay = 2))
    
    pp <- Column(xmat, type = "Stacked", data.label.show = FALSE)
    expect_true(TestWidget(pp, "legend-notdisabled-stacked-column", mouse.doubleclick = TRUE,
        mouse.xpos = 0.97, mouse.ypos = 0.08, delay = 2))
    
    # For Stacked Area, legend toggle should work with and without datalabels (DS-2497)
    pp <- Area(xmat, type = "Stacked", data.label.show = TRUE)
    expect_true(TestWidget(pp, "legend-notdisabled-stacked-area", mouse.doubleclick = TRUE,
        mouse.xpos = 0.97, mouse.ypos = 0.08, delay = 2))
    
    pp <- Area(xmat, type = "Stacked", data.label.show = FALSE)
    expect_true(TestWidget(pp, "legend-notdisabled-stacked-area-nodatalabels", mouse.doubleclick = TRUE,
        mouse.xpos = 0.97, mouse.ypos = 0.08))

    # Check legend toggling works properly for unstacked charts
    for (chart in c("Area", "Bar", "Column", "Line", "Radar"))
    {
        filestem <- paste0("legendtoggle-", tolower(chart))
        cmd <- paste0(chart, "(xmat, data.label.show = TRUE)")
        expect_error(pp <- eval(parse(text=cmd)), NA)
        expect_true(TestWidget(pp, paste0(filestem, ".png"), mouse.doubleclick = TRUE,
            mouse.xpos = 0.97, mouse.ypos = 0.08, delay = 2))
    }
    
})

