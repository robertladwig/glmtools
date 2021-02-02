## ----setup, include=FALSE---------------------------------
library(rmarkdown)
options(continue=" ")
options(width=60)
library(knitr)


## ---- eval=FALSE------------------------------------------
#  install.packages("glmtools",
#      repos = c("http://owi.usgs.gov/R"),
#      dependencies = TRUE)

## ---- eval=FALSE------------------------------------------
#  library(devtools)
#  install_github(repo = 'GLEON/GLM3r')

## ---------------------------------------------------------
library(glmtools)
GLM3r_folder = system.file('extdata', package = 'GLM3r')
glmtools_folder = system.file('extdata', package = 'glmtools')

## ---------------------------------------------------------
dir(GLM3r_folder)
dir(glmtools_folder)

## ---- eval=FALSE------------------------------------------
#  glm_version()

## ---------------------------------------------------------
citation('GLM3r')

## ---- eval=FALSE------------------------------------------
#  source("http://owi.usgs.gov/R/add_gran_repo.R")
#  update.packages()

## ---- eval=FALSE------------------------------------------
#  update.packages(repos = c("http://owi.usgs.gov/R"))

## ---- results ='hide'-------------------------------------
run_glm(sim_folder = GLM3r_folder)

## ---------------------------------------------------------
dir(GLM3r_folder)

## ---- eval =FALSE-----------------------------------------
#  run_glm('~/Documents/my_sim')

## ---------------------------------------------------------
eg_nml <- read_nml(nml_file = file.path(glmtools_folder,'glm3.nml'))

## ---------------------------------------------------------
eg_nml

## ---------------------------------------------------------
class(eg_nml)
names(eg_nml)
eg_nml[[1]][1:4]

## ---------------------------------------------------------
# water clarity
get_nml_value(eg_nml, 'Kw')

## ---------------------------------------------------------
# initial conditions for depths
get_nml_value(eg_nml, 'the_depths')

## ---------------------------------------------------------
# water clarity
eg_nml <- set_nml(eg_nml, 'Kw', 1.4)
# note how the value is now changed:
get_nml_value(eg_nml, 'Kw')

## ---------------------------------------------------------
eg_nml <- set_nml(eg_nml, arg_list = list('Kw' = 1.2, 'max_layers' = 480))
get_nml_value(eg_nml, 'max_layers')

## ---- eval=F----------------------------------------------
#  # define a location for the file to be written to. Here it will overwrite the existing `nml` file:
#  write_path <- file.path(GLM3r_folder,'glm3.nml')
#  write_nml(eg_nml, file = write_path)

## ---- eval=F----------------------------------------------
#  run_glm(GLM3r_folder)

## ---- fig.width=6, fig.height=2.5, results = 'hide', fig.keep='first'----
nc_file <- file.path(GLM3r_folder, 'output/output.nc')
plot_var(nc_file = nc_file, var_name = 'temp')

## ---- fig.width=6, fig.height=5, results = 'hide', fig.keep='first'----
sim_vars(file = nc_file)
plot_var(nc_file = nc_file, var_name = c('temp','u_mean'))

## ---- eval = T--------------------------------------------
# sim_folder <- run_example_sim(verbose = FALSE)
nc_file <- file.path(glmtools_folder, 'output.nc')
field_file <- file.path(glmtools_folder, 'LakeMendota_field_data_hours.csv')

## ---- eval = T--------------------------------------------
thermo_values <- compare_to_field(nc_file, field_file,
                          metric = 'thermo.depth', as_value = TRUE)

## ---- eval = T--------------------------------------------
temp_rmse <- compare_to_field(nc_file, field_file,
                          metric = 'water.temperature', as_value = FALSE)
print(paste(temp_rmse,'deg C RMSE'))

## ---- fig.width=6, fig.height=5.25, eval = T, results = 'hide', fig.keep='first'----
plot_var_compare(nc_file, field_file, precision = 'hours', var_name = 'temp') ## makes a plot!

## ---- fig.width=6, fig.height=5.25, eval = T, results = 'hide', fig.keep='first'----
plot_var_compare(nc_file, field_file, var_name = 'temp',interval = 2, precision = 'hours', 
                 legend.title = 'Temp degC',text.size = 14,obs.color = 'black',obs.shape = 17,
                 zlim = c(0,40),color.palette = 'BrBG') 

## ---- fig.width=4, fig.height=3.5, eval = F---------------
#  field_file <- file.path(glmtools_folder, 'LakeMendota_stage_USGS05428000.csv')
#  
#  plot_compare_stage(nc_file, field_file) ##makes a plot!

