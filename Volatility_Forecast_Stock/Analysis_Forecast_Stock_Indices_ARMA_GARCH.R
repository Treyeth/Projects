library(quantmod)
library(lattice)
library(timeSeries)
library(rugarch)
library(tseries)
library(forecast)
library(FinTS)
library(lmtest)
library(aTSA)
library(tsoutliers)
library(moments)
library(astsa)
library(PerformanceAnalytics)
library(urca)
library(stats)
library(fUnitRoots)
library(ggplot2)

##GETTING DATA

##INDICE1

getValues <- function(indice){
  a <- getSymbols(indice, from = "2016-02-27",to = "2018-02-27",auto.assign = FALSE,type = "zoo") # get stock data
  a <- Cl(a) # get the close values
  a <- na.spline(a) # interpolate the missing values
  return(a)
}

indice <- getValues("^GDAXI")
indice2 <- getValues("^FCHI")
indice3 <- getValues("^GSPC")
indice4 <- getValues("^N225")

par(mfrow=c(4,1))
plot(indice,main="Closing Prices DAX Performance Index")
plot(indice2,main="Closing Prices CAC 40")
plot(indice3,main="Closing Prices S&P 500")
plot(indice4,main="Closing Prices Nikkei 225")

#calculating number of differences required for a stationary time series
ndiffs(indice,alpha=0.05)	
ndiffs(indice2,alpha=0.05)
ndiffs(indice3,alpha=0.05)
ndiffs(indice4,alpha=0.05)


# Checking the Closing prices if they are stationary or not
adfTest(indice,type = c("nc", "c", "ct"),lags=5)
adfTest(indice2,type = c("nc", "c", "ct"),lags=5)
adfTest(indice3,type = c("nc", "c", "ct"),lags=5)
adfTest(indice4,type = c("nc", "c", "ct"),lags=5)

difflog <- function(indice){
  a <- diff(log(indice))
  a[1,] <- 0
  return(a)
}

indiced <- difflog(indice)
indiced2 <- difflog(indice2)
indiced3 <- difflog(indice3)
indiced4 <- difflog(indice3)

# Checking if the indices are stationary after differencing
adfTest(indiced,type = c("nc", "c", "ct"),lags=5)
adfTest(indiced2,type = c("nc", "c", "ct"),lags=5)
adfTest(indiced3,type = c("nc", "c", "ct"),lags=5)
adfTest(indiced4,type = c("nc", "c", "ct"),lags=5)

# Plotting the differenciated indices
par(mfrow=c(4,1))
plot(indiced,main = "Evolution of DAX Performance Index", xlab = "Yield", ylab = "Yield", ylim = c(-0.10, 0.08))
plot(indiced2,main = "Evolution of CAC 40", xlab = "Yield", ylab="Yield", ylim = c(-0.10, 0.08))
plot(indiced3,main = "Evolution of S&P 500", xlab = "Yield", ylab="Yield", ylim =  c(-0.05, 0.05))
plot(indiced4,main = "Evolution of Nikkei 225", xlab = "Yield", ylab="Yield", ylim = c(-0.10, 0.08))	

# Summary statistics
table.Stats(indiced) 
table.Stats(indiced2)
table.Stats(indiced3)
table.Stats(indiced4)

# Looking at the error distribution
jarque.bera.test(indiced) 
jarque.bera.test(indiced2) 
jarque.bera.test(indiced3) 	
jarque.bera.test(indiced4) 

##COMPARING HISTOGRAMS

par(mfrow = c(2,2))
retnorm <- rnorm(length(indiced), mean(indiced), sd(indiced))
retnorm2 <- rnorm(length(indiced2),mean(indiced2),sd(indiced2))
retnorm3 <- rnorm(length(indiced3),mean(indiced3),sd(indiced3))
retnorm4 <-rnorm(length(indiced4),mean(indiced4),sd(indiced4))

hist(indiced, freq = FALSE, breaks = 50, main = '(a)DAX Performance', xlab = 'Yield value DAX Performance')
lines(density(retnorm),col = "red")
lines(density(indiced),col = "blue")
names <- c("Normal", "Actual")
legend("topleft", names, lty = 1, col = c("red","blue"), title = "Distribution", cex = .65)

hist(indiced2,freq=FALSE,breaks=50,main='(b)CAC 40',xlab='Yield value CAC 40')
lines(density(retnorm2),col="red")
lines(density(indiced2),col="blue")

hist(indiced3, freq = FALSE, breaks = 50, main = '(c)S&P 500', xlab = 'Yield value Dow Jones')
lines(density(retnorm3),col = "red")
lines(density(indiced3),col = "blue")

