### LOADING PACKAGES ###

#classical packages for shiny
library(shiny)
library(shinydashboard)
library(dplyr)

#additional packages for the opinion mining project
library(highcharter)#package for rendering charts with additional JavaScript formatting
library(tm) #package for textmining
library(stringr)#package for easy manipulation on strings
library(wordcloud2)#package for word cloud visualization with additional JavaScript formatting
library(tidytext)#package for sentiment analysis
library(tidyr)# package for additional manipulations on dataframe
library(DT) #package for rendering dataframes in HTLM
library(slam)# package for additional functions on dataframe


### UI ###


#defining the header with a custom logo
header <- dashboardHeader(title= img(src = 'https://intellisolutions-dz.com/wp-content/uploads/2019/07/youtube.png', title="test",height = "50px"))

 #defining the sidebar 
sidebar <- dashboardSidebar(
  
  #displaying the video selector dropdown
  htmlOutput("video_selector"),
  hr(),
  #displaying the different tabs buttons
  sidebarMenu(id = 'menu',
              menuItem(strong("Video summary"),tabName = 'summary', icon = icon("youtube")),
              menuItem(strong("Text Mining"),tabName = 'textmining', icon = icon("zoom-in", lib = "glyphicon")),
              menuItem(strong("Sentiment Analysis"),tabName = 'sentiment', icon = icon("smile", lib = "font-awesome"))),
  #displaying the redirection buttons to code source and technical document 
  actionButton("button1", "Project Details",icon=icon("file-alt", lib= "font-awesome"), style = "display: inline-block; vertical-align: bottom; width: 115px ; margin-top:25px", onclick="window.open('https://drive.google.com/file/d/10vM9Tm3R43L-RsxVd8bfFYyW4ul8Q7vx/view?usp=sharing', '_blank')"),
  actionButton("button2", "Code",icon=icon("github"), style = "display: inline-block; vertical-align: bottom; width: 65px ; margin-top:25px", onclick="window.open('https://github.com/clietar/Data-Journalism/tree/master/Youtube%20NLP%20Application', '_blank')"))


