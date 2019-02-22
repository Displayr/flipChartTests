#' CreateSnapshot
#' 
#' Converts a htmlwidget to png image file
#' @param widget The htmlwidget to display.
#' @param filename Name of output file (png format).
#' @param delay Time to wait before taking screenshot, in seconds. Sometimes a longer delay is needed for all assets to display properly.
#' @param mouse.hover Logical indicating whether or not to simulate mouse clicking in the middle of the widget.
#' @details Works with plotly and rhtmlLabeledScatter. Errors with rhtmlPictograph.
#' @importFrom htmlwidgets saveWidget
#' @importFrom webshot webshot
#' @export
CreateSnapshot <- function(widget, filename, delay = 0.2, mouse.hover = TRUE)
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
    
    eval <- NULL
    if (mouse.hover)
        eval <- "this.mouse.click(opts.zoom*opts.width/2, opts.zoom*opts.vheight/2);"
    webshot(tmp.html, file = filename, delay = delay, eval = eval, cliprect = "viewport")
}