hist(indiced4,freq = FALSE, breaks = 50, main = '(d)Nikkei 225', xlab = 'Yield value Nikkei 225')
lines(density(retnorm4), col = "red")
lines(density(indiced4), col = "blue")

# Checking the autocorrelation
ggAcf(indiced, main = "Autocorrelation function", na.action = na.pass, lag.max = 30)
ggPacf(indice, main = "Partial autocorrelation function",na.action = na.pass, lag.max = 30)
ggAcf(indice^2, main = "Autocorrelation function", na.action = na.pass,lag.max = 30)
ggPacf(indice^2, main = "Partial autocorrelation function", na.action = na.pass, lag.max = 30)


# Getting the ARIMA model parameters in 2 ways
auto.arima(indiced, trace = TRUE, ic = "aic", approximation = FALSE)
auto.arima(indiced2,trace=TRUE,ic="aic",approximation=FALSE)
auto.arima(indiced3,trace=TRUE,ic="aic",approximation=FALSE)
auto.arima(indiced4,trace=TRUE,ic="aic",approximation=FALSE)

# Creating a function to calculate the ARIMA order
calcorder <- function(indice){
  final.aic <- Inf
  final.order <- c(0,0,0)
  for (i in 0:4) for (j in 0:4) {
    current.aic <- AIC(arima(indice, order = c(i, 0, j)))
    if (current.aic < final.aic) {
      final.aic <- current.aic
      final.order <- c(i, 0, j)
      final.arma <- arima(indice, order=final.order)
    }
  }
  list(final.aic, final.order)
}

(final.aic <- calcorder(indiced)[[1]])
(final.order <- calcorder(indiced)[[2]])
(final.aic2 <- calcorder(indiced2)[[1]])
(final.order2 <- calcorder(indiced3)[[2]])
(final.aic3 <- calcorder(indiced3)[[1]])
(final.order3 <- calcorder(indiced3)[[2]])
(final.aic4 <- calcorder(indiced4)[[1]])
(final.order4 <- calcorder(indiced4)[[2]])

# Fitting the ARIMA models
indicearima<-arima(indiced, order=c(final.order[1],0,final.order[3]))
jarque.bera.test(residuals(indicearima)) #The errors do not follow the normal distribution
indicearimar<-residuals(indicearima)

indicearima2<-arima(indiced2, order=c(final.order2[1],0,final.order2[3]))
jarque.bera.test(residuals(indicearima2)) #The errors do not follow the normal distribution
indicearimar2<-residuals(indicearima2)

indicearima3<-arima(indiced3, order=c(final.order3[1],0,final.order3[3]))
jarque.bera.test(residuals(indicearima3)) #The errors do not follow the normal distribution
indicearimar3<-residuals(indicearima3)

indicearima4<-arima(indiced4, order=c(final.order4[1],0,final.order4[3]))
jarque.bera.test(residuals(indicearima4)) #The errors do not follow the normal distribution
indicearimar4<-residuals(indicearima4)

# Testing the ARIMA residuals
par(mfrow=c(1,2))
acf(indicearimar^2,main="ACF reziduri ridicate la patrat pentru DAX")
pacf(indicearimar^2,main="PACF reziduri ridicate la patrat pentru DAX")

acf(indicearimar2^2,main="ACF reziduri ridicate la patrat pentru CAC 40")
pacf(indicearimar2^2,main="PACF reziduri ridicate la patrat pentru CAC 40")

acf(indicearimar3^2,main="ACF reziduri ridicate la patrat pentru S&P 500")
pacf(indicearimar3^2,main="PACF reziduri ridicate la patrat pentru S&P 500")

acf(indicearimar4^2,main="ACF reziduri ridicate la patrat pentru Nikkei 225")
pacf(indicearimar4^2,main="PACF reziduri ridicate la patrat pentru Nikkei 225")

# Lagrange multiplier test for conditional heteroscedasticity and Ljung-Box test
ArchTest(indicearimar,lags=10)
Box.test(indicearimar^2,lag=10,type="Ljung-Box")
Box.test(indicearimar^2,lag=15,type="Ljung-Box")
Box.test(indicearimar^2,lag=20,type="Ljung-Box")

ArchTest(indicearimar2,lags=10)
Box.test(indicearimar2^2,lag=10,type="Ljung-Box")
Box.test(indicearimar2^2,lag=15,type="Ljung-Box")
Box.test(indicearimar2^2,lag=20,type="Ljung-Box")

ArchTest(indicearimar3,lags=10)
Box.test(indicearimar3^2,lag=10,type="Ljung-Box")
Box.test(indicearimar3^2,lag=15,type="Ljung-Box")
Box.test(indicearimar3^2,lag=20,type="Ljung-Box")

