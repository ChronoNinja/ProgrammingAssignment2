# If working in RStudio, Ctrl+L will clear the console.
# Sourcing makeVector and cacheMean
source("makeVector.R")
source("cacheMean.R")

# Create numeric vector x with 2, 4, and 6
x <- c(2,4,6)

# Create special vector y
y <- makeVector(x)

# Calculate the mean of y
cacheMean(y)

# Calculate the mean of y again, but it is cached
cacheMean(y)

# Now reset x to be 1 through 10
x <- 1:10

# Remake vector y
y <- makeVector(x)

# Caclulate the mean of y, which is now not cached so recalculated
cacheMean(y)

# Demonstrate that it is cached again
cacheMean(y)

# Make x 1 through 20
x <- 1:20

# Notice that this next cacheMean is still the old mean, didn't remake y
cacheMean(y)

# Remake y
y <- makeVector(x)

# Now the cached Mean is correct
cacheMean(y)

# Check to see if indeed cached, good
cacheMean(y)