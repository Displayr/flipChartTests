context("Long axis labels")
library("flipChart")

dat.longlabels <- structure(c(7.91102010395624, 6.96526937072327, 5.46318510403465,
5.38509189451583, 4.78058885624491, 4.33171962498696, 3.89343951521741,
3.55479479224441, 3.49925232784262, 3.2548930765863, 3.07402467818954,
3.0495443587413, 2.89422593526089, 2.79615757754444, 2.56564004442188,
1.61841320359909, 1.58338586529381, 1.55622840223137, 1.39226282992314,
1.15765067144292, 1.14529457127121, 1.11671971850934, 1.03469831507199,
0.239788448851907, 0.338584394730979, 0.652596783697478, 0.65957266310851,
1.40220203380981, 1.69973936013571, 2.25076657961354, 2.69640999321625,
4.76387713463588, 4.87316019423645, 6.39980157610997, 7), .Names = c("Reliable",
"Fun", "Upper-class", "Confident", "Sexy", "Intelligent", "Honest",
"Traditional", "Down-to-earth", "Health-conscious", "Humorous",
"Up-to-date", "Imaginative", "Beautiful", "Charming", "Carefree",
"Youthful", "Open to new experiences", "Masculine", "Wholesome",
"Urban", "Outdoorsy", "Hip", "Tough", "Innocent", "Rebellious",
"Older", "Weight-conscious", "Reckless", "Individualistic", "Feminine",
"Trying to be cool", "Sleepy", "Unconventional", "Very Very Very Very Long And Tedious And Way Too Long Label That Will Be Truncated"
))

funcs <- c("Column", "Bar", "Area", "Line", "Radar")  # skip Scatter which does not handle wrapping
test.cases <- c('longlabels-wrap' = 'dat.longlabels[30:35]',
                'longlabels-wrap4' = 'dat.longlabels[30:35], categories.tick.label.wrap.nchar=4, categories.title="Long labels", categories.title.font.size=40',
                'longlabels-nowrap' = 'dat.longlabels[30:35], categories.tick.label.wrap=FALSE',
                'longlabels-angle' = 'dat.longlabels[1:5], categories.title="Kilometers per hour<br>from city centre", categories.tick.angle=90, categories.title.font.size=30')

for (ff in funcs)
{
    for (i in 1:length(test.cases))
    {
        filestem <- paste0("axislabels-", tolower(ff), "-", names(test.cases)[i])
        test_that(filestem, {

            cmd <- paste0("pp <- CChart(\"", ff, "\", ", test.cases[i], 
                          ", warn.if.no.match = FALSE)")
            expect_error(eval(parse(text=cmd)), NA)
            expect_true(TestWidget(pp, filestem))
        })
    }
}
