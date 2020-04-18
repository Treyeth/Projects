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

	indice<-getSymbols("^GDAXI", from="2016-02-27",to="2018-02-27",auto.assign=FALSE,type="zoo")
	indice<- Cl(indice) 
	indice[which(is.na(indice)),]
	indice<-na.spline(indice) 
	dim(indice)

##INDICE2

indice2<-getSymbols("^FCHI", from="2016-02-27",to="2018-02-27",auto.assign=FALSE,type="zoo")
	indice2<- Cl(indice2) 
	indice2[which(is.na(indice2)),] 
	indice2<-na.spline(indice2) 
	dim(indice2)

##INDICE3

indice3<-getSymbols("^GSPC", from="2016-02-27",to="2018-02-27",auto.assign=FALSE,type="zoo")
	indice3<- Cl(indice3) 
	indice3[which(is.na(indice3)),] 
	indice3<-na.spline(indice3) 
	dim(indice3)
	indice3<-as.data.frame(indice3)
	fix(indice3)
	indice3[504,1]<-2744.28
	indice3<-as.xts(indice3)
##INDICE4

indice4<-getSymbols("^N225", from="2016-02-27",to="2018-02-27",auto.assign=FALSE,type="zoo")
	indice4<- Cl(indice4) 
	indice4[which(is.na(indice4)),] 
	indice4<-na.spline(indice4) 
	dim(indice4)

##PLOT THEM

	par(mfrow=c(4,1))
	plot(indice,main="Preturi inchidere DAX Performance Index")
	plot(indice2,main="Preturi inchidere CAC 40")
	plot(indice3,main="Preturi inchidere S&P 500")
	plot(indice4,main="Preturi inchidere Nikkei 225")

#DIFERENTIERE

	ndiffs(indice,alpha=0.05)	
	ndiffs(indice2,alpha=0.05)
	ndiffs(indice3,alpha=0.05)
	ndiffs(indice4,alpha=0.05)

	indiced<-diff(log(indice))	 
	indiced[1,]<-0 
	indiced2<-diff(log(indice2))	 
	indiced2[1,]<-0 
	indiced3<-diff(log(indice3))
	indiced3[1,]<-0
	indiced4<-diff(log(indice4))
	indiced4[1,]<-0

##TESTARE STATIONARITATE

	#PRETURI INCHIDERE

	adfTest(indice,type = c("nc", "c", "ct"),lags=5)
	adfTest(indice2,type = c("nc", "c", "ct"),lags=5)
	adfTest(indice3,type = c("nc", "c", "ct"),lags=5)
	adfTest(indice4,type = c("nc", "c", "ct"),lags=5)
	PP.test(indice)
	PP.test(indice2)
	PP.test(indice3)
	PP.test(indice4)	

	#RANDAMENTE
	
	adfTest(indiced,type = c("nc", "c", "ct"),lags=5)
	adfTest(indiced2,type = c("nc", "c", "ct"),lags=5)
	adfTest(indiced3,type = c("nc", "c", "ct"),lags=5)
	adfTest(indiced4,type = c("nc", "c", "ct"),lags=5)
	PP.test(indiced)
	PP.test(indiced2)
	PP.test(indiced3)
	PP.test(indiced4)

##PLOT 

	par(mfrow=c(4,1))
	plot(indiced,main="Randamente DAX Performance Index",xlab="Randamente",ylab="Data",ylim=c(-0.10,0.08))
	plot(indiced2,main="Randamente CAC 40",xlab="Randamente",ylab="Data",ylim=c(-0.10,0.08))
	plot(indiced3,main="Randamente S&P 500",xlab="Randamente",ylab="Data",ylim=c(-0.05,0.05))
	plot(indiced4,main="Randamente Nikkei 225",xlab="Randamente",ylab="Data",ylim=c(-0.10,0.08))	

##SUMMARY STATS

	table.Stats(indiced) 
	table.Stats(indiced2)
	table.Stats(indiced3)
	table.Stats(indiced4)
	
	head(indiced)
	head(indiced2)
	head(indiced3)
	head(indiced4)

#ERROR DISTRIBUTION
	
	jarque.bera.test(indiced) 
	jarque.bera.test(indiced2) 
	jarque.bera.test(indiced3) 	
	jarque.bera.test(indiced4) 
	
