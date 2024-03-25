library (ggplot2)
library(janitor)
library(tidyr)

here::i_am("code/02_make_barplot.R")

stacked_data <- readRDS(file = here::here("output/data_clean.rds"))

#Creating barplot looking at the distribution of education level by FIPAG Water connection status

subset_stacked <- stacked_data %>% 
  drop_na(c(`FIPAG water connection`,`Education level`))


barplot <- ggplot(subset_stacked, aes(x = `FIPAG water connection`, fill = `Education level`)) +
  geom_bar(position = "fill") + 
  theme_bw() +                  
  labs(x = "FIPAG water connection", y = "Proportion of households") +  # Add axis labels (optional)
  scale_fill_discrete(name = "Education level")  + # Customize fill legend title (optional)
  scale_fill_manual(values= c("No/Incomplete primary education" = "#f1b6da",
                              "Primary education or some secondary education" = "#c2a5cf",
                              "Secondary education or higher" = "#5e3c99",
                              "NA" ="#bababa"))

ggsave(
  here::here("output/bar_plot.png"), 
  plot = barplot, 
  device = "png"  
)

