## R course day 2
## 29 Sept 2015
# prova no git
#It is important to mention wHAT PACKAGES i AM GOING TO USE

# load packages -----------------------------------------------------------
## here I need to charge "stringi" to make ggplot2 work properly 
# stingi facilitates the way R reads information

library(ggplot2)

# load gapminder data -----------------------------------------------------

gapminder <- read.csv("data/gapminder.csv")



# Load functions ----------------------------------------------------------

source("scripts/Functions.R")

#../ is used to use up folders

# subsetting review -------------------------------------------------------
#methods of subsetting

#X[a] for vectors
x<-c(10:1)
x
x[3]

#x[a,b] for dataframes, matrices, not lists

x<-list(c(1:10), c(10:20))
x
x[1,2] # this does not work for lists, this is reason why: Error in x[1, 2] : incorrect number of dimensions

#x["a"]or x["a",]
x<- c(1:10)
names(x) <- letters[1:10]
x
x["b"]

#x[[a]] for lists and dataframes
x<-list(c(1:10), c(10:20))
x
x[[1]]

#x$a
names(x) <- c("one", "two")
x
x$two


## more complex subsetting

# > , < , == , <= , =>

gapminder[gapminder$country == "Brazil", ]

x <- c(1:10)
x
x[x>7]
x[x<3]

# %in% 
x <- c(1:10)
names(x) <- letters[1:10]
x
x==c(4,5,6) #this does not work

x[x %in% c(4,5,6)] # so you need to use this operator

x[names(x) %in% c("d", "e", "f")]

x[x %in% c(4,5,6)]


#CHALLENGE 1

#Extract observations collected for the year 1957

gapminder[gapminder$year == 1957, ]

#Extract columns except 1 through to 4

gapminder[,-(1:4)]

gapminder[-(1:4)]# this is because dataframe are also like matrices, at the same time as lists

#Extract the rows where the life expectancy is longer the 80 years

gapminder[gapminder$lifeExp > 80, ]

head(gapminder)

#Extract the first row, and the fouth and fifth columns (lifeExp and gdPercap)

gapminder[1,c(4,6)]
gapminder[1,c("lifeExp", "pop")]

#Advanced: extract rows that contain years from 2002 to 2007
#incorrect
gm<-gapminder[gapminder$year == 2002|2007,]
gm
gm$year

g1<-gapminder[gapminder$year == 2002,]
g2<-gapminder[gapminder$year == 2007,]
rbind(g1,g2)

gm2 <- gapminder[gapminder$year == 2002 | gapminder$year == 2007,]
head(gm2)
gm2$year

gapminder$year %in% c(2002,2007)

gm3 <- gapminder[gapminder$year %in% c(2002,2007),]
gm3



#plotting

library(ggplot2)


#color by continent
ggplot(data=gapminder, aes(x= lifeExp, y=gdpPercap), colour = continent) +
  geom_point()

ggplot(data=gapminder, aes(x= lifeExp, y=gdpPercap), colour = continent) +
  geom_point() + 
  geom_line()

ggplot(data=gapminder, aes(x= lifeExp, y=gdpPercap), colour = continent, group = country) +
  geom_point() + 
  geom_line()

##points of top of lines

ggplot(data=gapminder, aes(x= year, y=pop, colour = continent, group = country)) +
  geom_line()  +
  geom_point(colour="black")  +
  scale_y_log10() 

#life expectancy and GDP
ggplot(data = gapminder, aes(x = lifeExp, y=gdpPercap))+ geom_point()

#GDP over time
ggplot(data = gapminder, aes(x = year, y=gdpPercap))+ geom_point()

## colour by country
ggplot(data = gapminder, aes(x = year, 
                             y=lifeExp))+ 
  geom_line(aes(colour=country))+
  geom_point(color="blue")
##switch the order

ggplot(data = gapminder, aes(x = year, 
                             y=lifeExp))+ 
  geom_point(color="blue")+
  geom_line(aes(colour=country))

## transformations and statistics

ggplot(gapminder, aes(x= lifeExp, y= gdpPercap,color = continent)) +
  geom_point()+
  scale_y_log10()+
  stat_smooth(method = "lm")

gm90 <- gapminder[gapminder$year > 1990,]
head(gm90)

