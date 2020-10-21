# READ ME #####################################################################
# AUTHOR:            joseph.adams@nrscotland.gov.uk
# PURPOSE OF SCRIPT: Read and clean data for RGAR Infographic booklet, 2018.
# CONTACTS:          Julie Ramsay, Denise Patrick, Sandy Taylor
# SOURCES:           ???
# NOTES:             ---
###############################################################################

###############################################################################
# 0. LOAD LIBRARIES ###########################################################
###############################################################################
library(readxl)
library(dplyr)
library(tidyr)
library(stringr)
library(scales)
library(here)

library(ggplot2)
library(cowplot)
library(scales)
library(RColorBrewer)

###############################################################################
# 2. CREATE PLOTTING VARIABLES ################################################
###############################################################################

# 1.1 ALL PLOTS SHOULD USE THE SEGOE UI FONT ##################################
if (.Platform[["OS.type"]] == "windows") {
  windowsFonts(`Segoe UI` = windowsFont("Segoe UI"))
}

nrs_font <- "Segoe UI"

# Neutral colours
col_neut_black <- "#000000"
col_neut_tundora <- "#4B4B4B"
col_neut_grey <- "#808080"
col_neut_silver <- "#b9b9b9"
col_neut_white <- "#FFFFFF"
# Household colours
col_house <- "#5C7B1E"
col_house_dark <- "#496218"
col_house_light <- "#ADBD8E"
# Population colours
col_pop <- "#2DA197"
col_pop_dark <- "#248078"
col_pop_light <- "#96D0CB"
# Births colours
col_births <- '#2E8ACA'
col_births_dark <- '#246EA1'
col_births_light <- '#81B8Df'
# Deaths colours
col_deaths <- "#284F99"
col_deaths_dark <- "#203F7A"
col_deaths_light <- "#93A7CC"
# Life expectancy colours
col_life_exp <- "#6566AE"
col_life_exp_dark <- "#50518B"
col_life_exp_light <- "#B2B2D6"
# Migration colours
col_mig <- "#90278E"
col_mig_dark <- "#731F71"
col_mig_light <- "#C793C6"
# Marriage and electoral colours
col_marri <- "#C9347C"
col_marri_dark <- "#A02963"
col_marri_light <- "#E499BD"
# Adoptions colours
col_adopt <- "#EE6214"
col_adopt_dark <- '#BE4E10'
col_adopt_light <- 'F6B089'

# 1.2 TURN OFF SCIENTIFIC NOTATION ############################################
options(scipen = 999)

# 1.3.1 DEFINE PLOTTING VARIABLES FOR BOOKLET##################################
rgar_axis_text_size_large <- 17.7
rgar_axis_text_size_small <- 11.25

rgar_line_size_large <- 1.8
rgar_line_size_medium <- 1.375
rgar_line_size_small <- 0.95
rgar_line_size_xsmall <- 0.5

rgar_text_size_small <- 5
rgar_text_size_medium <- 6
rgar_text_size_large <- 7

rgar_col_size <- 1.5
rgar_col_width_large <- 0.7
rgar_col_width_small <- 0.5

linetype_annotation_small <- info_line_type <- "12"
linetype_annotation_large <- "dashed"

geom_point_rgar <- function(...) {
  ggplot2::geom_point(..., shape = 21, size = 2.65, stroke = 1)
}

life_exp_lower_limit <- 65

rgar_plot_grid_middle_height <- 0.5

tweet_width <- 220.9
tweet_height <- 81.7

#1.3.2 DEFINE PLOTTING VARIABLES FOR INFOGRAPHICS

info_line_size <- 1.4

info_text_size <- 3.5

info_col_size <- 1.5
info_col_width <- 0.7

info_point_shape <- 21
info_point_size <- 2
info_point_stroke <- 0.5

info_axis_text_size_large <- 13
info_axis_text_size_small <- 10

# 1.4.1 DEFINE RGAR BOOKLET THEME ###############################################
theme_rgar <- function() {
  ggplot2::theme(
    # Declutter
    strip.background = ggplot2::element_blank(),
    panel.background = ggplot2::element_blank(),
    legend.position = "none",
    axis.line = ggplot2::element_blank(),
    axis.title = ggplot2::element_blank(),
    axis.ticks = element_blank(),
    
    # Text
    text = ggplot2::element_text(family = nrs_font),
    plot.title = element_text(hjust = 0, size = rgar_axis_text_size_large),
    axis.text = element_text(size = rgar_axis_text_size_small),
    strip.text.x = element_blank(),
    
    # Margin
    plot.margin = unit(c(0, 0, 0, 0), "npc"),
    panel.spacing = unit(0.1, "npc")
  )
}

# 1.4.2 DEFINE INFOGRAPHIC THEME ################################################
theme_info <- function() {
  ggplot2::theme(
    # Declutter
    strip.background =  ggplot2::element_blank(),
    panel.background = ggplot2::element_blank(),
    legend.position = 'none',
    axis.line = ggplot2::element_blank(),
    axis.title = ggplot2::element_blank(),
    axis.ticks = element_blank(),
    
    #Text
    text = ggplot2::element_text(family = nrs_font),
    plot.title = element_text(hjust = 0, size = info_axis_text_size_large),
    axis.text = element_text(size = info_axis_text_size_small),
    strip.text.x = element_blank(),
    
    # Margin
    plot.margin = unit(c(0,0,0,0), 'npc'),
    panel.spacing = unit(0.1, 'npc')
   )
}

###############################################################################
# END OF SCRIPT ###############################################################
###############################################################################