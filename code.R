library(readxl)
> activity <- read_excel("activity.csv")
Error: Can't establish that the input is either xls or xlsx.
> View(activity)
Error in View : object 'activity' not found
> library(readr)
> activity <- read_csv("activity.csv")
Parsed with column specification:
cols(
  steps = col_double(),
  date = col_date(format = ""),
  interval = col_double()
)
> View(activity)
> Total_Steps <- activity[, c(lapply(.SD, sum, na.rm = FALSE)), .SDcols = c("steps"), by = .(date)] 
Error in `[.tbl_df`(activity, , c(lapply(.SD, sum, na.rm = FALSE)), .SDcols = c("steps"),  : 
  unused arguments (.SDcols = c("steps"), by = .(date))
> Total_Steps <- activity[, c(lapply(.SD, sum, na.rm = TRUE)), .SDcols = c("steps"), by = .(date)]
Error in `[.tbl_df`(activity, , c(lapply(.SD, sum, na.rm = TRUE)), .SDcols = c("steps"),  : 
  unused arguments (.SDcols = c("steps"), by = .(date))
> head(activity)
# A tibble: 6 x 3
  steps date       interval
  <dbl> <date>        <dbl>
1    NA 2012-10-01        0
2    NA 2012-10-01        5
3    NA 2012-10-01       10
4    NA 2012-10-01       15
5    NA 2012-10-01       20
6    NA 2012-10-01       25
> setDT(activity)
> Total_Steps <- activity[, c(lapply(.SD, sum, na.rm = TRUE)), .SDcols = c("steps"), by = .(date)]
> head(Total_Steps, 10)
          date steps
 1: 2012-10-01     0
 2: 2012-10-02   126
 3: 2012-10-03 11352
 4: 2012-10-04 12116
 5: 2012-10-05 13294
 6: 2012-10-06 15420
 7: 2012-10-07 11015
 8: 2012-10-08     0
 9: 2012-10-09 12811
10: 2012-10-10  9900
> tail(Total_Steps,20)
          date steps
 1: 2012-11-11 12608
 2: 2012-11-12 10765
 3: 2012-11-13  7336
 4: 2012-11-14     0
 5: 2012-11-15    41
 6: 2012-11-16  5441
 7: 2012-11-17 14339
 8: 2012-11-18 15110
 9: 2012-11-19  8841
10: 2012-11-20  4472
11: 2012-11-21 12787
12: 2012-11-22 20427
13: 2012-11-23 21194
14: 2012-11-24 14478
15: 2012-11-25 11834
16: 2012-11-26 11162
17: 2012-11-27 13646
18: 2012-11-28 10183
19: 2012-11-29  7047
20: 2012-11-30     0
> library(ggplot2)
> 
> png("hist1.png", width=480, height=480)
> 
> ggplot(Total_Steps, aes(x = steps)) +
+     geom_histogram(fill = "blue", binwidth = 1000) +
+     labs(title = "Daily Steps", x = "Steps", y = "Frequency")
> 
> dev.off()
null device 
          1 
> Total_Steps[, .(Mean_Steps = mean(steps), Median_Steps = median(steps))]
   Mean_Steps Median_Steps
1:    9354.23        10395
> IntervalDT <- activityDT[, c(lapply(.SD, mean, na.rm = TRUE)), .SDcols = c("steps"), by = .(interval)] 
Error: object 'activityDT' not found
> 
> ggplot(IntervalDT, aes(x = interval , y = steps)) +
+     geom_line(color="blue", size=1) +
+     labs(title = "Avg. Daily Steps", x = "Interval", y = "Avg. Steps per day")
Error in ggplot(IntervalDT, aes(x = interval, y = steps)) : 
  object 'IntervalDT' not found
> IntervalDT <- activity[, c(lapply(.SD, mean, na.rm = TRUE)), .SDcols = c("steps"), by = .(interval)] 
> 
> ggplot(IntervalDT, aes(x = interval , y = steps)) +
+     geom_line(color="blue", size=1) +
+     labs(title = "Avg. Daily Steps", x = "Interval", y = "Avg. Steps per day")
> IntervalDT[steps == max(steps), .(max_interval = interval)]
   max_interval
1:          835
> activity[is.na(steps), .N ]
[1] 2304
> 
> 
> nrow(activity[is.na(steps),])
[1] 2304
> activity[is.na(steps), "steps"] <- round(activity[, c(lapply(.SD, mean, na.rm = TRUE)), .SDcols = c("steps")])
> data.table::fwrite(x = activity, file = "data/tidyData.csv", quote = FALSE)
Error in data.table::fwrite(x = activity, file = "data/tidyData.csv",  : 
  No such file or directory: 'data/tidyData.csv'. Unable to create new file for writing (it does not exist already). Do you have permission to write here, is there space on the disk and does the path exist?
> imp <- activity # new dataset called imp
> for (i in avg_step$interval) {
+     imp[imp$interval == i & is.na(imp$steps), ]$steps <- 
+         avg_step$steps[avg_step$interval == i]
+ }
Error in avg_step : object 'avg_step' not found
> head(imp)
   steps       date interval
1:    37 2012-10-01        0
2:    37 2012-10-01        5
3:    37 2012-10-01       10
4:    37 2012-10-01       15
5:    37 2012-10-01       20
6:    37 2012-10-01       25
> Total_Steps <- activityDT[, c(lapply(.SD, sum, na.rm = TRUE)), .SDcols = c("steps"), by = .(date)] 
Error: object 'activityDT' not found
> Total_Steps <- activity[, c(lapply(.SD, sum, na.rm = TRUE)), .SDcols = c("steps"), by = .(date)] 
> Total_Steps[, .(Mean_Steps = mean(steps), Median_Steps = median(steps))]
   Mean_Steps Median_Steps
1:   10751.74        10656
> library(ggplot2)
> ggplot(Total_Steps, aes(x = steps)) +
+     geom_histogram(fill = "blue", binwidth = 1000) +
+     labs(title = "Daily Steps", x = "Steps", y = "Frequency")
> activity[, dateTime := as.POSIXct(date, format = "%Y-%m-%d")]
> activity[, `Day of Week`:= weekdays(x = dateTime)]
> 
> activity[grepl(pattern = "Monday|Tuesday|Wednesday|Thursday|Friday", x = `Day of Week`), "weekday or weekend"] <- "weekday"
> activity[grepl(pattern = "Saturday|Sunday", x = `Day of Week`), "weekday or weekend"] <- "weekend"
> activity[, `weekday or weekend` := as.factor(`weekday or weekend`)]
> ggplot(Interval , aes(x = interval , y = steps, color=`weekday or weekend`)) + geom_line() + labs(title = "Avg. Daily Steps by Weektype", x = "Interval", y = "No. of Steps") + facet_wrap(~`weekday or weekend` , ncol = 1, nrow=2)
Error in ggplot(Interval, aes(x = interval, y = steps, color = `weekday or weekend`)) : 
  object 'Interval' not found
> activity[is.na(steps), "steps"] <- activity[, c(lapply(.SD, median, na.rm = TRUE)), .SDcols = c("steps")]
> Interval <- activity[, c(lapply(.SD, mean, na.rm = TRUE)), .SDcols = c("steps"), by = .(interval, `weekday or weekend`)] 
> 
> ggplot(Interval , aes(x = interval , y = steps, color=`weekday or weekend`)) + geom_line() + labs(title = "Avg. Daily Steps by Weektype", x = "Interval", y = "No. of Steps") + facet_wrap(~`weekday or weekend` , ncol = 1, nrow=2)