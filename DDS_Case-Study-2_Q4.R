#Question 4.I

TEMP <- read_csv("C:/Users/jkras/Desktop/SMU/DDS/Case Study 2/TEMP.csv")
TEMP_2 <- subset(TEMP, grepl("^.+(19|20)",Date))
TEMP_new <- aggregate(TEMP_2$`Monthly AverageTemp`, by = list(TEMP_2$Country), FUN = min, na.rm = T)
TEMP_new2 <- aggregate(TEMP_2$`Monthly AverageTemp`, by = list(TEMP_2$Country), FUN = max, na.rm = T)
TEMP_min <- subset(TEMP_new, select= x)
colnames(TEMP_min) <- "Minimum"
colnames(TEMP_new2) <- c("Country", "Maximum")
TEMP_Difference <- cbind(TEMP_new2, TEMP_min)
TEMP_Difference$Max_Min_Difference <- (TEMP_Difference$Maximum - TEMP_Difference$Minimum)
TEMP_20Max_Differences <- TEMP_Difference[order(TEMP_Difference$Max_Min_Difference, decreasing = T)[1:20], ]

TEMP_Sorted_Max_Differences <- TEMP_20Max_Differences[order(TEMP_20Max_Differences$Max_Min_Difference), ]
TEMP_Sorted_Max_Differences$Country <- factor(TEMP_Sorted_Max_Differences$Country, levels = TEMP_Sorted_Max_Differences$Country)

library(ggplot2)
ggplot(TEMP_Sorted_Max_Differences, aes(x=Country, y=Max_Min_Difference)) + 
  geom_bar(stat="identity", width=.5, aes(fill = Country)) + 
  labs(title="Ordered Bar Chart", 
       subtitle="Maximum-Minimum Difference in Average Monthly Temperature (C) by Country, since 1900", 
       caption="Case Study 2: Q4, Part I") + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6))

#Question 4.III

CityTemp <- read_csv("C:/Users/jkras/Desktop/SMU/DDS/Case Study 2/CityTemp.csv")
CityTemp_2 <- subset(CityTemp, grepl("^.+(19|20)",Date))
CityTemp_new <- aggregate(CityTemp_2$`Monthly AverageTemp`, by = list(CityTemp_2$City), FUN = min, na.rm = T)
CityTemp_new2 <- aggregate(CityTemp_2$`Monthly AverageTemp`, by = list(CityTemp_2$City), FUN = max, na.rm = T)
CityTemp_min <- subset(CityTemp_new, select= x)
colnames(CityTemp_min) <- "Minimum"
colnames(CityTemp_new2) <- c("City", "Maximum")
CityTemp_Difference <- cbind(CityTemp_new2, CityTemp_min)
CityTemp_Difference$Max_Min_Difference <- (CityTemp_Difference$Maximum - CityTemp_Difference$Minimum)
CityTemp_20Max_Differences <- CityTemp_Difference[order(CityTemp_Difference$Max_Min_Difference, decreasing = T)[1:20], ]

CityTemp_Sorted_Max_Differences <- CityTemp_20Max_Differences[order(CityTemp_20Max_Differences$Max_Min_Difference), ]
CityTemp_Sorted_Max_Differences$City <- factor(CityTemp_Sorted_Max_Differences$City, levels = CityTemp_Sorted_Max_Differences$City)

ggplot(CityTemp_Sorted_Max_Differences, aes(x=City, y=Max_Min_Difference)) + 
  geom_bar(stat="identity", width=.5, aes(fill = City)) + 
  labs(title="Ordered Bar Chart", 
       subtitle="Maximum-Minimum Difference in Average Monthly Temperature (C) by City, since 1900", 
       caption="Case Study 2: Q4, Part III") + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6))

#Question 4.IV

#Since 1900, the ranges of the maximum-minimum average monthly temperature difference by country and by city are roughly comparable.
#Of note is the larger spread in the top twenty cities (~20 degrees compared to ~14 degrees across the top twenty countries).
#Differences across countries are largely attributable to geographic and climatological differences. Arid, semi-arid, and landlocked humid continental regions with charcteristically large diurnal and seasonal fluctuations are especially prevalent on the list.
#Differences across cities are also partially attributable to the environmental impact of human activity in densely populated regions.
#As some of the listed cities are not situated in the list of countries, one can reasonably conclude that the diversity of climate types in countries with larger geographic landmass is also a factor. 

#Question 4.II

US_TEMP <- subset(subset(TEMP, grepl("^.+(199|200|201)",Date)), Country == "United States")
US_TEMP$Fahrenheit <- US_TEMP$`Monthly AverageTemp` * (9/5) + 32

US_TEMP$Date <- as.Date(US_TEMP$Date, "%m/%d/%Y")
US_TEMP$Year <- as.Date(cut(US_TEMP$Date, breaks = "year"))

library(scales)

ggplot(data = US_TEMP, aes(Year, Fahrenheit)) + 
  stat_summary(fun.y = mean, geom = "line", size = 1.5, linetype = "dotted", color = "purple") + 
  scale_x_date(labels = date_format("%Y"), date_breaks = "1 year") +
  labs(title="Time Series Line Chart", 
       subtitle="Average Monthly US Temperature (F), since 1990", 
       caption="Case Study 2: Q4, Part IIb")

US_YR_mean <- aggregate(US_TEMP$Fahrenheit, by = list(US_TEMP$Year), FUN = mean)
colnames(US_YR_mean) <- c("Year", "Yr_Mean_Fahrenheit")
US_YR_Diff <- diff(US_YR_mean$Yr_Mean_Fahrenheit)
US_YR_Difference <- as.numeric(c("NA", US_YR_Diff))
US_Yearly_Mean_Diff <- cbind(US_YR_mean, US_YR_Difference)
colnames(US_Yearly_Mean_Diff)[3] <- "Yearly_Mean_Difference"
US_Yearly_Mean_Diff[which.max(US_Yearly_Mean_Diff$Yearly_Mean_Difference),]



