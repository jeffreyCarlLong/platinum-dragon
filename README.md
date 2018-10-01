
# R Shiny Tutorial Notebook

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

Rules to writing server functions:

* Save objects to display to output$ 
  * output$foo is referenced in plotOutput("foo")
* Build objects to display with render*()
* Access input values with input$

<img src="/Users/jeffreylong/R/shiny/renderFunctions.png" width="400"/>

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



### Deploy to shinyapps.io

[http://shiny.rstudio.com/articles/shinyapps.html](http://shiny.rstudio.com/articles/shinyapps.html)

```{r shinyTemplate6, eval=FALSE}
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
                  value = 25, min = 1, max = 100),
      br(),
      textInput(inputId = "note",
                label = "Note",
                value = "Histogram with statistics"),
      actionButton(inputId = "addButton", 
                   label = "Add Note")
    ),
    mainPanel(                                     # *Output() functions
      verbatimTextOutput(outputId = "stats"),
      verbatimTextOutput(outputId = "note"),
      plotOutput(outputId = "hist")                # Adds an output space 
                                                   # in ui for R object.
                                                   # Build object
                                                   # in server func.
    )
  )
)

server <- function(input, output) { 
  data <- reactive({                           # To sync data across multiple
    rnorm(input$numNum)                        # outputs. data is a function and
  })                                           # must be referred to as data()
  output$stats <- renderPrint({
    summary(data())
  })
  output$note <- renderText({
    input$addButton
    paste0("Note: ", isolate({input$note}))
  })
  output$hist <- renderPlot({                  # Reactive function handles reactive
                                               # value from *Input() function.
    title <- paste(input$numNum,               # Can add R scripts and 
             " Random Normal Values")          # code between render {}

    hist(data(), main = title)                 # Code that builds obj.
                                               # input$num from sliderInput 
                                               # in UI, num-num, :)
                                               # num-num causes automatic reativity!
  })                                           # Save object to output$
}                                              # Referenced in plotOutput("")
shinyApp(ui = ui, server = server)
```



### HTML in R

Use tags() to add static content to your Shiny app.

Make a "www" directory, deposit images, no need to reference dir in call.

```{r htmlR}
names(tags)
fluidPage(
  wellPanel(
  tags$a(href = "https://github.com/jeffreyCarlLong/platinum-dragon/blob/master/README.md", "R Shiny Tutorial Notebook"),
  tags$h3("HTML in R"),
  tags$code("ls -la ~/*"), br(), br(),
  "Text in fluidPage will also print in the Shiny App", br(), br(),
  tags$hr(),
  tags$p("Will split content..."),
  tags$p("into separate paragraphs, with ",
         tags$strong("nested"),
         " tags.")
  )
)
```


Combine tabPanel() with tabsetPanel(), navlistPanel(), or navbarPage().

Add horizonal block of space with fluidRow() and blocks within with column().

The first argument to column() is the width in 12 unit increments. 

Offsets from the right can also be used.
 
```{r htmlR2}
fluidPage(
  tabsetPanel(
    tabPanel("Tab 1",
    tags$img(height = 100, width = 100, src = "https://upload.wikimedia.org/wikipedia/commons/f/f5/Hoffmann-La_Roche_logo.svg"),
    fluidRow(                                  # <div class="row"> In the row</div>
      column(3), 
      column(2),                               # or column(2, plotOutput("hist")),
      column(5)                                # or column(5, sliderInput(...))
    ),
    HTML("<h1>My Roche Shiny App</h1>")
    ),
    fluidRow(
      column(4, offset=8)
    )
  )

)

```

Wrapper functions exist for: a(), br(), code(), 
em(),  h1(), h2(), ..., h(6), 
hr(), img(), p(), strong()

```{r eval= FALSE}
fluidPage(
  navbarPage(
    navbarMenu()
  )
)
```

[http://rstudio.github.io/shinydashboard/](http://rstudio.github.io/shinydashboard/)



### CSS

[https://bootswatch.com/cerulean/](https://bootswatch.com/cerulean/)


```{html css}
<head>
  <link type="text/css" rel="stylesheet" href="bootswatch-cerulean.css"/>
  <style>
    li {
      color:purple;
    }

    .blue-item {
      color:blue;
    }
    
    #dark {
      color:navy;
    }
  </style>
</head>
  
<div class="container-fluid">
  <h1>CSS examples</h1>
  <p>This webpage uses...
  </p>
  <ol>
    <li>Purple line item, </li>
    <li class="blue-item">Blue item, class style over-rides global li style; </li>
    <li id="dark" class="blue-item">Navy item, id over-rides class style; </li>
    <li id="dark" class="blue-item" style="color:green"> Green item, specify</li>
  </ol>
</div>

```

Place .css files in the www folder of your app dir.
To get the CSS to be used by Shiny, try one of the following.

```{r eval=FALSE}
ui <- fluidPage(
  theme = "bootswatch-cerulean.css",
  sidebarLayout(
    sidebarPanel(),
    mainPanel()
  )
)

# OR

ui <- fluidPage(
  tag$head(
    tags$link(
      rel = "stylesheet",
      type = "text/css",
      href = "file.css"
    )
  )
)

# OR

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      p {
        color:red;
      }
    "))
  )
)

# OR

ui <- fluidPage(
  includeCSS("file.css")    # Can be in app dir, not necessarily www
)

# where file.css is
<style>
   p {
     color:red;
   }
 </style>

# OR

ui <- fluidPage(
  tags$h1("Title", style = "color:red;")
)

```

HTML class at Code Academy, 
[http://www.codeacademy.com/tracks/web](http://www.codeacademy.com/tracks/web)

Shiny CSS article, 
[http://shiny.rstudio.com/articles/css.html](http://shiny.rstudio.com/articles/css.html).

jQuery addition in the header, 
[http://shiny.rstudio.com/articles/google-analytics.html](http://shiny.rstudio.com/articles/google-analytics.html).


Stack Overflow Shiny Apps