##COMPARING HISTOGRAMS

	par(mfrow=c(2,2))
	retnorm<-rnorm(length(indiced),mean(indiced),sd(indiced))
	hist(indiced,freq=FALSE,breaks=50,main='(a)DAX Performance',xlab='Valoare randament DAX Performance',ylab='Densitatea')
	lines(density(retnorm),col="red")
	lines(density(indiced),col="blue")
	names<-c("Normala","Actuala")
	legend("topleft", names, lty=1,col=c("red","blue"), title = "Distributia",cex=.65)

	retnorm<-rnorm(length(indiced2),mean(indiced2),sd(indiced2))
	hist(indiced2,freq=FALSE,breaks=50,main='(b)CAC 40',xlab='Valoare randament CAC 40',ylab='Densitatea')
	lines(density(retnorm),col="red")
	lines(density(indiced2),col="blue")
	names<-c("Normala","Actuala")
	legend("topleft", names, lty=1,col=c("red","blue"), title = "Distributii",cex=.65)

	retnorm<-rnorm(length(indiced3),mean(indiced3),sd(indiced3))
	hist(indiced3,freq=FALSE,breaks=50,main='(c)S&P 500',xlab='Valoare randament Dow Jones',ylab='Densitatea')
	lines(density(retnorm),col="red")
	lines(density(indiced3),col="blue")
	names<-c("Normala","Actuala")
	legend("topleft", names, lty=1,col=c("red","blue"), title = "Distributii",cex=.65)
	
	retnorm<-rnorm(length(indiced4),mean(indiced4),sd(indiced4))
	hist(indiced4,freq=FALSE,breaks=50,main='(d)Nikkei 225',xlab='Valoare randament Nikkei 225',ylab='Densitatea')
	lines(density(retnorm),col="red")
	lines(density(indiced4),col="blue")
	names<-c("Normala","Actuala")
	legend("topleft", names, lty=1,col=c("red","blue"), title = "Distributii",cex=.65)

##FUNCTII DE AUTOCORELATIE

	ggAcf(indiced,main="Functia de autocorelare",na.action=na.pass,lag.max=30)
	ggPacf(indice,main="Functia de autocorelare partiala",na.action=na.pass,lag.max=30)
	ggAcf(indice^2,main="Functia de autocorelare",na.action=na.pass,lag.max=30)
	ggPacf(indice^2,main="Functia de autocorelare partiala",na.action=na.pass,lag.max=30)

##ARIMA ORDER
#INDICE1

	auto.arima(indiced,trace=TRUE,ic="aic",approximation=FALSE)
	final.aic <- Inf
	final.order <- c(0,0,0)
	for (i in 0:4) for (j in 0:4) {
  	current.aic <- AIC(arima(indiced, order=c(i, 0, j)))
  	if (current.aic < final.aic) {
  	  final.aic <- current.aic
  	  final.order <- c(i, 0, j)
  	  final.arma <- arima(indiced, order=final.order)
 	 }
	}
	final.aic
	final.order

#INDICE2

	auto.arima(indiced2,trace=TRUE,ic="aic",approximation=FALSE)
	final.aic2 <- Inf
	final.order2 <- c(0,0,0)
	for (i in 0:4) for (j in 0:4) {
  	current.aic2 <- AIC(arima(indiced2, order=c(i, 0, j)))
  	if (current.aic2 < final.aic2) {
  	  final.aic2 <- current.aic2
  	  final.order2 <- c(i, 0, j)
  	  final.arma <- arima(indiced2, order=final.order2)
 	 }
	}
	final.aic2
	final.order2

#INDICE3

	auto.arima(indiced3,trace=TRUE,ic="aic",approximation=FALSE)
	final.aic3 <- Inf
	final.order3 <- c(0,0,0)
	for (i in 0:4) for (j in 0:4) {
  	current.aic3 <- AIC(arima(indiced3, order=c(i, 0, j)))
  	if (current.aic3 < final.aic3) {
  	  final.aic3 <- current.aic3
  	  final.order3 <- c(i, 0, j)
  	  final.arma <- arima(indiced3, order=final.order3)
 	 }
	}
	final.aic3
	final.order3

