import pandas as pd 

df1 = pd.read_csv('Tweets1.csv', names=['tweet'])
df2 = pd.read_csv('Tweets2.csv', names=['tweet'])
df3 = pd.read_csv('Tweets3.csv', names=['tweet'])

df = pd.concat([df1,df2,df3], axis=0, join='outer', ignore_index=False, keys=None,levels=None, names=None, verify_integrity=False, copy=True)
df.to_csv('Tweets.csv', index=None, header=None)

df