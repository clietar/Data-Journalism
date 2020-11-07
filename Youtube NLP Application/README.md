# Youtube NLP App

This repo is for sharing the code source files of the  Youtube NLP Applicaiton built with Shiny. 

The Shiny App can be consulted here:
The technical documentation is available at:

The goal of the project is to mine opinions from thousands of Youtube Comments extracted with Youtube Data API v3.
We selected recent videos from different topics like Society, Politics, Tech, Gaming or Streaming. The subject had to trendy so we could spot debates/feedback sharings of users in the comments.

Here is a short summary of the interactive analysis provided by the application : 

- `Video  Summary Tab`:  create/set your own client ID/secret from GCP and set your own Mapbox token
- `Text Mining Tab`: uncomment  `googleAuthUI()` and remove the placeholder below
- `Sentiment Analysis Tab` reactive variable and remove the placeholder below
