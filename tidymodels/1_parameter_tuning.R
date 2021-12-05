library(tidymodels)  # for the parsnip package, along with the rest of tidymodels

df <- read.csv('data.csv') 

#delete columns only have nas 
df <- df %>% 
  select_if(~ !any(is.na(.))) %>% 
  mutate(diagnosis = factor(diagnosis))

# Based on Slide 11
data_split <- initial_split(df, prop = 3/4)

# Create data frames for the two sets:
train_data <- training(data_split)
test_data  <- testing(data_split)

# validation split from train
set.seed(234)
val_set<-validation_split(train_data, prop=4/5)


# create a recipe
class_rec <- 
  recipe(diagnosis~ ., data = train_data) %>%
  #step_string2factor(diagnosis)
  update_role(id, new_role = 'ID')

#define the model
rf_mod <- 
  rand_forest(mtry= tune(),trees = tune(), min_n = tune()) %>% 
  set_engine("ranger") %>% 
  set_mode("classification")

# specify which values want to try
rf_grid <- expand.grid(mtry = c(3, 4, 5), trees = c(5,10,15,20,30,50), min_n = c(5,10,20))

#create the work flow
rf_workflow <- 
  workflow() %>% 
  add_model(rf_mod) %>% 
  add_recipe(class_rec)

#Grid search based on the rf_grid
rf_tune_results <- rf_workflow %>%
  tune_grid(resamples =val_set, #CV object
            grid = rf_grid, # grid of values to try
            metrics = metric_set(accuracy, roc_auc) # metrics we care about
  )

rf_tune_results %>%
  collect_metrics()


#select the best model
param_final <- rf_tune_results %>%
  select_best(metric = "accuracy")
param_final

#record best parameters into the workflow 
rf_workflow <- rf_workflow %>%
  finalize_workflow(param_final)

rf_workflow

#evaluate on the test set 
rf_fit <- rf_workflow %>%
  # fit on the training set and evaluate on test set
  last_fit(data_split)


test_performance <- rf_fit %>% collect_metrics()
test_performance
