# Title: Problem Forward GGPlot Themes
# Author: Ken Morales
# Contact: kmorales@problemforward.com
# Date Created: 11.14.2018
# Purpose: To generate a template for Problem Forward plots (and graphics?)

#####

###
### Problem Forward Theme
###

##
## Setup
##

# Dependencies
libraries <- c("ggplot2", "ggthemes", "dplyr", "reshape2", "grid", "lubridate", "stringr", "viridis", "extrafont", "png")
suppressPackageStartupMessages(
  lapply(libraries,
         require, character.only = TRUE)
  )
options(stringsAsFactors = FALSE)

# Font setup
# Note: requires Roboto font to be installed: https://fonts.google.com/specimen/Roboto
font_import(pattern = "Roboto-Light.ttf")
windowsFonts(F = windowsFont("Roboto"))

# Palette Set Up
# Interested in using Viridis - plasma palette
# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html

# Example discrete palette:
pal_pf <- c("#d695ef", "#ff7cd8",  "#ff42c1",	"#6696fd", 	"#6b41e8")


# Problem Forward Theme
theme_pf <- function(base_size=10, font=NA){

  txt <- element_text(size = base_size, colour = "black", face = "plain", family = "Roboto")
  bold_txt <- element_text(size = base_size, colour = "black", face = "bold", family = "Roboto")

  theme_minimal(base_size = base_size, base_family = font) +
  theme(
      legend.key = element_blank(),
      strip.background = element_blank(),

      # text basics

      text = txt,
      plot.title = txt,

      axis.title = txt,
      axis.text = txt,

      legend.title = bold_txt,
      legend.text = txt ) +

    # Axes
    theme(

      # axis.line.y = element_line(colour = "pink", size = 1, linetype = "dashed"),
      # axis.line.x = element_line(colour = "pink", size = 1.2,linetype = "dashed"),
      #### remove Tick marks
      # axis.ticks = element_blank()

      ### legend  top and no title!
      # legend.position = "top",
      # legend.title = element_blank(),
      # legend.key = element_rect(fill = "lightskyblue1", color = "lightskyblue1"),
      # legend.background = element_rect( fill = "lightskyblue1",color = "pink", size = 0.5,linetype = "longdash"),

      ## background
      # plot.background = element_rect(fill = "lightskyblue1",colour = "pink",size = 0.5, linetype = "longdash")
    )
}

## Logo

logo <- readPNG(source = "images/smalllogo_test.png")
annotation_custom(rasterGrob(logo, interpolate=TRUE),
                  xmin=0.95*min(mtcars$mpg)-1, xmax=0.95*min(mtcars$mpg)+1,
                  ymin=0.62*min(mtcars$wt)-0.5, ymax=0.62*min(mtcars$wt)+0.5)
gt <- ggplot_gtable(ggplot_build(gg))
gt$layout$clip[gt$layout$name=="panel"] <- "off"
grid.draw(gt)

##
## Examples
##

# Plots created under mtcars

# Scatterplot Example
example1 <- ggplot(mtcars, aes(wt, mpg, color=cyl)) +
  geom_point() +
  theme_pf()
example1


# Chart #2
windowsFonts(F = windowsFont('Comic Sans MS'))

p <- ggplot(ddd[1:5,], aes(reorder(Industry, -m), m, color=Industry, fill=Industry)) + geom_point(size=4, shape="O")
p+ theme_unicorn(base_size = 12,font="F") +scale_color_discrete_unicorn()+scale_fill_unicorn() + ylab("Mean Valuation")+ xlab("Industries")


# Chart #3

p <- ggplot(d4, aes(N, m)) + geom_point(size=2, shape=1, color="Pink")
p<- p + theme_unicorn(base_size = 10,font="F")  +xlab("")+ ylab("Mean Valuation") + xlab("Number of Unicorns")
p <- p + annotation_custom(g, xmin=30, xmax=35, ymin=10, ymax=12)
p <- p + annotate(geom="text", x=3.5, y=12, label="Transportation", color="lightblue" , family=F)
p <- p + annotate(geom="text", x=12, y=11.5, label="On Demand", color="lightblue")
p <- p + annotate(geom="text", x=34, y=4, label="Ecommerce", color="lightblue")
p
