library(tidyverse)
library(survival)
library(survminer)
library(shiny)
library(dplyr)
# install.packages("RcppArmadillo")
library(RcppArmadillo)

tdata <- read_tsv("tdata.txt")
studychoices=unique(tdata$Study)
groupchoices=unique(tdata$Group)


ui <- fluidPage(
  
  
  titlePanel("Survival Data"),
  selectInput(inputId = "studyselector",label="Select a Study:", choices=studychoices),
  selectInput(inputId = "groupselector",label="Select a Group:", choices=groupchoices),
  plotOutput("p1")
  
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
  
  output$p1=renderPlot({
    fit=survfit(Surv(Time,Censored)~Group,data=filter())
    ggsurvplot(fit,data=filter(),pval=TRUE,xlim=c(0,max(filter()$Time)+1),
               title=paste("Study",input$studyselector, "Survival Plot for Group",input$groupselector),
               xlab="Time (Days)",
               ggtheme=theme(plot.title=element_text(hjust=0.5)))
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
