data(oil_3w_Type_5)

#New pattern adjust -----------------------
data <- oil_3w_Type_5$Type_5


#Series 1---------------
#Clean NA
summary(data[[1]])
data[[1]]$T_JUS_CKGL <- NULL
plot(as.ts(data[[1]]))

#Add event
labels <- data.frame(class = data[[1]]$class)
plot(as.ts(labels))

labels$cpd <- 0


cp = FALSE
for (i in 1:nrow(labels)){
  if (cp == FALSE){
    if(!is.na(labels$class[i]) && labels$class[i] != 0){
      print("Ponto de mudança localizado em:")
      print(i)
      labels$cpd[i] <- 1
      cp_idx <- i
      cp <- TRUE
    }
  }
}

cp_idx <- cp_idx+1
cp = FALSE

for (i in cp_idx:nrow(labels)){
  if (cp == FALSE){
    if(!is.na(labels$class[i]) && labels$class[i] != 105){ #Replace number by class
      print("Ponto de mudança localizado em:")
      print(i)
      labels$cpd[i] <- 1
      cp_idx <- i
      cp  <- TRUE
    }
  }
}

sum(labels$cpd)


plot(as.ts(labels))

#Add CPD labels
data[[1]]$event <- labels$cpd
#Remove old classes -----------------------
data[[1]]$class <- NULL

plot(as.ts(data[[1]]))


#Series 2---------------
#Clean NA
summary(data[[2]])
data[[2]]$T_JUS_CKGL <- NULL
plot(as.ts(data[[2]]))

#Add event
labels <- data.frame(class = data[[2]]$class)
plot(as.ts(labels))

labels$cpd <- 0


cp = FALSE
for (i in 1:nrow(labels)){
  if (cp == FALSE){
    if(!is.na(labels$class[i]) && labels$class[i] != 0){
      print("Ponto de mudança localizado em:")
      print(i)
      labels$cpd[i] <- 1
      cp_idx <- i
      cp <- TRUE
    }
  }
}

cp_idx <- cp_idx+1
cp = FALSE

for (i in cp_idx:nrow(labels)){
  if (cp == FALSE){
    if(!is.na(labels$class[i]) && labels$class[i] != 105){
      print("Ponto de mudança localizado em:")
      print(i)
      labels$cpd[i] <- 1
      cp_idx <- i
      cp  <- TRUE
    }
  }
}

sum(labels$cpd)


plot(as.ts(labels))

#Add CPD labels
data[[2]]$event <- labels$cpd
#Remove old classes -----------------------
data[[2]]$class <- NULL


plot(as.ts(data[[2]]))


#TO DO: Complete labels adjust to series 3 to 12

#Adjust names and types -----------------------
for (i in 1:length(data)){
  data[[i]]$event <- as.logical(as.integer(data[[i]]$event))
  names(data[[i]]) <- tolower(names(data[[i]]))
}



#Plot -----------------------
for (i in 1:length(data)){
  plot(as.ts(data[[i]]),
       main=names(data[i]))
}

#Dataset organized with series into a list
oil_3w_Type_5 <- list()

#Idx variable
for (i in 1:(length(data))) {
  idx <- 1:nrow(data[[i]])
  oil_3w_Type_5[[i]] <- cbind(data.frame(idx), data[[i]])
  names(oil_3w_Type_5)[i] <- names(data)[i]
}


for (i in 1:length(oil_3w_Type_5)){
  oil_3w_Type_5[[i]]$type <- ""
  oil_3w_Type_5[[i]]$type[oil_3w_Type_5[[i]]$event] <- "Change Point"
}


for (i in 1:length(oil_3w_Type_5)){
  plot(as.ts(oil_3w_Type_5[[i]]),
       main = names(oil_3w_Type_5[i]))
}


file_tp5 <- "data/oil_3w_Type_5.RData"
save(oil_3w_Type_5, file=file_tp5, compress = "xz")
