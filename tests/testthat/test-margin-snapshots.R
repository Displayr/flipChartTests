context("Text in margins")
library("flipChart")

# labeledscatterplots font color is not showing and does not handle '<br>'
# something strange happening with radar chart footer wrapping

dat <- structure(c(0, 22, 18, 15, 16, 19, 13, 18, 27, 12, 0, 22, 21,
18, 20, 16, 14, 22, 24, 10), .Dim = c(10L, 2L), statistic = "n", .Dimnames = list(
    c("Less than 18", "18 to 24", "25 to 29", "30 to 34", "35 to 39",
    "40 to 44", "45 to 49", "50 to 54", "55 to 64", "65 or more"
    ), c("Male", "Female")), name = "Q3. Age by Q2. Gender", questions = c("Q3. Age",
"Q2. Gender"))

filler.text <- "Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."

# Pie charts do not yet have title/subtitle/footers
funcs <- c("Column", "Bar", "Area", "Line", "Scatter", "LabeledScatter", "Radar")
test.cases <- c('footer' = 'dat, footer = filler.text',
                'footer-size5' = 'dat, footer = filler.text, footer.font.size = 5, footer.font.color = "red"',
                'footer-xtitle' = 'dat, footer = filler.text, x.title = "Some label<br>which goes over two lines", x.title.font.size=20, footer.wrap.nchar = 150',
                'alltitles' = 'dat, footer = filler.text, title = "Chart", subtitle = "A brief description<br>that may be longer that one line", global.font.color = "red", title.font.color = "blue", subtitle.font.color = "grey", footer.font.color = "green"')

for (ff in funcs)
{
    for (i in 1:length(test.cases))
    {
        filestem <- paste0(tolower(ff), "-", names(test.cases)[i])
        test_that(filestem, {

            extra.args <- ""
            cmd <- paste0("pp <- CChart(\"", ff, "\", ", test.cases[i], extra.args, ")")
            expect_error(eval(parse(text=cmd)), NA)

            accepted.file <- paste0("snapshots/accepted/", filestem, ".png")
            diff.file <- paste0("snapshots/diff/", filestem, ".png")
            expect_equal(CompareSnapshot(pp, diff.file, accepted.file), TRUE)
        })
    }
}
