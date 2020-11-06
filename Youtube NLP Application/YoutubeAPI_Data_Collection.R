library(tuber) #package to submit request to the Youtube Data API 

#packages for additional features on string manipulations
library(tidyverse)
library(glue) 
library(stringr)

# store API authentification credentials
client_id = "" #your client id
client_secret = "" #your client secret 

# use the youtube oauth 
yt_oauth(app_id = client_id,
         app_secret = client_secret,
         token = '')

#function to collect descriptive statistics given an input video id (nb of likes; nb of comments...)
get_all_stats <- function(id) {
  tuber::get_stats(video_id = id)
} 

#finction to get the raw comments, user assciated, nb of likes ect.. given an input video id
get_all_comments = function(id)
{
  tuber :: get_all_comments(video_id = id)
}

# function to get info on a video : description , channel associated... 
get_infos = function(id)
{
  tuber :: get_video_details(video_id = id)
}

#function to get the Youtube video id given an input video url
get_id = function(link) {
  if (stringr::str_detect(link, '/watch\\?')) {
    rgx = '(?<=\\?v=|&v=)[\\w]+'
  } else {
    rgx = '(?<=/)[\\w]+/?(?:$|\\?)'
  }
  stringr::str_extract(link, rgx)
}

#get a csv name based on video name
generate_csv_name = function(id) {
  video_name = get_infos(id)$items[[1]]$snippet$title
  video_csv_name = gsub(" ", "_",glue("{video_name}.csv"))
  toString(video_csv_name)
  
}
# get raw comments, number of likes and account associated from a youtube url and store data into a csv file
raw_data_to_csv = function(url) {
  id = get_id(url)
  api_data = get_all_comments(id)
  comments = data.frame(api_data[,3])
  authors = data.frame(api_data[,4])
  likes = data.frame(api_data[,10])
  names(comments)[names(comments) == colnames(comments)] = "Comments"
  names(authors)[names(authors) == colnames(authors)] = "Authors"
  names(likes)[names(likes) == colnames(likes)] = "Likes"
  raw_data = cbind(comments, authors, likes)
  raw_data
  write.csv(raw_data, generate_csv_name(id), row.names=FALSE)
}
#get stats on video given an url imnput and store them into a csv file
stats_to_csv = function(url) {
  id = get_id(url)
  api_stat = get_stats(id)
  stats = data.frame(api_stat)
  write.csv(stats, paste("stats_",generate_csv_name(id)))
  
}


