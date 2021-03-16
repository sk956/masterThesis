# Create another point cloud 

library(ggplot2) 

# brin the csv file 3 different csv files
tableP1 = read.csv("/Users/rentaluser/desktop/masterThesis/emotionCSV/processed/pilot_study/pilotteam1r2_Full_p1.csv")
tableP2 = read.csv("/Users/rentaluser/desktop/masterThesis/emotionCSV/processed/pilot_study/pilotteam1r2_Full_p2.csv")
tableP3  = read.csv("/Users/rentaluser/desktop/masterThesis/emotionCSV/processed/pilot_study/pilotteam1r2_Full_p3.csv")


# look at the videos that go bad 

line <- ggplot() + 
  geom_line(data = tableP1, aes(x = min_upgrade, y = cum_emotions ), color = 'blue') + 
  geom_line(data = tableP2, aes(x = min_upgrade, y = cum_emotions ), color = 'red') +
  geom_line(data = tableP3, aes(x = min_upgrade, y = cum_emotions ), color = 'black') + 
  xlab('minute') + 
  ylab('emotion')

line + stat_smooth(method  = "lm", formula = y~x)

# create a regression line by usingthe points for each color 

model <- lm(cum_emotions ~min_upgrade, data = tableP1)
model2 <- lm(cum_emotions ~min_upgrade, data = tableP2)
model3 <-  lm(cum_emotions ~min_upgrade, data = tableP3)

ggp <- ggplot(tableP1, aes(x = min_upgrade, y = cum_emotions, color = 'red'  )) + 
  geom_point() 
ggp + stat_smooth(method  = "lm", formula = y~x)

gg2 <- ggplot(tableP2, aes(x = min_upgrade, y = cum_emotions, color = 'blue'  )) + 
  geom_point() 
gg2 + stat_smooth(method  = "lm", formula = y~x)



summary(model)
summary(model2)
summary(model3)
