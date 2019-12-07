import spacy
from spacy import displacy
import pandas as pd
nlp = spacy.load('fr_core_news_sm')
tweets= open("tweets_cleaned.txt", 'r', encoding='utf-8').read()
doc = nlp(tweets)
B=[]
A=[]
other_stop_words= [] # fill yourself
for token in doc:
    if token.is_stop or token.text in other_stop_words:
        A = A
        B = B
    else:
        A.append(token.text)
        B.append(token.pos_)

data={'Text':A, 'POS': B}
df=pd.DataFrame(data)

#remove POS we don't want to study to gain computation time
df = df[df.POS != "PUNCT"]
df = df[df.POS != "SPACE"]
df = df[df.POS != "DET"]
df = df[df.POS != "X"]
df = df[df.POS != "ADP"]
df = df[df.POS != "CCONJ"]
df = df[df.POS != "SCONJ"]
df = df[df.POS != "AUX"]

#create a csv file with the top n most frequent words for a specif POS input
def top_pos(POS, n):
    df_POS = df[df.POS==POS]
    print(df_POS.shape)
    top_POS = df_POS['Text'].value_counts().head(n)
    top_POS.to_csv("top_{}_{}.csv".format(n,POS))

#examples used for the Yellow Vests NLP analysis
for i in ["ADJ","VERB","NOUN"]:
    top_pos(i, 20)

