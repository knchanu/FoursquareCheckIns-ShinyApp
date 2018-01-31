library(shiny)
library(shinydashboard)
library(leaflet)
library(shinythemes)


shinyUI(
        navbarPage(title = "Visualizing Foursquare Check Ins - NYC Edition",
             
                   theme = shinytheme("flatly"), 
                   #https://rstudio.github.io/shinythemes/
             
             
############### HOME ###############             
                   
        tabPanel("Home",
                
                 mainPanel(
                   br(),
                   br(),
                   br(),
                   br(),
                   h1(strong("Visualizing Foursquare Check-Ins",style = "color:red")),
                   h3(em("Insights about New Yorkers through the lens of Foursquare data*")),
                   br(),
                   br(),
                   h6("*Data based on long-term (about 10 months) check in data in New York City collected from Foursquare from 12 April 2012 to 16 February 2013.")
                 ),
                 
                 tags$img(src = "1_cDhwfDSJ7rSJl6jT-n1BWQ.gif", height = 640, width = 200)),
                 

                #.gif = https://cdn-images-1.medium.com/max/600/1*cDhwfDSJ7rSJl6jT-n1BWQ.gif
                #Image Src = https://medium.com/topos-ai/rethinking-distance-in-new-york-city-d17212d24919


############### OVERVIEW ##############

       tabPanel("Overview",
                
                mainPanel(
                  br(),
                  br(),
                  br(),
                  br(),
                  h1(strong("Overview", style = "color:red")),
                  br(),
                  h3("Hello, welcome!"),
                  h3("The goal of this Shiny app is to visualize consumer behavior and interaction with social media."),
                  br(),
                  h3(("Specifically,")), 
                  br(),
                  h2(em("What can we tell about New Yorkers and tourists in New York based on how they use Foursquare?"))
                  
                  ),
                br(),
                br(),
                br(),
                br(),
                br(),
                br(),
                tags$img(src = "1_VniZUGHDd_-DBs2Yof6W3A.gif", height = 200, width = 200),
                br(),
                tags$img(src = "1_ZUpppBawkTjT56B-QUvuSw.gif", height = 200, width = 200)),
                
############### NYC MAP ###############
                   
        tabPanel("NYC Map",
                 tags$iframe(src="https://knchanu.carto.com/builder/f2a4f574-8356-42a1-b79a-4485498100a0/embed", 
                             width="100%", 
                             height="610px",
                             seamless = "seamless")),
                 
############### ANALYSIS & INSIGHTS ###############

        tabPanel("Analytics & Insights",
                 
                 selectizeInput(inputId = "TimeFrameVCB",
                                label = h4(strong("Distribution of Check Ins - Weekday vs. Weekend",style = "color:red")),
                                choices = c("Weekday", "Weekend")),
                 
                 plotOutput("VCB", height = "480px", width = "100%")
          
                 ), 

############### VIDEO ###############

         tabPanel("Video",
                  tags$iframe(src="https://www.youtube.com/embed/wrInToGwiZQ?ecver=2", 
                              width="100%", 
                              height="610px",
                              seamless = "seamless")),
              
############### REFERENCES ###############

        navbarMenu("References",
                   tabPanel("NYC Check-ins Dataset",
                
                            tags$img(src = "Foursquare_logo.svg.png", height = 60, width = 100),
                            
                            #Image Src = https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Foursquare_logo.svg/1200px-Foursquare_logo.svg.png
                            
                            h3(a("NYC Check-ins Foursquare Dataset", 
                                  href="http://sites.google.com/site/yangdingqi/home/foursquare-dataset")),
                            tags$img(src="Foursquare-hand.jpg", height = 500, width = 710)
                            
                            ),
                    
                   tabPanel("Research Paper",        
                             h3(a("Modeling User Activity Preference by Leveraging User Spatial Temporal Characteristics in LBSNs", 
                                  href="http://www-public.tem-tsp.eu/~zhang_da/pub/TSMC_YANG_2014.pdf")),
                             tags$iframe(style="height:600px; width:100%; scrolling=yes", 
                                        src="http://www-public.tem-tsp.eu/~zhang_da/pub/TSMC_YANG_2014.pdf"))
                            
                            )
                      

))


