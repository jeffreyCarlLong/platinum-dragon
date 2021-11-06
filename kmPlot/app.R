library(tidyverse)
library(survival)
library(survminer)
library(shiny)
library(dplyr)
# install.packages("RcppArmadillo")
library(RcppArmadillo)
library(DT)

# # bash script to cut column 6
# cat tdata4.txt | cut -f 2,3,4,5,6 > tdata5.txt  
# # bash script to generate universally unique identifier
# alias uuid="uuidgen | tr -d - | tr -d '\n' | tr '[:upper:]' '[:lower:]'  | pbcopy && pbpaste && echo"
# for ((i=1; i<=107; i++))
# do
# uuid
# done


tdata <- read_tsv("tdata5.txt")
studychoices=unique(tdata$Study)
groupchoices=unique(tdata$Group)


ui <- fluidPage(
  titlePanel(title="Patient Survival by Biomarker Subgroup"),
  headerPanel(h3("Created November 2021",
              br(),
              h4("by Jeffrey Long"),
              h4("Bioinformatics Scientist"))),
  mainPanel(
    
    # Output: Tabset w/ data table and KM plot ----
    tabsetPanel(type = "tabs",
                tabPanel("Kaplan-Meier", 
                         selectInput(inputId = "studyselector",label="Select a Clinical Study:", choices=studychoices),
                         selectInput(inputId = "groupselector",label="Select a Biomarker Group:", choices=groupchoices),
                         plotOutput("kmplot")
                         ),
                tabPanel("Data Table", DT::dataTableOutput("datatable")),
                tabPanel("Summary", verbatimTextOutput("summary"))
    ),
    # Footer
    hr(),
    h5("This app contains randomly generated data and is for demonstration purposes only.")
  )
)

# Define server logic
server <- function(input, output) {
  
  filter=reactive({
    filteredData=tdata[tdata$Study==input$studyselector,]
    filteredData['Group'] = ifelse(filteredData$Group==input$groupselector,
                                   input$groupselector,
                                   "Others")
    return(filteredData)
  })
  
  output$datatable <- DT::renderDataTable({
    DT::datatable(tdata, options = list(orderClasses = TRUE))
  })
  

  output$summary <- renderPrint({
    summary(tdata)
  })
  
  output$kmplot=renderPlot({
    fit=survfit(Surv(Time,Censored)~Group,data=filter())
    ggsurvplot(fit,data=filter(),pval=TRUE,xlim=c(0,max(filter()$Time)+1),
               title=paste("Study",input$studyselector, "Kaplan Meier Curve for Biomarker Group",input$groupselector),
               xlab="Time (Months)",
               ggtheme=theme(plot.title=element_text(hjust=0.5)))
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
