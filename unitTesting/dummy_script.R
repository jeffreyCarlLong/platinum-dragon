#Data set for testing data dimensions
testing_data <- data.frame('letters'=c('a', 'b', 'c', 'd'), 'numbers'=seq(1, 4))

#Data set for testing model output
model_data <- data.frame('y'=c(rnorm(25, 0, 1), rnorm(25, 1, 1)), 'x'=rep(c('c1', 'c2'), each=25))
test.mod <- lm(y ~ x, data=model_data)

#A function to test
even_odd <- function(n){
  ifelse(n %% 2 == 0, print('even'), print('odd'))
}
