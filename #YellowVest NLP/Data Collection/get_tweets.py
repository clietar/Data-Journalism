
import tweepy
import csv

from tweepy.streaming import StreamListener
from tweepy import OAuthHandler
from tweepy import Stream

#replace with your API token (get them in your app parameters)
consumer_key = ""
consumer_secret = ""
access_key = ""
access_secret = ""


#Call the API you created on app.twitter (with a developer account)
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_key, access_secret)
api = tweepy.API(auth)

#Create a csv file with the utf-8 encoding method to get special characters such as French accents or emojis
Tweet_file = open('your_csv_file.csv', 'a+', encoding="utf-8", newline='')

#Store the full text of each tweet filtering with special keywords, at a particular date and in a particular language. 
csvWriter = csv.writer(Tweet_file)
ids = set()
search_terms = ('giletsjaunes -filter:retweets OR #gilets_jaunes -filter:retweets OR #GiletsJaunes -filter:retweets') #get multiple keywords WITHOUT retweets to avoid doublons
for tweet in tweepy.Cursor(api.search,
                    q=search_terms,
                    since="", #use english format like YYYY-MONTH_NUMBER-DAY_NUMBER
                    until="",
                    lang="fr").items(30):
    fulltext = api.get_status(tweet.id,tweet_mode="extended") #get the full text of a tweet
    csvWriter.writerow([fulltext.full_text])
    ids.add(tweet.id) 
    print ("number of unique ids seen so far: {}",format(len(ids)))

Tweet_file.close()

 
