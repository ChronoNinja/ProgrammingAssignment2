## The script below was used to debug and test the above code.
## The submission instructions do not ask the User to run the code
## however if the User were to run the code below, it would execute
## an example and implement the above functions.
##
## The 2x2 matrix 4 7 2 6 should have an inverse of 0.6 -0.7 -0.2 0.4
## Copy this section of code and then hit RUN if using RStudio

## print(environment())

source("cachematrix.R")
x <- matrix(c(4,7,2,6),c(2,2))
print(x)
y <- makeCacheMatrix(x)
## Check to see if y actually holds the values of the 2x2 matrix
y$getMatrix()
y$getInverse()
## Now see that you can change Matrix and leave Inverse alone
y$setMatrix(matrix(c(1,2,3,4),c(2,2)))
y$getMatrix()
y$getInverse()
## Now change the Inverse but leave the Matrix alone
y$setInverse(matrix(c(1,0,0,1),c(2,2)))
y$getMatrix()
y$getInverse()
## Reset everything back to the original matrix
y <- makeCacheMatrix(x)
y$getMatrix()
y$getInverse()
## Now test for the cacheSolve
z <- cacheSolve(y)
z
## Gives correct output as expected: 0.6, -0.7, -0.2, 0.4
## Show that the IF-ELSE statement works
y$setMatrix(matrix(c(1,2,3,4),c(1,4)))
z <- cacheSolve(y)
z
## Now show what happens when the matrix is square but singular
## Use the 2x2 matrix 3, 6, 4, 8
y$setMatrix(matrix(c(3,6,4,8),c(2,2)))
z <- cacheSolve(y)
z
## Reset everything back to the original status
y <- makeCacheMatrix(x)
z <- cacheSolve(y)
x
z
## OR
y$getMatrix()
y$getInverse()