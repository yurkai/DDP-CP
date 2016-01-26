# const
eqtNames <- c("1.6", "5.0", "10.0", "21.1", "42.2", "VO2max")

# read BO2max model
fitVO2 <- readRDS("vo2mod.rds")

eqt <- read.csv('equivtable.csv', sep = ';', stringsAsFactors = FALSE)

# transformation of eqt. 
# 1.6|5.0|10.0|21.1|42.2|VO2max --> VO2max|Distance|Time|Seconds
eqtBrush <- function(dat) {
        names(dat) <- eqtNames
        dat <- gather(dat, Distance, Time, 1:5)
        dat$Time  <- parse_date_time(paste(rep(origin, length(dat$Time)), 
                                           dat$Time), "Ymd HMS")
        dat$Seconds <- as.numeric(dat$Time)
        
        dat
}
