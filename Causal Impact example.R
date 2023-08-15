getwd()
setwd("C:/Users/Bruno/Documents/Bruno/Coursera")

install.packages("CausalImpact")
library(CausalImpact)
library(ggplot2)


set.seed(1)
x1 = 100 + arima.sim(model = list(ar = 0.999), n = 150)

help(arima.sim)

y = 1.5 * x1 + rnorm(150)

y[101:135] = y[101:135] + 12

data = cbind(y, x1)

head(data)

matplot(data, type = "l")



impact.plot = plot(impact) + theme_bw(base_size = 20)
plot(impact.plot)


preperiod <- c(1, 70)
postperiod <- c(71, 100)

impact = CausalImpact(data, preperiod, postperiod)

plot(impact)

summary(impact)
summary(impact, "report")