ggplot(gm90, aes(x= lifeExp, y= gdpPercap)) +
  geom_point()+
  scale_y_log10()+
  stat_smooth(method = "lm")+
  facet_grid(continent~year, scales = "free")


ggplot(gm90, aes(x= year, y= gdpPercap, color = lifeExp)) +
  geom_point()+
  scale_y_log10()+
  stat_smooth(method = "lm")+
  facet_wrap(~continent, scales = "free")


#Challenge modify the color and size of the points on the point layer 
#do not use aes function

ggplot(data = gapminder, aes(x= lifeExp, y=gdpPercap)) +
  geom_point(color="green", size = 8)  + scale_y_log10() + 
  geom_smooth(method="lm", size=1.5)

ggplot(data = gapminder, aes(x= lifeExp, y=gdpPercap, color = country)) +
  geom_point(color="green", size = 8)  + scale_y_log10() + 
  geom_smooth(method="lm", size=1.5)

ggplot(data = gapminder, aes(x= lifeExp, y=gdpPercap)) +
  geom_point(color="black", size = 8, alpha=0.1)  + scale_y_log10() + 
  geom_smooth(method="lm", size=1.5)


#challenge 
#CrEATE A DENSITY plot of GDP per capita, filled by continent.
#advanced: transform the x axis to better visualise the data spread
#Add a facet layer to panel the density plots by year

dens <- ggplot(data = gapminder, aes(x = gdpPercap, color = continent)) +
  scale_x_log10()

#dens <- ggplot(gapminder, aes(x = gdpPercap, color = country)) + scale_x_log10() 
#with country does not work because is onl one data and histogram does not work with one column

desnplot <- dens+geom_density()

desnplot +
  facet_wrap(~year)


#density plot
ggplot(dat=gapminder, aes(x=gdpPercap)) + geom_density()

ggplot(dat=gapminder, aes(x=gdpPercap, color=continent)) + geom_density()

ggplot(dat=gapminder, aes(x=gdpPercap, fill=continent)) + geom_density()

ggplot(dat=gapminder, aes(x=gdpPercap, color=continent)) + geom_density() + facet_wrap(~year)

ggplot(dat=gapminder, aes(x=gdpPercap, fill=continent)) + geom_density() + facet_wrap(~year)

ggplot(dat=gapminder, aes(x=gdpPercap, fill=continent)) + 
  geom_density() + facet_wrap(~year) + scale_x_log10()

ggplot(dat=gapminder, aes(x=gdpPercap, fill=continent)) + 
  geom_density(alpha=0.5) + facet_wrap(~year) + scale_x_log10() #alpha is to make it transparent
  
#to change color and tabs titles go to scales in the site

#add tittles and change the name of the scales

ggplot(dat=gapminder, aes(x=gdpPercap, fill=continent)) + 
  geom_density(alpha=0.5) + facet_wrap(~year) + scale_x_log10()+ ggtitle("GDP density")+
  ylab("GDP density") +
  xlab("GDP") +
  labs(fills="Continent")

ggplot(dat=gapminder, aes(x=gdpPercap, fill=continent)) + 
  geom_density(alpha=0.5) + facet_wrap(~year) + scale_x_log10()+ ggtitle("GDP density")+
  ylab("GDP density") +
  xlab("GDP") +
  scale_fill_manual(values = c("red", "blue", "green", "yellow")) 

#saving a plot 
ggsave("figures/density_plot.pdf")
ggsave("figures/density_plot.jpg")


pdf(file="figures/density_plot.pdf")
ggplot(data = gapminder, aes(x= lifeExp, y=gdpPercap)) +
  geom_point(color="green", size = 8)  + scale_y_log10() + 
  geom_smooth(method="lm", size=1.5)


#Challenge Rewrite  pdf command to print a second page in the pdf, showing a facet plot 
#(hint: use facet_grid) of the same data with one panel per continent


#multiple plots in a single pdf comienzo con pdf(file="") y termino con dev.off()

pdf(file="figures/density_plot1.pdf")
ggplot(data = gapminder, aes(x= lifeExp, y=gdpPercap, color = country)) +
  geom_point(color="green", size = 8)  + scale_y_log10() + 
  geom_smooth(method="lm", size=1.5)

