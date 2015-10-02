
# load data ---------------------------------------------------------------
gapminder <- read.csv("data/gapminder.csv")

# load packages -----------------------------------------------------------

library(dplyr)
library(ggplot2)
library(car)

# probability distributions -----------------------------------------------

# distr normal pode ser um numero com decimais, e pode ser negativa ou positiva, 
# vai de -infinito a +infinito
# rnorm  r is for random 

rnorm(n=30, mean=10,sd=4)
random_normal <- rnorm(n=300, mean=10,sd=4)

#create a dataframeto use ggplot

rand_df <- data.frame(rn=random_normal)
rand_df
ggplot(rand_df, aes(x=rn)) + geom_density()

## poisson distribution: simpler than normal distr 
## mean and variance are proportional to eachother equal here
## nao pode er negativa e tem que ser numeros enteros, aqui va de 0 a +infinito
?rpois
# n number of random values to return.
# lambda vector of (non-negative) means.

rand_df$randpois <- rpois(300, 4)
ggplot(rand_df, aes(x=randpois)) + geom_density()

### r. q, d
# the density function
# function curve

?curve
plot(curve(dnorm(x), from=-2, to=2), type="l", xlim=c(-3,3))


### curve for lines
 # example with species area curve
pop <- function(x){
  2*x^0.75
}
 
pop(4)
pop(40)
pop(400)

plot(curve(pop(x)))

# linear models -----------------------------------------------------------

head(gapminder)
lm(pop ~ year, data = gapminder)
model <- lm(pop ~ year, data = gapminder)
summary(model)

# t value = estimate / std error
# here we want to see the effect when the value is not zero

model2 <- lm(pop ~ year*continent, data = gapminder)
model3 <- lm(pop ~ year+continent, data = gapminder)
model4 <- lm(pop ~ year:continent, data = gapminder)
summary(model2)
summary(model3)
summary(model4)
# * means interaction of individual
# similar: year + continent + year:continent

# year is continuous variable
# continent is 0 or 1, binary variable 
# Africa está no intercepto porque es la primera en el alfabeto
# Estimate me muestra la diferencia entre los parametros
# no está correctos los grados de libertad,en este caso hay que cambiar el modelo.
# no es correcto porque hay pseudreplicacion

anova(model2)

# pero si invierto el modelo puede mudar si el modelo no es balaneado

model21 <- lm(pop ~ continent*year, data = gapminder)

model21 <- lm(pop ~ continent*year, data = gapminder)
anova(model21)

model22 <- lm(pop ~ year*gdpPercap, data = gapminder)
model23 <- lm(pop ~ gdpPercap*year, data = gapminder)
anova(model22)
anova(model23)

# mas nesse caso R por default calcula los cuadrados de forma secuencial tipo I
# tipo II suma de cuadrados considera o efeito de cada variavel
# independente de todas as outras, essa é a mais forte que tem
# mas quando tem interaçao no modelo todos os efeitos dependen dos outros
# ai voce faz ssqq tipo III para ver interação e testar s efeitos principais
# se nao efeito da interacao voce usa a tipo II
# anova sempre da secuencial, ou seja tipo I
# pacote car

Anova(model22, type = "III")
Anova(model23, type = "III")


Anova(model22, type = "II")
Anova(model23, type = "II")


# checking residuals ------------------------------------------------------

# SON LOS RESIDUOS LSO QUE DEBEN SER NORMALES, NO LOS DATOS, VER SI ELLOS ESTÁN IGUAL DE MAL

model5 <- lm(pop ~ year, data = gapminder)
summary(model5)
plot(pop ~ year, data = gapminder)
plot(model5)

qqnorm(resid(model5));qqline(resid(model5))
hist(resid(model5))

# isso aqui é do R para localizar un ponto en un grafico, aperta ESC al final
# ayuda a encontrar outliers

locator()