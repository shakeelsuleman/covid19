library(utils)
library(httr)
library(ggplot2)
library(gganimate)
library(readxl)

GET("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", authenticate(":", ":", type="ntlm"), write_disk(tf <- tempfile(fileext = ".csv")))
#read the Dataset sheet into “R”. The dataset will be called "data".
data <- read.csv(tf)

data$dates<- as.Date(data$dateRep, "%d/%m/%Y")


uk<- ggplot(data = subset(data, countriesAndTerritories == "United_Kingdom" ), aes(x = dates, y = cases_weekly)) +
  geom_line(size = 2, color = "red")

uk<- uk + labs(title = "Date:{frame_along}")

uk + transition_reveal(dates)

world<- ggplot(data = data, aes(x = dates, y = cases_weekly, fill = countriesAndTerritories)) +
  geom_col(show.legend = FALSE)

world<- world + labs(title = "Country:{closest_state}")

##download.file("https://fingertips.phe.org.uk/documents/Historic%20COVID-19%20Dashboard%20Data.xlsx", "cov.xlsx", mode = "wb")

##dh<- read_xlsx("cov.xlsx", sheet = 3, skip = 6)
######







