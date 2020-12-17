
# Create charts for poverty publication - both, interactive and non-interactive versions

library(tidyverse)
library(labelled)
library(ggrepel)
library(ggiraph)

source("R/00_functions.R")
source("R/00_colours.R")
source("R/06_prepcharts_poverty.R")

povertycharts <- list()

# Theme ----

mytheme <- theme_grey() +
  theme(text = element_text(colour = SGgreys[1], size = 14),

        line = element_line(colour = SGgreys[1],
                            linetype = 1,
                            lineend = 2,
                            size = 0.5),

        plot.title = element_text(hjust = 0, colour = SGgreys[1]),
        plot.subtitle = element_text(hjust = 0, colour = SGgreys[1]),
        plot.caption = element_text(hjust = 1),

        legend.position = "top",
        legend.title = element_blank(),

        panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),

        axis.line.x = element_line(),
        axis.ticks.length = unit(2, "pt"),
        axis.ticks.y = element_blank(),

        axis.title = element_blank(),
        axis.text.y = element_blank())

theme_set(mytheme)

# Key trends ----

# chart0a ----
data <- mutate(povertychartdata[["relpov"]], value = pprate) %>%
  filter(key == "After housing costs")

povertycharts[["chart0a"]] <- linechart_small(data) +
  addscales()

saveplot("website/chart0a.png")

# chart0b ----
data <- mutate(povertychartdata[["palma"]],
               value = Palma,
               key = "Before housing costs")

povertycharts[["chart0b"]] <- linechart_small(data,
                                              yrange = c(0.6, 1.7),
                                              col = SGblue2) +
  addscales()

saveplot("website/chart0b.png")

# chart0c ----
data <- mutate(povertychartdata[["medians"]],
               value = pp,
               text = comma(value, 1, prefix = "£")) %>%
  filter(key == "Before housing costs")

povertycharts[["chart0c"]] <- linechart_small(data,
                                              yrange = c(250, 600),
                                              GBP = TRUE,
                                              col = SGblue2) +
  addscales()

saveplot("website/chart0c.png")

# Poverty ----

## chart01 rel pov pp ----
data <- mutate(povertychartdata[["relpov"]], value = pprate)

povertycharts[["chart01"]] <- linechart(data, up = -0.1) +
  scale_y_continuous(limits = c(0.05, 0.35)) +
  addscales() +
  addsource() +
  addlabels() +
  addnames(up = c(-0.04, +0.03))

## chart02 abs pov pp ----
data <- mutate(povertychartdata[["abspov"]], value = pprate)

povertycharts[["chart02"]] <- linechart(data, up = 0.15) +
  scale_y_continuous(limits = c(0.13, 0.6)) +
  addnames(up = c(-0.18, +0.035)) +
  addscales() +
  addsource() +
  addlabels()

## chart03 food poverty pp ----

## chart04 rel pov wa ----
data <- mutate(povertychartdata[["relpov"]], value = warate)

povertycharts[["chart04"]] <- linechart(data, up = -0.1) +
  scale_y_continuous(limits = c(0.05, 0.35)) +
  addnames(up = c(-0.04, 0.05)) +
  addscales() +
  addsource() +
  addlabels()

## chart05 abs pov wa ----
data <- mutate(povertychartdata[["abspov"]], value = warate)

povertycharts[["chart05"]] <- linechart(data, up = 0.1) +
  scale_y_continuous(limits = c(0.1, 0.57)) +
  addnames(up = c(-0.13, +0.04)) +
  addscales() +
  addsource() +
  addlabels()

## chart06 work pov wa ----
data <- mutate(povertychartdata[["workpov"]], value = wacomp) %>%
  filter(groupingvar == "Someone in paid work")

povertycharts[["chart06"]] <- linechart(data, up = 0.3) +
  scale_y_continuous(limits = c(0.3, 0.75)) +
  addnames(up = c(-0.06, 0.09)) +
  addscales() +
  addsource() +
  addlabels()

## chart07 rel pov pn ----
data <- mutate(povertychartdata[["relpov"]], value = pnrate)

