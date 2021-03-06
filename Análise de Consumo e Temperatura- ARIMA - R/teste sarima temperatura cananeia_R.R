bd=read.table("temperatura.txt",header=T,dec=",")
bd
z=matrix(bd[1:110,2])
z



plot(z,main='serie original',xlab='Anos',ylab='Consumo',type="l",col="blue")
m = acf(z,lag.max=20, plot=T)
m
m$lag = m$lag*12
m$lag

#Identifica��o

#Diferen�a Simples
dif1=diff(z)
plot(dif1,type="l",main='serie diferenciada',xlab='Anos',ylab='Consumo')

dif2=diff(dif1)
plot(dif2,type="l",main='serie diferenciada 2 vezes',xlab='Anos',ylab='Consumo')

dif3=diff(dif2)
plot(dif3,type="l",main='serie diferenciada 3 vezes',xlab='Anos',ylab='Consumo')


#Diferen�a Sazonal
dif1s=diff(z,lag=12)
plot(dif1s,main='serie sazonalmente diferenciada',xlab='Anos',ylab='Consumo',type="l")


dif2s=diff(dif1s,lag=12)
plot(dif2s,main='serie sazonalmente diferenciada',xlab='Anos',ylab='Consumo',type="l")


dif3s=diff(dif2s,lag=12)
plot(dif3s,main='serie sazonalmente diferenciada',xlab='Anos',ylab='Consumo',type="l")

par(mfrow=c(2,1))
AC<-acf(dif1, lag.max = 20)
ACP<-pacf(dif1, lag.max = 20)





####################################################################################
x = matrix(bd[1:110,2])
x
plot(x,type="l",ylab="Temperatura Canan�ia - SP",xlab="M�s", 
col="blue", main="S�rie Original")
y = log(x)

#Precisa de Transforma��o?
tr=c(mean(bd[1:6,2]),mean(bd[7:12,2]),mean(bd[13:18,2]),mean(bd[19:24,2])
     )
tr
plot(tr)

#log da s�rie original
plot(x,main='serie original',xlab='Anos',ylab='No de passageiros',type="l")
m = acf(x,lag.max=20, plot=T, main="Fun��o de Autocorrela��o da S�rie")
m$lag = m$lag*12
plot(m,main='serie original')

#1� diferen�a simples
plot(diff(x),main='serie diferenciada',xlab='Anos',ylab='No de passageiros',type="l")
m = acf(diff(x),lag.max=36, plot=T)
m$lag = m$lag*12
m$lag
plot(m, main = '1a diferenca')


#2� diferen�a simples
plot(diff(diff(y)),main='serie diferenciada',xlab='Anos',ylab='No de passageiros',type="l")
par(mfrow=c(2,1))
m = acf(diff(diff(x)),lag.max=36, plot=T)
n = pacf(diff(diff(x)),lag.max=36, plot=T)
m$lag = m$lag*12
m$lag
plot(m, main = '1a diferenca')

#1� diferen�a sazonal
plot(diff(x,lag=12),main='1� Diferen�a Sazonal',xlab='Anos',
ylab='Temperatura Canan�ia SP',type="l", col="blue")
m = acf(diff(x,lag=12),lag.max=36, plot=T,
main="Autocorrela��o da S�rie Sazonalmente Diferenciada")
m$lag = m$lag*12
plot(m, main='1a diferen�a sazonal')


#2� diferen�a sazonal
plot(diff((diff(x,lag=12)),lag=12),main='serie sazonalmente diferenciada',xlab='Anos',ylab='Consumo',type="l")
par(mfrow=c(2,1))
m = acf(diff((diff(x,lag=12)),lag=12),lag.max=36, plot=T )
n = pacf(diff((diff(x,lag=12)),lag=12),lag.max=36, plot=T )
m$lag = m$lag*12
plot(m, main='2a diferen�a sazonal')



#Diferen�as necess�rias
z =(diff(diff(x,lag=12)))
plot(z,main='serie com 1 diferenca simples e 1 sazonal',
xlab='Meses',ylab='IPI',type="l")
par(mfrow=c(2,1))
ACFZ = acf(z, lag.max=20, plot=T)
ACPZ<-pacf(z, lag.max =20)
m$lag = (m$lag*12)
plot(ACFZ, main='1 diferen�a simples e 1 sazonal')


library(stats)    #  Modelos ARIMA


modelosaz=arima(x,order=c(2,1,1),seasonal=list(order=c(0,1,1),period=12))
#include.mean=F,fixed=c(0,0,0,0,0,0,0,NA,NA,NA))
			
modelosaz

#Diagn�stico
tsdiag(modelosaz)
res=modelosaz$residuals
res
var(res)
mean(res)

par(mfrow=c(2,1))
acf(res,lag.max=20)
pacf(res,lag.max=20)


#Previs�o
pv=predict(modelosaz,n.ahead=10)
pv
prev=matrix(pv$pred)
prev




#####################################################################################################################
z = matrix(bd[1:142,2])
z
plot(z,type="l")

par(mfrow=c(2,1))
acf(z,lag.max=48)
pacf(z,lag.max=48)

#IDENTIFICA��O

#Diferen�a Simples
dif1=diff(z)
plot(dif1,type="l",main='serie diferenciada',xlab='Anos',ylab='Consumo')

dif2=diff(dif1)
plot(dif2,type="l",main='serie diferenciada 2 vezes',xlab='Anos',ylab='Consumo')

dif3=diff(dif2)
plot(dif3,type="l",main='serie diferenciada 3 vezes',xlab='Anos',ylab='Consumo')


#Diferen�a Sazonal
dif1s=diff(z,lag=12)
plot(dif1s,main='serie sazonalmente diferenciada',xlab='Anos',ylab='Consumo',type="l")


dif2s=diff(dif1s,lag=12)
plot(dif2s,main='serie sazonalmente diferenciada',xlab='Anos',ylab='Consumo',type="l")


dif3s=diff(dif2s,lag=12)
plot(dif3s,main='serie sazonalmente diferenciada',xlab='Anos',ylab='Consumo',type="l")


x=diff(dif1s)


par(mfrow=c(2,1))
AC<-acf(x, lag.max = 48)
ACP<-pacf(x, lag.max = 48)

# AJUSTE DO MODELO SARIMA(1,0,0)x(1,0,0)12
fit=arima(z,order=c(2,1,1),seasonal=list(order=c(1,1,0),period=12),
include.mean=TRUE,fixed=c(NA,NA,NA,NA)
)

fit

# DIAGNOSTICO DO MODELO
tsdiag(fit)

plot(fit$res)

# IDENTIFICACAO DE AUTOCORRELACAO NA VARIANCIA

par(mfrow=c(2,1))
acf(fit$res^2)
pacf(fit$res^2)

# TRANSFORMACAO DA SERIE
w= log(z)
plot(w,type="l")
acf(w)
pacf(w)

# DIFERENCIACAO NAO SAZONAL
wd = diff(w)

acf(wd,lag.max=48)
plot(wd)

# DIFERENCIACAO SAZONAL
wds =diff(w,12)
plot(wds,type="l")
acf(wds,lag.max=48)
pacf(wds,lag.max=48)

# AJUSTE DO MODELO SARIMA(1,1,0)X(1,1,0)12 PARA L0GARITMO
fit2<-arima(w,order=c(2,1,2),seasonal=c(2,1,1))
tsdiag(fit2)
plot(fit2$res)
acf(fit2$res^2)
