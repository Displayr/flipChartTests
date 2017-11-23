context("Stacked Charts")

# data sets to check
set.seed(122333)
dat.list <- c("unnamed", "named", "gapped", "missing1", "missing13", "dated", "gapdated")
unnamed <- t(matrix(rpois(60, 4), 20, 3)) # all positives
named <- t(matrix(unnamed, 20, 3, dimnames = list(letters[1:20], LETTERS[1:3])))
gapped <- t(matrix(unnamed, 20, 3, dimnames = list(c(1:10, 21:30), LETTERS[1:3])))
missing1 <- gapped
missing1[1,1] <- NA
colnames(missing1) <- 25:44
missing13 <- missing1
missing13[1,c(1,3)] <- NA
dated <- gapped
colnames(dated) <- sprintf("%02d/01/2017", 1:20)
gapdated <- dated
colnames(gapdated) <- sprintf("%02d/01/2017", c(1:10, 21:30))

opts <- c('default' = '',
          'datalabels' = 'data.label.show = TRUE',
          'reversed' = 'x.data.reversed = TRUE, y.data.reversed = TRUE, data.label.show = TRUE')

# data axis of stacked area chart gets chopped off
for (func in c("Area", "Bar", "Column"))
{
    for (dat in dat.list)
    {
        for (ii in 1:length(opts))
        {
            filestem <- paste("stacked", tolower(func), dat, names(opts)[ii], sep="-")
            test_that(filestem, {
                
                stack.str <- "\"Stacked\", "
                if (ii %% 2 == 0)
                    stack.str <- "\"100% Stacked\", "
                cmd <- paste0("pp <- ", func, "(", dat, ", type = ", stack.str, opts[ii], ")")
                
                if (grepl("missing", filestem))
                    expect_error(eval(parse(text=cmd)))
                else
                {
                    expect_error(eval(parse(text=cmd)), NA)
                    expect_true(TestWidget(pp, filestem))
                }
            })
        }
    }
}
