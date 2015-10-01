#Install dplyr
library(dplyr)
# select filter group_by summarize mutate 5 funçoes do pacote dplyr
# filter para linha e select para columns
# pipe é um operador que encadeia funçoes 

gapminder <- read.csv("data/gapminder.csv")

#pipe operator %>%   Ele serve para 
#ctrl+shift+m


gm_europe_gdp <- gapminder %>%
  filter(continent=="Europe") %>%
  select (year, country,gdpPercap)
View(gm_europe_gdp)

#Challenge write a single command (which can span multiple lines and includes pipes)
#that will produce a dataframe that 

#filter and select
gm_africa_gdp <- gapminder %>%
  filter(continent=="Africa") %>%
  select (year, country,gdpPercap)
View(gm_africa_gdp)

#gruped_by

gapmider_grouped <- gapminder %>%
  group_by(continent)
gapmider_grouped

## summarize

gapminder_mean_gdp <- gapminder %>%
  group_by(continent) %>%
  summarize(mean_gdpPercap = mean(gdpPercap))
View(gapminder_mean_gdp)


#Challenge 2 calculate the average life exp per country. 
#which had the longest life exp and which had the shortest?

gapminder_mean_lifeExp <- gapminder %>%
  group_by(country) %>%
  summarize(mean_lifeExp = mean(lifeExp))
View (gapminder_mean_lifeExp)