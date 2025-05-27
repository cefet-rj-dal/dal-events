load("original_datasets/3W/data/grouped/parquet/4/data_3w_tp4_sample.RData")

#New pattern adjust -----------------------
data <- data_3w_tp4_sample


#var_exp <- c("P-JUS-BS","P-JUS-CKGL", "P-JUS-CKP","P-MON-CKGL","P-MON-CKP",
#             "P-MON-SDV-P","P-PDG","PT-P","P-TPT","QBS","QGL","T-JUS-CKP",
#             "T-MON-CKP","T-PDG","T-TPT","class")

var_exp <- c("P-JUS-CKGL",  #OK
             "P-MON-CKP", #OK
             "P-PDG", #OK
             "P-TPT", #OK
             "QGL", #OK
             "T-JUS-CKP",  #OK
             "T-PDG",
             "T-TPT", #OK
             "class")


for (i in 1:length(data)){
  data[[i]] <- data[[i]][,var_exp]
}

for (i in 1:length(data)){
  plot(as.ts(data[[i]]))
}


#Add CPD labels ---------------------
for (j in 1:length(data)){
  #Add event
  labels <- data.frame(class = data[[j]]$class)
  #plot(as.ts(labels))
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
  cp_class <- max(na.omit(labels$class))

  for (i in cp_idx:nrow(labels)){
    if (cp == FALSE){
      if(!is.na(labels$class[i]) && labels$class[i] != cp_class){ #Replace number by class
        print("Ponto de mudança localizado em:")
        print(i)
        labels$cpd[i] <- 1
        cp_idx <- i
        cp  <- TRUE
      }
    }
  }

  sum(labels$cpd)
  plot(as.ts(labels),
       main=paste("Series", j))

  #Add CPD labels
  data[[j]]$event <- labels$cpd

  print("Starting next series...")
  print("...........")

}



#Remove old classes -----------------------
for (i in 1:length(data)){
  data[[i]]$class <- NULL
}


#Adjust names and types -----------------------
var_exp <- c("P_JUS_CKGL",  #OK
             "P_MON_CKP", #OK
             "P_PDG", #OK
             "P_TPT", #OK
             "QGL", #OK
             "T_JUS_CKP",  #OK
             "T_PDG",
             "T_TPT", #OK
             "event")

for (i in 1:length(data)){
  data[[i]]$event <- as.logical(as.integer(data[[i]]$event))
  names(data[[i]]) <- tolower(var_exp)
}



#Plot -----------------------
for (i in 1:length(data)){
  plot(as.ts(data[[i]]),
       main=names(data[i]))
}

#Dataset organized with series into a list
oil_3w_Type_4 <- list()

#Idx variable
for (i in 1:(length(data))) {
  idx <- 1:nrow(data[[i]])
  oil_3w_Type_4[[i]] <- cbind(data.frame(idx), data[[i]])
  names(oil_3w_Type_4)[i] <- names(data)[i]
}


for (i in 1:length(oil_3w_Type_4)){
  oil_3w_Type_4[[i]]$type <- ""
  oil_3w_Type_4[[i]]$type[oil_3w_Type_4[[i]]$event] <- "Change Point"
}



for (i in 1:length(oil_3w_Type_4)){
  plot(as.ts(oil_3w_Type_4[[i]][,2:11]),
       main = names(oil_3w_Type_4[i]))
}


file_tp4 <- "data/oil_3w_Type_4.RData"
save(oil_3w_Type_4, file=file_tp4, compress = "xz")
