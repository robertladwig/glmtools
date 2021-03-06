% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_var_df.R
\name{plot_var_df}
\alias{plot_var_df}
\title{Plot variables from a data frame}
\usage{
plot_var_df(
  data,
  var_name,
  interpolate = F,
  fig_path = NULL,
  legend.title = var_name,
  text.size = 12,
  show.legend = TRUE,
  legend.position = "right",
  plot.title = NULL,
  color.palette = "RdYlBu",
  color.direction = -1,
  reference = "surface",
  zlim = NULL,
  ...
)
}
\arguments{
\item{data}{a dataframe directly from GLM output or field data. First column must be date/dateTime (Date or POSIXct format). 
Second column is depth. Subsequent columns are variable data. Format can be wide or long. If long format, can support multiple variables.}

\item{var_name}{a character vector of the variable names}

\item{interpolate}{Logical; FALSE = do not inteprolate data. TRUE = Interpolate data to daily timestep and 1 m depth interval}

\item{fig_path}{Default is NULL (only plots to screen). Enter string path to save as output file. File type can be anything supported by \code{\link[ggplot2:ggsave]{ggplot2:ggsave}}. See examples.}

\item{legend.title}{Vector string; Default (`NULL`) will use variable and units from netcdf file}

\item{text.size}{Integer; Default is 12. Higher values will increase text size in plot.}

\item{show.legend}{Logical; TRUE to show legend (default), FALSE to hide legend}

\item{legend.position}{String; Legend position. Default is 'right'. Options: 'left','right','top','bottom'}

\item{plot.title}{Vector string; Default is no title.}

\item{color.palette}{See \code{\link[ggplot2:scale_color_distiller]{ggplot2:scale_color_distiller}} . If a string, will use that named palette. Default is 'RdYlBu'. If a number, will index into the list of palettes of appropriate. 
Palettes available include: Diverging:
BrBG, PiYG, PRGn, PuOr, RdBu, RdGy, RdYlBu, RdYlGn. Spectral. Qualitative: Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, Set3. Sequential:
Blues, BuGn, BuPu, GnBu, Greens, Greys, Oranges, OrRd, PuBu, PuBuGn, PuRd, Purples, RdPu, Reds, YlGn, YlGnBu, YlOrBr, YlOrRd.}

\item{color.direction}{Sets the order of colors in the scale. If 1, colors are as output by brewer.pal. If -1, the order of colors is reversed (default).}

\item{reference}{String; 'surface' or 'bottom'. surface = Depths are referenced from the surface, bottom = Depths are referenced from the bottom (elevations)}

\item{zlim}{Color palette limits for z-variable. Default is maximum range of variable. Set as c(value,value).}

\item{...}{additional arguments passed to \code{\link[ggplot2:ggsave]{ggplot2:ggsave}}}
}
\description{
Plot variables from a data frame
}
\note{
\code{plot_var} uses the \code{\link[graphics]{layout}} function and so is restricted to a full page display.
When creating a heatmap, the output produced by \code{plot_var} is actually a combination of two plots; 
one is a \code{\link[graphics]{.filled.contour}} plot and the other is a legend.
}
\examples{
nc_file <- system.file("extdata", "output.nc", package = "glmtools")
data = get_var(nc_file,'temp', reference = 'surface') 
plot_var_df(data, var_name = 'temp', interpolate = FALSE, legend.title = 'Temp (degC)')
\dontrun{
#Saving plot
plot_var_df(data, var_name = 'temp',fig_path = '~/figtest.png', width = 6, height = 2, units = 'in')

# need to specify a valid .nc file here: 
plot_var(file = fabm_sim_nc.nc,
var_name = 'aed_oxygen_oxy', 
fig_path = 'aed_out.png')
}
}
\seealso{
\code{\link{get_var}}, \code{\link{sim_var_longname}}, 
\code{\link{sim_vars}}, \code{\link{plot_var}}
}
\author{
Jordan S. Read, Luke A. Winslow, Hilary A. Dugan
}
\keyword{methods}
