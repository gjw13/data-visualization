x = 2+3
mean
foo
ages <- c(53,20,39,27,18)
class(ages)
mean(ages) # compute the mean age in sample
mean(ages, trim=0.2)
seq(3.2,6.8)
seq(10,100,by=10)       # 'by' command indicates the increment of the sequences
seq(0,1,length.out=11)  # 'length.out' command indicates the desired length of sequence

# import jmen data
jmen <- read.table("jmen.txt", header=TRUE)
jmen[c(2,4,6),c(2,3)] # prints eye and hair color of 2nd, 4th, and 6th observations
subset(jmen, jmen$Hair == "Brown" | jmen$Eyes == "Brown") # selects all observations with brown hair or brown eyes

# convert jmen eyes attribute data to a table to simplify barplot creation
eye_table <- table(jmen$Eyes)   
barplot(eye_table, col=c("Blue","Brown","Green"), main="Eye Color of Sampled JMen", xlab="Eye Colors",ylab="Number of Individuals", names.arg=c("Blue Eyes","Brown Eyes","Green Eyes"))
# barplot of hair color
hair_table <- table(jmen$Hair)
barplot(hair_table, col=c("Black","Yellow","Brown","Red"), main="Hair Color of Sampled JMen", xlab="Hair Colors",ylab="Number of Men", names.arg=c("Black","Blond(e)","Brown","Red"))