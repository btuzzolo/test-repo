###########################################################################
# Exemplo de aplicação do método Causal Impact, que gera predições e dados
# 'contra-factuais', criando uma base de comparação caso a ação de Marketing/Promoção
# ou outro tipo de intervenção não tivesse acontecido
##########################################################################
## setup do diretório de trabalho
getwd()
setwd("C:/Users/")

## Instalando as bibliotecas necessárias
install.packages("CausalImpact")
library(CausalImpact)
library(ggplot2)

## Gerando série temporal hipotética para servir de exemplo
set.seed(100)
x1 = 100 + arima.sim(model = list(ar = 0.999), n = 150)
y = 1.5 * x1 + rnorm(150)
y[101:135] = y[101:135] + 12
date.points = seq.Date(as.Date("2023-01-01") , by = 1 , length.out = 150)
data = zoo(cbind(y, x1), date.points)

## Plotando a série temporal gerada
plot(data[ ,1], type = "l" , ylim =c(110,max(data[ ,1])) 
     , col = "black" , lwd = 2.0 , xlab = ("Tempo") , ylab = ("Observações") )
abline(v = as.Date("2023-04-11"), col = "red" , type = "l" , lty = 2)

## Definindo o período antes (pré) e após (post) o início da intervenção (campanha)
preperiod = as.Date(c("2023-01-01" , "2023-04-10"))
postperiod = as.Date(c("2023-04-11" , "2023-05-30"))

## Rodando a análise dos dados via função 'CausalImpact'
impact = CausalImpact(data, preperiod, postperiod)
plot(impact)

## Resumo dos resultados da análise
summary(impact)
summary(impact, "report")
