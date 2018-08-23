#' CreateSnapshot
#' 
#' Converts a htmlwidget to png image file
#' @param widget The htmlwidget to display.
#' @param filename Name of output file (png format).
#' @param delay Time to wait before taking screenshot, in seconds. Sometimes a longer delay is needed for all assets to display properly.
#' @details Works with plotly and rhtmlLabeledScatter. Errors with rhtmlPictograph.
#' @importFrom htmlwidgets saveWidget
#' @importFrom webshot webshot
#' @export
CreateSnapshot <- function(widget, filename, delay = 0.2)
{
    if (inherits(widget, "StandardChart"))
        widget <- widget$htmlwidget
    # Ensure that filename has 'png' suffix which is used by webshot
    if (!grepl(".png$", tolower(filename)))
        filename <- paste0(filename, ".png")
   
    # Generate unique name for temporary html file
    tmp.files <- tempdir()
    tmp.html <- paste0(tmp.files, ".html")
    on.exit(unlink(tmp.html), add = TRUE) 
    on.exit(unlink(tmp.files), add = TRUE) 
    
    saveWidget(widget, file = tmp.html, selfcontained = FALSE)
    webshot(tmp.html, file = filename, delay = delay)
}