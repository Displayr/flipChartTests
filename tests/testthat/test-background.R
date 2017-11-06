context("Background snapshots")
library("flipStandardCharts")
    
funcs <- c("Column", "Bar", "Area", "Line", "Scatter", "Radar")

# Add named entries to test.args to add more snapshot tests
# Here we are checcking the behaviour of the chart background and axis
test.args <- c('default' = '',
    'backgroundcolors' = 'background.fill.color="grey", charting.area.fill.color="yellow", charting.area.fill.opacity=0.2',
    'grid' = 'x.line.width=2, y.line.width=4, y.line.color="red", x.line.color="blue", y.tick.mark.length=10, x.tick.mark.length=1, x.grid.width=1, y.grid.width=1',
    'tickdist' = 'y.bounds.minimum=3, y.bounds.maximum=20, y.tick.distance=1',
    'reversed' = 'x.data.reversed=TRUE, y.data.reversed=TRUE',
    'legendpos' = 'legend.position.y=0.5, legend.position.x=0, legend.font.color="red"',
    'margins' = 'margin.left=0, margin.right=0, margin.top=0, margin.inner.pad=10, charting.area.fill.color="red", legend.show=FALSE, grid.show=FALSE',
    'font' = 'global.font.family="Courier", global.font.color="red"')

dat1 <- matrix(c(1:20), 10, 2, dimnames=list(letters[1:10], c("X", "Y")))

for (ff in funcs)
{
    for (i in 1:length(test.args))
    {
        # filestem is both the name of the image in accepted-snapshots
        # and the error msg expected on the output of devtools::test()
        filestem <- paste0("background-", tolower(ff), "-", names(test.args)[i])
        if (filestem %in% c("background-radar-reversed", "background-radar-grid"))
            next
        test_that(filestem, {
            extra.args <- ""
            if (filestem == "background-scatter-legendpos")
                extra.args <- ", scatter.colors.column=2, scatter.colors.as.categorical=T"
            cmd <- paste0("pp <- ", ff, "(dat1, ", test.args[i], extra.args, ")")
            expect_error(eval(parse(text=cmd)), NA)
            expect_true(TestWidget(pp, filestem))
        })
    }
}
