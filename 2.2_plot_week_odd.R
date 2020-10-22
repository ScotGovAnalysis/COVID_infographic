# Load libraries

library(readxl)
library(ggplot2)



#Load in data

data_fig1 <- read_excel("Data_Wk41.xlsx", 
                        sheet = "fig1", col_types = c("numeric", 
                                                      "numeric"))

data_fig2 <- read_excel("Data_Wk41.xlsx", 
                        sheet = "fig2", col_types = c("text", 
                                                      "numeric", "numeric", "numeric", 
                                                      "numeric", "numeric"))

# Draw plots

plot_fig1 <- ggplot(data = data_fig1) +
  geom_col(mapping = aes(x = week,
                         y = pweek),
           col = col_neut_white,
           fill = col_deaths) +
  scale_x_continuous(breaks=c(12 : 41)) +
  geom_text(mapping = aes(x = week,
                          y = pweek/2,
                          label = pweek),
            family = nrs_font,
            colour = col_neut_white) +
  theme_info() +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

plot_fig2 <- ggplot(data = data_fig2) +
  geom_area(mapping = aes(x = week,
                          y = total),
            fill = col_deaths) +
  geom_area(mapping = aes(x = week,
                          y = other),
            fill = col_neut_silver) +
  geom_line(mapping = aes(x = week,
                          y = av),
            size = 1.2,
            linetype = 'longdash') +
  scale_x_continuous(name="Week number", limits = c(12, 41), breaks = c(12 : 41)) +
  facet_wrap(~ type, ncol = 1) +
  theme(
    
    # Declutter
    strip.background =  ggplot2::element_blank(),
    panel.background = ggplot2::element_blank(),
    legend.position = 'none',
    axis.line = ggplot2::element_blank(),
    axis.title = ggplot2::element_blank(),
    
    #Text
    text = ggplot2::element_text(family = nrs_font),
    plot.title = element_text(hjust = 0, size = info_axis_text_size_large),
    axis.text = element_text(size = info_axis_text_size_small),
    strip.text.x = element_blank(),
    
    # Margin
    plot.margin = unit(c(0,0,0,0), 'npc'),
    panel.spacing = unit(0.1, 'npc')
  )

# Export infographic images

ggplot2::ggsave(plot = plot_fig1,
                file = "C19_fig1.svg",
                width = 168,
                height = 80,
                units = "mm")

ggplot2::ggsave(plot = plot_fig2,
                file = "C19_fig2.svg",
                width = 125,
                height = 210,
                units = "mm")

# Twitter image

ggplot2::ggsave(plot = plot_fig1,
                file = "C19_tweet1.svg",
                width = 241,
                height = 79,
                units = "mm")