povertycharts[["chart07"]] <- linechart(data, up = -0.05) +
  scale_y_continuous(limits = c(0.1, 0.4)) +
  addnames(up = c(-0.11, 0.03)) +
  addscales() +
  addsource() +
  addlabels()

## chart08 abs pov pn ----
data <- mutate(povertychartdata[["abspov"]], value = pnrate)

povertycharts[["chart08"]] <- linechart(data, up = 0.11) +
  scale_y_continuous(limits = c(0.11, 0.58)) +
  addnames(up = c(0.035, -0.27)) +
  addscales() +
  addsource() +
  addlabels()

## chart09 dep pn ----
data <- mutate(povertychartdata[["pndep"]],
               value = pnrate, key = "After housing costs")

povertycharts[["chart09"]] <- linechart(data, recession = FALSE) +
  scale_y_continuous(limits = c(0, 0.3)) +
  addscales() +
  addsource() +
  addlabels()

# Child poverty ----

# chart10 rel pov ch ----
data <- mutate(povertychartdata[["relpov"]], value = chrate)

povertycharts[["chart10"]] <- linechart(data, up = -0.05) +
  scale_y_continuous(limits = c(0.1, 0.4)) +
  addscales() +
  addsource() +
  addlabels() +
  addnames(up = c(-0.05, +0.03))

# chart11 abs pov ch ----
data <- mutate(povertychartdata[["abspov"]], value = chrate)

povertycharts[["chart11"]] <- linechart(data, up = 0.07) +
  scale_y_continuous(limits = c(0.06, 0.53)) +
  addnames(up = c(-0.2, 0.03)) +
  addscales() +
  addsource() +
  addlabels()

# chart12 mat dep ch ----
data <- mutate(povertychartdata[["cmd"]], value = chrate)

povertycharts[["chart12"]] <- linechart(data, recession = FALSE) +
  scale_y_continuous(limits = c(0, 0.45)) +
  addscales() +
  addlabels() +
  geom_vline(aes(xintercept = 18),
             colour = SGgreys[3],
             alpha = 0.9) +
  annotate("text",
           label = "Methodology \nchange",
           size = 3,
           colour = SGgreys[2],
           x = 18.2,
           y = 0.45,
           hjust = 0,
           vjust = 1) +
  addnames(up = c(0.06, -0.07)) +
  addsource()

# chart13 work pov ch ----
data <- mutate(povertychartdata[["workpov"]], value = chcomp) %>%
  filter(groupingvar == "Someone in paid work")

povertycharts[["chart13"]] <- linechart(data, up = 0.3) +
  scale_y_continuous(limits = c(0.3, 0.75)) +
  addnames(up = c(-0.07, 0.07)) +
  addscales() +
  addsource() +
  addlabels()

# chart14 food pov ch ----

# chart15 priority ch ----
data <- povertychartdata[["priority"]] %>%
  filter(!is.na(chrate)) %>%
  mutate(value = chrate,
         key = factor(groupingvar,
                      levels = c("All children",
                                 "In household with disabled person(s)",
                                 "3 or more children",
                                 "Youngest child is younger than 1",
                                 "Single parent in household",
                                 "Minority ethnic")))

povertycharts[["chart15"]] <- barchart(filter(data, povvar == "low60ahc"))

# chart16 priority ch ----
povertycharts[["chart16"]] <- barchart(filter(data, povvar == "abspovahc"))

# chart17 priority ch ----
povertycharts[["chart17"]] <- barchart(filter(data, povvar == "cmdahc"))

# Equality -----

## chart18 age ----
data <- povertychartdata[["age"]] %>%
  mutate(value = adrate,
         key = groupingvar) %>%
  filter(groupingvar != "All",
         groupingvar != "(Missing)") %>%
  ungroup()

