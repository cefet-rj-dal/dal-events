##---------------------------------------------------------------
## 3W Dataset - Oil wells
## Multivariate series with labeled change points
## Recommended use: multivariate or univariate CPD detection
##---------------------------------------------------------------
library(united)
library(daltoolbox)
library(harbinger)
library(tspredit)
library(daltoolboxdp)


## Load series ----------------------
data(oil_3w_Type_1)
#Selecting a well as example
data <- oil_3w_Type_1$`WELL-00001_20140124213136`
summary(data)
plot(as.ts(data))


## Preprocessing ----------------------
ts <- data[,2:8]
#preproc <- ts_norm_gminmax()
#preproc <- fit(preproc, ts)
#ts <- transform(preproc, ts)

head(ts)
plot(as.ts(ts))


## Univariate series selection ----------------------
#series <- ts$P_MON_CKP
series <- ts$p_tpt

series <- data$p_tpt
series <- data$p_mon_ckp

plot(as.ts(series))


## Event detection experiment ----------------------
#Detection steps
#Establishing arima method
model <- hcp_binseg()

#Fitting the model
model <- fit(model, series)

#Making detections
detection <- detect(model, series)


# Results analysis ----------------------
#Filtering detected events
print(detection |> dplyr::filter(event==TRUE))

#Ploting the results
grf <- har_plot(model, series, detection, data$event)
plot(grf)

#Evaluating the detection metrics
ev <- evaluate(model, detection$event, data$event)
print(ev$confMatrix)


# SoftEd
ev_soft <- evaluate(har_eval_soft(sw=90), detection$event, data$event)
ev_soft$confMatrix
ev_soft$accuracy
ev_soft$precision
ev_soft$recall
ev_soft$F1
