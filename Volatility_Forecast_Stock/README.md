# Volatility modelling using ARMA-GARCH and ARMA-EGARCH

The scope of this project was to model the volatility of DAX Performance, CAC40, S&P 500, Nikkei 225 indices from Germany, France, USA and Japan in order to generate 5 day forecasts on their stability. The analysed takes place between 27.02.2016 - 27.02.2018. In the empiric analysis two types of hybrid models are used: ARMA-GARCH and ARMA-EGARCH. For the errors of the model we take into account different types of distributions: normal distribution, t-student, skew-student, skew-generalized error distribution, normal inverse gaussian distribution, generalized hyperbolic and Johnson's SU distribution.

The Forecasts are generated dynamically on a 5 day period and their accuracy is measures with mean squared error (MSE) and absolute mean error (MAE). It is also searched if the model with the lowest value of the Akaike criterion generates the best forecasts.

![Screenshot](Images/histogram.png)

![Screenshot](Images/evolution_index.png)

| Model         | AIC value     |
| ------------- |:-------------:| 
| ARMA(1,0)     |.  *-3319.38*. |
| ARMA(1,1)     |   -3317.38    |
| ARMA(1,2)     | 	-3315.38    |

| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

	

ARMA(2,1)	-3320.07
ARMA(2,2)	-3323.25
ARMA(2,3)	-3320.55
ARMA(3,3)	-3330.71
