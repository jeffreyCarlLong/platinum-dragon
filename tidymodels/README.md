# R Master Class Week 7 -- Advanced Analysis using TidyModels
The data we used in the master class as an example is the breast cancer Diagnostic Data Set. 

##Data Description

Features are computed from a digitized image of a fine needle aspirate (FNA) of a breast mass. 
They describe characteristics of the cell nuclei present in the image. Our dataset consists of 569 observations and 32 variables. 
There is an ID variable, a diagnosis variable revealing if they were benign or malignant,and 30 measurement variables detailing the size and shape of the cell nuclei. 
The diagnosis, a categorical variable, is our response variable and the 30 measurement variables, all of which are continuous, are our potential explanatory variables for our model. 
The 30 measurement variables are actually only 10 different features of the nucleus, but with 3 different measurements of each; the mean, the standard error and the ‘worst’ or largest (mean of the three largest values). 
- radius - mean of distances from center to points on the perimeter
- texture - standard deviation of gray-scale values
- perimeter
- area
- smoothness - local variation in radius lengths
- compactness - perimeter^2 / area - 1.0
- concavity - severity of concave portions of the contour
- concave points - number of concave portions of the contour
- symmetry
- fractal dimension - “coastline approximation” - 1

