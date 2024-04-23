FROM rocker/r-ubuntu as base

#Creating project directory 

RUN mkdir final_project
WORKDIR /final_project

RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/setting.json

RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE renv/.cache

RUN R -e "renv::restore()"

#Adding programs 

FROM rocker/r-ubuntu
RUN apt-get update
RUN apt-get install -y pandoc


WORKDIR /final_project
COPY --from=base /final_project .

# Creating organizational structure 

Run mkdir output
Run mkdir data
Run mkdir code
Run mkdir report 

COPY data data
COPY code code
COPY Makefile .
COPY final_report.Rmd .
COPY config.yml .

# Making the report and moving it to the shared folder 

CMD make

