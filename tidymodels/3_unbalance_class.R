library(tidymodels)  # for the parsnip package, along with the rest of tidymodels

df <- read.csv('data.csv') 

#delete columns only have nas 
df <- df %>% 
  select_if(~ !any(is.na(.))) %>% 
  mutate(diagnosis = factor(diagnosis))

#### we realize the proportion for benign and malignant are slightly imbalanced.
df %>% 
  count(diagnosis) %>% 
  mutate(prop = n/sum(n))

### Why do we care?


# Based on Slide 11
data_split <- initial_split(df, prop = 3/4)

# Create data frames for the two sets:
train_data <- training(data_split)
test_data  <- testing(data_split)

# validation split from train
set.seed(234)
val_set<-validation_split(train_data, prop=4/5)


#this group task here is to implement oversampling to balance the clases. Hint create a new recipe, add a step called "step_rose"

#define the model

#specify which values want to try

#create the work flow

#grid search based on the rf_grid

#select the best model:

#record best parameters into the workflow 


#evaluate on the test set 