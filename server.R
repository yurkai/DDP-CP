# library(shiny)

shinyServer(function(input, output, session) {

observe({
        valDistance <- input$Distance
        valTime <- input$Time
        valPace <- input$Pace
        switch(input$dtp,
                Time = updateSliderInput(session, "Time", 
                                  value = dtpT(valDistance, valPace)),
                Pace = updateSliderInput(session, "Pace", 
                                  value = dtpP(valDistance, valTime)),
                Distance = updateSliderInput(session, "Distance", 
                                  value = dtpD(valTime, valPace))
        )
})

# plot
output$plot <- renderPlot({
        graph <- ggplot(data = eqtGraph, aes(x = Distance, y = Seconds)) + 
                geom_line( aes(group = VO2max, colour = factor(VO2max)) ) +
                scale_y_log10(breaks = yBreaks, labels = yLabels, limits = c(220, 22000)) + 
                geom_point(aes(colour = factor(VO2max))) +
                labs(x = "Distance, km", y = "Time, hr:min:sec", colour = "VO2max")
        
        VO2max <- round(predict(fitVO2, 
                                data.frame(Distance = input$Distance, 
                                           Seconds = as.numeric(input$Time))), 
                        1)
        userT <- setUserT(VO2max)
        graph + geom_point(data = userT, size = 2.7, aes(group = VO2max, colour = "you")) + 
                geom_line(data = userT, aes(group = VO2max, colour = "you"), size = 1.3) + 
                scale_colour_manual(limits=c("you", levels(factor(eqtGraph$VO2max))),
                                    labels = c("you", "newbie", "amateur", "pro"),
                                    values=c("orange", 2:4))
                # "champ", "amateur", "newbie"
})

output$RPvalue <- renderText({
        RPD <- input$RP
        if (!is.numeric(input$RP)) RPD <- 1
        if (RPD <= 0) RPD <- 1
        VO2max <- round(predict(fitVO2, 
                                data.frame(Distance = input$Distance, 
                                           Seconds = as.numeric(input$Time))), 
                        1)
        RPTime <- origin
        second(RPTime) <- round(predict(fitRaces, data.frame(VO2max = VO2max, Distance = RPD)))
        paste("Predicted Time - ", as.character(RPTime, "%T"))
})

output$Values <- renderText({
        VO2max <- round(predict(fitVO2, 
                                data.frame(Distance = input$Distance, 
                                           Seconds = as.numeric(input$Time))), 
                        1)
        paste(
                paste0("Distance, km - ", round(input$Distance, 1) ),
                paste0("Time, hr:min:sec - ", as.character(input$Time, "%T") ),
                paste0("Pace, min:sec - ", as.character(input$Pace, "%M:%S") ),
                paste0("Speed, km/hr: ", 
                       round(1/time_length(input$Pace - orig, unit = "hour"), 1) ),
                paste0("VO2max, mL/(kg*min): ", VO2max),
                sep = "\n")
})

})
