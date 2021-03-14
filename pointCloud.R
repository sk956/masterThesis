# Create another point cloud 

library(ggplot2) 

# brin the csv file 3 different csv files
tableP1 = read.csv("/Users/rentaluser/Desktop/masterThesis/emotionCSV/processed/testing/p1.csv")
tableP2 = read.csv("/Users/rentaluser/Desktop/masterThesis/emotionCSV/processed/testing/p2.csv")
tableP3  = read.csv("/Users/rentaluser/Desktop/masterThesis/emotionCSV/processed/testing/p3.csv")


# look at the videos that go bad 
ggplot() + 
  geom_line(data = tableP1, aes(x = min_timestamp, y = emotions ), color = 'red') + 
  geom_line(data = tableP2, aes(x = min_timestamp, y = emotions ), color = 'blue') +
  geom_line(data = tableP3, aes(x = min_timestamp, y = emotions ), color = 'black') + 
  xlab('minute') + 
  ylab('emotion')
