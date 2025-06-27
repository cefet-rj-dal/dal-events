library(united)

#TP1 --------------
data(oil_3w_Type_1)
summary(oil_3w_Type_1)

for(i in 1:length(oil_3w_Type_1)){
  plot(as.ts(oil_3w_Type_1[[1]]),
       main=names(oil_3w_Type_1[i]))
}

#DONE ----

#TP2 --------------
data(oil_3w_Type_2)
summary(oil_3w_Type_2)

#IN PROGRESS - S1 COMPLETE ----

#TP3 --------------
data(oil_3w_Type_3)

#GROUP NOT IMPLEMENTED ----

#TP4 --------------
data(oil_3w_Type_4)
summary(oil_3w_Type_4)

for(i in 1:length(oil_3w_Type_4)){
  plot(as.ts(oil_3w_Type_4[[1]][,2:11]),
       main=names(oil_3w_Type_4[i]))
}

#DONE ----

#TP5 --------------
data(oil_3w_Type_5)
summary(oil_3w_Type_5)

#IN PROGRESS - S1 AND S2 COMPLETE ----

#TP6
data(oil_3w_Type_6)
summary(oil_3w_Type_6)

#PENDING ALL 6 SERIES ----

#TP7 --------------
data(oil_3w_Type_7)
summary(oil_3w_Type_7)

names(oil_3w_Type_7$Type_7)

#PENDING ALL 4 SERIES ----

#TP8 --------------
data(oil_3w_Type_8)
summary(oil_3w_Type_8)

for(i in 1:length(oil_3w_Type_8)){
  plot(as.ts(oil_3w_Type_8[[1]]),
       main=names(oil_3w_Type_8[i]))
}

#DONE ----
