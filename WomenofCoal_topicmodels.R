library(tidytext)
library(topicmodels)
library(tidyverse)
library(tm)

setwd("~/Documents/GitHub/KentuckyOralHistory/txt")
text_dir <- "~/Documents/GitHub/KentuckyOralHistory/txt"

# Create corpus
corpus <- Corpus(DirSource(directory = text_dir, encoding = "UTF-8"))

# preprocessing
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)

dtm <- DocumentTermMatrix(corpus)

#lda
num_topics <- 5
lda_model <- LDA(dtm, k = num_topics)

#top terms
top_terms <- terms(lda_model, 10)

for (i in 1:num_topics) {
  cat("Topic", i, ":", paste(top_terms[i, ], collapse = ", "), "\n")
}
