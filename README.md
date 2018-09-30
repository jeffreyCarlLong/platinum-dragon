
# R Shiny Tutorial

[RStudio Tutorial](https://shiny.rstudio.com/tutorial/)

[Tutorial slides](https://ucsb-bren.github.io/env-info/wk08_shiny/shiny_lec.pdf)

Every Shiny app is maintained by a computer running R.

User interface (UI), server instructions are two required components.

## Minimal Shiny App

The minimal code for a Shiny app. 

```{r shinyTemplate, eval = FALSE}
library(shiny)
ui <- fluidPage("My Shiny App")

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
```

## Three Function Composition

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
ui <- fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(                                   # Add side panel for inputs
    sidebarPanel(
                                                   # *Input() functions
      sliderInput(inputId = "num",
                  label = "Choose a number",
                  value = 25, min = 1, max = 100)
    )
  )
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
```

### Shiny Output Functions

To display reactive results, add to fluidPage() with an *Output() function. 

<img src="outputFunctions.png" width="400"/>

```{r shinyTemplate4, eval = FALSE}
library(shiny)
ui <- fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(                                   # Add side panel for inputs
    sidebarPanel(
                                                   # *Input() functions
      sliderInput(inputId = "num",
                  label = "Choose a number",
                  value = 25, min = 1, max = 100)
    ),
    mainPanel(
                                                   # *Output() functions
      plotOutput(outputId = "hist")                # Adds an output space 
                                                   # in ui for R object.
                                                   # Build object
                                                   # in server func.
    )
  )
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
```

### Server Functions

Telling the server how to assemble inputs and outputs. 
Rules to writing server functions:

* Save objects to display to output$ 
  * output$foo is referenced in plotOutput("foo")
* Build objects to display with render*()
* Access input values with input$

<img src="renderFunctions.png" width="400"/>

#### Shiny App Template

```{r shinyTemplate5, eval = FALSE}
library(shiny)
ui <- fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(                                   # Add side panel for inputs
    sidebarPanel(
                                                   # *Input() functions
      sliderInput(inputId = "num",
                  label = "Choose a number",
                  value = 25, min = 1, max = 100)
    ),
    mainPanel(
                                                   # *Output() functions
      plotOutput(outputId = "hist")                # Adds an output space 
                                                   # in ui for R object.
                                                   # Build object
                                                   # in server func.
    )
  )
)

server <- function(input, output) { 
  output$hist <- renderPlot({                  # Can add R scripts and code between render {}
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


### Deploy shinyapps.io

[http://shiny.rstudio.com/articles/shinyapps.html](http://shiny.rstudio.com/articles/shinyapps.html)

```{r eval=FALSE}
# Install rsconnect package
if (!require("devtools"))
  install.packages("devtools")
devtools::install_github("rstudio/rsconnect")

# Set up your shinyapps.io account to recognize your computer
rsconnect::setAccountInfo(name='jefflong',
			  token='57EB65311F1075B42840A7E9AF80368B',
			  secret='<secret>')

# When ready to deploy app, point rsconnect to the app dir
library(rsconnect)
rsconnect::deployApp('/Users/jeffreylong/R/shiny/tutorialApp/shinyTutorial')
```

[https://jefflong.shinyapps.io/shinytutorial/](https://jefflong.shinyapps.io/shinytutorial/)



### Reactivity

Build reactive output to display in UI with render*(). E.g.
```{r eval=FALSE}
renderPlot(   { hist(rnorm(input$numNum)) })
```

When notified that it is invalid, the object created by 
a render*() function will rerun the entire block of code associated with it.


```{r shinyTemplate7, eval = FALSE}
library(shiny)

ui <- fluidPage(
  titlePanel("Jeff Long's Reactive Shiny App"),
  sidebarLayout(                                   # Add side panel for inputs
    sidebarPanel(
                                                   # *Input() functions
      sliderInput(inputId = "numNum",              # Input value of Slider
                  label = "Choose a number",
                  value = 25, min = 1, max = 100)
    ),
    mainPanel(                                     # *Output() functions
      verbatimTextOutput(outputId = "stats"),
      plotOutput(outputId = "hist")                # Adds an output space 
                                                   # in ui for R object.
                                                   # Build object
                                                   # in server func.
    )
  )
)

server <- function(input, output) { 
  data <- reactive({                           # To sync data across multiple
                                               # outputs. data is a function and
                                               # must be referred to as data()
    rnorm(input$numNum)
  })
  output$stats <- renderPrint({
    summary(data())
  })
  output$hist <- renderPlot({                  # Reactive function handles reactive
                                               # value from *Input() function.
                                               # Can add R scripts and 
                                               # code between render {}
    title <- paste(input$numNum, " Random Normal Values")
    hist(data(), main = title)                 # Code that builds obj.
                                               # input$num from sliderInput 
                                               # in UI, num-num, :)
                                               # num-num causes automatic reativity!
  })                                           # Save object to output$
                                               # Referenced in plotOutput("")
}

shinyApp(ui = ui, server = server)
```
