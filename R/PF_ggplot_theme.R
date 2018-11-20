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
libraries <- c("ggplot2", "ggthemes", "dplyr", "reshape2", "grid", "lubridate", "stringr", "viridis", "extrafont", "png", "devtools", "hrbrthemes", "gcookbook")
suppressPackageStartupMessages(
  lapply(libraries,
         require, character.only = TRUE)
  )

# Install hrbrthemes
devtools::install_github("hrbrmstr/hrbrthemes", force = TRUE)

options(stringsAsFactors = FALSE)

# Font setup
hrbrthemes::import_roboto_condensed()
d <- read.csv(extrafont:::fonttable_file(), stringsAsFactors = FALSE)
d[grepl("Light", d$FontName),]$FamilyName <- font_rc_light
write.csv(d,extrafont:::fonttable_file(), row.names = FALSE)
loadfonts()

# Palette Set Up
# Interested in using Viridis - plasma palette
# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html

# Problem with using function: requires discrete = true for discrete scales....

# Example discrete palette:
pal_pf <- c("#d695ef", "#ff7cd8",  "#ff42c1",	"#6696fd", 	"#6b41e8")




# Problem Forward Theme
theme_pf <- function(base_size=10, font=NA, discrete = TRUE, grid = "XY"){
  list(theme_ipsum_rc(
    base_size = base_size,
    base_family = font,
    grid = grid),
       labs(caption="Brought to you by Problem Forward"),
       # Color scales
       scale_fill_viridis(option = "plasma",
                          end = 0.8,
                          discrete = discrete),
       scale_colour_viridis(option = "plasma",
                            end = 0.8,
                            discrete = discrete)
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

           ### legend  top and no title!
           # legend.position = "top",
           # legend.title = element_blank(),
           # legend.key = element_rect(fill = "lightskyblue1", color = "lightskyblue1"),
           # legend.background = element_rect( fill = "lightskyblue1",color = "pink", size = 0.5,linetype = "longdash"),

           ## background
           # plot.background = element_rect(fill = "lightskyblue1",colour = "pink",size = 0.5, linetype = "longdash")
        # ),

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

##
## Scatterplot Example
##

example1 <- ggplot(mtcars, aes(mpg, wt)) +
  geom_point(aes(color=factor(carb))) +
  labs(x="Fuel efficiency (mpg)", y="Weight (tons)",
       title="Seminal ggplot2 scatterplot example",
       subtitle="A plot that is only useful for demonstration purposes")
example1

# With PF theme
example1_pf <- example1 +
  theme_pf()

example1_pf

##
## Multi-scatter plot example
##

example2 <- ggplot(mpg, aes(displ, hwy)) +
  geom_jitter(aes(color=class, fill=class), size=3, shape=21, alpha=1/2) +
  scale_x_continuous(expand=c(0,0), limits=c(1, 8), breaks=1:8) +
  scale_y_continuous(expand=c(0,0), limits=c(10, 50)) +
  facet_wrap(~class, scales="free") +
  labs(
    title="Seminal ggplot2 multi-scatterplot example",
    subtitle="This is a subtitle"
    )

# Without PF theme
example2 +
  theme(legend.position="none")

# With PF theme
example2_pf <- example2 +
  theme_pf() +
  theme(legend.position="none")

example2_pf

##
## Column example 1
##

example3 <-count(mpg, class) %>%
  mutate(pct=n/sum(n)) %>%
  ggplot(aes(class, pct, fill = class)) +
  geom_col() +
  scale_y_percent() +
  theme(legend.position="none") +
  labs(x="Fuel efficiency (mpg)", y="Weight (tons)",
       title="Seminal ggplot2 column chart example with percents",
       subtitle="A plot that is only useful for demonstration purposes")

example3

example3_pf <- example3 +
  theme_pf(grid = "Y") +
  theme(legend.position="none")

example3_pf

##
## Column Example 2
##

example4 <- count(mpg, class) %>%
  mutate(n=n*2000) %>%
  arrange(n) %>%
  mutate(class=factor(class, levels=class)) %>%
  ggplot(aes(class, n)) +
  geom_col() +
  geom_text(aes(label=scales::comma(n)), hjust=0, nudge_y=2000) +
  scale_y_comma(limits=c(0,150000)) +
  coord_flip() +
  labs(x="Fuel efficiency (mpg)", y="Weight (tons)",
       title="Seminal ggplot2 column chart example with commas",
       subtitle="A plot that is only useful for demonstration purposes, esp since you'd never\nreally want direct labels and axis labels")

example4

example4_pf <- example4 +
  theme_pf(grid = "X")

example4_pf

##
## Area chart
##

example5 <- ggplot(uspopage, aes(x=Year, y=Thousands, fill = AgeGroup)) +
  geom_area() +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_comma() +
  labs(title="Age distribution of population in the U.S., 1900-2002",
       subtitle="Example data from the R Graphics Cookbook") +
  theme(axis.text.x=element_text(hjust=c(0, 0.5, 0.5, 0.5, 1))) +
  theme(legend.position="bottom")

example5

example5_pf <- example5 +
  theme_pf() +
  theme(legend.position="bottom")

example5_pf
