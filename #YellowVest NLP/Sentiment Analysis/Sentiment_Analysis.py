import pandas as pd
import re
import matplotlib.pyplot as plt
import seaborn as sns
import string
import textblob as tb
import textblob_fr as tbfr
import collections
import plotly.graph_objects as go
import chart_studio.plotly as py


df=pd.read_csv('tweets_cleaned.csv')



# our column tweet is an object dtype, but not a string type : we apply a string method for text processing
df['new_tweet']= df['tweet'].apply(str)

#removing emojis 
df['new_tweet'] = df['new_tweet'].str.replace('[^\w\s#@/:%.,_-]', ' ', flags=re.UNICODE)


#removing tabs and useless spaces
df['new_tweet'] = df['new_tweet'].str.replace(' +',' ')
df['new_tweet'] = df['new_tweet'].apply(lambda x : x.strip())

#removing null value
df = df[df['new_tweet'] != "nan"]


#compute new colonne of string length
df['length']= df['new_tweet'].apply(len)

#ploting distribution of length
layout = go.Layout(width=650,
                   height=400,
                   showlegend=False,
                   hovermode='x')
layout.update(xaxis =dict(title='Length'),
              yaxis =dict(title='Count'))
fig = go.Figure(data=[go.Histogram(x=df['length'])], layout=layout)
fig.update_layout(title_text="Distribution of #YelloVests tweet length")
py.sign_in('spiderweb','meN8XQSk6p9SwNrAC740')
py.iplot(fig, filename='Yellovest_tweet_length')


# process text in each line : remove ponctuations, spliting string into list of words, removing own custom stop words list
# returning a list of words in each line (OPTIONAL :  can improve sentiment anlysis)

# my_stop_words_list = []

#def text_process(mess):
    #nopunc =[char for char in mess.lower() if char not in string.punctuation]
    #nopunc=''.join(nopunc)
    #return [word for word in nopunc.split() if word not in my_stop_words_list]


#df['new_tweet'] = df['new_tweet'].apply(text_process)


#Join list elements to recover 'string' type in the Pandas Dataframe
#def join_element (list):
   # message = ' '.join(list)
   # return message

#df['new_tweet'] = df['new_tweet'].apply(join_element)



#fit TexBlob sentiment model to your pandas data frame, output the polarity between [-1:1] i.e [very negatif : very postive]
def sentiment_analysis(text):
    blob = tb.TextBlob(text, pos_tagger=tbfr.PatternTagger(), analyzer=tbfr.PatternAnalyzer())
    return blob.sentiment[0]
    
df['tweet_polarity'] = df['new_tweet'].apply(sentiment_analysis)

def simple_classifier (polarity):
    if polarity <0.000000:
        category = "Very negative - neutral"
    elif polarity > 0.000000:
        category = "neutral - Very positive"
    else:
        category = "misclassified"
    return category


df['simple_classification'] = df['tweet_polarity'].apply(simple_classifier)

# plot distribution of our simple classifier based on Textblob sentiment analysis
layout = go.Layout(width=650,
                   height=400,
                   showlegend=False,
                   hovermode='x')
layout.update(xaxis =dict(title='Value'),
              yaxis =dict(title='Count'))
fig = go.Figure(data=[go.Histogram(x=df['simple_classification'])], layout=layout)
fig.update_layout(title_text="Distribution of #YellowVests classified sentiments")
py.sign_in('spiderweb','meN8XQSk6p9SwNrAC740')
py.iplot(fig, filename='Yellowvest_sentiment_classified')
fig.show()

df = df[df['tweet_polarity'] == 1.000000]
df.to_csv('top_positive.csv')