#INDICE 4

	auto.arima(indiced4,trace=TRUE,ic="aic",approximation=FALSE)
	final.aic4 <- Inf
	final.order4 <- c(0,0,0)
	for (i in 0:4) for (j in 0:4) {
  	current.aic4 <- AIC(arima(indiced4, order=c(i, 0, j)))
  	if (current.aic4 < final.aic4) {
  	  final.aic4 <- current.aic4
  	  final.order4 <- c(i, 0, j)
  	  final.arma <- arima(indiced4, order=final.order4)
 	 }
	}
	final.aic4
	final.order4

##FITTING ARIMA

	indicearima<-arima(indiced, order=c(final.order[1],0,final.order[3]))
	jarque.bera.test(residuals(indicearima)) #erorile nu sunt distribuite normal
	indicearima
	indicearimar<-residuals(indicearima)

	indicearima2<-arima(indiced2, order=c(final.order2[1],0,final.order2[3]))
	jarque.bera.test(residuals(indicearima2)) #erorile nu sunt distribuite normal
	indicearima2
	indicearimar2<-residuals(indicearima2)

	indicearima3<-arima(indiced3, order=c(final.order3[1],0,final.order3[3]))
	jarque.bera.test(residuals(indicearima3)) #erorile nu sunt distribuite normal
	indicearima3
	indicearimar3<-residuals(indicearima3)

	indicearima4<-arima(indiced4, order=c(final.order4[1],0,final.order4[3]))
	jarque.bera.test(residuals(indicearima4)) #erorile nu sunt distribuite normal
	indicearima4
	indicearimar4<-residuals(indicearima4)

##ARIMA TESTS

	par(mfrow=c(1,2))
	acf(indicearimar^2,main="ACF reziduri ridicate la patrat pentru DAX")
	pacf(indicearimar^2,main="PACF reziduri ridicate la patrat pentru DAX")

	acf(indicearimar2^2,main="ACF reziduri ridicate la patrat pentru CAC 40")
	pacf(indicearimar2^2,main="PACF reziduri ridicate la patrat pentru CAC 40")

	acf(indicearimar3^2,main="ACF reziduri ridicate la patrat pentru S&P 500")
	pacf(indicearimar3^2,main="PACF reziduri ridicate la patrat pentru S&P 500")
	
	acf(indicearimar4^2,main="ACF reziduri ridicate la patrat pentru Nikkei 225")
	pacf(indicearimar4^2,main="PACF reziduri ridicate la patrat pentru Nikkei 225")
	
	acf(abs(indicearimar))
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


##GARCH FITTING

	sample<-5
	submodel<-NULL
	indiceg<- indiced
	final.order11<-final.order[1]
	final.order12<-final.order[3]
	model2<-"eGARCH"

######INDICE 1
######GARCH

	garch1<-ugarchspec(variance.model = list (garchOrder = c(1,1)),mean.model = list(armaOrder = c(final.order11,final.order12)))
	garch1fit<-ugarchfit(spec = garch1,data=indiceg,out.sample=sample)
	garch1fit
	#GARCH t-distrib
	garch2<-ugarchspec(variance.model = list (garchOrder = c(1,1)),mean.model = list(armaOrder = c(final.order11,final.order12)),distribution.model = "std")
	garch2fit<-ugarchfit(spec = garch2,data=indiceg,out.sample=sample)
	garch2fit
	#GARCH GED
	garch3<-ugarchspec(variance.model = list (garchOrder = c(1,1)),mean.model = list(armaOrder = c(final.order11,final.order12)),distribution.model = "ged")
	garch3fit<-ugarchfit(spec = garch3,data=indiceg,out.sample=sample)
	garch3fit
	#GARCH SSTD
	garch4<-ugarchspec(variance.model = list (garchOrder = c(1,1)),mean.model = list(armaOrder = c(final.order11,final.order12)),distribution.model = "sstd")
	garch4fit<-ugarchfit(spec = garch4,data=indiceg,out.sample=sample)
	garch4fit
	#GARCH NIG
	garch5<-ugarchspec(variance.model = list (garchOrder = c(1,1)),mean.model = list(armaOrder = c(final.order11,final.order12)),distribution.model = "nig")
	garch5fit<-ugarchfit(spec = garch5,data=indiceg,out.sample=sample)
	garch5fit
	#GARCH GHYP
	garch6<-ugarchspec(variance.model = list (garchOrder = c(1,1)),mean.model = list(armaOrder = c(final.order11,final.order12)),distribution.model = "ghyp")
	garch6fit<-ugarchfit(spec = garch6,data=indiceg,out.sample=sample)
	garch6fit
	#GARCH sged
	garch7<-ugarchspec(variance.model = list (garchOrder = c(1,1)),mean.model = list(armaOrder = c(final.order11,final.order12)),distribution.model = "sged")
	garch7fit<-ugarchfit(spec = garch7,data=indiceg,out.sample=sample)
	garch7fit

