import pandas as pd
import plotly.graph_objects as go
import chart_studio.plotly as py
import plotly as py1
import random

df = pd.read_csv('top_20_ADJ.csv', names= ['Value', 'Frequency'])

words = list(df['Value'])
frequency = list(df['Frequency'])



lower, upper = 30, 90
frequency1 = [((x - min(frequency)) / (max(frequency) - min(frequency))) * (upper - lower) + lower for x in frequency]



lenth =  len(words)
colors = [py1.colors.DEFAULT_PLOTLY_COLORS[random.randrange(1, 10)] for i in range(lenth)]

data = go.Scatter(
x=random.choices(range(lenth), k=lenth),
y= random.shuffle(x),
mode='text',
text=words,
hovertext=['"{0}" {1} values'.format(w, f) for w, f in zip(words, frequency)],
hoverinfo='text',
textfont={'size': frequency1, 'color': colors})
layout = go.Layout({'xaxis': {'showgrid': False, 'showticklabels': False, 'zeroline': False},
                    'yaxis': {'showgrid': False, 'showticklabels': False, 'zeroline': False}})

fig = go.Figure(data=[data], layout=layout)
fig.update_layout(title_text="Top 20 of most frequent adjectives from #YellowVests NLP Analysis ")
py.sign_in('spiderweb','meN8XQSk6p9SwNrAC740')
py.iplot(fig, filename='Top_20_Adjectives')