ggplot(dat=gapminder, aes(x=gdpPercap, fill=continent)) + 
  geom_density(alpha=0.5) + facet_grid(~continent) + scale_x_log10()

dev.off()


png(file="figures/density_plot1.png")
ggplot(data = gapminder, aes(x= lifeExp, y=gdpPercap, color = country)) +
  geom_point(color="green", size = 8)  + scale_y_log10() + 
  geom_smooth(method="lm", size=1.5)

ggplot(dat=gapminder, aes(x=gdpPercap, fill=continent)) + 
  geom_density(alpha=0.5) + facet_grid(~continent) + scale_x_log10()

dev.off()

jpeg(file="figures/density_plot1.jpeg")
ggplot(data = gapminder, aes(x= lifeExp, y=gdpPercap, color = country)) +
  geom_point(color="green", size = 8)  + scale_y_log10() + 
  geom_smooth(method="lm", size=1.5)

ggplot(dat=gapminder, aes(x=gdpPercap, fill=continent)) + 
  geom_density(alpha=0.5) + facet_grid(~continent) + scale_x_log10()

dev.off()


###multiplot grid.arrange
###gridExtra::grid.arrange ()


# Working with dataframes -------------------------------------------------

#rbind and cbind can add rows and columns to data frames
iris
head(iris)


##add a new column to this dataframe

iris$Family <- "Iridaceae"
head(iris)

## Adding columns using the own data

iris$Petal.Area <- iris$Petal.Width * iris$Petal.Length
head(iris)
 ##another way to do it:
iris$Sepal.Area <- with (iris, Sepal.Width * Sepal.Length)
head(iris)

Iris #to see the misspell

#Summary statistics

mean(iris$Petal.Width)
sd(iris$Petal.Width)
median(iris$Petal.Width)

#coeficiente de variación cv  = sd(x)/x mean

mean_petal_width <- mean(iris$Petal.Width)
sd_petal_width <- sd(iris$Petal.Width)

cv = sd_petal_width / mean_petal_width
cv


#Challenge find the cv for the variable sepal.lenght in the iris dataset

mean_sepal_length <- mean(iris$Sepal.Length)
sd_sepal_length <- sd(iris$Sepal.Length)
cv = sd_sepal_length/ mean_sepal_length 
cv


# Functions ---------------------------------------------------------------


cal_CV(iris$Sepal.Length)
cal_CV(iris$Sepal.Width)
cal_CV(gapminder$gdpPercap)
cal_CV(rnorm(2000))


circum_diameter(30)
circum_diameter(3)

##Challenge: write a function that calculates the radius of the diameter

diam_radius(30)

radius_area(30)
radius_area(2)

area_from_circum(40)

#make a dataframe

circs <- data.frame(xs = 10:200)
head(circs)

circs$areas <- area_from_circum(circum = circs$xs)
head(circs)

ggplot (circs, aes(x=xs,y=areas)) + geom_line()



##Saving data

brazil <- gapminder [gapminder$country =="Brazil", ]
brazil

write.table(x = brazil, 
            file = "cleaned_data/brazil_data.csv", 
            sep = ",")


write.table(x = brazil, 
            file = "cleaned_data/brazil_data.csv", 
            sep = ",", 
            row.names = FALSE,
            quote = FALSE)

write.csv(x = brazil, file = "cleaned_data/brazil_data2.csv")

write.table(x = brazil, file = "cleaned_data/brazil_data_semicolon.csv", 
            sep=";", 
            row.names = FALSE, 
            quote = FALSE)
Brazil2 <- read.table("cleaned_data/brazil_data_semicolon.csv")



# Challenge: write a data cleaning script fil that subsets the gapminder 
# data to include only data points collected since 1990
# use this script to write out the new subset to a file in the 
# cleaned-dat/ directory

data_1990 <- gapminder[gapminder$year > 1990, ]
data_1990


write.table(x = data_1990,
            file = "cleaned_data/data_1990.csv", 
            sep=";", 
            row.names = FALSE, 
            quote = FALSE)


SINCE_1990 <- gapminder[gapminder$year > 1990, ]
SINCE_1990


write.table(x = SINCE_1990,
            file = "cleaned_data/SINCE_1990.csv", 
            sep="\t", 
            row.names = FALSE, 
            quote = FALSE)
