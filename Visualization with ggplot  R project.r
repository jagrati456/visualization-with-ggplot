#importing csv file
data=read.csv("Documents/txhousing.csv")
data

#uploading ggplot library
install.packages("ggplot2")
library(ggplot2) 

#structre of dataset
str(data)

#helping for dataset
help("data")

#concatinate the month and year column
data$date1=as.Date((paste(data$month,data$year,"01", sep = "-" )),format = "%m-%Y-%d")
str(data)


#removes NA's
data = na.omit(data)
str(data)

# finding unique dates
unique(data$date1)

#declaring function aggregate
sg= as.data.frame(aggregate(data$sales,by=list(data$date1),function(x)(sum(x))))
sg

#declaring ggplot
p1=ggplot(sg,aes(x=sg$Group.1, y=sg$x))
p1

#ploting line plot
p1+geom_line()

#ploting smooth trend line
p1+geom_line()+geom_smooth()


data$date=as.Date(data$date,origin='2000-01-01')
data$date

p1=ggplot(data,aes(x=date,y=sales))
p1+geom_line(color ='blue')
p1+geom_col(aes(color='red'))


#Histogram
p2=ggplot(data,aes(x=sales))
p2


p2+geom_histogram(stat ='bin',binwidth=30,fill='blue')

p2+geom_histogram(stat='bin',binwidth=30,fill="blue")+xlim(c(0,1000))

#scatterplot
p3=ggplot(data,aes(x=listings,y=sales))+geom_point()
p3


#How these values have desplys as per cities
p3=ggplot(data,aes(x=listings,y=sales))+geom_point(aes(color=city))
p3

#listing of all the cities
p3=ggplot(data[data$city %in% c('Austin','Dallas','Lufkin','Midland','Tyler','Waco'),],aes(x=listings,y=sales))+geom_point(aes(color=city))
p3

#Titling the graph
p3+ggtitle("sales vs listing",subtitle="For 6 Cities only")
p3

#labeling
p3+ggtitle("sales vs listing", subtitle = "For 6 cities only")+xlab("Listings")+ylab("sales")
p3

#scaling

p4=ggplot(data,aes(x=sales,y=volume))+geom_point(aes(color=month))
p4

#I want tomention some name of my continuous scale & i also want to change the color  of my plot
p4+scale_x_continuous(name="sales")


p4+scale_x_continuous(name="sales")+scale_color_continuous(name="months",low="red",high="green")


#we don"t want the cuts to be 3,6,9,12.i want the cuts at every odd number
p4+scale_x_continuous(name="sales")+scale_color_continuous(name="months",low="red",high="green", breaks=c(1,3,5,7,9,11))


