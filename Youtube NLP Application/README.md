Here are the code source files for the  Youtube NLP Applicaiton built with Shiny. 

The goal of the project is to mine opinions from thousands of Youtube Comments extracted with Youtube Data API v3.
We selected recent videos from different topics like Society, Politics, Tech, Gaming or Streaming. The subject had to trendy so we could spot debates/feedback sharings of users in the comments.


Here is a short summary of the interactive analysis provided by the application : 


# Shiny GA Map

This repo is part of a post detailing how to create a custom Google Analytics Shiny app [found here](https://compassred.shinyapps.io/shiny_ga_map_published/).

In order to run, make the following changes:

- `global.R`:  create/set your own client ID/secret from GCP and set your own Mapbox token
- `ui.R`: uncomment  `googleAuthUI()` and remove the placeholder below
- `server.R`: uncomment the `ga_data()` reactive variable and remove the placeholder below
