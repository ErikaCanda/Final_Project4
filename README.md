# Code Description

`code/00_clean_data.R`
- Reads raw data from `data/PAASIM_2019.xlsx` and `data/PAASIM_2020.xlsx`
- Cleans the data, combines both data sets to into one, and saves it as `output/data_clean.rds` in the `output/` folder

`code/01_make_table1.R`
- Reads cleaned data from `output/data_clean.rds`
- Generates Table 1 and saves it as `output/table_one.rds` in the `output/` folder

`code/02_make_barplot.R`
- Reads cleaned data from `output/data_clean.rds`
- Generates a bar plot and saves it as `output/barplot.png` in the `output/` folder

`code/03_render_report.R`
- Renders the R Markdown report `project4_report.Rmd`
- Saves the compiled report as `output/project4_report.config_default.html` in the `report/` folder

`project4_report.Rmd`
- Reads data, tables, and figures from the `output/` folder
- Displays results for the production report

## Instructions for Generating the Final Report

1. Ensure that the required raw data files `PAASIM_2019.xlsx` and `PAASIM_2020.xlsx` are located in the `data/` folder.
2. Run the following scripts in sequence:
   - `code/00_clean_data.R` to clean the data, stack the data and generate `output/data_clean.rds`
   - `code/01_make_table1.R` to generate Table 1 and save it as `output/table_one.rds`
   - `code/02_make_barplot.R` to generate the bar plot and save it as `output/barplot.png`
   - `code/03_render_report.R` to render the R Markdown report and save the compiled report as `output/project4_report.config_default.html`
3. Once the all og the scripts have been executed, the final report will be available in the `report/` folder as `project4_report.config_default.html`.
```