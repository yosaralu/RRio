
# Functions ---------------------------------------------------------------

### FUNCTIONS TO DRY --> DONT REPEAT YOURSELF
### for analyzing gapminder data
### Sara
### September



# function to calculate the cv
## takes a vector of numbers
### returns the cv
cal_CV <- function(x){
  mean_x <- mean(x)
  sd_x <- sd(x)
  CV <- sd_x / mean_x
  return(CV)
}

# go from circumference to diameter
circum_diameter <- function(circ){
  diam <- circ/pi
  return(diam)
}

#redius of the diameter

diam_radius <- function(x){
  radius <- x / 2
  return(radius)
  }


#radius to area
radius_area <- function(x){
  area <- pi * x^2
  return(area)
}

# start with circumference and get the area: this is putting 
# together all the functions made before

area_from_circum <- function(x){
    ## get the diameter from the circumference
  diam <- circum_diameter(x)
    ## get the radius
    rad <- diam_radius(diam)
  ## calculate area from radius
  Area <- radius_area(rad)
  return(Area)
}






