#######EGARCH

	egarch1<-ugarchspec(variance.model = list (model=model2,submodel=submodel,garchOrder = c(1,1)),mean.model = list(armaOrder = c(final.order11,final.order12)))
	egarch1fit<-ugarchfit(spec = egarch1,data=indiceg,out.sample=sample)
	egarch1fit
	#EGARCH T-STUD
	egarch2<-ugarchspec(variance.model = list (model=model2,submodel=submodel,garchOrder = c(1,1)),mean.model = list(armaOrder = c(final.order11,final.order12)),distribution.model = "std")
	egarch2fit<-ugarchfit(spec = egarch2,data=indiceg,out.sample=sample)
	egarch2fit
	#EGARCH GED
	egarch3<-ugarchspec(variance.model = list (model=model2,submodel=submodel,garchOrder = c(1,1)),mean.model = list(armaOrder = c(final.order11,final.order12)),distribution.model = "ged")
	egarch3fit<-ugarchfit(spec = egarch3,data=indiceg,out.sample=sample)
	egarch3fit
	#EGARCH SSTD
	egarch4<-ugarchspec(variance.model = list (model=model2,submodel=submodel,garchOrder = c(1,1)),mean.model = list(armaOrder = c(final.order11,final.order12)),distribution.model = "sstd")
	egarch4fit<-ugarchfit(spec = egarch4,data=indiceg,out.sample=sample)
	egarch4fit
	#EGARCH NIG
	egarch5<-ugarchspec(variance.model = list (model=model2,submodel=submodel,garchOrder = c(1,1)),mean.model = list(armaOrder = c(final.order11,final.order12)),distribution.model = "nig")
	egarch5fit<-ugarchfit(spec = egarch5,data=indiceg,out.sample=sample)
	egarch5fit
	#EGARCH GHYP
	egarch6<-ugarchspec(variance.model = list (model=model2,submodel=submodel,garchOrder = c(1,1)),mean.model = list(armaOrder = c(final.order11,final.order12)),distribution.model = "ghyp")
	egarch6fit<-ugarchfit(spec = egarch6,data=indiceg,out.sample=sample)
	egarch6fit
	#EGARCH sged
	egarch7<-ugarchspec(variance.model = list (model=model2,submodel=submodel,garchOrder = c(1,1)),mean.model = list(armaOrder = c(final.order11,final.order12)),distribution.model = "sged")
	egarch7fit<-ugarchfit(spec = egarch7,data=indiceg,out.sample=sample)
	egarch7fit

##TESTING THE MODELS
##GARCH TESTS

	garch1rs<-residuals(garch1fit)/sigma(garch1fit)
	garch1rsp<-garch1rs^2
	Box.test(garch1rsp,lag=10,type="Ljung-Box")
	Box.test(garch1rsp,lag=15,type="Ljung-Box")
	Box.test(garch1rsp,lag=20,type="Ljung-Box")
	jarque.bera.test(garch1rs)
	ArchTest(garch1rs,lag=10)
##GARCH STD TESTS

	garch2rs<-residuals(garch2fit)/sigma(garch2fit)
	garch2rsp<-garch2rs^2
	Box.test(garch2rsp,lag=10,type="Ljung-Box")
	Box.test(garch2rsp,lag=15,type="Ljung-Box")
	Box.test(garch2rsp,lag=20,type="Ljung-Box")
	jarque.bera.test(garch2rs)
	ArchTest(garch2rs,lag=10)

##GARCH GED
	garch3rs<-residuals(garch3fit)/sigma(garch3fit)
	garch3rsp<-garch3rs^2
	Box.test(garch3rsp,lag=10,type="Ljung-Box")
	Box.test(garch3rsp,lag=15,type="Ljung-Box")
	Box.test(garch3rsp,lag=20,type="Ljung-Box")
	jarque.bera.test(garch3rs)
	ArchTest(garch3rs,lag=10)

