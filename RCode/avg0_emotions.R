
library(ggplot2)
library(ggpubr)

# brin the csv file 3 different csv files
tableP1avg = read.csv("/Users/coolseyun/desktop/masterThesis/emotionCSV/processed/3.9/team4/03_09_2021_vero_4_task+team_round_3.csv_Full_avg_p1.csv")

line <- ggplot() + 
  geom_line(data = tableP1avg, aes(x = min_upgrade, y = average_e0), color = 'blue') +
  xlab('minute') + 
  ylab('average0_emotion')

line <- line + annotate(geom="text", x=20, y= 1000, label="3.6team7r3_avg",
                        color="Black")

# also get the coeffiecinet of the graphs 


line

# linear line get 

model <- lm(average_e0 ~min_upgrade, data = tableP1avg)


line2 <- ggplot(tableP1avg, aes(x = min_upgrade, y = average_e0)) + 
  geom_point() 
line2 <-line2 + stat_smooth(method  = "lm", formula = y~x)
summary(model)
cof <- summary(model)$coefficients[2,1]
line2 <- line2 + annotate(geom="text", x=20, y= 1000, label= cof,
                          color="red")

line2