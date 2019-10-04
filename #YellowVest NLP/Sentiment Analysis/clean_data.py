import pandas as pd
import re

data=pd.read_csv("toulouse.csv")
data.columns=['tweet']

for row in data.iterrows():
    row[i]=row[i].str.replace('@','') 


data.head(200)
  




