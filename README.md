
# R Shiny Tutorial

[RStudio Tutorial](https://shiny.rstudio.com/tutorial/)

[Tutorial slides](https://ucsb-bren.github.io/env-info/wk08_shiny/shiny_lec.pdf)

Every Shiny app is maintained by a computer running R.

User interface (UI), server instructions are two required components.

## Shiny App Template

The minimal code for a Shiny app. 

```{r shinyTemplate, eval = FALSE}
library(shiny)
ui <- fluidPage("My Shiny App")

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
```

Three types of functions: input, output and server.

```{r shinyTemplate2, eval = FALSE}
library(shiny)
ui <- fluidPage("My Shiny App"
  # *Input() functions
  # *Output() functions
)

server <- function(input, output) {
  # server functions
}

shinyApp(ui = ui, server = server)
```

### Shiny Input Functions

Add elements to your app as arguments to fluidPage().

<img src="inputFunctions.png" width="650"/>

```{r shinyTemplate3, eval = FALSE}
library(shiny)
ui <- fluidPage("My Shiny App"
  # *Input() functions
  sliderInput(inputId = "num",
              label = "Choose a number",
              value = 25, min = 1, max = 100)
  # *Output() functions
  )

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
```

### Shiny Output Functions

To display reactive results, add to fluidPage() with an *Output() function. 

<img src="outputFunctions.png" width="400"/>

```{r shinyTemplate4, eval = FALSE}
library(shiny)
ui <- fluidPage("My Shiny App"
  # *Input() functions
  sliderInput(inputId = "num",
              label = "Choose a number",
              value = 25, min = 1, max = 100), # Add commas 
                                               # between
                                               # arguments
  # *Output() functions
  plotOutput("hist")                           # Adds a space 
                                               # in ui for R object.
                                               # Build object
                                               # in server func.
  )

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
```

### Server Functions

Rules to writing server functions:

* Save objects to display to output$ 
  * output$foo is referenced in plotOutput("foo")
* Build objects to display with render*()
* Access input values with input$

<img src="renderFunctions.png" width="400"/>

```{r shinyTemplate5, eval = FALSE}
library(shiny)
ui <- fluidPage("My Shiny App"
  # *Input() functions
  sliderInput(inputId = "num",
              label = "Choose a number",
              value = 25, min = 1, max = 100), # Add commas 
                                               # between
                                               # arguments
  # *Output() functions
  plotOutput("hist")                           # Adds a space 
                                               # in ui for R object.
                                               # Build object
                                               # in server func.
  )

server <- function(input, output) {
  output$hist <- renderPlot({
    title <- "100 Random Normal Values"
    hist(rnorm(input$num), main = title)       # Code that builds obj.
                                               # input$num from sliderInput in UI, num-num, :)
                                               # num-num causes automatic reativity!
  })                                           # Save object to output$
                                               # Referenced in plotOutput("")
    
    
}

shinyApp(ui = ui, server = server)
```

### How To Save Your App

One directory with every file the app needs:

* app.R (your script which ends with a call to shinyApp())
* datasets, images, css, helper scripts, etc.
Note- you must use exact name, app.R.

