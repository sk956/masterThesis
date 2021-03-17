# Create another point cloud 

library(ggplot2) 

# brin the csv file 3 different csv files
tableP1 = read.csv("/Users/rentaluser/desktop/masterThesis/emotionCSV/processed/pilot_study/pilotTeam1r2/pilotteam1r2_Full_p1.csv")
tableP2 = read.csv("/Users/rentaluser/desktop/masterThesis/emotionCSV/processed/pilot_study/pilotTeam1r2/pilotteam1r2_Full_p2.csv")
tableP3  = read.csv("/Users/rentaluser/desktop/masterThesis/emotionCSV/processed/pilot_study/pilotTeam1r2/pilotteam1r2_Full_p3.csv")


# look at the videos that go bad 

line <- ggplot() + 
  geom_line(data = tableP1, aes(x = min_upgrade, y = cum_emotions ), color = 'blue') + 
  geom_line(data = tableP2, aes(x = min_upgrade, y = cum_emotions ), color = 'red') +
  geom_line(data = tableP3, aes(x = min_upgrade, y = cum_emotions ), color = 'black') + 
  xlab('minute') + 
  ylab('emotion')

line + annotate(geom="text", x=20, y= 1000, label="P1-Blue/ P2-Red/ P3-Black",
               color="Black")



# create a regression line by usingthe points for each color 

model <- lm(cum_emotions ~min_upgrade, data = tableP1)
model2 <- lm(cum_emotions ~min_upgrade, data = tableP2)
model3 <-  lm(cum_emotions ~min_upgrade, data = tableP3)

# 3 different graphs linear regression lines
ggp <- ggplot(tableP1, aes(x = min_upgrade, y = cum_emotions  )) + 
  geom_point() 
ggp <-ggp + stat_smooth(method  = "lm", formula = y~x)

summary(model)
ggp + annotate(geom="text", x=20, y= 1000, label="P1, 198.4354 ",
             color="red")


gg2 <- ggplot(tableP2, aes(x = min_upgrade, y = cum_emotions )) + 
  geom_point() 
gg2 <- gg2 + stat_smooth(method  = "lm", formula = y~x)
summary(model2)
gg2 + annotate(geom="text", x=20, y= 1000, label="P2,  232.697 ",
               color="red")

gg3 <- ggplot(tableP3, aes(x = min_upgrade, y = cum_emotions )) + 
  geom_point() 
gg3 <- gg3+ stat_smooth(method  = "lm", formula = y~x)
summary(model3)
gg3 + annotate(geom="text", x=20, y= 1000, label="P3, 152.590  ",
               color="red")

