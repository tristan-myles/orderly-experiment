# *============================ Plot theme (kinda) ============================*
library(ggplot2)
library(ggtext)
library(tidyverse)

# *--------------------------------- Colours ----------------------------------*
# Brand colours from here:
# https://www.imperial.ac.uk/brand-style-guide/visual-identity/brand-colours/
# Haven't really looked into whether this meets the requirements for an
# accesible (e.g. colour blindness) colour palette
# *----------------------------------------------------------------------------*
imperial_navy <- rgb(0, 33/256, 71/256)
imperial_grey <- rgb(235/256, 238/256, 238/256)
imperial_blue <- rgb(0, 62/256, 116/256)
imperial_light_blue <- rgb(212/256, 239/256, 252/256)
imperial_light_blue_custom <- rgb(140/256, 220/256, 245/256)

tangerine <- rgb(236/256, 115/256, 0)
lime <- rgb(196/256, 214/256, 0)
kermit_green <- rgb(102/256, 164/256, 10/256)
dark_green <- rgb(2/256, 137/256, 59/256)
lemon_yellow <- rgb(255/256, 216/256, 1/256)
raspberry <- rgb(145/256, 0, 72/256)

# *-------------------------------- Example 1 ---------------------------------*
x <- seq(as.Date("2010-01-01"), as.Date("2011-12-31"), by="days")
y1 <- rnorm(NROW(x))
y2 <- rnorm(NROW(x), mean = 3)
y3 <- rnorm(NROW(x), mean = -3)

df <- data.frame(x=x, y1=y1, y2=y2, y3=y3)

df %>% write.csv("data.csv")

random <- df %>%
    pivot_longer(cols=c(y1, y2, y3)) %>%
    ggplot(aes(x=x, y=value, colour=name)) +
    geom_line() +
    scale_y_continuous(limits = c(-8,8), breaks = seq(-6,6, by=6),
                       expand=c(0,0)) +
    scale_color_manual(name="Some random lines",
                       labels = c(bquote(mu~"= -3"),
                                  bquote(mu~"= 0"),
                                  bquote(mu~"= 3")),
                       values = c(y2=dark_green,
                                  y1=imperial_blue,
                                  y3=tangerine)) +
    labs(title = "This is a title", subtitle = "This is a smaller title",
         x = "Date", y = "Value") +
    # neat way to scale dates (which can be annoying when they're long)
    scale_x_date(date_breaks = "6 months" , date_labels = "%Y-%m",
                 limits = c(min(x), as.Date("2012-06-01")),
                 # use expand to start at exact dates
                 expand=c(0, 0)) +
    # NB that this is before the part below. If you put it after, it will
    # overwrite the custom changes. Basic idea is to use them_bw and update it.
    theme_bw() +
    # This next part is the "theme".
    # Text family to match your theme text makes the plots fit in better (imo)!
    theme(text=element_text(family="Lato thin"),
          # custom legend position
          legend.position=c(.915,.5),
          legend.title=element_text(size=8, family="Lato"),
          legend.text=element_text(size=7, family="Lato"),
          legend.key.size = unit(0.4, "cm"),
          legend.background = element_rect(colour = imperial_grey, size=0.4,
                                           fill = 'white', linetype='solid'),
          panel.grid.major=element_line(colour=imperial_grey, linewidth=0.3),
          panel.grid.minor=element_line(colour=imperial_grey, linewidth=0.3),
          panel.border = element_blank(),
          axis.line = element_line(color = 'black'),
          plot.title = element_markdown(size=15, hjust=0.5, face="bold"),
          plot.subtitle = element_markdown(hjust=0.5, face="bold"),
          axis.text.x = element_text(size = 12, face = "bold"),
          axis.title.x = element_text(size = 14, face = "bold"),
          axis.text.y = element_text(size = 12, face = "bold"),
          axis.title.y = element_text(size = 14, face = "bold"))

# If you use a custom font family and export as a pdf then it might display
# weirdly if you open it on a PC without that font. Without going into too much
# detail, using device=cairo_pdf should help with this.
ggsave("random_lines.pdf",
       height=1080, width=1980, units="px", dpi=200,
       random, device=cairo_pdf)
# *============================================================================*
