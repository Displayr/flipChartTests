#' CreateSnapshot
#' 
#' Converts a htmlwidget to png image file
#' @param widget The htmlwidget to display.
#' @param filename Name of output file (png format).
#' @param width Width of the snapshot viewport in pixels.
#' @param height Height of the snapshot viewport in pixels.
#' @param delay Time to wait before taking screenshot, in seconds. Sometimes a longer delay is needed for all assets to display properly.
#' @param mouse.hover Logical indicating whether or not to simulate mouse clicking.
#'    Note that the cursor itself is not visible, only the effects of clicking.
#' @param mouse.doubleclick Logical indicating whether to simulate doubleclicking. Overrides \code{mouse.hover}.
#' @param mouse.xpos Horizontal position of the mouse ranging from 0 (left) to 1 (right).
#' @param mouse.ypos Vertical position of the mouse ranging from 0 (top) to 1 (bottom).
#' @details Works with plotly and rhtmlLabeledScatter. Errors with rhtmlPictograph.
#' @importFrom htmlwidgets saveWidget
#' @importFrom webshot webshot
#' @export
CreateSnapshot <- function(widget, filename, delay = 0.2, width = 992, height = 744,
                           mouse.hover = TRUE, mouse.doubleclick = FALSE,
                           mouse.xpos = 0.5, mouse.ypos = 0.5)
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
    if (mouse.doubleclick)
        eval <- paste0("this.mouse.doubleclick(", mouse.xpos * width, ", ", mouse.ypos * height, ")")
    else if (mouse.hover)
        eval <- paste0("this.mouse.click(", mouse.xpos * width, ", ", mouse.ypos * height, ")")
    
    webshot(tmp.html, file = filename, delay = delay, cliprect = "viewport", eval = eval, debug = TRUE,
        vwidth = width, vheight = height)
}