ArchTest(indicearimar4,lags=10)
Box.test(indicearimar4^2,lag=10,type="Ljung-Box")
Box.test(indicearimar4^2,lag=15,type="Ljung-Box")
Box.test(indicearimar4^2,lag=20,type="Ljung-Box")

# Creating function for ARMA - GARCH fitting
fitgarch <- function(sample = 5, index, order1 , order2, distrib, model = "sGARCH"){
  garch1<-ugarchspec(variance.model = list (model = model, garchOrder = c(1,1)), mean.model = list(armaOrder = c(order1, order2)), distribution.model = distrib)
  garch1fit<-ugarchfit(spec = garch1, data = index,out.sample = sample)
  garch1fit
}

# Trying out the different distributions
garch1fit <- fitgarch(index = indiced, order1 = final.order[1], order2 = final.order[3], distrib = "norm")
garch2fit <- fitgarch(index = indiced, order1 = final.order[1], order2 = final.order[3], distrib = "std")
garch3fit <- fitgarch(index = indiced, order1 = final.order[1], order2 = final.order[3], distrib = "ged")
garch4fit <- fitgarch(index = indiced, order1 = final.order[1], order2 = final.order[3], distrib = "sstd")
garch5fit <- fitgarch(index = indiced, order1 = final.order[1], order2 = final.order[3], distrib = "nig")
garch6fit <- fitgarch(index = indiced, order1 = final.order[1], order2 = final.order[3], distrib = "ghyp")
garch7fit <- fitgarch(index = indiced, order1 = final.order[1], order2 = final.order[3], distrib = "sged")

egarch1fit <- fitgarch(index = indiced, order1 = final.order[1], order2 = final.order[3], distrib = "norm", model = "eGARCH")
egarch2fit <- fitgarch(index = indiced, order1 = final.order[1], order2 = final.order[3], distrib = "std", model = "eGARCH")
egarch3fit <- fitgarch(index = indiced, order1 = final.order[1], order2 = final.order[3], distrib = "ged", model = "eGARCH")
egarch4fit <- fitgarch(index = indiced, order1 = final.order[1], order2 = final.order[3], distrib = "sstd", model = "eGARCH")
egarch5fit <- fitgarch(index = indiced, order1 = final.order[1], order2 = final.order[3], distrib = "nig", model = "eGARCH")
egarch6fit <- fitgarch(index = indiced, order1 = final.order[1], order2 = final.order[3], distrib = "ghyp", model = "eGARCH")
egarch7fit <- fitgarch(index = indiced, order1 = final.order[1], order2 = final.order[3], distrib = "sged", model = "eGARCH")

##TESTING THE MODELS
##GARCH TESTS

garchtest <- function(model){
  garch1rs<-residuals(model)/sigma(model)
  garch1rsp<-garch1rs^2
  list("Ljung Box" = c(Box.test(garch1rsp,lag=10,type="Ljung-Box")[3],Box.test(garch1rsp,lag=15,type="Ljung-Box")[3], Box.test(garch1rsp,lag=20,type="Ljung-Box")[3]),
        "Jarque-Bera" = jarque.bera.test(garch1rs)[3], "ARCH-LM" = ArchTest(garch1rs,lag=10)[3])
}
?ugarchspec
garch1test <- garchtest(garch1fit)
garch2test <- garchtest(garch2fit)
garch3test <- garchtest(garch3fit)
garch4test <- garchtest(garch4fit)
garch5test <- garchtest(garch5fit)
garch6test <- garchtest(garch6fit)
garch7test <- garchtest(garch7fit)

egarch1test <- garchtest(egarch1fit)
egarch2test <- garchtest(egarch2fit)
egarch3test <- garchtest(egarch3fit)
egarch4test <- garchtest(egarch4fit)
egarch5test <- garchtest(egarch5fit)
egarch6test <- garchtest(egarch6fit)
egarch7test <- garchtest(egarch7fit)

# Compare information criterion between models
model.list = list(garch11=garch1fit,
                  garch11t=garch2fit,
                  garch11g=garch3fit,
                  garch11sstd=garch4fit,
                  garch11nig=garch5fit,
                  garch11ghyp=garch6fit,
                  garch11sged=garch7fit,
                  egarch11=egarch1fit,
                  egarch11t=egarch2fit,
                  egarch11g=egarch3fit,
                  egarch11sstd=egarch4fit,
                  egarch11nig=egarch5fit,
                  egarch11ghyp=egarch6fit,
                  egarch11sged=egarch7fit)

info.mat = sapply(model.list, infocriteria)
rownames(info.mat) = rownames(infocriteria(garch1fit))
(info.mat<-as.data.frame(info.mat))


