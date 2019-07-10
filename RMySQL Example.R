# Check out this presentation for more documentation
# https://www.slideshare.net/RsquaredIn/rmysql-tutorial-for-beginners

#library needed to connect to MySQL
library(RMySQL)
library(ggplot2)

#RStudio function that prompts for password. Security is always important.
psswd <- .rs.askForPassword("Database Password:")

#Define connection string 
con <- dbConnect(MySQL(), user='root',password=psswd, host='localhost', dbname='legos' )

#get information about the connection
dbGetInfo(con)

#list tables in database
dbListTables(con)

#list column in a table
dbListFields(con,"sets")

#import an entire table 
lego_sets <- dbReadTable(con,"sets")

head(lego_sets)

#plot the number of legos by year per set
ggplot(data=lego_sets, aes(x=year, y=num_parts)) +
  geom_jitter(alpha=0.5, shape=1)


#import the results of a SQL query

avg_by_year <- dbGetQuery(con, "SELECT year, avg(num_parts) as avg_parts FROM sets GROUP BY year")

head(avg_by_year)

#function to compute lm equation
lm_eqn <- function(df,x,y){
    m <- lm(y ~ x, df);
    eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(r)^2~"="~r2, 
         list(a = format(coef(m)[1], digits = 2), 
              b = format(coef(m)[2], digits = 2), 
             r2 = format(summary(m)$r.squared, digits = 3)))
    as.character(as.expression(eq));                 
}

ggplot(data=avg_by_year, aes(x=year, y=avg_parts)) +
  geom_point(alpha=0.5, shape=16) +
  geom_smooth(method='lm',formula=y~x) + 
  geom_text(x = 1970, y = 200, label = lm_eqn(avg_by_year,avg_by_year$year,avg_by_year$avg_parts), parse = TRUE)

#for large queries, this can be done in different steps. 
#This allows you to process the results in chunks.

very_big_sets_qry <- dbSendQuery(con, "SELECT * FROM sets WHERE num_parts>=1000") 

very_big_sets <- dbFetch(very_big_sets_qry)

#write out data
dbWriteTable(con, "big_sets", data.frame(big_sets, stringsAsFactors = F), overwrite=TRUE)

#let's check and see if it's there

#delete a table
dbRemoveTable(con, "big_sets")


#disconnect from the database
dbDisconnect(con)
