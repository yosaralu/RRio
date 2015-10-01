
# Using dplyr -------------------------------------------------------------

#Install dplyr (Alethia)
library(dplyr)
# This package has five functions: select, filter, group_by, summarize, mutate 
# filter para linha e select para columns
# pipe é um operador que encadeia funçoes 

gapminder <- read.csv("data/gapminder.csv")
library(dplyr)
#pipe operator %>%   
#ctrl+shift+m

#filter and select

gm_europe_gdp <- gapminder %>%
  filter(continent=="Europe") %>%
  select (year, country, gdpPercap)
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
  summarize(mean_lifeExp = mean(lifeExp)) %>%
  arrange(mean_lifeExp)
View (gapminder_mean_lifeExp) 

#ordered from the highest to the lower
gapminder_mean_lifeExp <- gapminder %>%
  group_by(country) %>%
  summarize(mean_lifeExp = mean(lifeExp)) %>%
  arrange(desc(mean_lifeExp)) ###arrange(desc())
View (gapminder_mean_lifeExp)

gdp_continent_year <- gapminder %>% 
  group_by(continent, year) %>% 
  summarize(mean_gdpPercap = mean(gdpPercap))
View (gdp_continent_year)

# It is possible to add more statistic calculation

gdp_continent_year <- gapminder %>% 
  group_by(continent, year) %>% 
  summarize(mean_gdpPercap = mean(gdpPercap), sd_gdpPercap = sd(gdpPercap))
View (gdp_continent_year)

head(gdp_continent_year)

#Mutate() add a new column inside a pipe

gdp_pop_millions <- gapminder %>% 
  mutate(pop_millions = pop/10^6)
View(gdp_pop_millions)


#Challenge 3 Calculate the average lifeexp in 2002 
# of 2 randomly selected countries for each continent
# then arrange the continent names in reverse order .
# Hint: use the dplyr functions arrange () and sample_n()
# they have similar syntanx to other dplyr functions

#gapminder_mean_lifeExp_2002 <-
  
gapminder_mean_lifeExp_2002 <- set.seed(1) #adding this function I made the result from randomization be the same
  gapminder %>% 
  filter(year == 2002) %>% 
  group_by(continent) %>% 
  sample_n(2) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% 
  arrange(desc(mean_lifeExp))
  #arrange(desc(continent))
 
  
#  How to organize data sets? ---------------------------------------------


# Tidying data with tidyr -------------------------------------------------
library(tidyr)
gap_wide <- read.csv(file="cleaned_data/gap_wide.csv")
View(gap_wide)
head(gap_wide)

#gather all of the stuff
gap_long <- gather(gap_wide, obstype_year, obs_values, -continent, -country)
  
head(gap_long)

#what we need to do now is to separate the values

gap_long_sep <- separate(gap_long, obstype_year, into = c("obstype", "year"), sep = "_") 
head(gap_long_sep)

#look at the structure
str(gap_long_sep)

#year is still a character, so I have to change that
gap_long_sep$year <- as.numeric(gap_long_sep$year)

#look at the structure again
str(gap_long_sep)

# Challenge: using gap_long calculate the mean life exp, 
# population and gdpPercap for each continent. Hint: use the group_by()
# and summarize () fucntions we learned in the dplyr lesson

gap_long_sep %>%
  group_by(continent, obstype) %>%
  summarize(mean_obs = mean(obs_values))



gap_long_sep %>%
  group_by(continent, country, obstype) %>%
 summarize(mean_obs = mean(obs_values))

## put observation into columns
# when groups are not unique I made the unique by making a new column
## simple example of tidyr operations



exemplo <- data.frame(grp = c("a","a","b","b"),
                      foo = c(1,2,3,4),
                      bar = c(5,6,7,8))
exemplo
gather(exemplo, key = "variable", value = "value", foo:bar)  ## would work for 3rd column
## also by *excluding* a column
gather(exemplo, key="variable", value = "value", grp)

comprido <- gather(exemplo, key="variable", value = "value", -grp)
comprido

gordo <- spread(comprido[-1], key = variable, value = value)

comprido %>% 
  group_by(grp, variable) %>% 
  mutate(new_name = seq_along(value)) %>% 
  spread(variable, value)

exemplo

# CHALLENGE 3

## part a
## calculate the mean population size for each countries and (within continents)
## 


pop_means <- gapminder %>% 
group_by(continent, country) %>% 
  summarize(meanpop = mean(pop))

pop_means

## make acolumn for each country, and a row for each continent
### ADVANCED fill in missing values with 0

spread(pop_means, country, meanpop)
pop_countries <- spread(pop_means, country, meanpop)
View(pop_countries)
#?spread
#spread(data, key, value, fill = NA, convert = FALSE, drop = TRUE)
pop_countries <- spread(pop_means, country, meanpop, fill = 0)
View(pop_countries)
