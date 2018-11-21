##
## Example plots
##

library(ggplot2)
library(hrbrthemes)
# library(theme_pf)

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

example5 <- ggplot(gcookbook::uspopage, aes(x=Year, y=Thousands, fill = AgeGroup)) +
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
