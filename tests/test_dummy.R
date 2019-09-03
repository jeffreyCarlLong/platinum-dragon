source('dummy_script.R')

context('testing data integrity')

# Test number of cols is equal to our number of variables
test_that('data dimensions correct', {
  expect_equal(ncol(testing_data), 2)
  expect_equal(nrow(testing_data), 4)
})

test_that('no missing values', {
  expect_identical(testing_data, na.omit(testing_data))
})

test_that('data types correct', {
  expect_is(testing_data,'data.frame')
  expect_is(testing_data$numbers, 'integer')
  # expect_is(testing_data$letters, 'character') #this one fails; they're factors
  expect_is(testing_data$letters, 'factor') #this one fails; they're factors
})

context('testing model output')

test_that('right number of coefficients', {
  expect_equal(length(test.mod$coefficients), 2)
})

test_that('all factor levels present', {
  expect_equivalent(levels(model_data$x), unlist(test.mod$xlevels))
})

test_that('mean of group 1 equals intercept', {
  expect_equivalent(mean(model_data$y[model_data$x == 'c1']), test.mod$coefficients['(Intercept)'])
})

context('testing a custom function')

test_that('even_odd prints the right message', {
  expect_that(even_odd(1), prints_text('odd'))
  expect_that(even_odd(6), prints_text('even'))
})
