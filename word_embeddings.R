
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

if (!file.exists("word_embeddings/fullcorpus_bngrams.bin")) {model = train_word2vec("word_embeddings/word_embeddings.txt","word_embeddings/fullcorpus_bngrams.bin",vectors=200,threads=4,window=30,iter=30,negative_samples=0)} else model = read.vectors("word_embeddings/fullcorpus_bngrams.bin")

work_vectors <- model %>% closest_to("work")

home_vectors <- model %>% closest_to(model[[c("home", "family")]], 50)

family_vectors <- model %>% closest_to("family")

coal_vectors <- model %>% closest_to("coal")

women_vectors <- model %>% closest_to("women")

labor_vectors <- model %>% closest_to(model[[c("work","worked", "working", "works")]],50)

pregnancy_vectors <- model %>% closest_to(model[[c("pregnant","pregnancy","baby", "babies", "midwife")]],50)

union_vectors <- model %>% closest_to(model[[c("strike", "picket","union", "labor")]],50)

housewife_vectors <- model %>% closest_to(model[[c("housewife", "housekeeping", "keeping house")]],50)

communist_vectors <- model %>% closest_to(model[[c("communism" , "communist")]], 50)

kids_vectors <- model %>% closest_to(model[[c("kids", "kid", "child", "children")]], 50)

years_vectors <- model %>% closest_to(model[[c("year", "years")]], 50)

#visualize models
work = closest_to(model,model[[c("work")]],50)
average_work = model[[work$word,average=F]]
plot(average_work,method="pca")

home = closest_to(model,model[[c("home")]],50)
average_home = model[[home$word,average=F]]
plot(average_home,method="pca")

family = closest_to(model,model[[c("family")]],50)
average_family = model[[family$word,average=F]]
 plot(average_family,method="pca")

coal = closest_to(model,model[[c("coal")]],50)
average_coal = model[[coal$word,average=F]]
plot(average_coal,method="pca")

women = closest_to(model,model[[c("women")]],50)
average_women = model[[women$word,average=F]]
plot(average_women,method="pca")

labor = closest_to(model,model[[c("labor")]],50)
average_labor = model[[labor$word,average=F]]
plot(average_labor,method="pca")

pregnancy = closest_to(model,model[[c("pregnant","pregnancy","baby", "babies", "midwife")]],50)
average_pregnancy = model[[pregnancy$word,average=F]]
plot(average_pregnancy,method="pca")

union = closest_to(model,model[[c("strike", "picket","union", "labor")]],50)
average_union = model[[union$word,average=F]]
plot(average_union,method="pca")

housewife = closest_to(model,model[[c("housewife", "housekeeping", "keeping house")]],50)
average_housewife = model[[housewife$word,average=F]]
plot(average_housewife,method="pca")


kids = closest_to(model,model[[c("kids", "kid", "child", "children")]], 50)
average_kids = model[[kids$word,average=F]]
plot(average_kids,method="pca")

years = closest_to(model,model[[c("year", "years")]], 50)
average_years = model[[years$word,average=F]]
plot(average_years,method="pca")

##save dataframes as .csv

file_path <- "labor_vectors.csv"
write.csv(labor_vectors, file = file_path, row.names = FALSE)

file_path <- "home_vectors.csv"
write.csv(home_vectors, file = file_path, row.names = FALSE)


