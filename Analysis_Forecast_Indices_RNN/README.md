# Analysis and forecast of stock indices using RNNs

The scope of this project is to analyse and to forecast the trend of Dow Jones Industrial Average, SMI, BEL 20 and BET stock market indices. The chosen period for this analysis is 01.02.2012-31.01.2020. In this project 2 types of models are used, LSTM and GRU. These models have the ability to take into account long-term dependencies, which make them adequate for time sequence modelling. The training set contains data from 01.02.2012 until 31.12.2018 and the train set from 01.01.2019 up until 31.01.2020. The dinamic forecasts use sequences with 15 days each. In order to observe the accuracy, the forecasts are compared with the real values in the testing set. 

