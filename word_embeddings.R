#install package

if (!require(wordVectors)) {
  if (!(require(devtools))) {
    install.packages("devtools")
  }
  devtools::install_github("bmschmidt/wordVectors")
}
#load libraries
library(wordVectors)
library(magrittr)


#build up / train the model

if (!file.exists("word_embeddings/fullcorpus_bngrams.txt")) prep_word2vec(origin="txt/",destination="word_embeddings/word_embeddings.txt",lowercase=T,bundle_ngrams=2)

if (!file.exists("word_embeddings.bin")) {model = train_word2vec("word_embeddings/word_embeddings.txt","word_embeddings.bin",vectors=200,threads=4,window=30,iter=30,negative_samples=0)} else model = read.vectors("word_embeddings")

work_vectors <- model %>% closest_to("work")

home_vectors <- model %>% closest_to("home")

family_vectors <- model %>% closest_to("family")

coal_vectors <- model %>% closest_to("coal")

women_vectors <- model %>% closest_to("women")

labor_vectors <- model %>% closest_to("labor")



#visualize models
work = closest_to(model,model[[c("work")]],150)
average_work = model[[work$word,average=F]]
plot(average_work,method="pca")

home = closest_to(model,model[[c("home")]],150)
average_home = model[[home$word,average=F]]
plot(average_home,method="pca")

family = closest_to(model,model[[c("family")]],150)
average_family = model[[family$word,average=F]]
plot(average_family,method="pca")

coal = closest_to(model,model[[c("coal")]],150)
average_coal = model[[coal$word,average=F]]
plot(average_coal,method="pca")

women = closest_to(model,model[[c("women")]],150)
average_women = model[[women$word,average=F]]
plot(average_women,method="pca")

