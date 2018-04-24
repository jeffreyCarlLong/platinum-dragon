# Tidy Tools and Base R

## COLLECTION OF SYNTAX- 

This is a cookbook of R commands to manipulate data frames. 
I recently wrangled data for a clinical trial data analysis project.
A list of the functions covered in this recipe is: 
colnames, 
ddply (for row counts), 
ifelse, 
filter, 
unique, 
write.csv, 
is.na, 
paste, 
left_join, 
aggregate, 
select, 
group_by, 
summarise, 
gsub, 
read_excel, 
c (concatenate), 
rbind, 
separate, 
spread, 
grepl, 
substr,
separate_rows,
drop_na,
bash engine sort,
t.test

This file is meant to be a quick reference for a programmer 
who has used these functions before, and just needs a reminder of 
R syntax. 

### Slick column rename
colnames(df)[names(df)=="varName"] <- "newVarName"

### Summarize N of Variable Values
rowCountForVar <- plyr::ddply(df, .(df$groupingVar,df$varToCount),nrow)

### Consolidate Variable Values
df$\`Consolidated Vars\` <- ifelse((df$"Var to Consolidate" == "high")|(df$"Var to Consolidate" == "very high"),"Responding Patient",df$"Var to Consolidate")

### Filter Variable on Value
df <- filter(df,df$\`Variable Name\` == "Value")

### Remove duplicates
df <- unique(df)

### Write data
write.csv(df,"Filename.csv", row.names=FALSE, na="")

### Flag samples without value for variable
df$\`newVariable\` <- ifelse(is.na(df$variable),FALSE,TRUE)

### Create new variable
df$newVar <- paste("Year", df$year, "Month", df$month, "Day", df$\`The Day\`)

### Join two dataframes
df <- left_join(df, altDf, by = c("Var1" = "Var1", "Var2" = "Var2"))

### Sum samples within a group
df <- aggregate(df$varToFunctionalize, by df["varToGroup"], FUN=mean)

### Parse out columns of interest
dfSvelte <- select(dfSvelte, 1:42,45)

### Summarise with group_by
df <- df %>% 
  group_by(groupVar) %>% 
  summarise_each(funs(min(resultVar, na.rm = TRUE)))
  
#### or 
newDf <- df %>%
  group_by(groupVar) %>%
  summarise(df = mean(result))

### Remove commas, AKA Replace commas with nothing
df$\`Some Variable\` <- gsub(",", "", df$\`Some Variable\`)

### Read in Excel file
df <- read_excel("/Path/to/file.xlsx")

### Pulling out columns
df <- df[,c("Col 1", "Col 2", "Col 3")]

### Adding dataframes together
dfBound <- rbind(df1, df2)

### Splitting a variable column
df <- separate(df, \`Var Name\`, c("Token 1", "Token 2", "Token 3"), sep = "_")

### Transposing data
dfWide <- dfLong %>% spread(\`Row Name Var\`, \`Result To Spread\`, convert = TRUE)

### Remove data
df <- filter(df, !grepl('ID1|ID2|ID3',idVar))

### Cut up regular values
df$\`The Var\` <- substr(as.character(df$\`The Var\`),index1,index2)

### Separate delimited in several columns into separate rows and fill other variables
dfSplit <- separate_rows(df, delimVar1, delimVar2, delimVar3, delimVar4, sep =  ";", convert = FALSE)

### Remove rows which have NAs in one (key) variable
dfRmNa <- drop_na(df, "Var")

### Bash sorting in RStudio
bash engine='bash'

sort -k1,1 /Users/jlong/Documents/File.txt > /Users/jlong/Documents/File.sorted.txt

### t-Test for Gene Mutation of Interest given IC50 scores for cell lines
d.filt <- filter(d, d$Gene == "GoI")

t.test(d.filt$IC50~d.filt$Mutated)


