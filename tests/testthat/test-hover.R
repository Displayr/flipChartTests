context("Mouse interactions")

set.seed(245788)
xmat <- matrix(rpois(60, 4), 20, 3, dimnames = list(letters[1:20], c("Alpha", "Beta", "Gamma")))
xx <- c(a = 0.01, b = 3, c = 4, d = 5, e = 6, f = 7, g = 8, h = 9,  i = 10)

test_that("Tooltips shown for small values",
{
    pp <- Bar(xx)
    expect_true(TestWidget(pp, "hover-smallvals-bar", mouse.xpos = 0.09, mouse.ypos = 0.1))
    
    pp <- Column(xx)
    expect_true(TestWidget(pp, "hover-smallvals-column", mouse.xpos = 0.1, mouse.ypos = 0.97))
    
    pp <- Pyramid(xx)
    expect_true(TestWidget(pp, "hover-smallvals-pyramid", mouse.xpos = 0.5, mouse.ypos = 0.1))
    
})

test_that("Legend toggle",
{
    pp <- Bar(xmat, type = "Stacked", data.label.show = TRUE)
    expect_true(TestWidget(pp, "legend-disabled-stacked-bar", mouse.doubleclick = TRUE,
        mouse.xpos = 0.97, mouse.ypos = 0.08))
    
    pp <- Bar(xmat, type = "Stacked", data.label.show = FALSE)
    expect_true(TestWidget(pp, "legend-notdisabled-stacked-bar", mouse.doubleclick = TRUE,
        mouse.xpos = 0.97, mouse.ypos = 0.08))
    
    pp <- Column(xmat, type = "Stacked", data.label.show = TRUE)
    expect_true(TestWidget(pp, "legend-disabled-stacked-column", mouse.doubleclick = TRUE,
        mouse.xpos = 0.97, mouse.ypos = 0.08))
    
    pp <- Column(xmat, type = "Stacked", data.label.show = FALSE)
    expect_true(TestWidget(pp, "legend-notdisabled-stacked-column", mouse.doubleclick = TRUE,
        mouse.xpos = 0.97, mouse.ypos = 0.08))
    
    
    
})