##GARCH SSTD

	garch4rs<-residuals(garch4fit)/sigma(garch4fit)
	garch4rsp<-garch4rs^2
	Box.test(garch4rsp,lag=10,type="Ljung-Box")
	Box.test(garch4rsp,lag=15,type="Ljung-Box")
	Box.test(garch4rsp,lag=20,type="Ljung-Box")
	jarque.bera.test(garch4rs)
	ArchTest(garch4rs)
##GARCH NIG

	garch5rs<-residuals(garch5fit)/sigma(garch5fit)
	garch5rsp<-garch5rs^2
	Box.test(garch5rsp,lag=10,type="Ljung-Box")
	Box.test(garch5rsp,lag=15,type="Ljung-Box")
	Box.test(garch5rsp,lag=20,type="Ljung-Box")
	jarque.bera.test(garch5rs)
	ArchTest(garch5rs,lag=10)

##GARCH GHYP

	garch6rs<-residuals(garch6fit)/sigma(garch6fit)
	garch6rsp<-garch6rs^2
	Box.test(garch6rsp,lag=10,type="Ljung-Box")
	Box.test(garch6rsp,lag=15,type="Ljung-Box")
	Box.test(garch6rsp,lag=20,type="Ljung-Box")
	jarque.bera.test(garch6rs)
	ArchTest(garch6rs)

##GARCH SGED

	garch7rs<-residuals(garch7fit)/sigma(garch7fit)
	garch7rsp<-garch7rs^2
	Box.test(garch7rsp,lag=10,type="Ljung-Box")
	Box.test(garch7rsp,lag=15,type="Ljung-Box")
	Box.test(garch7rsp,lag=20,type="Ljung-Box")
	jarque.bera.test(garch7rs)
	ArchTest(garch7rs)

##EGARCH TEST

	egarch1rs<-residuals(egarch1fit)/sigma(egarch1fit)
	egarch1rsp<-egarch1rs^2
	Box.test(egarch1rsp,lag=10,type="Ljung-Box")
	Box.test(egarch1rsp,lag=15,type="Ljung-Box")
	Box.test(egarch1rsp,lag=20,type="Ljung-Box")
	jarque.bera.test(egarch1rs)
	ArchTest(egarch1rs)

##EGARCH STD TEST

	egarch2rs<-residuals(egarch2fit)/sigma(egarch2fit)
	egarch2rsp<-egarch2rs^2
	Box.test(egarch2rsp,lag=10,type="Ljung-Box")
	Box.test(egarch2rsp,lag=15,type="Ljung-Box")
	Box.test(egarch2rsp,lag=20,type="Ljung-Box")
	jarque.bera.test(egarch2rs)
	ArchTest(egarch2rs)

##EGARCH GED

	egarch3rs<-residuals(egarch3fit)/sigma(egarch3fit)
	egarch3rsp<-egarch3rs^2
	Box.test(egarch3rsp,lag=10,type="Ljung-Box")
	Box.test(egarch3rsp,lag=15,type="Ljung-Box")
	Box.test(egarch3rsp,lag=20,type="Ljung-Box")
	jarque.bera.test(egarch3rs)
	ArchTest(egarch3rs)

##EGARCH SSTD TEST

	egarch4rs<-residuals(egarch4fit)/sigma(egarch4fit)
	egarch4rsp<-egarch4rs^2
	Box.test(egarch4rsp,lag=10,type="Ljung-Box")
	Box.test(egarch4rsp,lag=15,type="Ljung-Box")
	Box.test(egarch4rsp,lag=20,type="Ljung-Box")
	jarque.bera.test(egarch4rs)
	ArchTest(egarch4rs)

##EGARCH NIG

	egarch5rs<-residuals(egarch5fit)/sigma(egarch5fit)
	egarch5rsp<-egarch5rs^2
	Box.test(egarch5rsp,lag=10,type="Ljung-Box")
	Box.test(egarch5rsp,lag=15,type="Ljung-Box")
	Box.test(egarch5rsp,lag=20,type="Ljung-Box")
	jarque.bera.test(egarch5rs)
	ArchTest(egarch5rs)

