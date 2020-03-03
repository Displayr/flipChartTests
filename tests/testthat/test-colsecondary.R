context("Column chart with secondary axis")

dat1 <- list()
dat2 <- list()

# Inputs need to be paired to have the same type of x-axis
set.seed(654321)
fseq <- c(1,2,3,5,8,13,21,34,55)
dat1[["numeric"]] <- matrix(rpois(27, 4), 9, 3, dimnames = list(fseq, LETTERS[1:3]))
dat2[["numeric"]] <- matrix(rpois(45, 4), 15, 3, dimnames = list(c(0, fseq, 56:60), LETTERS[3+(1:3)]))

dat1[["categoricals"]] <- matrix(c(1:20), 10, 2, dimnames=list(letters[1:10], c("X", "Y")))
dat2[["categoricals"]] <- matrix(rpois(10, 5) * 1e6, 10, 1, dimnames=list(letters[1:10], c("Random")))


dat1[["dates"]] <- matrix(c(1:20), 10, 2,
                dimnames=list(sprintf("%02d/01/2017", c(1:5, 16:20)), c("M1 2019", "M1 2020")))
dat2[["dates"]] <- matrix(rpois(20, 4) * 1e-3, 10, 2,
                dimnames=list(sprintf("%02d/01/2017", c((1:10)+10)), c("M2 2019", "M2 2020")))

opts <- c('default' = '',
          'categoryformat' = 'x.tick.format = "Category", data.label.show = TRUE, type = "Stacked", opacity = 0.4', 
          'zeroaxis' = 'x.zero = TRUE, x.data.reversed = TRUE, data.label.show = TRUE',
          'reversed' = 'x.data.reversed = TRUE, y.data.reversed = TRUE, data.label.show = TRUE',
          'x2datalabels' = 'x2.data.label.show = TRUE, x2.data.label.font.color = "red", x2.data.label.font.family = "Impact", x2.data.label.font.size = 7, x2.data.label.format = ".3f"',
          'markers' = 'x2.data.label.show = TRUE, x2.marker.border.width = 0, x2.data.label.font.autocolor = TRUE, x2.data.label.position = "Middle", x2.marker.show = TRUE, x2.marker.size = 20, x2.marker.opacity = 0.5, x2.marker.symbols = c("circle", "diamond"), type = "Stacked", opacity = 1.0, colors =c("grey20", "grey40", "grey60")',
          'curve' = 'x2.shape = "Curved", x2.line.thickness = "5,4,3", x2.line.type = "Solid, Dot, Dash", type = "Stacked", opacity = 0.4, colors =c("grey20", "grey40", "grey60")'
         )

library(flipStandardCharts)
for (i in 1:length(dat1))
{
    for (j in 1:length(opts))
    {
        filestem <- paste("colsecondary", names(dat1)[i], names(opts)[j], sep = "_")
        test_that(filestem,
        {
            cmd <- paste0("pp <- Column(dat1[[", i, "]], x2 = dat2[[", i, "]], ",
                          opts[j], ")")
            expect_error(suppressWarnings(eval(parse(text = cmd))), NA)
            expect_true(TestWidget(pp, filestem))
            #print(pp)
            #readline(prompt=paste0(filestem, ": press [enter] to continue: "))
        })
    }
}