import pandas as pd


#read the csv we create as a Pandas data frame, and give a column name
data=pd.read_csv("your_csv_file.csv")
data.columns=['tweet']

#replace unwanted characters in each tweet, such as web adress of the tweet, mentioned users, tabulations and #
data['tweet'] = data['tweet'].str.replace(r'@[A-Za-z0-9-_]+',' ').astype('object')
data['tweet'] = data['tweet'].str.replace(r'https?:\/\/.*[\r\n]*', '').astype('object')
data['tweet'] = data['tweet'].str.replace(r'\n', ' ').astype('object')
data['tweet'] = data['tweet'].str.replace(r'#[A-Za-z0-9]+', ' ').astype('object')
data['tweet'] = data['tweet'].str.replace(r'  ', ' ').astype('object')
data['tweet'] = data['tweet'].str.replace(r'&lt;', '').astype('object')
data['tweet'] = data['tweet'].str.replace(r'\"', '').astype('object')
data['tweet'] = data['tweet'].str.replace(r'[\", ]', ' ').astype('object')
data['tweet'] = data['tweet'].str.replace(r'\t', '').astype('object')

#save cleaned tweets in a csv (we will use it for Sentiment analysis)
data.to_csv("tweets_cleaned.csv", index=None)
#save cleaned tweets in a txt file (we will use it for NLP)
data.to_csv("tweets_cleaned.txt", header=None, index=None)