# Calculating the dynamic forecasts
garch11n <- ugarchforecast(garch1fit, n.roll = sample, n.ahead = 1)
garch11t <- ugarchforecast(garch2fit, n.roll = sample, n.ahead = 1)
garch11g<- ugarchforecast(garch3fit,n.roll = sample,n.ahead = 1)
garch11sstd<-ugarchforecast(garch4fit,n.roll = sample,n.ahead = 1)
garch11nig<- ugarchforecast(garch5fit,n.roll = sample,n.ahead = 1)
garch11ghyp<-ugarchforecast(garch6fit,n.roll = sample,n.ahead = 1)
garch11sged<- ugarchforecast(garch7fit,n.roll = sample,n.ahead = 1)
egarch11n <- ugarchforecast(egarch1fit, n.roll = sample, n.ahead = 1)
egarch11t <- ugarchforecast(egarch2fit, n.roll = sample, n.ahead = 1)
egarch11g<- ugarchforecast(egarch3fit,n.roll = sample,n.ahead = 1)
egarch11sstd<-ugarchforecast(egarch4fit,n.roll = sample,n.ahead = 1)
egarch11nig<- ugarchforecast(egarch5fit,n.roll = sample,n.ahead = 1)
egarch11ghyp<-ugarchforecast(egarch6fit,n.roll = sample,n.ahead = 1)
egarch11sged<- ugarchforecast(egarch7fit,n.roll = sample,n.ahead = 1)

# Comparing the dynamic forecasts
fcst.list = list(garch11=garch11n,
                 garch11t=garch11t,
                 garch11g=garch11g,
                 garch11sstd=garch11sstd,
                 garch11nig=garch11nig,
                 garch11ghyp=garch11ghyp,
                 garch11sged=garch11sged,
                 egarch11=egarch11n,
                 egarch11t=egarch11t,
                 egarch11g=egarch11g,
                 egarch11sstd=egarch11sstd,
                 egarch11nig=egarch11nig,
                 egarch11ghyp=egarch11ghyp,
                 egarch11sged=egarch11sged
)
fpm.mat = sapply(fcst.list, fpm)
fpm.mat<-as.data.frame(fpm.mat)
fpm.mat<-t(fpm.mat)
fpm.mat

##fitted(garch11t)
##sigma(garch11t)

plot(egarch11t,which=2)
plot(garch11sstd,which=2)

# Calculating the static forecasts
garch11n2 <- ugarchforecast(garch1fit, n.ahead = sample)
garch11t2<-ugarchforecast(garch2fit, n.ahead = sample)
garch11g2<- ugarchforecast(garch3fit, n.ahead = sample)
garch11sstd2<-ugarchforecast(garch4fit, n.ahead = sample)
garch11nig2<- ugarchforecast(garch5fit, n.ahead = sample)
garch11ghyp2<-ugarchforecast(garch6fit, n.ahead = sample)
garch11sged2<- ugarchforecast(garch7fit, n.ahead = sample)
egarch11n2<-ugarchforecast(egarch1fit, n.ahead = sample)
egarch11t2<-ugarchforecast(egarch2fit, n.ahead = sample)
egarch11g2<- ugarchforecast(egarch3fit, n.ahead = sample)
egarch11sstd2<-ugarchforecast(egarch4fit, n.ahead = sample)
egarch11nig2<- ugarchforecast(egarch5fit, n.ahead = sample)
egarch11ghyp2<-ugarchforecast(egarch6fit, n.ahead = sample)
egarch11sged2<- ugarchforecast(egarch7fit, n.ahead = sample)

plot(garch11nig2,which=1)
plot(garch1fit,which="all")
lines(indice,col="blue")
show(garch11nig2)
plot(garch11n,which=2)

# compute forecast evaluation statistics
fcst.list2 = list(garch11=garch11n2,
                  garch11.t=garch11t2,
                  garch11g=garch11g2,
                  garch11sstd=garch11sstd2,
                  garch11nig=garch11nig2,
                  garch11ghyp=garch11ghyp2,
                  garch11sged=garch11sged2,
                  egarch11=egarch11n2,
                  egarch11t=egarch11t2,
                  egarch11g=egarch11g2,
                  egarch11sstd=egarch11sstd2,
                  egarch11nig=egarch11nig2,
                  egarch11ghyp=egarch11ghyp2,
                  egarch11sged=egarch11sged2)
fpm.mat2 = sapply(fcst.list2, fpm)
row.names(fpm.mat2)<- c("MSE", "MAE", "DAC","N")
fpm.mat2
par(mfrow=c(2,1))
plot(indiced)
plot(garch11sstd,which=3)

