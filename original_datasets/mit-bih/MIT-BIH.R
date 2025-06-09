url <- "https://canopus.eic.cefet-rj.br/data/MIT-BIH/MIT-BIH-Dataset.RData"

# Define o caminho temporário local
destfile <- tempfile(fileext = ".RData")

# Baixa o arquivo da internet
download.file(url, destfile, mode = "wb")

load(destfile)


levels <- c('\'', '!', '"', '(', ')', '*', '/', '?', '@', '[', ']', '^', '`',
            '|', '~', '+', '=', 'A', 'a', 'B', 'D', 'e', 'E', 'F', 'f', 'J',
            'j', 'L', 'N', 'n', 'p', 'Q', 'R', 'r', 'S', 's', 't', 'T', 'u',
            'V', 'x')
j <- 1
motif_MLII <- list()
for (i in 1:length(dataset)) {
  if (!is.null(dataset[[i]]$MLII)) {
    data <- dataset[[i]]$MLII$signal
    data <- data[,1:4]
    colnames(data) <- c("idx", "value", "event", "seq")
    data$seqlen <- 50
    data$seq <- factor(data$seq, levels=levels)
    data$event <- FALSE
    data$event[!is.na(data$seq)] <- TRUE
    motif_MLII[[j]] <- data
    names(motif_MLII)[j] <- sprintf("%s_MLII", names(dataset[i]))
    j <- j + 1
  }
  if (j > 5)
    break
}

save(motif_MLII, file="motif_MLII.RData", compress = "xz")


j <- 1
motif_V1 <- list()
for (i in 1:length(dataset)) {
  if (!is.null(dataset[[i]]$V1)) {
    data <- dataset[[i]]$V1$signal
    data <- data[,1:4]
    colnames(data) <- c("idx", "value", "event", "seq")
    data$seqlen <- 50
    data$seq <- factor(data$seq, levels=levels)
    data$event <- FALSE
    data$event[!is.na(data$seq)] <- TRUE
    motif_V1[[j]] <- data
    names(motif_V1)[j] <- sprintf("%s_V1", names(dataset[i]))
    j <- j + 1
  }
  if (j > 5)
    break
}
save(motif_V1, file="motif_V1.RData", compress = "xz")


j <- 1
motif_V2 <- list()
for (i in 1:length(dataset)) {
  if (!is.null(dataset[[i]]$V2)) {
    data <- dataset[[i]]$V2$signal
    data <- data[,1:4]
    colnames(data) <- c("idx", "value", "event", "seq")
    data$seqlen <- 50
    data$seq <- factor(data$seq, levels=levels)
    data$event <- FALSE
    data$event[!is.na(data$seq)] <- TRUE
    motif_V2[[j]] <- data
    names(motif_V2)[j] <- sprintf("%s_V2", names(dataset[i]))
    j <- j + 1
  }
  if (j > 5)
    break
}
save(motif_V2, file="motif_V2.RData", compress = "xz")

j <- 1
motif_V5 <- list()
for (i in 1:length(dataset)) {
  if (!is.null(dataset[[i]]$V5)) {
    data <- dataset[[i]]$V5$signal
    data <- data[,1:4]
    colnames(data) <- c("idx", "value", "event", "seq")
    data$seqlen <- 50
    data$seq <- factor(data$seq, levels=levels)
    data$event <- FALSE
    data$event[!is.na(data$seq)] <- TRUE
    motif_V5[[j]] <- data
    names(motif_V5)[j] <- sprintf("%s_V5", names(dataset[i]))
    j <- j + 1
  }
  if (j > 5)
    break
}
save(motif_V5, file="motif_V5.RData", compress = "xz")

