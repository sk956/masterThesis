
# CUM0_EMOTIONS GRAPH


# Create another point cloud  for emotion0
 
library(ggplot2)
library(ggpubr)

# brin the csv file 3 different csv files
tableP1 = read.csv("/Users/coolseyun/desktop/masterThesis/emotionCSV/processed/3.9/team4/03_09_2021_vero_4_task+team_round_3.csv_Full_avg_p1.csv")
tableP2 = read.csv("/Users/coolseyun/desktop/masterThesis/emotionCSV/processed/3.9/team4/03_09_2021_vero_4_task+team_round_3.csv_Full_avg_p2.csv")
tableP3  = read.csv("/Users/coolseyun/desktop/masterThesis/emotionCSV/processed/3.9/team4/03_09_2021_vero_4_task+team_round_3.csv_Full_avg_p3.csv")

line <- ggplot() + 
  geom_line(data = tableP1, aes(x = min_upgrade, y = cum0_emotions ), color = 'blue') + 
  geom_line(data = tableP2, aes(x = min_upgrade, y = cum0_emotions ), color = 'red') +
  geom_line(data = tableP3, aes(x = min_upgrade, y = cum0_emotions ), color = 'black') + 
  xlab('minute') + 
  ylab('emotion0')

line <- line + annotate(geom="text", x=20, y= 1000, label="P1-Blue/ P2-Red/ P3-Black",
                        color="Black")



# ㅊcreate a regression model

model <- lm(cum0_emotions ~min_upgrade, data = tableP1)
model2 <- lm(cum0_emotions ~min_upgrade, data = tableP2)
model3 <-  lm(cum0_emotions ~min_upgrade, data = tableP3)

# 3 different graphs linear regression lines
ggp <- ggplot(tableP1, aes(x = min_upgrade, y = cum0_emotions  )) + 
  geom_point() 
ggp <-ggp + stat_smooth(method  = "lm", formula = y~x)

summary(model)
# data from summary model
cof <- summary(model)$coefficients[2,1]

ggp <- ggp + annotate(geom="text", x=20, y= 1000, label=cof,
                      color="red")


gg2 <- ggplot(tableP2, aes(x = min_upgrade, y = cum0_emotions )) + 
  geom_point() 
gg2 <- gg2 + stat_smooth(method  = "lm", formula = y~x)
summary(model2)
cof <- summary(model2)$coefficients[2,1]
gg2 <- gg2 + annotate(geom="text", x=20, y= 1000, label=cof,
                      color="red")

gg3 <- ggplot(tableP3, aes(x = min_upgrade, y = cum0_emotions )) + 
  geom_point() 
gg3 <- gg3+ stat_smooth(method  = "lm", formula = y~x)
summary(model3)
cof <- summary(model3)$coefficients[2,1]
gg3 <- gg3 + annotate(geom="text", x=20, y= 1000, label=cof,
                      color="red")


ggarrange(ggp, gg2, gg3, line , 
          labels = c("P1", "P2", "P3", "All"),
          ncol = 2, nrow = 2)

