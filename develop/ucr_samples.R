##---------------------------------------------------------------
## UCR Anomaly Archive
## Univariate series with labeled anomalies
## Recommended use: univariate event detection
##---------------------------------------------------------------

library(united)
library(daltoolbox)
library(daltoolboxdp)
library(harbinger)
library(tspredit)

## Load series ----------------------
data(ucr_ecg)


## Univariate series selection ----------------------
#Selecting
for (i in 1:length(ucr_ecg)){
  plot(as.ts(ucr_ecg[[i]]),
       main=paste("UCR", i))
}


series <- ucr_ecg[[3]]

plot(as.ts(series))



#Labels
#IDX = 5400_5600 -> Range defined in dataset documentation
#series$event <- 0
#series$event[5400:5600] <- 1
#names(series) <- c("value", "event")
#plot(as.ts(series))

#Sample
#Test: 2500
start = 5000


train <- series[1:start,]
plot(as.ts(train))


test <- series[(start+1):nrow(series),]
plot(as.ts(test))

## Preprocessing ----------------------
preproc <- ts_norm_gminmax()
preproc <- fit(preproc, series$value)
series$value <- transform(preproc, series$value)
head(series)

plot(as.ts(series))

## Event detection experiment ----------------------
#Detection steps
#Establishing arima method
model <- hanr_arima()
model <- hanr_fbiad()
model <- hanr_remd()
model <- han_autoencoder(3, 2, autoenc_ed, num_epochs = 1500)

#Fitting the model
#model <- fit(model, series$value)
model <- fit(model, train$value)


#Making detections
detection <- detect(model, series$value)
detection <- detect(model, test$value)


# Results analysis ----------------------
#Filtering detected events
print(detection |> dplyr::filter(event==TRUE))

#Ploting the results
grf <- har_plot(model, series$value, detection, series$event) #Complete series
grf <- har_plot(model, test$value, detection, test$event) #Test sample
plot(grf)

#Evaluating the detection metrics
#Complete series
ev <- evaluate(model, detection$event, series$event)

#Complete series
ev <- evaluate(model, detection$event, test$event)
print(ev$confMatrix)


#SoftEd Evaluation
s=200
#Complete series
ev_soft <- evaluate(har_eval_soft(sw=s), detection$event, series$event)

#Test sample
ev_soft <- evaluate(har_eval_soft(sw=s), detection$event, test$event)
print(ev_soft$confMatrix)

print(ev_soft$accuracy)
print(ev_soft$F1)

