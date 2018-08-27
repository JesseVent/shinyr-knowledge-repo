# Option 4 !2.5 Testing Overly Long Invalid Font@#@#$523424

Available as `stat_calendar_heatmap` and `ggplot_calendar_heatmap`.

A calendar heatmap is a great way to visualise daily data. Its structure
makes it easy to detect weekly, monthly, or seasonal patterns.

```r
# creating some data
set.seed(1)
dtData = data.table(
  DateCol = seq(
    as.Date("1/01/2014", "%d/%m/%Y"),
    as.Date("31/12/2015", "%d/%m/%Y"),
    "days"
  ),
  ValueCol = runif(730)
)
dtData[, ValueCol := ValueCol + (strftime(DateCol,"%u") %in% c(6,7) * runif(1) * 0.75), .I]
dtData[, ValueCol := ValueCol + (abs(as.numeric(strftime(DateCol,"%m")) - 6.5)) * runif(1) * 0.75, .I]

# base plot
p1 = ggplot_calendar_heatmap(
  dtData,
  'DateCol',
  'ValueCol'
)

# adding some formatting
p1 +
  xlab(NULL) +
  ylab(NULL) +
  scale_fill_continuous(low = 'green', high = 'red') +
  facet_wrap(~Year, ncol = 1)
```

![Calendar
  Heatmap](https://github.com/JesseVent/ggTimeSeries/blob/581fa14a6bbf71dd1c30190244ffdce9646900e1/README_files/figure-markdown_strict/calendar_heatmap-1.png?raw=true)

```r
# creating some categorical data
dtData[, CategCol := letters[1 + round(ValueCol * 7)]]

# base plot
p2 = ggplot_calendar_heatmap(
  dtData,
  'DateCol',
  'CategCol'
)

# adding some formatting
p2 +
  xlab(NULL) +
  ylab(NULL) +
  facet_wrap(~Year, ncol = 1)
```

![Calendar Heatmap
  2](https://github.com/JesseVent/ggTimeSeries/blob/581fa14a6bbf71dd1c30190244ffdce9646900e1/README_files/figure-markdown_strict/calendar_heatmap-2.png?raw=true)
