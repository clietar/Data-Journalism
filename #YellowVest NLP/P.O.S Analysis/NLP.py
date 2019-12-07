import spacy
from spacy import displacy
import pandas as pd
nlp = spacy.load('fr_core_news_sm')
tweets= open("tweets_cleaned.txt", 'r', encoding='utf-8').read()
doc = nlp(tweets)
B=[]
A=[]
other_stop_words= ["jaunes", "jaune", "petits", "grands", "politiques", "écembre", "an","ans","=","l","d","%","faire","fait", "faut","veulent", "ect", "ect", "vient", "👍","🤮", "✌", "🦞","🙄", "😂", "retraites","🤔","voir","«", "Emmanuel","1er","mis","pris","place","grand","social","10h","petit"]
for token in doc:
    if token.is_stop or token.text in other_stop_words:
        A = A
        B = B
    else:
        A.append(token.text)
        B.append(token.pos_)

data={'Text':A, 'POS': B}
df=pd.DataFrame(data)

df = df[df.POS != "PUNCT"]
df = df[df.POS != "SPACE"]
df = df[df.POS != "DET"]
df = df[df.POS != "X"]
df = df[df.POS != "ADP"]
df = df[df.POS != "CCONJ"]
df = df[df.POS != "SCONJ"]
df = df[df.POS != "AUX"]


def top_pos(POS, n):
    df_POS = df[df.POS==POS]
    print(df_POS.shape)
    top_POS = df_POS['Text'].value_counts().head(n)
    top_POS.to_csv("top_{}_{}.csv".format(n,POS))

for i in ["ADJ","VERB","NOUN"]:
    top_pos(i, 20)