body <- dashboardBody(
  
  #Custom CSS code for changing color of main header & logo divs
  tags$head(tags$style(HTML('
           /* logo */
        .skin-blue .main-header .logo {
                              background-color: #EFF1F7;
                              }

        /* logo when hovered */
        .skin-blue .main-header .logo:hover {
                              background-color: #D02F26;
                              }

        /* navbar (rest of the header) */
        .skin-blue .main-header .navbar {
                              background-color: #D02F26;
                              font-size: 22px;
                              color :white;
                              font-weight: bold;
                              }     
    
    .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
    font-weight: bold;font-size: 16px;
    }
    '))),
  #Custom CSS for application title 
  tags$script(HTML('
                   $(document).ready(function() {
                   $("header").find("nav").append(\'<span class="myClass" style="white-space:pre"> <center> An Opinion Mining Story: What insights to extract from Youtube comments?  </center> </span>\');
                   })
                   ')),
  tags$head(tags$style(HTML('.modal-sm {width: 40px;}'))),
  
  
  
  # Set the boxes for storing all charts with custom CSS (reactive adaption on screen)
  tags$head(tags$style(HTML(".col-sm-2,.col-sm-12,.col-sm-4,.col-sm-12,.col-sm-6,.col-sm-7,.col-sm-5 {
                            position: relative;
                            min-height: 1px;
                            padding-right: 5px;
                            padding-left: 5px;"))),
  
  tags$head(tags$style(HTML(".container-fluid {padding-left: 5px; padding-right: 5px;}"))),
  tags$head(tags$style(HTML(".form-group {margin-bottom: -15px;}"))),
  
  tags$head(tags$style(HTML(".box {margin-bottom: 10px;}"))),
  
  # set a custom CSS div for storing text & scrolling through it
  tags$head(tags$style(HTML("#scrollingtext {
                        width: 100%;
                        height: 250px;
                        overflow: scroll;
                        padding-left:0px;padding-right:0px;
                    }"))),
  tags$head(tags$style(HTML(".box-header {text-align: center;} "))),
  
  #defining the ui for each tab 
  tabItems(
    #The video summary tab : displaying the youtube video, the descriptive statistics associated and the top  6 liked comments
    tabItem("summary",
            fluidPage(
              fluidRow(
                #displaying the video
                column(width = 6,
                       box(width=NULL, height=640, solidHeader = F, title = strong("Watch video"),
                           htmlOutput("video")
                       )
                ),
                #displaying the statistics into a DataFrame 
                column(width=6, box(width=NULL, height=320, solidHeader = F, title = strong("Top stats"),  DT::dataTableOutput("stat_table")
                )),
                #displaying the top 6 liked comments, storing in the scrollingtext div for displaying all the text into a box
                column(width=6,box(width=NULL, height=310, id="scrollingtext", solidHeader = F, title = strong("Top 6 comments"),
                                   htmlOutput("top_6_comments")
                )
                )
              )
            )
            
    ),
    #The Text Mining  tab : displaying the the word frequency plot and the word cloud plot 
    tabItem("textmining",
            fluidPage(
              fluidRow(
                #displaying the word cloud plot 
                column(12,
                       box(width=12, height=350, solidHeader = F, title = strong("Top Frequent Words"),
                           wordcloud2Output("word_cloud_plot",height = 250, width="100%"))
                ),
                #displaying the word frenquency plot 
                column(12,
                       box(width=12, height=320, solidHeader = F,
                           highchartOutput("word_freq_plot", height=280))
                       
                       
                )
              )
            )
            
    ),
    #The sentiment tab :displaying the emotion radar, the sentiment polarity plot and the top positive/negative comments
    tabItem("sentiment",
            fluidPage(
              fluidRow(
                #displaying the sentiment polarity plot 
                column(width = 6,
                       box(width=NULL, height=400, solidHeader = F, title = strong("Sentiment Polarity"),
                           highchartOutput("sentiment_polarity_plot",height = 350))
                ),
                #displaying the emotion radar
                column(width = 6,
                       box(width=NULL, height=400, solidHeader = F, title = strong("Emotions Radar"),
                           highchartOutput("emotion_radar_plot",height=350)
                       )
                ),
                #displaying the top positive commnent, storing it in a scrollingtext div
                column(width = 6,
                       box(width=NULL, id="scrollingtext", height=250, solidHeader = F,
                           htmlOutput("top_positive_comment")
                       )
                ),
                #displaying the top negative commnent, storing it in a scrollingtext div
                column(width = 6,
                       box(width=NULL, height=250,id="scrollingtext",  solidHeader = F,
                           htmlOutput("top_negative_comment")
                           
                       )
                )
              )
              
            )
            
            
            
            
            
    )))


ui <- dashboardPage(title = 'Youtube NLP App', header , sidebar, body)





server = function(input, output, session) {
  
  ##LOADING DATA SET##
  
  #Loading raw comment datasets
  ps5 = read.csv('data/PS5_Hardware_Reveal_Trailer.csv')
  iphone = read.csv('data/iPHONE_12_TRAILER.csv')
  trump = read.csv("data/Joe_Biden_and_Donald_Trump's_fiery_first_debate—Here_are_the_highlights.csv")
  corona= read.csv('data/The_Race_To_Develop_A_Coronavirus_Vaccine.csv')
  qanon = read.csv("data/QAnon_-_If_You_Don't_Know,_Now_You_Know_|_The_Daily_Social_Distancing_Show.csv")
  emily = read.csv('data/Emily_in_Paris_|_Official_Trailer_|_Netflix.csv')
  lockdown = read.csv('data/PM_announces_month-long_lockdown_in_England.csv')
  fifa = read.csv('data/FIFA_21_|_Official_Reveal_Trailer.csv')
  tesla=  read.csv('data/Tesla_Cybertruck_event_in_5_minutes.csv')
  disney = read.csv('data/Start_Streaming_Now_|_Disney+.csv')
  
  

  
  
  #loading video stats comments 
  ps5_stats = read.csv('stats/stats_ PS5_Hardware_Reveal_Trailer.csv')
  iphone_stats = read.csv('stats/stats_ iPHONE_12_TRAILER.csv')
  trump_stats = read.csv("stats/stats_ Joe_Biden_and_Donald_Trump's_fiery_first_debate—Here_are_the_highlights.csv")
  corona_stats = read.csv('stats/stats_ The_Race_To_Develop_A_Coronavirus_Vaccine.csv')
  qanon_stats = read.csv("stats/stats_ QAnon_-_If_You_Don't_Know,_Now_You_Know_|_The_Daily_Social_Distancing_Show.csv")
  lockdown_stats = read.csv('stats/stats_ PM_announces_month-long_lockdown_in_England.csv')
  emily_stats =read.csv('stats/stats_ Emily_in_Paris_|_Official_Trailer_|_Netflix.csv')
  fifa_stats = read.csv('stats/stats_ FIFA_21_|_Official_Reveal_Trailer.csv')
  tesla_stats = read.csv('stats/stats_ Tesla_Cybertruck_event_in_5_minutes.csv')
  disney_stats = read.csv('stats/stats_ Start_Streaming_Now_|_Disney+.csv')
  
  
  
  #Merging all youtube datasets & adding a column "video" to specify  the topic   ===
  youtube_raw_final = rbind(
    cbind(ps5, video = "PS5 Reveal Trailer"),
    cbind(iphone, video = "Iphone 12 Unveiled"),
    cbind(trump, video = "TrumpvsBiden 1st Debate"),
    cbind(corona, video = "Coronavirus Vaccine Race"),
    cbind(qanon, video = "QAnon Movement"),
    cbind(emily, video = "EmilyinParis Trailer"),
    cbind(lockdown, video = "New UK Lockdown"),
    cbind(fifa, video = "FIFA 21 Trailer"),
    cbind(tesla, video = "Tesla CyberTruck fail"),
    cbind(disney, video = "Disney+ announcement")
  )
  
  #Mergn al youtube stat datasets & adding a column "video" to specify the topic 
  youtube_stats_final = rbind(
    cbind(ps5_stats, video = "PS5 Reveal Trailer"),
    cbind(iphone_stats, video = "Iphone 12 Unveiled"),
    cbind(trump_stats, video = "TrumpvsBiden 1st Debate"),
    cbind(corona_stats, video = "Coronavirus Vaccine Race"),
    cbind(qanon_stats, video = "QAnon Movement"),
    cbind(lockdown_stats, video = "New UK Lockdown"),
    cbind(emily_stats, video = "EmilyinParis Trailer"),
    cbind(fifa_stats, video = "FIFA 21 Trailer"),
    cbind(tesla_stats, video = "Tesla CyberTruck fail"),
    cbind(disney_stats, video = "Disney+ announcement")
  )
  
  
  #Defining the video selector
  output$video_selector = renderUI({
    selectInput("video_selector",label = "Select Youtube Video:",
                choices = list("Gaming"=c("PS5 Reveal Trailer","FIFA 21 Trailer"), "Tech"=c("Tesla CyberTruck fail", "Iphone 12 Unveiled"), "Streaming"=c("EmilyinParis Trailer","Disney+ announcement"), "Politics"=c('TrumpvsBiden 1st Debate','New UK Lockdown'), "Society"=c("Coronavirus Vaccine Race","QAnon Movement")),
                selected = "Disney+ announcement", width="100%")
  })
  
  
  
  ##SERVER CODE FOR  SUMMURAY PAGE##
  
  
  # dynamic stat  selection when selecting the video 
  reactive_youtube_stats_selection = reactive({
    selected_stats = youtube_stats_final %>% filter(video == input$video_selector)
    selected_stats
    
  }) 
  
  #getting video id from the stat dataset 
  fetch_id_from_dataset =  reactive({
    id = reactive_youtube_stats_selection()[1,2]
    id
  })
  
  
  #deifing the video plot form embedding youtube video in dashboard
  output$video <- renderUI({
    HTML(paste0('<iframe src="https://www.youtube.com/embed/',fetch_id_from_dataset() ,'" width="100%" height="100%" frameborder="0" style="display: block; margin: 0px auto; position: absolute; top: 0; left: 0;"></iframe>'))
  })
  
  
  
  #reactive  cleaning  stat dataset for outputing the stat  dataframe in the dashboard 
  stats_cleaning  =  reactive({
    df = reactive_youtube_stats_selection()
    names(df) = c("","id", "Views","Likes","Dislikes","Favorite","Comments") 
    cleaned_stats  =  df[,c("Views","Likes","Dislikes","Comments")]%>% t() %>% data.frame()
    cleaned_stats
    
  })
  
  
  #defining the dataframe plot and adding custom Javascript code
  output$stat_table <- DT::renderDataTable({
    DT::datatable(stats_cleaning(), rownames=TRUE, colnames="Count",  selection = 'single', options = list(
      initComplete = JS(
        "function(settings, json) {",
        "$('body').css({'font-weight': 'bold'});",
        "}"
      )
    ))
  })
  
  
  #getting the top 6 comments 
  top_liked_comments = reactive({
    youtube_comments= youtube_raw_final %>% filter(video == input$video_selector)
    top_comments = head(youtube_comments %>% select(Comments, Likes) %>% arrange(desc(Likes)))
    top_comments
  })
  
  
  #defining the top 6 comments plot 
  output$top_6_comments = renderUI({
    tags$ul(
      tags$li(paste(top_liked_comments()[1,]$Comments,"-",paste(top_liked_comments()[1,]$Likes, "likes")), style = "margin-bottom: 5px; color: #222C31; font-weight: bold; font-family:Monaco"), 
      tags$li(paste(top_liked_comments()[2,]$Comments,"-",paste(top_liked_comments()[2,]$Likes,"likes")), style = "margin-bottom: 5px; color: #D02F26; font-weight: bold; font-family:Monaco"), 
      tags$li(paste(top_liked_comments()[3,]$Comments,"-",paste(top_liked_comments()[3,]$Likes,"likes")), style = "margin-bottom: 5px; color: #222C31; font-weight: bold; font-family:Monaco"),
      tags$li(paste(top_liked_comments()[4,]$Comments,"-",paste(top_liked_comments()[4,]$Likes,"likes")), style = "margin-bottom: 0px; color: #D02F26; font-weight: bold; font-family:Monaco"),
      tags$li(paste(top_liked_comments()[5,]$Comments,"-",paste(top_liked_comments()[5,]$Likes,"likes")), style = "margin-bottom: 0px; color: #222C31; font-weight: bold; font-family:Monaco"),
      tags$li(paste(top_liked_comments()[6,]$Comments,"-",paste(top_liked_comments()[6,]$Likes,"likes")), style = "margin-bottom: 0px; color: #D02F26; font-weight: bold; font-family:Monaco")
    )
  })
  
  
  
  ##DATA CLEANING ##
  
  # function  to clean the data given a column input 
  
  comments_cleaner = function(comments) {
    # Remove the &
    comments=gsub("&amp", "", comments) 
    # Remove the @
    comments= gsub("@\\w+", "",comments ) 
    # Before removing punctuations, add a space before every hashtag
    comments =gsub("#", " ",comments) 
    # Remove Punct
    comments= gsub("[[:punct:]]", "",comments) 
    # Remove Digit/Numbers
    comments =gsub("[[:digit:]]", "",comments)
    # Remove Links
    comments= gsub("http\\w+", "",comments) 
    # Remove tabs
    comments= gsub("[ \t]{2,}", " ",comments) 
    # Remove extra white spaces
    comments= gsub("^\\s+|\\s+$", " ",comments) 
    # remove blank spaces at the beginning
    comments= gsub("^ ", "",comments)  
    # remove blank spaces at the end
    comments=gsub(" $", "",comments) 
    # Remove Unicode Character
    comments = gsub("[^[:alnum:][:blank:]?&/\\-]", "",comments ) 
    # keep only latin characters
    comments = gsub("([^A-Za-z ])+", "",comments ) 
    #get rid of unnecessary spaces
    comments= str_replace_all(comments," "," ") 
    # Get rid of hashtag
    comments = str_replace_all(comments,"#[a-z,A-Z]*","") 
    # Get rid of references to other users
    comments = str_replace_all(comments,"@[a-z,A-Z]*","") 
    
    comments
  }
  
  # function to clean the comment column of an input collected youtube dataset & keep cleaning dataset
  
  youtube_cleaner = function(df) {
    df = unique(df)
    df[,1] = comments_cleaner(df[,1])
    # remove rows with no comments
    df = df[!apply(df, 1, function(x) any(x=="")),] 
    df
    
  }
  
  # keep all comments from final youtube dataset & video topic for text mining (remove users, and like counts to each comment)
  youtube_final_raw_comments = youtube_raw_final %>% select(1,4)
  
  
  
  
  
  # dynamic data cleaning on comments when selecting the video : applying previous function defined when selecting a video topic via the video selector
  reactive_youtube_data_cleaning = reactive({
    #displaying info to the user
    progress = shiny::Progress$new()
    progress$set(message = "Fetching youtube dataset.. ", value = 0)
    on.exit(progress$close())
    
    #applying cleaning functions
    video_comments = youtube_final_raw_comments %>% filter(video == input$video_selector)
    progress$set(detail = "Cleaning selected video dataset", value = 0.5)
    cleaned_comments = youtube_cleaner(video_comments)[,1]
    cleaned_comments
    
  })
  
  ## SERVER CODE FOR TEXT MINING TAB ##
  
  # defining function to create a corpus of documents from cleaned comments & apply further cleaning "tm" package methods on it
  corpus_cleaner = function(cleaned_comments, 
                            #custom stop word lists : remove words from video title, highly linked to video topic and irrelevant, and ohter common English stop words incorrectly input by Youtube users
                            stopwords = c("trump", "biden", "donald", "joe", 
                                          "makeamericagreatagain", "usa",
                                          "sony",
                                          "ps", "playstation", "play", "american", "america", "debate", "can", "cant", "dont","didnt", "youre", "hes", "just", "like", "president", "hes","like", "got", "see", "look", "console", "que", "whats", "know", "thats", "just", "get", "people", "will", "even", "let", "make", "guy","one", "game", "fifa", "trailer","vaccine", "corona", "covid", "coronavirus", "virus", "tesla", "truck", "car", "phone", "apple", "disney","lockdown", "trevor", "qanon", "anon", "elon","musk", "cybertruck", "emily", "paris", "camera", "iphone")){
    corpus = Corpus(VectorSource(cleaned_comments))
    # Convert the text to lower case
    corpus = tm_map(corpus, content_transformer(tolower))
    # Remove numbers
    corpus = tm_map(corpus, removeNumbers) 
    # Remove english common stopwords
    corpus = tm_map(corpus, removeWords, stopwords("english")) 
    # Remove  words in the customized stop word list
    corpus = tm_map(corpus, removeWords, stopwords) 
    # Remove punctuations
    corpus = tm_map(corpus, removePunctuation) 
    # Eliminate extra white spaces
    corpus = tm_map(corpus, stripWhitespace) 
    corpus
  }   
  
  
  #dynamic  creation of the corpus following video topic selection & cleaning  (corpus = a collection of all documents, a document = a comment)
  corpus = reactive({
    
    #displaying info to the user
    progress = shiny::Progress$new()
    progress$set(message = "Preparing Corpus", value = 0)
    on.exit(progress$close())
    
    progress$set(detail = "Cleaning corpus...", value = 0.5)
    corpus_cleaner(reactive_youtube_data_cleaning())
    
  }) 
  

  
  #dynamic creation of the TermDocumentMatrix (a sparse matrix where each row represent the occurency of a term through all documents/comments) following video topic selection, cleaning on it and corpus creation associated
  TDM = reactive({
    
    #displaying info to the user
    progress = shiny::Progress$new()
    progress$set(message = "Starting video comments mining", value = 0)
    on.exit(progress$close())
    
    progress$set(detail = "Creating the TermDocumentMatrix...", value = 0.5)
    TermDocumentMatrix(corpus())
    
  })
  
  #get  the term frequency dataframe  from the TermdocumentMatrix : summing all column values for each row of TDM to get the frequency of a term across all documents
  term_frequencies = reactive({
    frequency = sort(row_sums(TDM()),decreasing=TRUE)
    data.frame(term = names(frequency),frequency=frequency)
  })
  
  
  #defining the word frequency plot with additonal JavaScript code formatting for the tooltip
  output$word_freq_plot = highcharter :: renderHighchart({
    hc = highchart() %>% #	A highchart htmlwidget object
      hc_tooltip(crosshairs = TRUE, shared = FALSE,useHTML=TRUE,
                 #customer JavaScript code for the tooltip
                 formatter = JS(paste0("function() {  
                                       //console.log(this);
                                       //console.log(this.point.y);
                                       var result='';
                                       result='<br/><span style=\\'color'+this.series.color+'\\'></span><b> '
                                       +Math.round(this.point.y.toFixed(0)) + ' times' + '</b>';
                                       return result;
      }"))) %>%
      # selecting top 50 of most frequent word
      hc_xAxis(categories = term_frequencies()$term[1:200], 
               labels = list(style = list(fontSize= '15px')), max=20, scrollbar = list(enabled = T)
      )    %>%
      hc_add_series(data = term_frequencies()$frequency[1:50], type ="column",
                    color = "#D02F26", showInLegend= F)
  })
  
  
  #defining the Word cloud plot
  output$word_cloud_plot = wordcloud2 :: renderWordcloud2({
    set.seed(666)
    # filtering the term frequencies dataframe to display only relevant frequent terms
    term_frequencies_filtered = (term_frequencies() %>% filter(frequency>1) %>% arrange(desc(frequency)))[1:200,] 
    wordcloud2(data = term_frequencies_filtered, size=0.8, minSize = 0.0, fontWeight = 'bold',
               # passing the filtered dataframe into the word cloud function 
               ellipticity = 0.15, fontFamily='Monaco') 
    
  })   
  
  
  
  ## SERVER CODE FOR THE SENTIMENT ANALYSIS CODE ##
  
  
  #emotion classification : computing the occurences(=emotion scores) of the 8 emotion classes through all comments'tokens
  
  #displaying information for the user
  emotion_score = reactive({
    progress = shiny::Progress$new()
    progress$set(message = "Preparing data for emotion mining...", value = 0.2)
    on.exit(progress$close())
    
    #doing  reactive cleaning process when topic is selected 
    comments_data = data.frame(comment_id = 1:length(reactive_youtube_data_cleaning()), cleaned_comments = reactive_youtube_data_cleaning())
    comments_data$cleaned_comments = as.character(comments_data$cleaned_comments)
    
    # tokenizing (= splitting) each comment into words (=tokens)
    tokenized_comments = comments_data  %>% unnest_tokens(output = word, input = cleaned_comments, token = "words") 
    
    # retrieving emotion categories for tokens present in the NRC emotion-lexicon package (collection of english words labelled with emotion class(es) , from tidytext package )
    tokenized_comments_with_emotions = tokenized_comments %>% inner_join(get_sentiments("nrc"))
    progress$set(value = 0.8, detail = paste("Fetching top emotions in Youtube comments..."))
    
    #computing occurency of each emotion as the score
    top_emotions = tokenized_comments_with_emotions %>% group_by(sentiment) %>% summarise(occcurency = n()) 
    names(top_emotions) = c("emotion", "occurency")
    # removing "postive" and "negative" emotions, will be treated in sentiment polarity analysis
    top_emotions[c(1:5,8:10),] 
    
  })
  
  
  
  
  #definng the emotion radar plot with highcharter package
  output$emotion_radar_plot = highcharter :: renderHighchart({
    hc = highchart() %>%
      hc_chart(polar = T) %>% 
      hc_xAxis(categories = emotion_score()$emotion, 
               labels = list(style = list(fontSize= '13px')), title =NULL, tickmarkPlacement = "on", lineWidth = 0) %>% 
      hc_plotOptions(series = list(marker = list(enabled = F))) %>% 
      hc_yAxis(gridLineInterpolation = "polygon", lineWidth = 0, min = 0) %>% 
      hc_add_series(name = "Occurency of emotion in comments", emotion_score()$occurency, type ="area", color = "#EA3223", pointPlacement = "on")
  })
  
  
  
#defining the sentiment score by comments for the sentiment polarity analysis : get a score between -5 and 5 for each token of comment, sum all the scores to get a score for each comment, and categorize it as "negative", "positive" or "neutral" given the score
  
#display info to the user
  sentiment_score = reactive({
    progress = shiny::Progress$new()
    progress$set(message = "Preparing for  Sentiment mining", value = 0)
    on.exit(progress$close())
    
    #doing  reactive cleaning process when topic is selected 
    comments_data = data.frame(comment_id = 1:length(reactive_youtube_data_cleaning()), cleaned_comments = reactive_youtube_data_cleaning())
    comments_data$cleaned_comments = as.character(comments_data$cleaned_comments)
    
    # tokenizing (= splitting) each comment into words (=tokens)
    tokenized_comments = comments_data  %>% unnest_tokens(output = word, input = cleaned_comments, token = "words")
    #retrieving sentiment score associated to tokens present in the "afinn" word-lexion (each word is labelized with a score between -5 and 5), store the score in a "value" column
    tokenized_comments_with_sentiment_score = tokenized_comments %>% inner_join(get_sentiments("afinn"))
    #get total emotion score by comments : summing all emotion scores for each tokens belonging to a comment 
    score_by_comments_id = tokenized_comments_with_sentiment_score %>% group_by(comment_id) %>% summarize(score = sum(value))
    
    progress$set(detail = "Getting score...", value = 0.8)
    # categorizing the comments id based on the total emotion score (if > 0, positive comment, if ==0, neutral comment, else negative comment)
    score_by_comments_id$outcome = ifelse(score_by_comments_id$score < 0, "Negative", ifelse(score_by_comments_id$score > 0, "Positive", "Neutral"))
    # retrieving full comment for each comment id that received a sentiment score
    score_by_comments = score_by_comments_id %>% left_join(comments_data) 
    
    #getting the top positive and negative comments based on total sentiment score of each comment id
    top_positive_comment = as.character(score_by_comments[score_by_comments$score == max(score_by_comments$score),"cleaned_comments"][1,1])
    top_negative_comment = as.character(score_by_comments[score_by_comments$score == min(score_by_comments$score),"cleaned_comments"][1,1])
    
    output_list = list(score_by_comments, top_positive_comment, top_negative_comment)
    output_list
  })
  
  #computing percentage of positive , negative and neutral comments occurences
  sentiment_ratio  = reactive({
    sentiment_score()[[1]] %>% group_by(outcome) %>% summarise(score = n()) %>% 
      mutate(score_percentage = (score/sum(score))*100, coloract = c("#D02F26", "#2980b9", "#2ecc71"))
  })
  
  
  #defining the sentiment plority  plot
  output$sentiment_polarity_plot = highcharter :: renderHighchart({
    
    hc = highchart() %>%
      hc_tooltip(crosshairs = TRUE, shared = FALSE,useHTML=TRUE,
                 formatter = JS(paste0("function() {
                                       console.log(this.point.y);
                                       var result='';
                                       result='<br/><span style=\\'color:'+this.series.color+'\\'>'+this.series.name+'</span>:<b> '+Math.round(this.point.y.toFixed(0))/1 + '%' + '</b>';
                                       return result;
                   }")))%>%
      hc_xAxis(categories = sentiment_ratio()$outcome,
               labels = list(style = list(fontSize= '15px'))
      )    %>%
      hc_colors(colors = sentiment_ratio()$coloract) %>% 
      hc_add_series(name="Proportion of sentiment in comments ", data = sentiment_ratio()$score_percentage, colorByPoint = TRUE, 
                    type ="column",
                    color = "#D02F26", showInLegend= F) %>% 
      hc_yAxis(labels=list(format = '{value}%'),min=0,
               max=100,showFirstLabel = TRUE,showLastLabel=TRUE)
  })
  
  
  
  #defining  the top positive and negative comments display , with customer HTML code 
  output$top_positive_comment = renderUI({
    HTML(paste("<b>","Top positive comment: ","</b>"),"<br>","<i style = 'font-weight: bold'>","\"",sentiment_score()[[2]],"\"","</i>","<hr>")
  })
  output$top_negative_comment = renderText({
    HTML(paste("<b>","Top negative comment: ","</b>"),"<br>","<i style = 'font-weight: bold'>","\"",sentiment_score()[[3]],"\"","</i>")
  })
  
  
  
  
}

# Create Shiny app ----
shinyApp(ui, server)
