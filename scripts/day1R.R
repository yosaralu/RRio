library(ggplot2)
#R in Rio
## Instructors: Andrew and Aletha

##challenge!
mass <- 47.5
age <- 122
mass <- mass*2.3
age <- age - 20

mass>age #is mass larger than age?
mass<age
mass==age
mass!=age

## Data types

#logical
a <- TRUE
b <- FALSE

#integer
c <- 5L

#double
d <- 5

#complex number

e <- 1 + 2i

#characters

f <- "cat"

##Challenge 2!

answer <- TRUE
height <- 6L
dog_name <- "dark"

is.logical(answer)
is.numeric(height)
is.character(dog_name)

## Data structures

# Vector

vec1 <- vector("character")
vec2 <- vector("character", length = 5)

vec3 <- c(1, 2, 3, 4, 5)
vec4 <- c(0:100)

vec5 <- seq(0, 100, by=0.5)

vec6 <- c(TRUE, 10L, "cat")
vec6
typeof(vec6)
as.double(vec6)

## Getting information about an object's structure

x <- 0:10000

length(x)
str(x)
head(x)
tail(x)

ages <- c(23, 24, 25, 32, 49)
ages

names(ages) <- c("Juliana", "Rodrigo", "Carlos", "Bella", "Andrew")
ages

#numeric is a category for two data types: double and interger

## Matrices

x <- matrix(1:10, nrow = 5, ncol = 2)
str(x)

rownames(x) <- c("a","b","c","d","e")
colnames(x) <- c("a","b")
x

## Challenge 3!

x <- matrix(rnorm(18), ncol=6, nrow=3)
length(x)

y <- matrix(1:50) # by default the function organizes my matrix by columns
y <- matrix(1:50, 10, 5, byrow=TRUE)
y

## Factors

x <- factor(c("yes","no","yes","yes"))
x
typeof(x)
str(x)
x <- factor(c("case","control","control","case"),
            levels=c("control","case"))
x
str(x)
typeof(x)

## Lists: contain multiple data types

a <- list(1, "a", TRUE, 5L)
xlist <- list(name="Iris Data", nums= 1:10, data=head(iris))
xlist

#Data Frame

df <- data.frame(a=c(1,2,3),b= c("a","b","c"),c=c(TRUE,FALSE,FALSE))
df

rbind(df1,df2) #combining two datasets -> adding by row
cbind(df1,df2) # combining two datasets -> adding by column

##Challenge 4!

df <- data.frame(id=c('a','b','c','d','e','f'),x=1:6, y=c(214:219))
length(df)

##Challenge 5!

mydf <- data.frame(first="Pedro",last="Junger",age=26)
df2 <- data.frame(first="Sara",last="Colmenares",age=31)

total <- rbind(mydf,df2)
str(total)

### subsetting
#### taking out parts of larger objects
x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
names(x) <- c("a","b","c","d","e")
x
typeof(x)
is.double(x)
is.numeric(x)
x[1]
x[c(3,5)]

x[1:5]
x[5:1]

## skipping elements

x[-1]
x[-c(2,4)]
x[c(-2,-4)]

##Challenge 6!
x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
names(x) <- c("a","b","c","d","e")
x
x[-c(1,5)] # first way
x[c(2,3,4)]
x[c(2:4)]
x[c("b","c","d")]
x[c(FALSE,TRUE,TRUE,TRUE,FALSE)]

## subsetting by name
x["a"]
is_it_b <- names(x) == "b"
x[is_it_b]

## for matching multiple things
names(x) %in% c("b","c","d")
names(x)
x[names(x) %in% c("b","c","d")]

### multiple conditions
a <- 1:10
a
a>7
a[a>7]
a[a<7]
a[a<=7]

TRUE & TRUE
FALSE & FALSE
TRUE & FALSE

c(TRUE, FALSE) | c(FALSE, TRUE)

## CHALLENGE 7!

x
## write a subsetting command to return the values in x that are greater than 4,
## AND less than 7

x[x>4 & x<7]

#-----
# how many times is x greater than 6???
as.numeric(x > 6)
sum(x > 6)
x&TRUE

## matrices
set.seed(1) # choose the starting number
m <- matrix(rnorm(6*4), ncol= 4, nrow = 6)
m
m[1:3, c(2,3)]

##CHALLENGE 8!

m <- matrix(1:18, nrow=3, ncol=6)

#subsetting lists
xlist <- list(a="UFRJ", b=1:10, c=head(iris))
xlist
xlist[1] # you get part of a list as a list ("a car from a train")
xlist["a"]
xlist$a
xlist[[1]] # you get the content of the first component (what it's inside the car), the result is not a list
xlist[["a"]]

xlist[["b"]]
xlist[["b"]] [2]

## reading in data
gapminder <- read.csv("gapminder.csv")
gapminder <- gapminder[-c(1705:1706),]
head(gapminder)
str(gapminder)
tail(gapminder)

BRASIL <- gapminder$country == "Brazil"
gapminder[BRASIL,]
BRASIL
gapminder
gapminder$country

#plotting
library(ggplot2)

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
