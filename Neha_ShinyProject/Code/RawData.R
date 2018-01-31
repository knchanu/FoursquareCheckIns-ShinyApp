###### NYCDSA: Shiny Project ######
###### Author: Neha Chanu #######


library(ggplot2)
library(data.table)
library(dplyr)

#Import the NYC Check-ins dataset 

raw.df <- fread("/Users/nehachanu/Desktop/NYSDSA Homework/Neha_ShinyProject/NYC and Tokyo Check-in Dataset/dataset_tsmc2014/dataset_TSMC2014_NYC.txt", stringsAsFactors = F)
raw.df <- as.data.frame(raw.df)

#Change/Add column names

colnames(raw.df) = c('UserID_Anonymized','VenueID_Foursquare','VenueCategoryID_Foursquare','VenueCategoryName_Foursquare','Latitude','Longitude','TimezoneOffset_minutes','UTC_time')

#Create a new column, "VenueCategoryBucket" that categorizes each of the venue categories into 9 broader categories

TransformRaw.df = function(x){
  
 if(x == "Gastropub" |
     x == "Other Nightlife" |
     x == "Bar" |
     x == "Comedy Club" |
     x == "Casino" |
     x == "Beer Garden" |
     x == "Winery" |
     x == "Brewery" |
     x == "Distillery" |
     x == "Nightlife Spot"){                
    return("Bar & Nightlife")           #1
      
  }else if(x == "Bank" |
           x == "Government Building" |
           x == "Office" |
           x == "Building" |
           x == "Hotel" |
           x == "Factory" |
           x == "Convention Center" |
           x == "Post Office" |
           x == "Housing Development" |
           x == "Professional & Other Places" |
           x == "Design Studio" |
           x == "Embassy / Consulate" |
           x == "Financial or Legal Service" |
           x == "Military Base" |
           x == "Photography Lab" |
           x == "Animal Shelter" |
           x == "Laundry Service" |
           x == "Moving Target" |
           x == "Cemetery" |
           x == "Rest Area" |
           x == "Recycling Facility" | 
           x == "Rental Car Location" |
           x == "Car Wash" |
           x == "Funeral Home" |
           x == "Storage Facility" |
           x == "Newsstand" |
           x == "Pet Service" |
           x == "Medical Center"){          
    return("Business, Government & Other")            #2
      
    }else if(x == "Student Center" |
           x == "College Academic Building" |
           x == "University" |
           x == "General College & University" |
           x == "School" |
           x == "Bookstore" |
           x == "Community College" |
           x == "Medical School" | 
           x == "College Theater" | 
           x == "Sorority House" |
           x == "High School" |
           x == "College & University" | 
           x == "Library" | 
           x == "Nursery" |
           x == "Law School" |
           x == "Elementary School" |
           x == "Education" |
           x == "College Stadium" |
           x == "Fraternity House" |
           x == "Middle School" ){          
    return("Education")                         #3
    
  }else if(x == "Bridge" |
           x == "Bus Station" |
           x == "Airport" |
           x == "Ferry" |
           x == "Subway" |
           x == "Road" |
           x == "Light Rail" |
           x == "Train Station" |
           x == "General Travel" |
           x == "Gas Station / Garage" |
           x == "Parking" |
           x == "Harbor / Marina" |
           x == "Taxi" |
           x == "Travel & Transport" |
           x == "Travel Lounge" |
           x == "Bike Rental / Bike Share"){          
    return("Travel & Transportation")           #4

  }else if(x == "Home (private)" |
           x == "Tattoo Parlor" |
           x == "Salon / Barbershop" |
           x == "Residential Building (Apartment / Condo)" |
           x == "Gym / Fitness Center" |
           x == "Tanning Salon" |
           x == "Spa / Massage" | 
           x == "Garden" |
           x == "Nail Salon" ){          
    return("Home & Personal")                   #5
    
  }else if(x == "Other Great Outdoors" |
           x == "Music Venue" |
           x == "Park" |
           x == "Neighborhood" |
           x == "Playground" |
           x == "Stadium" |
           x == "Performing Arts Venue" |
           x == "Campground" |
           x == "Art Gallery" |
           x == "Event Space" |
           x == "Museum" |
           x == "Arcade" |
           x == "Concert Hall" |
           x == "Athletic & Sport" |
           x == "Theater" |
           x == "Movie Theater" |
           x == "Scenic Lookout" |
           x == "General Entertainment" |
           x == "Pool" |
           x == "Arts & Entertainment" | 
           x == "Bowling Alley" |
           x == "Pool Hall" |
           x == "Outdoors & Recreation" |
           x == "River" |
           x == "Beach" |
           x == "Historic Site" |
           x == "History Museum" |
           x == "Sculpture Garden" |
           x == "Ski Area" |
           x == "City" |
           x == "Science Museum" |
           x == "Art Museum" |
           x == "Racetrack" |
           x == "Zoo" |
           x == "Gaming Cafe" |
           x == "Aquarium" | 
           x == "Fair" |
           x == "Planetarium" |
           x == "Internet Cafe" |
           x == "Public Art" |
           x == "Garden Center" |
           x == "Castle"){          
    return("Leisure & Outdoors")                #6  
    
  }else if(x == "Church" | 
           x == "Synagogue" | 
           x == "Temple" |
           x == "Spiritual Center" |
           x == "Shrine" |
           x == "Mosque"){          
    return("Religious")                         #7    
    
  }else if(x == "Arts & Crafts Store" |
           x == "Electronics Store" |
           x == "Mobile Phone Shop" |
           x == "Automotive Shop" |
           x == "Sporting Goods Shop" |
           x == "Jewelry Store" |
           x == "Clothing Store" |
           x == "Department Store" |
           x == "Mall" |
           x == "Music Store" |
           x == "Miscellaneous Shop" |
           x == "Hardware Store" |
           x == "Convenience Store" |
           x == "Bike Shop" |
           x == "Video Game Store" |
           x == "Toy / Game Store" |
           x == "Paper / Office Supplies Store" |
           x == "Candy Store" |
           x == "Camera Store" |
           x == "Cosmetics Shop" |
           x == "Plaza" |
           x == "Pet Store" |
           x == "Smoke Shop" |
           x == "Record Shop" |
           x == "Furniture / Home Store" |
           x == "Bridal Shop" |
           x == "Antique Shop" |
           x == "Thrift / Vintage Store" |
           x == "Car Dealership" |
           x == "Flea Market" |
           x == "Gift Shop" | 
           x == "Flower Shop" |
           x == "Hobby Shop" |
           x == "Board Shop" |
           x == "Shop & Service" |
           x == "Video Store" |
           x == "Motorcycle Shop" |
           x == "Market" |
           x == "Drugstore / Pharmacy"){          
    return("Shopping")                          #8    
    
  }else{
    return("Food & Beverage")                   #9
  }         
}
  
