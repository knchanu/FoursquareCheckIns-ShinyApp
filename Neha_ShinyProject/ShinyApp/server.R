
library(shiny)
library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)

#==========================================
########## Bar Plot ##########
#==========================================

function(input, output) {
  
  output$VCB <- renderPlot({
    
    if (input$TimeFrameVCB == "Weekday") {
      new.df = raw.df %>% filter(Weekend_or_Weekday == "Weekday") %>% 
        group_by(VenueCategoryBucket) %>% 
        summarise(count = n())
    } else {
      new.df = raw.df %>% filter(Weekend_or_Weekday == "Weekend") %>% 
        group_by(VenueCategoryBucket) %>% 
        summarise(count = n())
    }
     #new.df = raw.df %>% group_by(VenueCategoryBucket, Weekend_or_Weekday) %>% summarise(count = n())
     ggplot(new.df, 
            aes(x = VenueCategoryBucket, y = count, fill = VenueCategoryBucket)) + 
       geom_bar(stat = "identity") + 
       coord_flip() + 
       labs(x = "Number of Check Ins", y = "Venue Category") + scale_fill_discrete(name = "Venue Category")
     
     
    
  })
}