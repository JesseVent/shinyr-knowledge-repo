# Option 3

However there are cases when the data scientist becomes more demanding
and specific. Five alternatives available to such a data scientist are
listed below. All of these options are available as `geom`s or packaged
functions in the `ggplot2` based `ggTimeSeries` package.

Before that, setting a minimal theme -

```r
minimalTheme = theme_set(theme_bw(12))
minimalTheme = theme_update(
axis.ticks = element_blank(),
legend.position = 'none',
strip.background = element_blank(),
panel.border = element_blank(),
panel.background = element_blank(),
panel.grid = element_blank()
)
```
