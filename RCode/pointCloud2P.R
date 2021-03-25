
# Create another point cloud for emotion

library(ggplot2)
library(ggpubr)

# brin the csv file 3 different csv files
tableP1 = read.csv("/Users/coolseyun/desktop/masterThesis/emotionCSV/processed/3.6/03_06_2021AM_vero_7_team_round_3.csv_Full_avg_p1.csv")
tableP2 = read.csv("/Users/coolseyun/desktop/masterThesis/emotionCSV/processed/3.6/03_06_2021AM_vero_7_team_round_3.csv_Full_avg_p2.csv")


# look at the videos that go bad 

#attach(mtcars)
#par(mfrow=c(2,2))

line <- ggplot() + 
  geom_line(data = tableP1, aes(x = min_upgrade, y = cum_emotions ), color = 'blue') + 
  geom_line(data = tableP2, aes(x = min_upgrade, y = cum_emotions ), color = 'red') +
  xlab('minute') + 
  ylab('emotion')

line <- line + annotate(geom="text", x=20, y= 1000, label="P1-Blue/ P2-Red",
                        color="Black")



# ㅊcreate a regression model

model <- lm(cum_emotions ~min_upgrade, data = tableP1)
model2 <- lm(cum_emotions ~min_upgrade, data = tableP2)

# 3 different graphs linear regression lines
ggp <- ggplot(tableP1, aes(x = min_upgrade, y = cum_emotions  )) + 
  geom_point() 
ggp <-ggp + stat_smooth(method  = "lm", formula = y~x)

summary(model)
# data from summary model
cof <- summary(model)$coefficients[2,1]

ggp <- ggp + annotate(geom="text", x=20, y= 1000, label=cof,
                      color="red")


gg2 <- ggplot(tableP2, aes(x = min_upgrade, y = cum_emotions )) + 
  geom_point() 
gg2 <- gg2 + stat_smooth(method  = "lm", formula = y~x)
summary(model2)
cof <- summary(model2)$coefficients[2,1]
gg2 <- gg2 + annotate(geom="text", x=20, y= 1000, label=cof,
                      color="red")




ggarrange(ggp, gg2, line , 
          labels = c("P1", "P2", "All"),
          ncol = 2, nrow = 2)




