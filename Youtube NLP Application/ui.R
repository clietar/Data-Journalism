header <- dashboardHeader(title= img(src = 'tweet_grey.png',
                                     title = "Youtube", height = "30px"))

sidebar <- dashboardSidebar(
  sidebarMenu(id = 'menu',
              menuItem(strong("Video summary"),tabName = 'summary', icon = icon("twitter")),
              menuItem(strong("Text Mining"),tabName = 'textmining', icon = icon("th-list", lib = "glyphicon")),
              menuItem(strong("Sentiment Analysis"),tabName = 'sentiment', icon = icon("thumbs-up", lib = "glyphicon")),
  ),
  hr(),
  htmlOutput("video_selector")
)

body <- dashboardBody(
  
  # Title 
  tags$head(tags$style(HTML(
    '.skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
    font-weight: bold;font-size: 16px;
    }
    '))),
  tags$head(tags$style(HTML(
    '.myClass { 
    font-size: 20px;
    line-height: 50px;
    text-align: left;
    font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
    padding: 0 15px;
    overflow: hidden;
    color: white;
    }
    '))),
  #tags$head(tags$style(HTML("div.main-header {text-align: center;}"))),
  tags$script(HTML('
                   $(document).ready(function() {
                   $("header").find("nav").append(\'<span class="myClass" style="white-space:pre">                                                        Twitter Talks, Shiny Sparks !</span>\');
                   })
                   ')),
  tags$head(tags$style(HTML('.modal-sm {width: 40px;}'))),
  
  # Set the boxes of all charts
  tags$head(tags$style(HTML(".col-sm-2,.col-sm-12,.col-sm-4,.col-sm-12,.col-sm-6,.col-sm-7,.col-sm-5 {
                            position: relative;
                            min-height: 1px;
                            padding-right: 5px;
                            padding-left: 5px;"))),
  
  tags$head(tags$style(HTML(".container-fluid {padding-left: 5px; padding-right: 5px;}"))),
  tags$head(tags$style(HTML(".form-group {margin-bottom: -15px;}"))),
  
  tags$head(tags$style(HTML(".box {margin-bottom: 10px;}"))),
  
  
  tags$head(tags$style(HTML("#col_word_cloud,#col_freq {padding-left:0px;padding-right:0px;} "))),
  #tags$head(tags$style(HTML("#col_emotion,#col_sentiment {padding-left:0px;padding-right:0px;} "))),
  tags$head(tags$style(HTML(".box-header {text-align: center;} "))),
  tags$head(tags$style(HTML("#network_panel {width:100%;} "))),
  
  tabItems(
    tabItem("textmining",
            fluidPage(
              fluidRow(
                column(7, id = "col_word_cloud",
                       box(width=12, height=550, solidHeader = F, title = strong("The Word Cloud"),
                           radioButtons("word_cloud_gram",NULL, c("Uni-gram","Bi-gram"), selected = "Uni-gram", inline = T),
                           #plotOutput("word_cloud_plot",height = "300px")
                           wordcloud2Output("word_cloud_plot",height = "470px"))
                ),
                column(5, id = "col_freq",
                       box(width=12, height=550, solidHeader = F, title = strong("Here are the frequent words.."),
                           highchartOutput("word_freq_plot", height=500)
                       )
                       
                )
              )
            )
            
    ),
    tabItem("sentiment",
            fluidPage(
              fluidRow(
                column(width = 6, id = "col_emotion",
                       box(width=NULL, height=550, solidHeader = F, title = strong("Emotions Radar"),
                           highchartOutput("emotion_polar_plot",height=500)
                       )
                ),
                column(width = 6, 
                       box(width=NULL, height=270, solidHeader = F, title = strong("Sentiment Polarity"),
                           highchartOutput("sentiment_plot",height = 210)
                       ),
                       box(width=NULL, height=270, solidHeader = F, title = strong("The extreme ones.."),
                           htmlOutput("pos_tweet"),
                           htmlOutput("neg_tweet")
                       )
                )
              )
            )
            
    ),
    tabItem("summary",
            fluidPage(
              fluidRow(
                box(width=12, height=370, title = strong("Let us check some popular tweets !!"),
                    radioButtons("fav_rt_button",NULL, c("Most Favorited","Most Retweeted"), selected = "Most Favorited", inline = T),hr(),
                    htmlOutput("fav_rt_tweets")),
                box(width=12, height=300, title = strong("Story - Screenplay - Direction ..."),
                    tags$ul(
                      tags$li(strong(tags$a("Murali - LinkedIn Connect", href = "https://www.linkedin.com/in/muralimohanakrishnadandu/", target="_blank"))," | ",
                              strong(tags$a("Medium Article Link", href = "https://www.linkedin.com/in/muralimohanakrishnadandu/", target="_blank")))
                    ),
                    hr(),
                    h5(strong("Twitter Data:"),style = 'color:rgb(0, 112, 192)'),strong("Tweets downloaded during the time period 15th Sep'2018 - 22nd Sep'2018 with following hashtags - "),
                    tags$ul(
                      tags$li("Data Science (#DataScience OR #MachineLearning OR #DeepLearning): 37426 tweets"),
                      tags$li("IPhoneXS (#iPhoneXS OR #iPhoneXSMax): 21876 tweets"),
                      tags$li("Captain Marvel Trailer (#CaptainMarvelTH OR #CaptainMarvelTrailer OR #captainmarvel): 46092 tweets"),
                      tags$li("Section 377 (#Section377Verdict OR #Section377 OR #377Verdict OR #section377scrapped): 1232 tweets"),
                      tags$li("Robo 2.0 Teaser (#2Point0Teaser OR #2Point0 OR #2point0trailer): 5395 tweets"),
                      tags$li("Reliance-Dassault Rafale (#Reliance OR #reliance OR #Dassault OR #Rafale): 7991 tweets")
                    )
                )
              )
            )
            
    )
    
  )
  
  
  
  
  
  
)

ui <- dashboardPage(title = 'Twitter Analytics App', header , sidebar, body)



