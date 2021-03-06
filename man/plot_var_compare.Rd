% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_var_compare.R
\name{plot_var_compare}
\alias{plot_var_compare}
\title{Plot matching heatmaps for modeled and observed temp}
\usage{
plot_var_compare(
  nc_file,
  field_file,
  var_name = "temp",
  fig_path = NULL,
  resample = TRUE,
  precision = "hours",
  conversion = NULL,
  legend.title = NULL,
  interval = 1,
  method = "match",
  text.size = 12,
  color.palette = "RdYlBu",
  color.direction = -1,
  obs.color = "white",
  obs.alpha = 0.6,
  obs.shape = 16,
  obs.size = 1,
  shiftPalette = NULL,
  zlim = NULL,
  ...
)
}
\arguments{
\item{nc_file}{Netcdf model output file}

\item{field_file}{CSV or TSV field data file (see \link{resample_to_field} for format)}

\item{var_name}{a character vector of valid variable names (see \code{\link{sim_vars}})}

\item{fig_path}{Default is NULL (only plots to screen). Enter string path to save as output file. File type can be anything supported by \code{\link[ggplot2:ggsave]{ggplot2:ggsave}}. See examples.}

\item{resample}{sample the model output to the same time points as the observations?}

\item{precision}{the time interval of the output.nc file and the field file must match (options: 'secs', 'mins','hours', or 'days')}

\item{conversion}{conversion multiplier to adjust model output to field data units}

\item{legend.title}{Vector string; Default (`NULL`) will use variable and units from netcdf file}

\item{interval}{Positive number indicating the depth interval in meters to interpolate output data. Must be less than max depth of lake. Default = 0.5 m.}

\item{method}{String; 'match' for exact match or 'interp' for temporal interpolation}

\item{text.size}{Integer; Default is 12. Higher values will increase text size in plot.}

\item{color.palette}{See: \code{ggplot2:scale_color_distiller}. If a string, will use that named palette. Default is 'RdYlBu'. If a number, will index into the list of palettes of appropriate. 
Palettes available include: Diverging:
BrBG, PiYG, PRGn, PuOr, RdBu, RdGy, RdYlBu, RdYlGn. Spectral. Qualitative: Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, Set3. Sequential:
Blues, BuGn, BuPu, GnBu, Greens, Greys, Oranges, OrRd, PuBu, PuBuGn, PuRd, Purples, RdPu, Reds, YlGn, YlGnBu, YlOrBr, YlOrRd.}

\item{color.direction}{Sets the order of colors in the scale. If 1, colors are as output by brewer.pal. If -1, the order of colors is reversed (default).}

\item{obs.color}{Color of observation points. For options see: vignette("ggplot2-specs")}

\item{obs.alpha}{Alpha transparency of observation points. If set to 0, no points will appear. For options see: vignette("ggplot2-specs")}

\item{obs.shape}{Shape of observation points. For options see: vignette("ggplot2-specs")}

\item{obs.size}{Size of observation points. For options see: \code{vignette("ggplot2-specs", package = 'ggplot2')}}

\item{shiftPalette}{See values argument in: \code{ggplot2:scale_color_distiller}. Default is c(0,1). To shift pallete lower. Use c(0,0.2,1).}

\item{zlim}{Color palette limits for z-variable. Default is maximum range of variable. Set as c(value,value).}

\item{\dots}{additional arguments passed to \code{ggsave()}}
}
\description{
Plot matching heatmaps for modeled and observed temp
}
\examples{
nc_file <- system.file("extdata", "output.nc", package = "glmtools")
field_file <- system.file("extdata", "LakeMendota_field_data_hours.csv", package = "glmtools")

plot_var_compare(nc_file, field_file, 'temp', resample = FALSE) ##makes a plot

\dontrun{
#Change color palette, custom legend title, save figure:
plot_var_compare(nc_file, field_file, var_name = 'temp', resample = TRUE, 
legend.title = 'Temp (*C)', color.palette = 'PuBuGn', color.direction = 1,
fig_path = './figtest.png', width = 6, height = 8, units = 'in')
}

}
\seealso{
Internally uses \link{get_var} and \link{resample_to_field}
}
\author{
Jordan S. Read, Luke A. Winslow, Hilary A. Dugan
}
