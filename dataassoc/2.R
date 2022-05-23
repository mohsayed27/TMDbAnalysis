# 1.
# First of all, start by cleaning the workspace and setting the working directory.

#clear env
rm(list = ls())

#change directory
setwd(".")
 
# 2.
# Load the libraries arules and arulesViz
if(!require("arules")){
  install.packages(c("arules", "arulesViz"))
}
library("arules")
library("arulesViz")
# 3.
# Load the transactions in the file AssociationRules.csv using the function
# read.transactions.
# help("read.transactions")
transcations = read.transactions("genre2.txt", header= FALSE)

# Make sure you don't include the header line in the dataset.
# There is no header line
# 4.
# Display the transactions in a readable format using the function inspect. Display
# only the first 100 transactions.
#help(inspect)
inspect(transcations[1:100])
length(transcations)
# 5.
# What are the most frequent two items in the dataset? What are their frequencies?
#   Hint: use the function itemFrequency or use the function summary.
#help("itemFrequency")
transcations_summary = summary(transcations)
freq_transcations = itemFrequency(transcations, type= "absolute")
typeof(transcations_summary)
typeof(freq_transcations)

# Top 2 are item13 and item5 with 4947 and 3698 mentions 
transcations_summary@itemSummary

# Another way 
sort(freq_transcations, decreasing= TRUE)[1:2]
# 6.
# Plot the 5 most frequent items of the transactions using the function
# itemFrequencyPlot
names(sort(freq_transcations, decreasing= TRUE)[1:5])
#help(itemFrequencyPlot)
itemFrequencyPlot(transcations, topN = 5)

# 7.
# Generate the association rules from the transactions using the apriori algorithm. Set
# the minimum support = 0.01, minimum confidence = 0.5, minimum cardinality (number of items in the rule) = 2. Use the function apriori
#help("apriori")

rules <- apriori(transcations, parameter= c(support= 0.05, confidence= 0.2, minlen= 2, maxlen=3))

# 8.
# Now, sort the generated rules by support. Search the function sort found in the
# arules package. Show only the first 6 rules.
# I found that head was faster than sort while searching
inspect(head(rules, n = 6, by = "support"))
# 9.
# Sort the generated rules by confidence. Show only the first 6 rules.
inspect(head(rules, n = 6, by = "confidence"))
# 10.
# Sort the generated rules by lift. Show only the first 6 rules.
inspect(head(rules, n = 6, by = "lift"))
# 11.
# Plot the generated rules with support as x-axis, confidence as y-axis and lift as
# shading. Use the function plot in arules package.
# help(plot)
plot(rules, measure = c("support", "confidence"), shading = "lift")
