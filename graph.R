# for ggplot
yBreaks  <- c(5*60, 10*60, 18*60, 30*60, 50*60, 80*60, 2*60*60, 3*60*60, 4*60*60, 5*60*60, 6*60*60)
yLabels  <- c("5:00", "10:00", "18:00", "30:00", "50:00", "1:20:00", "2:00:00", "3:00:00", "4:00:00", "5:00:00", "6:00:00")

# basic lines
eqtGraph <- eqt[c(1,21,50), ]
eqtGraph <- eqtBrush(eqtGraph)
userT <- eqtBrush(eqt[11,])
fitRaces <- readRDS("racesmod.rds")
VO2max <- 52

# use this functions to add users line to plot
setUserT <- function(VO2max) {
        userT <- eqtBrush(eqt[11,])
        userT$VO2max <- VO2max
        userT[1,4] <- round(predict(fitRaces, data.frame(VO2max = VO2max, Distance = 1.6)))        # 1.6 km
        userT[2,4] <- round(predict(fitRaces, data.frame(VO2max = VO2max, Distance = 5)))          # 5 km
        userT[3,4] <- round(predict(fitRaces, data.frame(VO2max = VO2max, Distance = 10)))         # 10 km
        userT[4,4] <- round(predict(fitRaces, data.frame(VO2max = VO2max, Distance = 21.1)))       # 21.1 km
        userT[5,4] <- round(predict(fitRaces, data.frame(VO2max = VO2max, Distance = 42.2)))       # 42.2 km
        
        userT
}