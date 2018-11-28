#' Applies the Problem Forward ggplot2 theme.
#'
#' You can \code{+ theme_pf()} to an existing ggplot to apply our branding.
#' It should be one of the first things you do after adding in the ggplot
#' \code{aes} and \code{geom}, so that you can fiddle with the rest of the
#' layout afterward.
#'
#' @param base_size base font size for the plot; defaults to \code{10}
#' @param font font family to use; defaults to \code{"Roboto"}
#' @param discrete use a discrete color palette; defaults to \code{TRUE}
#' @param grid major axis grid lines in plot; defaults to \code{"XY"}.
#'        options include: \code{"X"} for only X grid lines,
#'                         \code{"Y"} for only Y grid lines,
#'                         \code{"XY"} for both.
#'
#' @export
#'
#' @examples
#' TBD.

# Problem Forward Theme
theme_pf <- function(base_size=10, font=NA, discrete = TRUE, grid = "XY"){

    # Font setup
    if(!("Roboto Condensed" %in% fonts())){
      hrbrthemes::import_roboto_condensed()
      d <- read.csv(extrafont:::fonttable_file(), stringsAsFactors = FALSE)
      d[grepl("Light", d$FontName),]$FamilyName <- font_rc_light
      write.csv(d,extrafont:::fonttable_file(), row.names = FALSE)
    }

    # Load fonts and see if this break it
    extrafont::loadfonts()
    
    # Logo setup
    # logo <- readPNG("images/PFlogo.png")
    # g <- rasterGrob(logo, interpolate=TRUE)

    # ggplot commands
    list(theme_ipsum_rc(base_size = base_size,
                        base_family = font,
                        grid = grid
                        ),
         labs(caption="Brought to you by Problem Forward"),
         # Color scales
         scale_fill_viridis(option = "plasma",
                            end = 0.8,
                            discrete = discrete),
         scale_colour_viridis(option = "plasma",
                            end = 0.8,
                            discrete = discrete)
         # Logo
         # annotation_custom(g,
                           # xmin=-Inf,
                           # xmax=Inf,
                           # ymin=-Inf,
                           # ymax=Inf)
    # Below is for more fine control if desired

    # Strip background colors
       # theme(
       # legend.key = element_blank(),
       # strip.background = element_blank(),

       # Text assignment

       # text = txt,
       # plot.title = bold_txt,

       # axis.title = txt,
       # axis.text = txt,

       # legend.title = bold_txt,
       # legend.text = txt
       # )
       # ,
       # +

         # Axes
      #   theme(
           # axis.line.y = element_line(colour = "pink", size = 1, linetype = "dashed"),
           # axis.line.x = element_line(colour = "pink", size = 1.2,linetype = "dashed"),
           #### remove Tick marks
           # axis.ticks = element_blank()

           ### legend
           # legend.position = "top",
           # legend.title = element_blank(),
           # legend.key = element_rect(fill = "lightskyblue1", color = "lightskyblue1"),
           # legend.background = element_rect( fill = "lightskyblue1",color = "pink", size = 0.5,linetype = "longdash"),

           ## background
           # plot.background = element_rect(fill = "lightskyblue1",colour = "pink",size = 0.5, linetype = "longdash")
        # ),

      )
}

## Other logo attempts below:

# logo <- readPNG(source = "images/smalllogo_test.png")
# annotation_custom(rasterGrob(logo, interpolate=TRUE),
#                   xmin=0.95*min(mtcars$mpg)-1, xmax=0.95*min(mtcars$mpg)+1,
#                   ymin=0.62*min(mtcars$wt)-0.5, ymax=0.62*min(mtcars$wt)+0.5)
# gt <- ggplot_gtable(ggplot_build(gg))
# gt$layout$clip[gt$layout$name=="panel"] <- "off"
# grid.draw(gt)
