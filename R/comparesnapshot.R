#' CompareSnapshot
#'
#' Takes snapshot of a widget and compares it against another snapshot.
#' @return TRUE if the accepted snapshot does not exist or the widget 
#'   looks the same as the accepted snapshot
#' @param widget The htmlwidget to display.
#' @param diff.file Character; the name of the snapshot file taken
#' @param accepted.file Character; the name of the snapshot to be compared against.
#'    If this file does not exist, it will be created from a snapshot of the widget.
#' @param delay Time to wait before taking screenshot, in seconds. Sometimes a longer delay is needed for all assets to display properly.
#' @param threshold similarity parameter for comparing screenshots.
#' @param strict Whether to give warning if \code{accepted.file} does not exist.
#' @importFrom visualTest isSimilar
CompareSnapshot <- function(widget, 
                            diff.file,
                            accepted.file,
                            delay = 0.2,
                            threshold = 0.1,
                            strict = FALSE)
{
    if (!file.exists(accepted.file))
    {
        CreateSnapshot(widget, filename = accepted.file, delay = delay)
        if (strict)
            warning("File ", accepted.file, " does not exist.")
        return (TRUE)
    }
    else
    {
        CreateSnapshot(widget, filename = diff.file, delay = delay)
        return(isSimilar(file = diff.file, fingerprint = accepted.file, threshold = threshold))
    }
}
