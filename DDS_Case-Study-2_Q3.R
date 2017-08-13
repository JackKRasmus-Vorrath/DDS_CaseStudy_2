attach(Orange)

Mean_Circ_by_Tree <- aggregate(circumference ~ Tree, data = Orange, FUN = mean)
Mean_Circ_by_Tree

Median_Circ_by_Tree <- aggregate(circumference ~ Tree, data = Orange, FUN = median)
Median_Circ_by_Tree

library(ggplot2)

Circ_v_Age_by_Tree <- ggplot(Orange, aes(age, circumference)) + geom_point(aes(color = factor(Tree))) + labs(title = "Circumference|Age by Tree", subtitle = "Tree Type Grouped by Increasing Max Diameter")

Circ_v_Tree_boxplot <- ggplot(Orange, aes(Tree, circumference)) + geom_boxplot() + labs(title = "Boxplot of Circumference|Tree", subtitle = "Tree Type Grouped by Increasing Max Diameter")
