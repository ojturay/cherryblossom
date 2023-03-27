library(ggplot2)
library(readxl)
library(ggpubr)
library(lubridate)
library(jpeg)

## uploading data file 
cherry <- read_excel( path = '......//Downloads//cherryblossom.xlsx',
                      col_names = TRUE,
                      col_types = c('numeric', 'numeric', 'numeric','numeric','numeric','text' ))
cherry <- cherry[!is.na(cherry$`Full-flowering date (DOY)`),]
colnames(cherry)[1:2] <- c('year', 'day')

##updating the date format to a readable and more understandable format
y.dates <- parse_date_time(c('3-20', '4-1', '4-10', '4-20', '5-1', '5-10'), orders='md')
y.ticks <- day(y.dates)
y.lab <- paste(month(x=y.dates, label =T), day(y.dates))

#adding a background picture of the cherryblossom tree
pic <- readJPEG('.......//Downloads//IMG.jpg')
plot(1:2, type = 'n')
rasterImage(pic, 1, 1, 2, 2)


#graph of when the cherry blossom tree begins to flower
ggplot( data= cherry, aes(x= year, y = day)) +
  theme_economist() +
  theme(panel.grid = element_blank(),
        axis.text  = element_text(size = 12),
        axis.title = element_text(size = 15)) +
  background_image(raster.img = pic)+
  geom_line() +
  geom_smooth(color = 'black') +
  scale_x_continuous(name = 'Year', breaks =c(812,1000,1250,1500,1750,2000), 
                     expand = c(0.01,0))+
  scale_y_continuous(name = element_blank(), labels = y.lab) 
  