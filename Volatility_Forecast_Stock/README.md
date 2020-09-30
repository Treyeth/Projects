# Volatility modelling using ARMA-GARCH and ARMA-EGARCH

The scope of this project was to model the volatility of DAX Performance, CAC40, S&P 500, Nikkei 225 indices from Germany, France, USA and Japan in order to generate 5 day forecasts on their stability. The analysed takes place between 27.02.2016 - 27.02.2018. In the empiric analysis two types of hybrid models are used: ARMA-GARCH and ARMA-EGARCH. For the errors of the model we take into account different types of distributions: normal distribution, t-student, skew-student, skew-generalized error distribution, normal inverse gaussian distribution, generalized hyperbolic and Johnson's SU distribution.

The Forecasts are generated dynamically on a 5 day period and their accuracy is measures with mean squared error (MSE) and absolute mean error (MAE). It is also searched if the model with the lowest value of the Akaike criterion generates the best forecasts.

![Screenshot](Images/histogram.png)

![Screenshot](Images/evolution_index.png)

# Estimating the ARMA models, testing the autocorrelation and the heteroskedasticity

In order to find the parameters of the autoregressive model (AR) and the moving average model (MA), multiple models are estimated with different values for the order of AR and MA. The model will be chosen based on the informational criterion Akaike (AIC). The model with the samllest value will be chosen as the best. 

We will take as an example for the next steps the DAX index:

| Model         | AIC value     |
| ------------- |:-------------:| 
| ARMA(1,0)     | -3319.38|
| ARMA(1,1)     |   -3317.38    |
| ARMA(1,2)     | 	-3315.38    |
|ARMA(2,1)     |	-3320.07 |
|ARMA(2,2)	|-3323.25 |
|ARMA(2,3)	|-3320.55 |
|ARMA(3,3)	|**-3330.71** |

Going through the previous table, we can see that the best model for DAX would be an ARMA(3,3). 
The next step which we need to take is to check for the presence of autocorrelation and heteroskedasticity in the residuals of the ARMA model. The presence of autocorrelation is determined using the Ljung-Box test and the ARCH-LM test for the presence of heteroskedasticity.

	


## DAX Forecast
![Screenshot](Images/forecast_dax.png)

## CAC 40 Forecast
![Screenshot](Images/forecast_cac_40_mse.png)
![Screenshot](Images/forecast_cac_40_mae.png)

## S&P 500 Forecast
![Screenshot](Images/forecast_s&p_500.png)

## Nikkei 225 Forecast
![Screenshot](Images/forecast_nikkei_225_mse.png)
![Screenshot](Images/forecast_nikkei_225_mae.png)