##EGARCH GHYP TEST

	egarch6rs<-residuals(egarch6fit)/sigma(egarch6fit)
	egarch6rsp<-egarch6rs^2
	Box.test(egarch6rsp,lag=10,type="Ljung-Box")
	Box.test(egarch6rsp,lag=15,type="Ljung-Box")
	Box.test(egarch6rsp,lag=20,type="Ljung-Box")
	jarque.bera.test(egarch6rs)
	ArchTest(egarch6rs)
	
##EGARCH SGED TEST

	egarch7rs<-residuals(egarch7fit)/sigma(egarch7fit)
	egarch7rsp<-egarch7rs^2
	Box.test(egarch7rsp,lag=10,type="Ljung-Box")
	Box.test(egarch7rsp,lag=15,type="Ljung-Box")
	Box.test(egarch7rsp,lag=20,type="Ljung-Box")
	jarque.bera.test(egarch7rs)
	ArchTest(egarch7rs)	

# compare information criteria
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
info.mat
info.mat<-as.data.frame(info.mat)
info.mat
min(info.mat[1,2:14])

fix(info.mat)

# COMPUTING FORECASTS
#DYNAMIC
garch11n <- ugarchforecast(garch1fit, n.roll=sample, n.ahead=1)
garch11t <- ugarchforecast(garch2fit, n.roll=sample, n.ahead=1)
garch11g<- ugarchforecast(garch3fit,n.roll=sample,n.ahead=1)
garch11sstd<-ugarchforecast(garch4fit,n.roll=sample,n.ahead=1)
garch11nig<- ugarchforecast(garch5fit,n.roll=sample,n.ahead=1)
garch11ghyp<-ugarchforecast(garch6fit,n.roll=sample,n.ahead=1)
garch11sged<- ugarchforecast(garch7fit,n.roll=sample,n.ahead=1)
egarch11n <- ugarchforecast(egarch1fit, n.roll=sample, n.ahead=1)
egarch11t <- ugarchforecast(egarch2fit, n.roll=sample, n.ahead=1)
egarch11g<- ugarchforecast(egarch3fit,n.roll=sample,n.ahead=1)
egarch11sstd<-ugarchforecast(egarch4fit,n.roll=sample,n.ahead=1)
egarch11nig<- ugarchforecast(egarch5fit,n.roll=sample,n.ahead=1)
egarch11ghyp<-ugarchforecast(egarch6fit,n.roll=sample,n.ahead=1)
egarch11sged<- ugarchforecast(egarch7fit,n.roll=sample,n.ahead=1)


#COMPARING DYNAMIC FORECASTS 
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
fpm.mat
fpm.mat<-as.data.frame(fpm.mat)
fpm.mat<-t(fpm.mat)
fix(fpm.mat)
which(fpm.mat[,1]== min(fpm.mat[,1]))
##fitted(garch11t)
##sigma(garch11t)
plot(egarch11t,which=2)
plot(garch11sstd,which=2)

#STATIC
garch11n2 <- ugarchforecast(garch1fit,n.ahead=sample)
garch11t2<-ugarchforecast(garch2fit,n.ahead=sample)
garch11g2<- ugarchforecast(garch3fit,n.ahead=sample)
garch11sstd2<-ugarchforecast(garch4fit,n.ahead=sample)
garch11nig2<- ugarchforecast(garch5fit,n.ahead=sample)
garch11ghyp2<-ugarchforecast(garch6fit,n.ahead=sample)
garch11sged2<- ugarchforecast(garch7fit,n.ahead=sample)
egarch11n2<-ugarchforecast(egarch1fit,n.ahead=sample)
egarch11t2<-ugarchforecast(egarch2fit,n.ahead=sample)
egarch11g2<- ugarchforecast(egarch3fit,n.ahead=sample)
egarch11sstd2<-ugarchforecast(egarch4fit,n.ahead=sample)
egarch11nig2<- ugarchforecast(egarch5fit,n.ahead=sample)
egarch11ghyp2<-ugarchforecast(egarch6fit,n.ahead=sample)
egarch11sged2<- ugarchforecast(egarch7fit,n.ahead=sample)

plot(garch11nig2,which=1)
plot(garch1fit,which="all")
lines(indice,col="blue")
class(garch11n)
show(garch11nig2)
dataframe<-as.array(garch11nig2)
garch11nig2
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
