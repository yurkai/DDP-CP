# These function allows calculate one of parameters using other two
# Distance, Time, Pace

dtpT <- function(valDistance, valPace) {
        valTime <- orig
        second(valTime) <- valDistance * 
                time_length(valPace - orig, unit = "second")
        valTime
}

dtpP <- function(valDistance, valTime) {
        valPace <- orig
        second(valPace) <- round(time_length(valTime - orig, unit = "second") /
                valDistance)
        valPace
}

dtpD <- function(valTime, valPace) {
        valDistance <- round(time_length(valTime - orig, unit = "second") / 
                             time_length(valPace - orig, unit = "second"), 1)
        valDistance
}