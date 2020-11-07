# Youtube NLP App

This repo is for sharing the code source files of the  Youtube NLP Applicaiton built with Shiny. 

The Shiny App can be consulted here: https://charles-lietar.shinyapps.io/youtube-nlp/

The technical documentation is available at: https://drive.google.com/file/d/10vM9Tm3R43L-RsxVd8bfFYyW4ul8Q7vx/view

The goal of the project is to mine opinions from thousands of Youtube Comments extracted with Youtube Data API v3.
We selected recent videos from different topics like Society, Politics, Tech, Gaming or Streaming. The subject had to trendy so we could spot debates/feedback sharings of users in the comments.

Here is a short summary of the interactive analysis provided by the application : 

- `Video  Summary Tab`:  provides a summary of the descriptive statistics available on video ; allows the users to play video directly in applicaiton, and displays the top 6 most liked comments

![alt text](https://www.noelshack.com/2020-45-6-1604773932-tab1.jpg)

- `Text Mining Tab`: outputs the 200 most frequent words typed by users for  a video comments input, and plot them in a bar chart and a word cloud plot

![alt text](https://www.noelshack.com/2020-45-6-1604773935-tab2.jpg)

- `Sentiment Analysis Tab` :  shows the top frequent emotions in the comments (emotion classification), and a sentiment polarity analysis by showing the proportion of positive vs neutral vs negative comments. It then displays the most positive and the most negative comments.  

![alt text](https://www.noelshack.com/2020-45-6-1604773933-tab3.png)
