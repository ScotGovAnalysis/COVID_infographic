################################################################################
################################################################################
# Deaths Involving Coronavirus (Covid-19) In Scotland - Infographic
# Author: Joseph Adams
# Email: joseph.adams@nrscotland.gov.uk
################################################################################
################################################################################

# Load libraries
library(readxl)
library(ggplot2)
library(dplyr)
library(tidyr)

source("NRS style.R")

# Read data
data_death <- read_excel("Copy of Infographic data week 50.xlsx", 
                        sheet = "deaths") %>%
  filter(week >= 12)

data_age <- read_excel("Copy of Infographic data week 50.xlsx", 
                         sheet = "age") %>%
  filter(week >= 12) %>%
  mutate(deaths_other = deaths_all - deaths_covid) %>%
  gather(key = "deaths_type", value = "count",
         -c(week, age_group, deaths_all, deaths_5_year_avg))


# Plot 1 - deaths per week involving Covid-19 -----------------------------
plot_1 <- ggplot(data = data_death) +
  geom_col(mapping = aes(x = week,
                         y = deaths),
           col = col_neut_white,
           fill = col_deaths) +
  scale_x_continuous(breaks = seq(min(data_death[["week"]]), max(data_death[["week"]]), 2)) +
  geom_text(
    mapping = aes(x = week,
                  y = deaths / 2,
                  label = deaths),
    family = nrs_font,
    colour = col_neut_white
  ) +
  theme_info() +
  theme(
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  ) 


# Plot 2 - 2020 deaths by age ---------------------------------------------

# stops axis being decimal source: 
# https://stackoverflow.com/questions/42588238/setting-individual-y-axis-limits-with-facet-wrap-not-with-scales-free-y
data_age <- data.table::data.table(data_age)
data_age[,y_min:= count*0.5, by = age_group]
data_age[,y_max:= count*1.5, by = age_group] 

plot_2 <- ggplot(data = data_age) +
  geom_area(mapping = aes(x = week,
                          y = count,
                          fill = deaths_type)) +
  geom_line(mapping = aes(x = week,
                          y = deaths_5_year_avg),
            size = 1.2,
            linetype = 'longdash') +
  scale_fill_manual(values = c(col_deaths, col_neut_silver)) +
  scale_x_continuous(name="Week number",
                     breaks = c(seq(from = min(data_age[["week"]]),
                                  to = max(data_age[["week"]]),
                                  by = 4), 50)) +
  facet_wrap(~ age_group, ncol = 2, scales = "free_y"
             ) +
  geom_blank(aes(y = y_min)) + # stops axis being decimal see line 55
  geom_blank(aes(y = y_max)) + # stops axis being decimal see line 55
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
plot_2

# Save plots --------------------------------------------------------------

ggplot2::ggsave(plot = plot_1,
                file = "plot_1.svg",
                width = 165,
                height = 80,
                units = "mm")

ggplot2::ggsave(plot = plot_2,
                file = "plot_2.svg",
                width = 152,
                height = 159,
                units = "mm")

