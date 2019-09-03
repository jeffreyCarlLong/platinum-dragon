mydata <- read.csv("mydata.csv") 
mydata <- sas.get("data.sas7bdat")
mydata <- read_sas("data.sas7bdat")
mydata <- read.dta("c:/mydata.dta")

str_detect(mydata$linename, "Rituximab")
str_subset(mydata$linename, "Rituximab")
str_trim(mydata$linename) # removes whitespace for variable


# Find top 5 most frequent lines ("linename") for each line of therapy ("linenumber")

library("dplyr")
library("tidyr")
mydata %>%
  group_by(linenumber,linename) %>%
  summarise(n=n()) %>%
  top_n(5) %>%
  arrange(desc(n))

labresults <- mydata %>%
  filter(linenumber<=4) %>%
  left_join(
    mydata.labs %>%
    filter(labcomponent %in% c("Biomarker1", "Biomarker2, "ADA3")) %>%
      select(patientid, practicetype, labcomponent, resultdate, testunitscleaned, testresultcleaned)
    ) %>%
  group_by(patientid, labcomponent, linenumber) %>%
  filter(resultdate>=startdate & resultdate<=enddate) %>%
  filter(resultdate==min(resultdate)) %>%
  ungroup()

labresults_wide <- data.frame(
  labresults %>%
    select(patientid, practicetype, linenumber, labcomponent, testresultcleaned) %>%
    group_by(linenumber) %>%
    mutate(grouped_id = row_number()) %>%
    spread(labcomponent, testresultcleaned) %>%
    group_by(patientid, linenumber) %>%
    summarise_each(funs(max(., na.rm = TRUE)))
)

library(table1)
# summary table with remaining variables and stratify by practice type
table1( ~. | practicetype, data=labresults_wide %>%
  filter(linenumber==1) %>% 
  select(~c(patientid, grouped_id, linenumber))
)

model(Y ~ X1 + X2, data=data)

library("glm", "glmnet")  # linear models
glm()
glmnet()
cv.glmnet()
predict()

library("lme4", "nlme")  # mixed-effect models
lmer()
nlme()
predict()

library("survival")  # survival models
Survfit()
Surv(Time, Event)
predict()

library(srvminer)  # draw survival curves
ggsurvplot()

library(caret)  # machine learning
createDataPartition()
train()
predict()
# Regression, Random forest, Gradient boosting, Support vector machine, Naive Bayes, Neural nets, etc.

# data frame of mortality
# patientid\tduration\tevent01\tlinenumber
# model survival by line of therapy
mydata.os.drug <- survfit(Surv(duration, Event) ~ linenumber, data = refractoryPatients)

ggsurvplot(
  mydata,
  data = refractoryPatients,
  risk.table = TRUE,
  xlab = "Time in days",
  surv.median.line = "v",
  break.time.by = 120,
  title = "Indication Drug-refractory overall survival by line of therapy"
)

# distribution of indication stage (at initial diagnosis) by patient birth year
mydata3 <- indication.demographics[,c("patientid", "stage", "birthyear")]
# plot birth year on x-axis
ggplot(mydata3, aes(birthyear)) + 
  # fill color by indication stage
  geom_bar(aes(fill=stage)) + 
  theme_minimal() + 
  ggtitle("Distribution of indication stage by patient birth year")

library("cowplot")
p1 <- ggplot(mydata3, aes(birthyear)) + 
  # fill color by indication stage
  geom_bar(aes(fill=stage)) + 
  theme_minimal() + 
  ggtitle("Distribution of indication stage by patient birth year")
p2 <- ggplot(mydata3, aes(birthyear)) + 
  # fill color by indication stage
  geom_bar(aes(fill=stage)) + 
  theme_minimal() + 
  ggtitle("Distribution of indication stage by patient birth year")
p3 <- ggplot(mydata3, aes(birthyear)) + 
  # fill color by indication stage
  geom_bar(aes(fill=stage)) + 
  theme_minimal() + 
  ggtitle("Distribution of indication stage by patient birth year")
plot_grid(p1,p2,p3, ncol=1)

# Result presentation with R Markdown and knitr
## Access Data- RocheTeradata, RWDSverse, Hmisc/foreign/haven
## Manipulate, Wrangle Data- dplyr, tidyr, lubridate, stringr, data.table
## Model- glm/glmnet, lme4/nlme, survival, survminer, caret
## Output- knitr, table1, kableExtra, ggplot2, gridExtra, cowplot, plotly

---
title: "Template Report"
author: "Jeffrey Long"
date: "//2019"
output:
  html_document:
    toc: true
---

This is a report on indication, drug, assay.

```{r package_options, include=FALSE}
knitr::opts_chunk$set(echo = FALSE)
```

## Libraries

```{r message=FALSE, warning=FALSE, echo=FALSE}
library(tidyverse)
library(dplyr)
library(table1)
```

## Code

### Get data
```{r echo=FALSE, warning=FALSE}
con <- connect_to_data(datalab = "myData",
  type = 'TYPE',
  uid = "longj25",
  pwd = readLines("~/.ssh/.pass"))
```


### Data wrangling
```{r}
# code here
```

### Results
```{r}
# code here
```
