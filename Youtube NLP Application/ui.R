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
  actionButton("button1", "Project Details",icon=icon("file-alt", lib= "font-awesome"), style = "display: inline-block; vertical-align: bottom; width: 115px ; margin-top:25px", onclick="window.open('http://google.com', '_blank')"),
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


ui <- dashboardPage(title = 'Youtube Opinion Mining', header , sidebar, body)
