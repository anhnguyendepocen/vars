library(tseries)
library(urca)
data(Raotbl3)
attach(Raotbl3)
lc <- ts(lc, start=c(1966,4), end=c(1991,2),
         frequency=4)
li <- ts(li, start=c(1966,4), end=c(1991,2),
         frequency=4)
lw <- ts(lw, start=c(1966,4), end=c(1991,2),
         frequency=4)
ukcons <- window(cbind(lc, li, lw), start=c(1967, 2),
                 end=c(1991,2))
lc.eq <- summary(lm(lc ~ li + lw, data=ukcons))
li.eq <- summary(lm(li ~ lc + lw, data=ukcons))
lw.eq <- summary(lm(lw ~ li + lc, data=ukcons))
error.lc <- ts(resid(lc.eq), start=c(1967,2),
               end=c(1991,2), frequency=4)
error.li <- ts(resid(li.eq), start=c(1967,2),
               end=c(1991,2), frequency=4)
error.lw <- ts(resid(lw.eq), start=c(1967,2),
               end=c(1991,2), frequency=4)
ci.lc <- ur.df(error.lc, lags=1, type='none')
ci.li <- ur.df(error.li, lags=1, type='none')
ci.lw <- ur.df(error.lw, lags=1, type='none')
jb.lc <- jarque.bera.test(error.lc)
jb.li <- jarque.bera.test(error.li)
jb.lw <- jarque.bera.test(error.lw)
