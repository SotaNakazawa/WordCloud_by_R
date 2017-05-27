library(twitteR)

#TwitterAPIのKeyとTokenを読み込む
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

#Tweetの取得
tweets_Abe <- userTimeline("AbeShinzo",500)
tweets_Koike <- userTimeline("ecoyuri",500)
tweets_Kono <- userTimeline("konotarogomame",500)
tweets_Katayama <- userTimeline("katayama_s",500)
tweets_Yamamoto <- userTimeline("ichita_y",500)

#Tweetをデータフレームへ変換
TwGetDF_Abe <- twListToDF(tweets_Abe)
TwGetDF_Koike <- twListToDF(tweets_Koike)
TwGetDF_Kono <- twListToDF(tweets_Kono)
TwGetDF_Katayama <- twListToDF(tweets_Katayama)
TwGetDF_Yamamoto <- twListToDF(tweets_Yamamoto)

#変換したTweetを結合
tweets_zimin <- rbind(TwGetDF_Abe,TwGetDF_Koike,TwGetDF_Kono,
                      TwGetDF_Katayama,TwGetDF_Yamamoto)

#テキストファイルへ書き出し
write.table(tweets_zimin,"Zimin.txt")

library(RMeCab)
#テキストファイルを形態素解析して頻度を算出
frq_Zimin <- RMeCabFreq("Zimin.txt")

library(dplyr)
#解析結果からデータを抽出
frq2_Zimin <- frq_Zimin %>% filter(Freq>30&Freq<400, Info1 %in% c("名詞","形容詞","動詞"), Info2 != "数")

library(wordcloud)
#ワードクラウドの描画
wordcloud(frq2_Zimin$Term,frq2_Zimin$Freq,random.order=FALSE,
          color=rainbow(5),random.color=FALSE,scale=c(3,1),min.freq=90)
