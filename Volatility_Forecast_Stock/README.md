# Volatility modelling using ARMA-GARCH and ARMA-EGARCH

The scope of this project was to model the volatility of DAX Performance, CAC40, S&P 500, Nikkei 225 indices from Germany, France, USA and Japan in order to generate 5 day forecasts on their stability. The analysed takes place between 27.02.2016 - 27.02.2018. In the empiric analysis two types of hybrid models are used: ARMA-GARCH and ARMA-EGARCH. For the errors of the model we take into account different types of distributions: normal distribution, t-student, skew-student, skew-generalized error distribution, normal inverse gaussian distribution, generalized hyperbolic and Johnson's SU distribution.

The Forecasts are generated dynamically on a 5 day period and their accuracy is measured with mean squared error (MSE) and absolute mean error (MAE). It is also searched if the model with the lowest value of the Akaike criterion generates the best forecasts.

![Screenshot](Images/histogram.png)

![Screenshot](Images/evolution_index.png)

# Estimating the ARMA models, testing the autocorrelation and the heteroskedasticity

In order to find the parameters of the Autoregressive model (AR) and the Moving Average model (MA), multiple models are estimated with different values for the order of AR and MA. The model will be chosen based on the informational criterion Akaike (AIC). The model with the samllest value will be chosen as the best. 

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

| Index         | Q(10)         | p-value | Q(15) | p-value| Q(20) | p-value|
| ------------- |:-------------:| -----:| ------:| ------:| ------:| ------:|
| DAX	        | 47.493	| 0.000 | 51.588 | 0.000  | 53.172 | 0.000

| Index        | ARCH-LM        | p-value |
| ------------- |:-------------:| -----:|
| DAX	        | 41.007	| 0.000 |

The autocorrelation is confirmed by the values from the Ljung-Box test where the null hypothesis (H0: residuals are independent) is rejected. The heteroskedasticity is confirmed by the ARCH-LM where the null hypothesis is also rejected (H0: residuals are homoskedastic).

Obtaining this information, we can now model the volatility with the help of GARCH(1,1) and EGARCH(1,1). 

# Estimating ARMA-GARCH and ARMA-EGARCH, checking residuals and choosing the adequate model

In this chapter, GARCH(1,1) and EGARCH(1,1) models will be estimated using multiple different distribution errors. In order to compare the forecasts with real data, we will leave the last 5 observations outside of the sample for each model. When choosing the most adequate models, the information criterion Akaike will be used. At the same, the forecasts for each model is compared using MSE and MAE. The validity of the model is afterwards checked by checking the standardised residuals in order to test if the autocorrelation is eliminated from the residuals and if they are homoskedastic.

| Model         | AIC.          | MSE   |   MAE | 
| ------------- |:-------------:| -----:| ------:|
|GARCH-NORM	|-6.6888	|0.000003861	|0.001687|
|GARCH-STD	|-6.7154	|0.000007018	|0.002495|
|GARCH-GED	|-6.7182	|0.000006123	|0.002381|
|GARCH-SSTD	|-6.7126	|0.000006849	|0.002474|
|GARCH-NIG	|-6.7190	|**0.000002977**|**0.001473**|
|GARCH-GHYP	|-6.7122	|0.000006066	|0.002121|
|GARCH-SGED	|-6.7150	|0.000005728	|0.002093|
|EGARCH-NORM	|-6.6816	|0.000005650	|0.001994|
|EGARCH-STD	|**-6.7882**	|0.000008711	|0.002549|
|EGARCH-GED	|-6.7654	|0.000006977	|0.002437|
|EGARCH-SSTD	|-6.7646	|0.000005613	|0.002241|
|EGARCH-NIG	|-6.7700	|0.000006897	|0.002442|
|EGARCH-GHYP	|-6.7607	|0.000005602	|0.002229|
|EGARCH-SGED	|-6.7660	|0.000007001	|0.002487|

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
