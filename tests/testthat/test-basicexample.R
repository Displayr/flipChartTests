context("Basic example")
# This file demonstrates how to test combinations of parameters
# It can be then used to create snapshot tests
# See flipChartTests/tests/testthat/test-basicexample.R

# Set up various data types to test
set.seed(1234)
random <- rnorm(20)
positives <- abs(random)

# Create lists of all charting functions, and data types and options to use
# Functions excluded: Waterfall, Venn, Stream, HeatMap
charting.funcs <- c("Column", "Bar", "Area", "Line", "Pie", "Radar",
                    "Scatter", "LabeledScatter", "Box", "Bean", "Distribution",
                    "Density", "Violin")
dat.list <- c("random", "positives")

# Iterate through all combinations of charting functions and data types
for (func in charting.funcs)
{
    for (dat in dat.list)
    {
        # Create name which will appear in the error message if test fails
        filestem <- paste0(tolower(func), "-", dat)
        if (filestem == "radar-random")
            next
        
        test_that(filestem, {

            # Create command that will create widget
            cmd <- paste0("pp <- ", func, "(", dat, ")")

            # Run command and check outputs
            # First, isolate specific cases which behave differently
            if (filestem == "pie-random")
                expect_warning(eval(parse(text=cmd)))

            # General case for all other combinations
            else
                expect_error(eval(parse(text=cmd)), NA)
            
            # Create snapshot and compare 
            expect_equal(TestWidget(pp, filestem), TRUE)
        })
    }
}