povertycharts[["chart18"]] <- linechart(data, recession = FALSE) +
  scale_y_continuous(limits = c(0.05, 0.35)) +
  addscales() +
  addsource() +
  scale_x_discrete(drop = FALSE,
                   breaks = c("1994-97", "", "", "",
                              "", "", "2000-03", "",
                              "", "", "", "",
                              "2006-09", "", "", "",
                              "", "", "2012-15", "",
                              "", "", "2016-19"),
                   expand = c(0.3, 0)) +
  geom_text_repel(data = filter(data, min(data$years) == as.character(data$years)),
                  mapping = aes(label = str_c(key, ": ", percent(value, 1))),
                  direction = "y",
                  nudge_x = -1,
                  hjust = 1,
                  show.legend = FALSE,
                  segment.colour = NA) +
  geom_text_repel(data = filter(data, years == levels(periods)[length(periods) - 2]),
                  mapping = aes(label = str_c(percent(value, 1), " (", key, ")")),
                  direction = "y",
                  nudge_x = 1,
                  hjust = 0,
                  show.legend = FALSE,
                  segment.colour = NA)

## chart19 gender wa ----
data <- povertychartdata[["gender"]] %>%
  ungroup() %>%
  filter(groupingvar %in% c("Female working-age adult, no dependent children",
                            "Male working-age adult, no dependent children",
                            "Female working-age adult with dependent children")) %>%
  mutate(value = adrate,
         key = factor(groupingvar,
                      levels = c("Female working-age adult, no dependent children",
                                 "Male working-age adult, no dependent children",
                                 "Female working-age adult with dependent children"),
                      labels = c("Single woman, no children",
                                 "Single man, no children",
                                 "Single mother")) )

povertycharts[["chart19"]] <- linechart(data, recession = FALSE) +
  scale_y_continuous(limits = c(0.18, 0.68)) +
  addscales() +
  addsource() +
  addlabels() +
  addnames(up = c(0.05, -0.05, 0.03))

## chart20 gender pn ----
data <- povertychartdata[["gender"]] %>%
  ungroup() %>%
  filter(groupingvar %in% c("Male pensioner",
                            "Female pensioner")) %>%
  mutate(value = adrate,
         key = factor(groupingvar,
                      levels = c("Male pensioner",
                                 "Female pensioner"),
                      labels = c("Single male pensioner",
                                 "Single female pensioner")))

povertycharts[["chart20"]] <- linechart(data, recession = FALSE) +
  scale_y_continuous(limits = c(0.1, 0.6)) +
  addscales() +
  addsource() +
  addlabels() +
  addnames(up = c(-0.14, 0.04))

## chart21 marital ----
data <- povertychartdata[["marital"]] %>%
  ungroup() %>%
  filter(groupingvar != "All") %>%
  mutate(value = adrate,
         key = groupingvar,
         key = case_when(key == "Divorced / Civil Partnership dissolved / separated" ~ "Divorced",
                         key == "Married / Civil Partnership" ~ "Married",
                         TRUE ~ as.character(key)))

povertycharts[["chart21"]] <- linechart(data, recession = FALSE) +
  scale_x_discrete(drop = FALSE,
                   breaks = c("1994-97", "", "", "",
                              "", "", "2000-03", "",
                              "", "", "", "",
                              "2006-09", "", "", "",
                              "", "", "2012-15", "",
                              "", "", "2016-19"),
                   expand = c(0.3, 0)) +
  scale_y_continuous(limits = c(0.05, 0.5)) +
  addscales() +
  addsource() +
  geom_text_repel(data = filter(data, min(data$years) == as.character(data$years)),
                  mapping = aes(label = str_c(key, ": ", percent(value, 1))),
                  direction = "y",
                  nudge_x = -1,
                  hjust = 1,
                  show.legend = FALSE,
                  segment.colour = NA) +
  geom_text_repel(data = filter(data, years == levels(periods)[length(periods) - 2]),
                  mapping = aes(label = str_c(percent(value, 1), " (", key, ")")),
                  direction = "y",
                  nudge_x = 1,
                  hjust = 0,
                  show.legend = FALSE,
                  segment.colour = NA)

## chart22 ethnic ----

data <- povertychartdata[["ethnic"]] %>%
  mutate(value = pprate,
         key = groupingvar)

povertycharts[["chart22"]] <- barchart(data)

## chart23 religion ----

data <- povertychartdata[["religion"]] %>%
  mutate(value = adrate,
         key = groupingvar)

