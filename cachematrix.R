##
## Purpose of Code
##
## Original Author (forked from): Roger D. Peng
## Editting Author: Tony Kelly
##
## This R script defines 2 functions.  One function to make and cache a special matrix, and then
## another function to calculate the inverse of the matrix.  This code is essentially built off
## of the template provided by makeVector.R and cacheMean.R , both which contain functions
## makeVector and cacheMean.  Further details of the actual functions are commented in their
## respective sections.
##
## makeVector and cacheMean were actually terribly written in terms of the data dictionary names.
## More effort was made in my code to make the variable names much more descriptive
##
## I created a code called cacheMatrixTest.R which can be RUN within RStudio.  It was created
## as a means of testing and debugging this code as I grew to understand it.
##
## NOTICE: If you are experienced at all with object-oriented programming, then you will notice
##  that this is pretty close to achieving the same effect in R.  It is close enough, that I
##  refer to various sections as Members and Methods.  Also, even though I could have written
##  the embedded function environments as one liners, I prefer to have the same structure to
##  my functions throughout, hence the use of curly braces at the end of each function.  This
##  is a personal coding preference.
##

## makeCacheMatrix takes as its input a numeric matrix
##   The output/return of the makeCacheMatrix is a LIST with the properties
##    set using the functions/methods as described within the body below

makeCacheMatrix <- function(hold_matrix = matrix()) { # pass initial matrix
  
  ## Members
  ## hold_matrix : this is the matrix passed to makeCacheMatrix.. sort of a member
  ## hold_inverse : this is the variable to hold the matrix inverse
  
  hold_inverse <- NULL
  
  ## Methods (functions within makeCaheMatrix environment)
  ## set_matrices : clears the cached values and resets hold_matrix and hold_inverse
  ## set_inverse  : provides a means of directly setting the hold_inverse to a value
  ## get_matrix   : returns the value contained in hold_matrix
  ## get_inverse  : returns the value contained in hold_inverse
  
  set_matrices <- function(new_matrix) {
    hold_matrix  <<- new_matrix
    hold_inverse <<- NULL
  }
  
  set_inverse <- function(new_inverse) {
    hold_inverse <<- new_inverse
  }
  
  get_matrix <- function() {
    ## returns hold_matrix
    hold_matrix
  }
  
  get_inverse <- function() {
    ## returns hold_inverse
    hold_inverse 
  }
  
  ## makeCacheMatrix returns a list with the functions
  list(setMatrix  = set_matrices, 
       setInverse = set_inverse,
       getMatrix  = get_matrix,
       getInverse = get_inverse)
}

## cacheSolve takes the matrix list object made by
##  the routine makeCacheMatrix.  It first checks
##  to see if the matrix is even a square matrix.
##  If the matrix is square, it then looks to see
##  if the inverse already has been cached.  If
##  the inverse has already been calculated and
##  stored, then it does not repeat the computation,
##  otherwise the solve function is used to calculate
##  the inverse.  I obtained the idea for the solve
##  function from: http://www.statmethods.net/advstats/matrix.html
##
##  Of course, local_inverse and local_matrix are sort of moot points,
##  There is no real need to use them, could just work on the matrix_object
##  directly.  But to follow the suggested template and to have ease of
##  reading, I use them anyway.
##
##  Notice that this code already checks to see if the matrix has changed,
##  Since the matrix changes in one of two ways, either the original matrix
##  changes and then the makeCacheMatrix resets everything, or the setMatrix
##  function is called, and everything is reset.  So no need to hard check
##  whether the matrix has changed inside the code.  Just use as is.
cacheSolve <- function(matrix_object, ...) {
  
  ## Members
  ## local_inverse : takes a variable of type makeCacheMatrix, specifically the inverse
  ## local_matrix  : stores a copy of the current matrix into a local variable
  local_inverse <- matrix_object$getInverse() 
  local_matrix  <- matrix_object$getMatrix()
  
  ## First, check to see if the Inverse has already been calculated
  ## If it has, then it should not have a NULL value and the inverse
  ## Can just be returned
  if(!is.null(local_inverse)) {
    message("getting cached data")
    return(local_inverse)
  }

  ## If we are at this part of the code, then we have passed the IF statement
  ## In this case, the local_inverse is NULL, thus the inverse does need to
  ## be calculated.  So, first, test whether the matrix is a square matrix.
  ## However, even if the matrix is square, it could be singular.  A singular
  ## matrix will be one that has a determinant of zero.  This needs to be 
  ## checked for as well.
  if ( nrow(local_matrix) == ncol(local_matrix) && det(local_matrix) != 0) {
    local_inverse <- solve(local_matrix)
    matrix_object$setInverse(local_inverse)
    return(local_inverse) # return new inverse
  }
  else if (nrow(local_matrix) != ncol(local_matrix)) {
    message("Matrix is not square.  Please check your matrix.")
    return(local_inverse) # return current inverse
  }
  else {
    message("Martix is singular.  Cannot find inverse.")
    return(local_inverse) # return current inverse
  }
}