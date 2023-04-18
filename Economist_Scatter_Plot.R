# Re-creating the plot from the Economist using 'ggplot2' library. 
# The plot visualises the relationship between corruption and the human development in various countries, based on data from 2011.

# Loading the required libraries.
library(ggplot2)
library(data.table)

# Reading the data. 
df<- fread("Economist_Assignment_Data.csv", drop = 1)

head(df)

# Creating the basic scatter plot. 
# Assigning x & y axes, as CPI & HDI respectively. 
# Assigning the colour coding by 'Region'. 
# Assigning the size of points to 4 and using 'shape' to specify empty circles as points. 
pl <- ggplot(df, aes(x = CPI, y = HDI)) + geom_point(aes(color = Region), size = 4, shape = 1)
print(pl)

# Adding a trend line.
# Passing the following arguments to 'geom_smooth()':
# a. 'method' - specifies the type of smoothing, here 'lm', which is the linear regression line will be used to fit the data.
# b. 'formula' - formula for smoothing function, here we use logarithmic transformation
# c. 'se' - whether to include a shaded area representing the standard error estimate, here 'FALSE'.
# d. 'color' - setting the line's color to red. 
pl1 <- pl + geom_smooth(method = 'lm', formula = y ~ log(x), se = FALSE, color = 'red')
print(pl1)

# Adding data labels to scatter points representing the country names from column 'Country'.
# The Economist on their graph have only a subset of countries represented with the data label.
# Re-creating that subset and assigning to a variable 'pointsToLabel'.
# Using the 'subset()' function to only show the data labels for values from 'Country' column that match the values in variable 'pointsToLabel'.
# Assigning colour to the country labels as well as using 'check_overlap' to not show any data labels that could overlap with other labels.
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl2 <- pl1 + geom_text(aes(label = Country), color = 'gray20', data = subset(df, Country %in% pointsToLabel), check_overlap = TRUE)
print(pl2)

# Adding a theme to the plot.
pl3 <- pl2 + theme_bw()
print(pl3)

# Using the 'scale_x_continuous' function to adjust the x-axis. 
# Assigning a new name to the x-axis.
# Specifying the scale of x-axis being 1-10.
# Adding tick marks at every change of unit on x-axis.
pl4 <- pl3 + scale_x_continuous(name = "Corruption Perception Index, 2011 (10 = least corrupt)", limits = c(1,10), breaks = (1:10))
print(pl4)

# Using the 'scale_y_continuous' function to adjust the y-axis.
# Assigning a new name to the y-axis.
# Specifying the scale of y-axis being 0.2-1.
# Adding tick marks at every 0.2 change of unit on y-axis.
pl5 <- pl4 + scale_y_continuous(name = "Human Development Index, 2011 (1 = Best)", limits = c(0.2,1), breaks = seq(0.2,1,0.2))
print(pl5)

# Adding the plot title. 
pl6 <- pl5 + ggtitle("Corruption and Human Development")
print(pl6)

# Using theme to customise the title.
# Putting the title at the center and increasing the font size.
pl7 <- pl6 + theme(plot.title = element_text(size = 20, hjust = 0.5))
print(pl7)