povertycharts[["chart23"]] <- barchart(data)

## chart24 disability ----
data <- povertychartdata[["disability"]] %>%
  ungroup() %>%
  filter(groupingvar != "All") %>%
  mutate(value = adrate,
         key = groupingvar)

povertycharts[["chart24"]] <- linechart(data, recession = FALSE) +
  disabilitybreaks() +
  scale_y_continuous(limits = c(0.1, 0.4)) +
  addscales() +
  addsource() +
  addlabels() +
  addnames(up = c(-0.07, 0.07))

## chart25 disability2 ----
data <- povertychartdata[["disability2"]] %>%
  ungroup() %>%
  filter(groupingvar != "All") %>%
  mutate(value = adrate,
         key = groupingvar)

povertycharts[["chart25"]] <- linechart(data, recession = FALSE) +
  scale_y_continuous(limits = c(0.1, 0.4)) +
  addscales() +
  disabilitybreaks() +
  addsource() +
  addlabels() +
  addnames(up = c(-0.06, -0.05))

# Income inequality ----

## chart26 palma ----
data <- mutate(povertychartdata[["palma"]], value = Palma)

povertycharts[["chart26"]] <- linechart(data, up = 1.15) +
  scale_y_continuous(limits = c(0.9, 1.6)) +
  addscales() +
  addsource() +
  addlabels() +
  addnames(up = c(-0.06, 0.26))

## chart27 gini ----
data <- mutate(povertychartdata[["gini"]], value = Gini)

povertycharts[["chart27"]] <- linechart(data, up = -0.07) +
  scale_y_continuous(limits = c(0.27, 0.38)) +
  addscales() +
  addsource() +
  addlabels() +
  addnames(up = c(-0.01, 0.035))

# Income ----

## chart28 medians ----
data <- mutate(povertychartdata[["medians"]],
               value = pp,
               text = stringi::stri_enc_toutf8(comma(value, 1, prefix = "£")))

povertycharts[["chart28"]] <- linechart(data, up = 599.55, GBP = TRUE) +
  scale_y_continuous(limits = c(250, 600)) +
  addscales() +
  addsource() +
  addlabels(GBP = TRUE) +
  addnames(up = c(110, -30))

## chart29 deciles ----
data <- povertychartdata[["deciles"]] %>%
  tail(4L) %>%
  gather(key, value, -years) %>%
  filter(key != "100%") %>%
  mutate(text = stringi::stri_escape_unicode(str_c(comma(value, prefix = "£"), " (", years, ")")))

povertycharts[["chart29"]] <- ggplot(data,
                                     aes(x = key,
                                         y = value,
                                         fill = years,
                                         group = years)) +

  geom_bar_interactive(aes(tooltip = text,
                           data_id = key),
           position = 'dodge',
           colour = "white",
           stat = "identity") +

  scale_fill_manual(values = rev(SGblues)) +

  scale_x_discrete(labels = c("1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th"),
                   expand = c(0.1, 0.1)) +

  scale_y_continuous(labels = comma_format(prefix = "£")) +

  theme(axis.line.y = element_line(),
        axis.text.y = element_text(hjust = 1,
                                   margin = margin(0, 3, 0, 0, "pt")),
        axis.ticks.length = unit(2, "pt"),
        axis.ticks.y = element_line(),
        axis.title = element_blank()) +

  addsource()

## chart30 distribution ----
decilepoints <- povertychartdata[["deciles"]] %>%
  filter(years == max(levels(periods))) %>%
  select(-years) %>%
  gather(key, value) %>%
  mutate(xpos = lag(value) + 1/2*(value - lag(value)),
         xpos = ifelse(is.na(xpos), value/2, xpos),
         xpos = ifelse(key == "100%", (lag(value) + 100), xpos))

data <- mutate(povertychartdata[["distribution"]],
               value = gs_newpp,
               Scotmedian = decilepoints$value[5],
               UKmedian = povertychartdata[["UKdeciles"]]$value[5],
               povthresh = 0.6*UKmedian) %>%
  filter(income > 0,
         income < 1200)

