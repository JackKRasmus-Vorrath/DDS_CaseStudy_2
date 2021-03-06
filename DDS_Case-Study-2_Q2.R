#The following calculates log returns and volatility measures of time series data on Automatic Data Processing, Inc. (ADP) stock performance using three different decay factors.

library(tseries)
options("getSymbols.warning4.0"=FALSE)
options("getSymbols.yahoo.warning"=FALSE)
ADPdata <- get.hist.quote('ADP', quote = 'Close')
head(ADPdata)


##Lagged Log Returns

ADPret <- log(lag(ADPdata)) - log(ADPdata)
head(ADPret)


##Calculated Volatility Measure

ADPvol <- sd(ADPret) * sqrt(250) * 100
ADPvol


##Exponentially Downweighted Continuous Lookback Window

Vol <- function(d, logrets){
  var = 0
  lam = 0
  varlist <- c()
  for (r in logrets){
    lam = lam*(1 - 1/d) + 1
    var = (1 - 1/lam)*var + (1/lam)*r^2
    varlist <- c(varlist, var)
  }
  sqrt(varlist)
}
volest <- Vol(10, ADPret)
head(volest)
volest2 <- Vol(30, ADPret)
head(volest2)
volest3 <- Vol(100, ADPret)
head(volest3)


##Plotted Volatility Curves

plot(volest, type = 'l', col = 'black', xlab = 'Time Index: January 1991 - Present', ylab = 'Volatility Estimate', main = 'ADP, Inc. Log-lagged Stock Return Volatility Curves')
lines(volest2, type = 'l', col = 'blue')
lines(volest3, type = 'l', col = 'red')
legend("topright", c('.90 decay factor', '.967 decay factor', '.99 decay factor'), lty=c(1, 1, 1), col = c('black', 'blue', 'red'))


#The volatility curve with decay factor 0.99 demonstrates substantially smoother features.
