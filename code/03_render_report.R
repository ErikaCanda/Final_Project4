here::i_am("code/03_render_report.R")

WHICH_CONFIG <- Sys.getenv("WHICH_CONFIG")
config_list <- config::get(
  config = WHICH_CONFIG
)

library(rmarkdown)
report_filename <- paste0(
  "report/final_report_config_",
  WHICH_CONFIG,
  ".html"
)

render("final_report.Rmd",
       output_file = report_filename)
