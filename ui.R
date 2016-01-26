library(shiny)
library(lubridate)
library(tidyr)
library(ggplot2)
library(brnn)
source("const.R")
source("dtp.R")
source("eqt.R")
source("graph.R")

# UI
shinyUI(fluidPage(
        titlePanel("Runner helper"),
        sidebarLayout(
                sidebarPanel(
                        sliderInput("Distance",
                                    "Distance, km",
                                    min = minDistance,
                                    max = maxDistance,
                                    value = valDistance,
                                    step = stepDistance),
                        sliderInput("Time",
                                    "Time, hr:min:sec",
                                    min = minTime,
                                    max = maxTime,
                                    value = valTime,
                                    step = 1,
                                    timeFormat = "%H:%M:%S",
                                    timezone = "+0000"),
                        sliderInput("Pace",
                                    "Pace, min:sec",
                                    min = minPace,
                                    max = maxPace,
                                    value = valPace,
                                    step = 1,
                                    timeFormat = "%M:%S",
                                    timezone = "+0000"),
                        radioButtons("dtp", label = "Select calculated value",
                                     choices = list("Distance" = "Distance", 
                                                    "Time" = "Time", 
                                                    "Pace" = "Pace"), 
                                     selected = "Pace"),
                        verbatimTextOutput("Values")
                ),
                mainPanel( 
                        h3("Race predictor"),
                        plotOutput("plot"),
                        numericInput("RP", 
                                     label = "Custom distance in km", 
                                     value = 15,
                                     min = 1,
                                     max = 50),
                        textOutput("RPvalue"),
                        br(),
                        h4("Instructions"),
                        p("This app provide runners (pace) calculator and race predictor features. For example, you want to run a marathon in 3 hours and using this app you may find you optimal pace (runners use pace instead of speed). Pace 6:00 means that you need 6 minutes to run 1 km."),
                        p("1. Runner's calculator: select parameter you want to calculate and play with sliders. If you take real values from life you'll get adequate result."),
                        p("2. Race Predictor: set your best race using sliders and take a look on plot. You may also enter desirable distance below and get your time."),
                        p("P.s. Full code on: https://github.com/yurkai/DDP-CP"),
                        p("P.s. This app uses Bayesian neural networks to predict your VO2max and race time. Find more info on this page: http://rpubs.com/yurkai/DDPCP")
                )
                
        )
))
