
import tweepy
import csv

from tweepy.streaming import StreamListener
from tweepy import OAuthHandler
from tweepy import Stream


consumer_key = "MsNJDa0ki28GKLkLUjmuQWbya"
consumer_secret = "VcTkOFxRtpoFckYjsf91Z6ZKLLNUPrmDTwz4uP9TPja49Qifjz"
access_key = "1175038722347339776-FJCAVtlWauw1MNYoSPwzCLvvq0M0A0"
access_secret = "f2t7MyzrxpNPw8oVgyNLyBujtn2oB3JYFIck856cMhbB7"


#Call the API you created on app.twitter (with a developer account)
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_key, access_secret)
api = tweepy.API(auth)

#Create a csv file with the utf-8 encoding method to get special characters such as French accents or emojis
Toulouse_Tweets = open('Toulouse.csv', 'a+', encoding="utf-8", newline='')

#Store the full text of each tweet filtering with special keywords, at a particular date and in a particular language. 
csvWriter = csv.writer(Toulouse_Tweets)
ids = set()
search_terms = ('giletsjaunes -filter:retweets OR #gilets_jaunes -filter:retweets OR #GiletsJaunes -filter:retweets')
for tweet in tweepy.Cursor(api.search,
                    q=search_terms,
                    since="2019-09-01", 
                    until="2019-10-02",

                    lang="fr").items(30):
    fulltext = api.get_status(tweet.id,tweet_mode="extended")
    csvWriter.writerow([fulltext.full_text])
    
    ids.add(tweet.id) 
    print ("number of unique ids seen so far: {}",format(len(ids)))
Toulouse_Tweets.close()

 
