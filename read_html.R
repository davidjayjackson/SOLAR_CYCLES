library(tidyverse)
library(pracma)
library(lubridate)
# Import kanzel date
rm(list=ls())
K <- data.table::fread("../db/kh_spots.csv")
K$Ymd <- as.Date(K$Ymd)
K$Year <- year(K$Ymd)
K$Month <- month(K$Ymd)
K$Spots <- K$s_n + K$s_s
K1 <- K %>% select(Ymd,R)
## Begin Movie Averages calc(pracma):
## Types: (s)imple, (t)riangular, (w)eighted,
##  (m)odified, (e)xponentail, (r)running
##
K1$S <- movavg(K$R, 365,"s")
K1$T <- movavg(K$R, 365,"t")
K1$W <- movavg(K$R, 365,"w")
K1$M <- movavg(K$R, 365,"m")
K1$E <- movavg(K$R, 365,"e")
K1$Run <- movavg(K$R, 365,"r")
summary(K1)
ggplot(K1) + geom_line(aes(x=Ymd,y=S,col="Simple")) +
  geom_line(aes(x=Ymd,y=T,col="triangular")) +
  geom_line(aes(x=Ymd,y=W,col="Weighted" )) +
  geom_line(aes(x=Ymd,y=M,col="Modified" )) +
  geom_line(aes(x=Ymd,y=E,col="Exponential" )) +
  geom_line(aes(x=Ymd,y=Run,col="Running" )) +
  labs(title="Comparing Six types of Moving Average",
       subtitle="Kanzel ISN: 1951 - 2020",
       x="Year-Month-Day",y="365 Days Moving Averages")

K1 %>% filter(Ymd>="2008-01-01") 
ggplot() + geom_line(aes(x=Ymd,y=S,col="Simple")) +
  geom_line(aes(x=Ymd,y=T,col="triangular")) +
  geom_line(aes(x=Ymd,y=W,col="Weighted" )) +
  geom_line(aes(x=Ymd,y=M,col="Modified" )) +
  geom_line(aes(x=Ymd,y=E,col="Exponential" )) +
  geom_line(aes(x=Ymd,y=Run,col="Running" )) +
  labs(title="Comparing Six types of Moving Average",
       subtitle="Kanzel ISN: 2008 - 2020",
       x="Year-Month-Day",y="365 Days Moving Averages")