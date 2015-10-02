
# load data ---------------------------------------------------------------
gapminder <- read.csv("data/gapminder.csv")

# load packages -----------------------------------------------------------

library(dplyr)
library(ggplot2)
library(car)
library(vegan)

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
 

# fitting count data! -----------------------------------------------------

 ### transform the response variable!

model6 <- lm(log(pop) ~ year, data = gapminder)
plot(model6)
qqnorm(resid(model6));qqline(resid(model6))
hist(resid(model6), col = "violet")

## GLMs with poisson errors
 

model7 <- glm(pop ~year, data = gapminder, family = poisson)
plot(model7)

# esse modelo ajusta melhor ao dado porque a magnitude dos residuos é menor
summary(model7)
# z value muy alto y p value muyyyyy bajo, el modelo está super mal
# Ahi, los deviance null and residual deben ser vistos:
model7$deviance/model7$df.residual
# aqui deve ser menor do que 2 (acá da 90574383)
# para arreglar esto se usa dividir la variable respuesta, en este caso pop, por ese numero:
model71 <- glm(pop/model7$deviance/model7$df.residual ~year, data = gapminder, family = poisson)
plot(model71)
summary(model71)
 # o hacer una quasipoisson
model8 <- glm(pop ~ year, data = gapminder, family = quasipoisson())
plot(model8)
summary(model8)
# aqui todavia no está bien - así que lo mejor es vovler y transformar los datos
# aca no da AIC y eso no es bueno

# AIC es util cuando se hace seleccion de modelos
# load vegan

model9 <- lm(log(pop) ~ 1, data = gapminder)
model91 <- lm(log(pop) ~ year, data = gapminder)
model92 <- lm(log(pop) ~ year*country, data = gapminder)

anova(model9, model91, model92)
AIC(model9, model91, model92)

# AICcmodavgv is a good package for model averaging
# check aictab() function

model93 <- lm(log(pop) ~ year*country*continent, data = gapminder)
anova(model93)

### draw a poisson distribution
pois_resp <- pois_resp %>% 
  mutate (ys=rpois(1, lambda = xs))

# Multivariate analyses ---------------------------------------------------
# todos los analises multivariados compactan nubes de puntos a 2D y son basados en 
# matrices de distancias, a mayor distancia mayor diferencia en el espacio creado
# todo va a ser siempre disimilariedado similariedad basado en distancia

library(vegan)
data("varechem")
data("varespec")
data("dune")
data("dune.env")

View(varechem)
View(varespec)

# no hay distancia ideal

distl <- vegdist(varespec, method = "bray")
distl
distl <- vegdist(varespec, method = "bray", diag = TRUE)

# pca en vegan es con la función rda

pca1 <- rda(varechem)
plot(pca1)

# centralizar primero o standardize
pca1 <- rda(varechem, scale = TRUE)
plot(pca1)

ordiplot(pca1) # check ordihull
ordiplot(pca1, type = "text")
ordiplot(pca1, display = "species")
ordiplot(pca1, display = "sites")
ordiplot(pca1, scaling = 3)
pca1
summary(pca1)
scores(pca1)

scores(pca1)$sites # aca posso fazer um dataframe e fazer o que eu quiser no ggplot

rda1 <- rda(varespec ~ K + pH + P, data = varechem) #tem sempre que especificar as variaveis
rda1
plot(rda1)

rda2 <- rda(log(varespec+1) ~ K + pH + P, data = varechem)
rda2
plot(rda2)

rda3 <- rda(decostand(varespec, method = "hellinger") ~ K + pH + P, data = varechem)
rda3
plot(rda3)
#hellinger es muy usado porque reduce el peso de especies raras

#testar significancia de los ejes
anova(rda3, by = "axis")
anova(rda3, by = "terms") # SQQ Type I
anova(rda3, by = "margin") # SQQ Type II
# r quadrado ajustado da sua multivariada
RsquareAdj(rda3)

cca1 <- cca(decostand(varespec, method = "hellinger") ~ K + pH + P, data = varechem)
cca1
plot(cca1)
anova(cca1, by = "axis")
anova(cca1, by = "terms") # SQQ Type I
anova(cca1, by = "margin") # SQQ Type II
RsquareAdj(rda3)


# mds matriz de distancia
distl
dist2 <- vegdist (varechem, method = "euclid")

mds1 <- cmdscale(dist2)
mds1
plot(mds1)

# variance partitioning
# ?varpart

# ?mantel for mantel test
# ?anosim for anosim

# permanova + permdisp

head(dune)
head(dune.env)
head(dune.env)

perm1 <- adonis(dune ~ Use, data = dune.env, method = "bray") # for permanova
perm1

perm2 <- adonis(dune ~ Management, data = dune.env, method = "bray") # for permanova
perm2
#post-test es cuantificando individualmente 

dist3 <- vegdist(dune,method = "bray")
disper3 <- betadisper(d = dist3, group = dune.env$Management)
disper3
permutest(disper3, pairwise = TRUE)
plot(disper3)
levels(dune.env$Management)
boxplot(disper3)
scores(disper3)
disper3$distances
# la distancia al centroide es la distancia en el boxplot

library(dplyr)
dune2 <- dune.env %>% 
  mutate(dispersao = disper3$distances) %>% 
  ggplot(aes(x=Management, y=dispersao)) +
  geom_boxplot()

dune2

dune3 <- dune.env %>% 
  mutate(dispersao = disper3$distances) %>% 
  ggplot(aes(x = A1, y = dispersao)) +
  geom_point()
dune3
