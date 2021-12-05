library(tidymodels)  # for the parsnip package, along with the rest of tidymodels

df <- read.csv('data.csv') 

#delete columns only have NAs 
df <- df %>% 
  select_if(~ !any(is.na(.))) %>% 
  mutate(diagnosis = factor(diagnosis))


#take a look of the data 
head(df)


# Using this dataset of 32 variables measuring the size and 
# shape of cell nuclei, 
# goal is to create a model that will allow us to predict 
# whether a breast cancer cell is benign or malignant.

# Data Description
# Features are computed from a digitized image of a fine 
# needle aspirate (FNA) of a breast mass. 
# They describe characteristics of the cell nuclei present 
# in the image. Our dataset consists of 569 observations 
# and 32 variables. 
# There is an ID variable, a diagnosis variable revealing 
# if they were benign or malignant,
# and 30 measurement variables detailing the size and shape 
# of the cell nuclei. 
# The diagnosis, a categorical variable, is our response 
# variable and the 30 measurement variables, all of which 
# are continuous, 
# are our potential explanatory variables for our model. 
# The 30 measurement variables are actually only 10 
# different features of the nucleus, but with 3 different 
# measurements of each; 
# the mean, the standard error and the ‘worst’ or largest 
# (mean of the three largest values). 
# radius - mean of distances from center to points on 
# the perimeter
# texture - standard deviation of gray-scale values
# perimeter
# area
# smoothness - local variation in radius lengths
# compactness - perimeter^2 / area - 1.0
# concavity - severity of concave portions of the contour
# concave points - number of concave portions of the contour
# symmetry
# fractal dimension - “coastline approximation” - 1

# To get a glimpse of your data:
glimpse(df)

# Check missing data
missing_values <- df %>% summarize_all(funs(sum(is.na(.))/n()))

missing_values <- gather(missing_values, key="feature", value="missing_pct")

missing_values %>% 
  ggplot(aes(x=reorder(feature,-missing_pct),y=missing_pct)) +
  geom_bar(stat="identity",fill="red")+
  coord_flip()+theme_bw()

# Start the model by split the data into train/test set

# First, we need to s plit the data into 
set.seed(123)
# Put 80% of the data into the training set 
data_split <- initial_split(df, prop = 4/5)

# Create data frames for the two sets:
train_data <- training(data_split)
test_data  <- testing(data_split)

# Create a recipe
class_rec <- 
  recipe(diagnosis~ ., data = train_data) %>%
  #step_string2factor(diagnosis)
  update_role(id, new_role = 'ID')
# The recipe function has two arguments here, first is a 
# formula, anything on the left hand side is considered the 
# model outcome. 
# We also update the roles here to use the update_role 
# function to indicate the want to assign "ID" to our 
# column id, which tells the
# recipe to not use them as either outcomes or input.


# The parsnip is where all the models we have in the 
# tidymodels packages, here I am using random forest model
# parsnip models: https://www.tidymodels.org/find/parsnip/

# Check the engine that were implemented 
show_engines("rand_forest")

# Define the model
rf_mod <- 
  rand_forest(mtry = 6, trees = 100, min_n = 200) %>% 
  set_engine("ranger") %>% 
  set_mode("classification")

rf_workflow <- 
  workflow() %>% 
  add_model(rf_mod) %>% 
  add_recipe(class_rec)

# install.packages("ranger")
library(ranger)

class_fit <- 
  rf_workflow %>% 
  fit(data = train_data)

# Validate with the the test data 
class_fit %>%
  predict(test_data) %>%
  bind_cols(test_data) %>%
  conf_mat(truth = diagnosis, estimate = .pred_class) 

class_fit %>%
  predict(test_data) %>%
  bind_cols(test_data) %>%
  metrics(truth = diagnosis, estimate = .pred_class) 

# Per class metrics
class_pred <- class_fit %>%
  predict(test_data) %>%
  bind_cols(test_data)


# Kappa is accuracy normalized would be expected chance alone
class_pred %>% 
  metrics(truth = diagnosis, .pred_class)


# Per class metrics
class_probs <- class_fit %>%
  predict(test_data, type = "prob") %>%
  bind_cols(test_data)

class_probs%>%
  roc_curve(diagnosis, .pred_B) %>%
  autoplot()

# The validation is from package yardstick package
roc_curve(class_probs,diagnosis, .pred_B)

