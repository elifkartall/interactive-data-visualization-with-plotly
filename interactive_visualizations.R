data <- Amazon_top100_bestselling_books_2009to2021
is.na(data)
data <- na.omit(data)
library(plotly)
library(ggplot2)
library(tidyverse)  

#creating histograms
data %>%
  plot_ly(x=~genre) %>%
  add_histogram(color= I("pink"))
##adjusting the bin size
data %>%
  plot_ly(x=~genre) %>%
  add_histogram(color= I("green"), xbins = list(start = 0.8 , end = 5, size = 1))


##scatterplot 
data %>%
  plot_ly(x=~price, y=~ratings) %>%
  add_markers()
###setting the shape of graph and hoverinfo
data %>%
  plot_ly(x=~price, y=~ratings, hoverinfo = "text", 
          text = ~paste("Price:", price , "<br>", "Ratings:", ratings)) %>%
  add_markers(marker=list(symbol="circle-open" , color = "red", opacity=0.2))

##adding a third variable
data %>%
  plot_ly(x=~price, y=~ratings, color = ~genre, hoverinfo = "text", 
          text = ~paste("Price:", price , "<br>", "Ratings:", ratings)) %>%
  add_markers(marker=list(symbol="diamond", size=8), colors = "Dark2")

##stacked bar chart
data %>%
  count(genre, ratings) %>%
   plot_ly(x=~genre, y=~n , color=~ratings) %>%
   add_bars() %>%
   layout(barmode=("stack"))

##boxplot
data %>%
  plot_ly(x=~genre, y=~ratings) %>%
  add_boxplot(color = c("pink"))

###adding a smoother
m <- loess(ratings~price, data = data , span = 1.5)
data %>%
  plot_ly(x=~price , y=~ratings) %>%
  add_markers() %>%
  add_lines(y = fitted(m)) %>%
  layout(showlegend = FALSE)
