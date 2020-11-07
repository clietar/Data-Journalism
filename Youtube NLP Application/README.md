# Youtube NLP App

This repo is for sharing the code source files of the  Youtube NLP Applicaiton built with Shiny. 

The Shiny App can be consulted here: https://charles-lietar.shinyapps.io/youtube-nlp/

The technical documentation is available at: https://drive.google.com/file/d/10vM9Tm3R43L-RsxVd8bfFYyW4ul8Q7vx/view

The goal of the project is to mine opinions from thousands of Youtube Comments extracted with Youtube Data API v3.
We selected recent videos from different topics like Society, Politics, Tech, Gaming or Streaming. The subject had to be trendy so we could get various input from users  in the comments (debates, feedback sharing, personal opinions..)

Here is a short summary of the interactive analysis provided by the application : 

- `Video  Summary Tab`:  provides a summary of the descriptive statistics available on video ; allows the users to play video directly in applicaiton, and displays the top 6 most liked comments

<img width="1279" alt="tab1" src="https://user-images.githubusercontent.com/55199729/98449021-92cd3180-2130-11eb-853f-dbdc5903dd90.png">


- `Text Mining Tab`: outputs the 200 most frequent words typed by users for  a video comments input, and plot them in a bar chart and a word cloud plot

<img width="1269" alt="tab2" src="https://user-images.githubusercontent.com/55199729/98449134-58b05f80-2131-11eb-8bbf-9f4f5071a7f3.png">

- `Sentiment Analysis Tab` :  shows the top frequent emotions in the comments (emotion classification), and a sentiment polarity analysis by showing the proportion of positive vs neutral vs negative comments. It then displays the most positive and the most negative comments.  

<img width="1280" alt="tab3" src="https://user-images.githubusercontent.com/55199729/98449143-6960d580-2131-11eb-965f-27c1a22ceb65.png">
