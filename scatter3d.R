```{r}
library(datasets)
data(mtcars)
head(mtcars)
```

```{r}
plotly::plot_ly(mtcars, x = ~mpg, y = ~disp, z = ~qsec) %>%
  plotly::add_markers()
```


[https://plot.ly/r/3d-scatter-plots/](https://plot.ly/r/3d-scatter-plots/)

```{r}
library(plotly)

mtcars$am[which(mtcars$am == 0)] <- 'Automatic'
mtcars$am[which(mtcars$am == 1)] <- 'Manual'
mtcars$am <- as.factor(mtcars$am)

p <- plot_ly(mtcars, x = ~wt, y = ~hp, z = ~qsec, color = ~am, colors = c('#BF382A', '#0C4B8E')) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Weight'),
                     yaxis = list(title = 'Gross horsepower'),
                     zaxis = list(title = '1/4 mile time')))

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
chart_link = api_create(p, filename="scatter3d-basic")
chart_link
```
