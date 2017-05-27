library(twitteR)

consumerKey <- "hoge"
consumerSecret <- "hoge"
accessToken <- "hoge"
accessTokenSecret <- "hoge"
cred <- setup_twitter_oauth(
  consumer_key = consumerKey,
  consumer_secret = consumerSecret,
  access_token = accessToken,
  access_secret = accessTokenSecret
)

tweets_Renho <- userTimeline("renho_sha",500)
tweets_Haraguchi <- userTimeline("kharaguchi",500)
tweets_Matsuura <- userTimeline("GOGOdai5",500)
tweets_Oguma <- userTimeline("oguma_shinji",500)
tweets_Ohsaka <- userTimeline("seiji_ohsaka",500)

TwGetDF_Renho <- twListToDF(tweets_Renho)
TwGetDF_Haraguchi <- twListToDF(tweets_Haraguchi)
TwGetDF_Matsuura <- twListToDF(tweets_Matsuura)
TwGetDF_Oguma <- twListToDF(tweets_Oguma)
TwGetDF_Ohsaka <- twListToDF(tweets_Ohsaka)

tweets_Minshin <- rbind(TwGetDF_Renho,TwGetDF_Haraguchi,TwGetDF_Matsuura,
                      TwGetDF_Oguma,TwGetDF_Ohsaka)
write.table(tweets_Minshin,"Minshin.txt")


library(RMeCab)
frq_Minshin <- RMeCabFreq("Minshin.txt")

library(dplyr)
frq2_Minshin <- frq_Minshin %>% filter(Freq>30&Freq<400, Info1 %in% c("名詞","形容詞","動詞"), Info2 != "数")

library(wordcloud)
wordcloud(frq2_Minshin$Term,frq2_Minshin$Freq,random.order=FALSE,color=rainbow(5),random.color=FALSE,scale=c(3,1),min.freq=70)
