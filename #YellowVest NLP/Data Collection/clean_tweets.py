import pandas as pd


#read the csv we create as a Pandas data frame, and give a column name
data=pd.read_csv("your_csv_file.csv")
data.columns=['tweet']

#replace unwanted characters in each tweet, such as web adress of the tweet, mentioned users, tabulations and #
data['tweet'] = data['tweet'].str.replace(r'@[A-Za-z0-9-_]+','').astype('object')
data['tweet'] = data['tweet'].str.replace(r'https?:\/\/.*[\r\n]*', '').astype('object')
data['tweet'] = data['tweet'].str.replace(r'\n', ' ').astype('object')
data['tweet'] = data['tweet'].str.replace(r'#', '').astype('object')

#create a new clean csv file with 2 columns : Pandas index and tweets
data.to_csv("your_csv_file_cleaned.csv")




