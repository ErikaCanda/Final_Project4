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
3. Use the make final_report.htm command to run all of the scripts and the final report will be available in the `report/` folder as `project4_report.config_default.html`.

# Generating the report

Use the command: make final_report.html

# Intructions for Building the Docker Image

1. Open Docker on your computer.
2. Clone this repository to your local machine in the directory you plan to work from:
   git clone https://github.com/your-username/nam-of-repository.git
3. To make the image in your local container use the command: make project_image
4. To run the report use the command: docker run -v "$$(pwd)/report":/final_project/report final_project3 

# Intructions for Building an Automated report using docker hub

Link to docker image: https://hub.docker.com/r/erikacanda/final_image/tags 

1. For mac users run the command: make macreport/final_report.html
2. For windows usersrun the command: make windowsreport/final_report.html


