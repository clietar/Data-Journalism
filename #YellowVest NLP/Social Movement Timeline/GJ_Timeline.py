import numpy as np
import pandas as pd
import plotly.graph_objects as go
import chart_studio.plotly as py
df = pd.read_csv('C:/Users/t-chliet/Projects/GJ_Timeline.csv')
FG = df['Nb of participants according to French Government'].tolist()
LNJ = df['Nb of participants according to "Le Nombre Jaune"'].tolist()

FrenchGovernment = go.Scatter(x=df.Day[:1],
                    y=FG[:1],
                    text=['FG'],
                    hovertext=df['Act'],
                    mode='lines+markers',
                    name='French Government',
                    line=dict(width=1.5,
                              color='LightSkyBlue'))
                    

LeNombreJaune = go.Scatter(x = df.Day[:1],
                    y = LNJ[:1],
                    text=['LNJ'],
                    hovertext=df['Act'],
                    name='Le Nombre Jaune',
                    mode='lines+markers',
                    line=dict(width=1.5,
                              color='gold'))
                    

frames = [dict(data= [dict(type='scatter',
                           x=df.Day[:k+1],
                           y=FG[:k+1]),
                      dict(type='scatter',
                           x=df.Day[:k+1],
                           y=LNJ[:k+1])],
               traces= [0, 1],  
              )for k  in  range(1, len(FG))] 

layout = go.Layout(width=650,
                   height=400,
                   showlegend=True,
                   hovermode='x',
                   updatemenus=[dict(type='buttons', showactive=False,
                                y=0.70,
                                x=1.18,
                                xanchor='right',
                                yanchor='top',
                                pad=dict(t=0, r=10),
                                buttons=[dict(label='Play',
                                              method='animate',
                                              args=[None, 
                                                    dict(frame=dict(duration=150, 
                                                                    redraw=False),
                                                         transition=dict(duration=0),
                                                         fromcurrent=True,
                                                         mode='immediate')])])])


layout.update(xaxis =dict(title='Date',range=[df.Day[0], df.Day[len(df)-1]], autorange=False),
              yaxis =dict(title='Number of participants',range=[min(FG)-0.5, max(LNJ)+0.5], autorange=False))
fig = go.Figure(data=[FrenchGovernment, LeNombreJaune], frames=frames, layout=layout)
fig.update_layout(title_text="The fall of yellow vests movement")
py.sign_in('spiderweb','meN8XQSk6p9SwNrAC740')
py.iplot(fig, filename='YellowVests_Timeline')