povertycharts[["chart30"]] <- ggplot(data,
       aes(x = income, weight = value)) +

  geom_density(colour = NA,
               fill = SGmix[1],
               adjust = 1/2) +

  scale_x_continuous(labels = comma_format(prefix = "£"),
                     breaks = c(seq(0, 1200, 200)),
                     expand = c(0.1, 0.1),
                     limits = c(0,1200)) +

  annotate("rect", fill = "white", alpha = 0.4,
           xmin = 0,
           xmax = decilepoints$value[1],
           ymin = -Inf,
           ymax = +Inf) +

  annotate("rect", fill = "white", alpha = 0.4,
           xmin = decilepoints$value[2],
           xmax = decilepoints$value[3],
           ymin = -Inf, ymax = +Inf) +

  annotate("rect", fill = "white", alpha = 0.4,
           xmin = decilepoints$value[4],
           xmax = decilepoints$value[5],
           ymin = -Inf, ymax = +Inf) +

  annotate("rect", fill = "white", alpha = 0.4,
           xmin = decilepoints$value[6],
           xmax = decilepoints$value[7],
           ymin = -Inf, ymax = +Inf) +

  annotate("rect", fill = "white", alpha = 0.4,
           xmin = decilepoints$value[8],
           xmax = decilepoints$value[9],
           ymin = -Inf, ymax = +Inf) +

  geom_text(data = decilepoints,
            aes(x = xpos, y = 1700, label = c(seq("1", "10"))),
            colour = SGgreys[5],
            fontface = "bold") +

  geom_vline(aes(xintercept = povthresh),
             colour = SGgreys[4],
             linetype = "dashed") +

  geom_vline(aes(xintercept = UKmedian),
             colour = SGgreys[4],
             linetype = "dashed") +

  annotate("text", x = 280, y = 2.5E4,
           label = str_c("Poverty threshold: ",
                         comma(data$povthresh[1],
                               prefix = "£",
                               accuracy = 1)),
           colour = SGgreys[2],
           size = 3,
           hjust = 1) +

  annotate("text", x = 570, y = 2.5E4,
           label = str_c("Median income: ",
                         comma(data$UKmedian[1],
                               prefix = "£",
                               accuracy = 1)),
           colour = SGgreys[2],
           size = 3,
           hjust = 0) +

  addsource()


## chart31 sources ----
data <- povertychartdata[["sources"]] %>%
  gather(key, value, -decbhc) %>%
  filter(decbhc != "All") %>%
  mutate(key = case_when(key == "earnings" ~ "Earnings",
                         key == "benefits" ~ "Social security",
                         key == "occpens" ~ "Occupational pensions",
                         key == "investments" ~ "Investments",
                         key == "other" ~ "Other"),
         key = factor(key, levels = c("Earnings",
                                      "Investments",
                                      "Occupational pensions",
                                      "Other",
                                      "Social security")),
         text = str_c(key, ": ",
                      percent(value,1)))

povertycharts[["chart31"]] <- ggplot(data, aes(x = decbhc,
                 y = value,
                 fill = key,
                 width = 1)) +

  geom_bar_interactive(aes(tooltip = text,
                           data_id = key),
                       position = "fill",
                       stat = "identity",
                       colour = "white") +

  scale_fill_manual(values = SGmix) +

  scale_y_continuous(labels = percent_format(1)) +
  scale_x_discrete(breaks = c(seq(1, 10, 1)),
                     labels = c("1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th"),
                     expand = c(0.05, 0.05)) +

  theme(axis.line = element_line(),
        axis.text.y = element_text(hjust = 1,
                                   margin = margin(0, 3, 0, 0, "pt")),
        axis.title.y = element_text(hjust = 0.5),
        axis.ticks.length = unit(2, "pt"),
        axis.ticks.y = element_line(),
        legend.position = c(0.75, 0.72)) +

  ylab("Proportion of income") +
  addsource()


# Child poverty update ----

## chartcp1 ----

## chartcp2 ----

## chartcp3 ----

## chartcp4 ----

# remove(periods, SGblue, SGblue2, SGblues, SGgreys, SGmix, SGoranges, yearsno)