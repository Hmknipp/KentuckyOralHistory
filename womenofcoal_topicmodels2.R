library(tidytext)
library(topicmodels)
library(tidyverse)
library(tm)
library(reshape2)
library(ggplot2)
library(dplyr)
library(tidyr)

setwd("~/Documents/GitHub/KentuckyOralHistory")
text_dir <- "~/Documents/GitHub/KentuckyOralHistory/txt"

# Create corpus
text<- Corpus(DirSource(directory = text_dir, encoding = "UTF-8"))
corpus_womenofcoal <- Corpus(VectorSource(text))

mystopwords <- readLines("~/Documents/GitHub/KentuckyOralHistory/eng.txt")


# preprocessing
corpus_womenofcoal <- tm_map(corpus_womenofcoal, content_transformer(tolower))
corpus_womenofcoal <- tm_map(corpus_womenofcoal, removePunctuation) 
corpus_womenofcoal <- tm_map(corpus_womenofcoal, removeNumbers)
corpus_womenofcoal <- tm_map(corpus_womenofcoal, removeWords, mystopwords) 
corpus_womenofcoal <- tm_map(corpus_womenofcoal, stripWhitespace)


# Convert the corpus to a Document-Term Matrix (DTM)
dtm <- DocumentTermMatrix(corpus_womenofcoal)

# Create the LDA model
womenofcoalLDA <- LDA(dtm, k = 15, control = list(seed = 1234))



#lda
num_topics <- 15
lda_model <- LDA(dtm, k = 15)

#top terms
top_terms <- terms(lda_model, 15)

for (i in 1:num_topics) {
  cat("Topic", i, ":", paste(top_terms[i, ], collapse = ", "), "\n")
}


woc_topics <- tidy(womenofcoalLDA, matrix= "beta")
woc_topics

#intial LDA top terms and visualization

woc_top_terms <- woc_topics %>%
  group_by(topic) %>% 
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, beta)

woc_top_terms %>% 
  mutate (term = reorder(term,beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip() 


