# DDP-CP
Developing Data Products Course Project on Coursera

This repo contains files for runner's calculator on shinyapps.io platform. These files are
* ui.R - user interface
* server.R - server code
* equivtable.csv - data I use for train models
* const.R - 'constants' I use in UI and calculations
* dtp.R - functions for caomputations of distance, time and pace
* eqt.R - some code for operationg with equivalnce tables
* graph.R - code I use to plot results
* racesmod.rds - model that predicts time races (library brnn)
* vo2mod.rds - model that predicts VO2 max (library brnn)

Both models are Bayes regularized neural network (find more on https://rpubs.com/yurkai/DDPCP)
