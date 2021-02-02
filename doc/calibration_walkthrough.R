## ----setup, include=FALSE---------------------------------
library(rmarkdown)
options(continue=" ")
options(width=60)
library(knitr)
library(glmtools)
library(GLM3r)
knitr::opts_knit$set(root.dir = tempdir())

## ---------------------------------------------------------
library(glmtools)
GLM3r_folder = system.file('extdata', package = 'GLM3r')
glmtools_folder = system.file('extdata', package = 'glmtools')

## ---------------------------------------------------------
dir(GLM3r_folder)
dir(glmtools_folder)

## ---- results = 'hide'------------------------------------
example.files <- dir(glmtools_folder)
temp_folder <<- tempdir()

file.copy(list.files(glmtools_folder,full.names = T), temp_folder, overwrite = TRUE)


## ---------------------------------------------------------
dir(temp_folder)

## ---------------------------------------------------------
out_file <- file.path(temp_folder, 'output/output.nc')
field_data <- file.path(temp_folder, 'LakeMendota_field_data_hours.csv')
file.copy('glm3_uncalibrated.nml', 'glm3.nml', overwrite = TRUE)
nml_data <- file.path(temp_folder, 'glm3.nml')

## ---- results = 'hide'------------------------------------
GLM3r::run_glm(sim_folder = temp_folder)

## ---- results = 'hide', fig.keep='first', fig.width = 6----
plot_var_nc(out_file, var_name = 'temp')

## ---- results = 'hide', fig.keep='first', fig.width = 6----
plot_var_compare(nc_file = out_file, field_file = field_data,var_name = 'temp', precision = 'hours')

## ---- fig.keep='first', fig.width = 6---------------------
temp_rmse <- compare_to_field(out_file, field_file = field_data,
                              metric = 'water.temperature', as_value = FALSE, precision= 'hours')

print(paste('Total time period (uncalibrated):',round(temp_rmse,2),'deg C RMSE'))

## ---- warning = F-----------------------------------------
var = 'temp'         # variable to which we apply the calibration procedure
path = getwd()       # simulation path/folder
# obs = read_field_obs(field_data)  # observed field data
nml.file = nml_data  # path of the nml configuration file
calib_setup = get_calib_setup() # create a setup of variables for calibration
glmcmd = NULL        # command to be used, default applies the GLM3r function
# Optional variables
first.attempt = TRUE # if TRUE, deletes all local csv-files that stores the 
#outcome of previous calibration runs
period = get_calib_periods(nml = nml_data, ratio = 1) # define a period for the calibration, 
# thissupports a split-sample calibration (e.g. calibration and validation period)
scaling = TRUE       # scaling of the variables in a space of [0,10]; TRUE for CMA-ES
method = 'CMA-ES'    # optimization method, choose either `CMA-ES` or `Nelder-Mead`
metric = 'RMSE'      # objective function to be minimized, here the root-mean square error
target.fit = 1.0     # refers to a target fit of 1.0 degrees Celsius
target.iter = 100    # refers to a maximum run of 100 calibration iterations
plotting = FALSE      # if TRUE, script will automatically save the contour plots
output = out_file    # path of the output file
field.file = field_data # path of the field data

# main calibration function
calibrate_sim(var, path, field.file, nml.file, calib_setup, glmcmd, first.attempt, period, scaling, method, metric, target.fit, target.iter, plotting, output)


