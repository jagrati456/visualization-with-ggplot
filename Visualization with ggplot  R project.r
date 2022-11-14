#importing csv file
data=read.csv("Documents/txhousing.csv")
data
#In this dataset 8602 rows and 10 columns

#uploading ggplot library
install.packages("ggplot2")
library(ggplot2) 
#1.installing ggplot2 
#2.importing library ggplot2

#structre of dataset
str(data)
#1.we can see that first column is character & other all are either int or number 
#2.But we concentrate on very last column i.e date it is a numeric vector but actually it is a date.hence we have to declare it as a date.

#helping for dataset
help("data")

#concatinate the month and year column
data$date1=as.Date((paste(data$month,data$year,"01", sep = "-" )),format = "%m-%Y-%d")
str(data)
#1.here we concatinate the month and year column and declare it as date1. 
#2.we observe that now there are 11 variables. 
#3.In date format there is no date available that'y I put it as "01".


#removes NA's
data = na.omit(data)
str(data)
#1.My data has some NA's .so i need to delete that NA's but basically we need to impute by mean or median or some thing else but I am not doing this .i directly removing those rows. 
#2.Now the row's are 7126. 
#3.Now I am okay for the analysis of ggplot.

# finding unique dates
unique(data$date1)
#1.We need to find the unique date for the analysis 
#2.There are 187 unique dates.But there are 7126 values are repeated. 
#3.so. we don't want that repetation need only unique dates.

#declaring function aggregate
sg= as.data.frame(aggregate(data$sales,by=list(data$date1),function(x)(sum(x))))
sg
#here,we analyse the sales that will be monthwise or daywise but daywise is not possible because "01" is same.Now what I will do is this dates.i will at the sale value.so we can do that by function aggregate.                            

#declaring ggplot
p1=ggplot(sg,aes(x=sg$Group.1, y=sg$x))
p1
#Now i am declaring here my ggplot          

#ploting line plot
p1+geom_line()
#we observe that the sales from 2000 increases slowly and from 2007 decreases and after 2010 it increases again

#ploting smooth trend line
p1+geom_line()+geom_smooth()
#It shows trend .Around the blue line it shows confidance interval.


data$date=as.Date(data$date,origin='2000-01-01')
data$date
#this txhousing data is year of 2005.
                            
p1=ggplot(data,aes(x=date,y=sales))
p1+geom_line(color ='blue')
p1+geom_col(aes(color='red'))
#this ggplot for date vs sales

#Histogram
p2=ggplot(data,aes(x=sales))
p2


p2+geom_histogram(stat ='bin',binwidth=30,fill='blue')
#The big bars are running initial sie only.we are not interested in the last scale.we want 2500 & 1000 scale only.
                            

p2+geom_histogram(stat='bin',binwidth=30,fill="blue")+xlim(c(0,1000))
#Now the histogram ploted properly
                            
#scatterplot
p3=ggplot(data,aes(x=listings,y=sales))+geom_point()
p3
#In this plot we can see the listing increases and it increases after 1000 than sales alse increases.
                            

#How these values have desplys as per cities
p3=ggplot(data,aes(x=listings,y=sales))+geom_point(aes(color=city))
p3

#listing of all the cities
p3=ggplot(data[data$city %in% c('Austin','Dallas','Lufkin','Midland','Tyler','Waco'),],aes(x=listings,y=sales))+geom_point(aes(color=city))
p3
#Austin & Dallas has very low sales.
                            
                            
#Titling the graph
p3+ggtitle("sales vs listing",subtitle="For 6 Cities only")
p3

#labeling
p3+ggtitle("sales vs listing", subtitle = "For 6 cities only")+xlab("Listings")+ylab("sales")
p3

#scaling

p4=ggplot(data,aes(x=sales,y=volume))+geom_point(aes(color=month))
p4
#1.Aestatic mensions what you want to plot on agraph but it does not mension how it will plot.so scalings comes in handy there. 
#2.All the points arrange in as per the months.we can see the right hand side the legends are available from 1st month it is dark & 12th month it becomes lighter. so this graph is likewise plotted.   
                            

#I want tomention some name of my continuous scale & i also want to change the color  of my plot
p4+scale_x_continuous(name="sales")
#X-axis replace by the sales
                            

p4+scale_x_continuous(name="sales")+scale_color_continuous(name="months",low="red",high="green")
#we can see the difference between the points.

#we don"t want the cuts to be 3,6,9,12.i want the cuts at every odd number
p4+scale_x_continuous(name="sales")+scale_color_continuous(name="months",low="red",high="green", breaks=c(1,3,5,7,9,11))