raw.df$VenueCategoryBucket = sapply(raw.df$VenueCategoryName_Foursquare, TransformRaw.df)


#Split the column, "UTC_Time" into new columns: "DayofWeek", "WeekdayOrWeekend", "Month","Year","MilitaryTime"

##Split "UTC_Time" into "Split"

raw.df$Split = strsplit(raw.df$UTC_time, split = " ")

###"DayofWeek" Column 

DofWk = function(x){
  if(any(x == "Mon")){
    return("Monday")
    
  }else if(any(x == "Tue")){
    return("Tuesday")
    
  }else if(any(x == "Wed")){
    return("Wednesday")
    
  }else if(any(x == "Thu")){
    return("Thursday")
    
  }else if(any(x == "Fri")){
    return("Friday")
    
  }else if(any(x == "Sat")){
    return("Saturday")
    
  }else{
    return("Sunday")
  } 
}

raw.df$DayofWeek = sapply(raw.df$Split, DofWk)

###"Month" Column

Mth = function(x){
  
  if(any(x == "Apr")){
    return("April")
    
  }else if(any(x == "Jun")){
    return("June")
    
  }else if(any(x == "Jul")){
    return("July")
    
  }else if(any(x == "Aug")){
    return("August")
    
  }else if(any(x == "Sep")){
    return("September")
    
  }else if(any(x == "Oct")){
    return("October")
    
  }else if(any(x == "Nov")){
    return("November")
    
  }else if(any(x == "Dec")){
    return("December")
    
  }else if(any(x == "Jan")){
    return("January")
    
  }else{
    return("May")
    
  }
}

raw.df$Month = sapply(raw.df$Split, Mth)

###"Year" column 

Yr = function(x){
  if(any(x == "2012")){
    return("2012")
    
  }else{
    return("2013")
  }
}

raw.df$Year = sapply(raw.df$Split, Yr)


###"Weekend_or_Weekday" Column 

Wk_Wknd = function(x){
  if(any(x == "Sunday" |
         x == "Saturday")){
    return("Weekend")
    
  }else{
    return("Weekday")
  }
}

raw.df$Weekend_or_Weekday = sapply(raw.df$DayofWeek, Wk_Wknd)

###"Time" Column 

Tm = function(x){
  return(x[4])
}

raw.df$Time = sapply(raw.df$Split, Tm)

library(chron)
raw.df$Time = chron(times = raw.df$Time)

#Extract the time in hours and put that in a new column, "Hours"

raw.df$Hours = hours(raw.df$Time)

###Export .csv file.

#Change working directory
setwd("/users/nehachanu/Desktop/NYSDSA Homework/Neha_ShinyProject/")

#Since exporting to .csv is not allowed when there is a list, change class of "Split" to character.

raw.df$Split = as.character(raw.df$Split)

class(raw.df$Split)

write.csv(raw.df, file='my_data.csv', row.names=F)

#Change class of UserID_Anonymized to numeric

#raw.df$UserID_Anonymized = as.numeric(UserID_Anonymized)


# ggplot(raw.df, aes(x=reorder(VenueCategoryBucket, Hours), y=VenueCategoryBucket)) +
#   geom_bar(stat='identity') +
#   coord_flip()

raw.df %>% mutate(NumberRows)

library(googleVis)

#trial = gvisBarChart(raw.df, xvar = "NumberRows", yvar = "VenueCategoryBucket")

new.df = raw.df %>% group_by(VenueCategoryBucket, Weekend_or_Weekday) %>% summarise(count = n())

ggplot(new.df, aes(x = VenueCategoryBucket, y = count, fill = VenueCategoryBucket)) + geom_bar(stat = "identity") + coord_flip()

install.packages('rsconnect')
