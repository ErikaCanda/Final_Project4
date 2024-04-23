# Report-associated rukes 

final_report.config_default.html: code/03_render_report.R\
	final_report.Rmd descriptive_analysis
	Rscript code/03_render_report.R

output/data_clean.rds: code/00_clean_data.R data/PAASIM_2019.xlsx data/PAASIM_2020.xlsx
	Rscript code/00_clean_data.R
	
output/table_one.rds: code/01_make_table1.R output/data_clean.rds
	Rscript code/01_make_table1.R
	
output/barplot.png: code/02_make_barplot.R output/data_clean.rds
	Rscript code/02_make_barplot.R

. PHONY: descriptive_analysis
descriptive_analysis:	output/table_one.rds output/barplot.png

	
.PHONY: clean	
clean: 
	rm -f output/*.rds
	rm -f output/*.png
	rm -f *.html
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"
	
# Docker associated rules (for our local machine)
PROJECTFILES = final_report.Rmd code/02_make_barplot.R code/03_render_report.R Makefile
RENVFILES = renv.lock renv/activate.R renv/settings.json

#Rule to build locally image in the container 
project_image: dockerfile $(PROJECTFILES) $(RENVFILES) 
	docker build -t final_project3 .
	touch $@ 


# Rule to build report automatically in the container
report/final_report.html: 
	docker run -v "$$(pwd)"/report:/final_project/report erikacanda/final_image 
	