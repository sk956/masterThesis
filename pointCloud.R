# Create another point cloud 

library(ggplot2) 

# brin the csv file 3 different csv files
tableP1 = read.csv("/Users/rentaluser/desktop/masterThesis/emotionCSV/processed/pilot_study/pilotteam1r2_p1.csv")
tableP2 = read.csv("/Users/rentaluser/desktop/masterThesis/emotionCSV/processed/pilot_study/pilotteam1r2_p2.csv")
tableP3  = read.csv("/Users/rentaluser/desktop/masterThesis/emotionCSV/processed/pilot_study/pilotteam1r2_p3.csv")


# look at the videos that go bad 
ggplot() + 
  geom_line(data = tableP1, aes(x = min_upgrade, y = emotions ), color = 'blue') + 
  geom_line(data = tableP2, aes(x = min_upgrade, y = emotions ), color = 'red') +
  geom_line(data = tableP3, aes(x = min_upgrade, y = emotions ), color = 'black') + 
  xlab('minute') + 
  ylab('emotion')

