# rHelp

## Useful R function with quick syntax references.

These are some useful R functions for wrangling data. 
The functions include: 
aggregate, 
bash engine, 
c (concatenate), 
colnames, 
ddply (for row counts), 
drop_na, 
filter,
flags, 
grepl, 
group_by, 
gsub, 
ifelse, 
is.na, 
left_join, 
paste, 
rbind, 
read_excel, 
select, 
separate, 
separate_rows,
sort, 
spread, 
substr, 
summarise, 
t.test, 
unique, 
write.csv, ...

### aggregate: Sum samples within a group
df <- aggregate(df$varToFunctionalize, by df["varToGroup"], FUN = mean)

### bash in RStudio
bash engine='bash'

### colnames:  Slick column rename
colnames(df)[names(df) == "varName"] <- "newVarName"

### ddply:: Summarize N of Variable Values
rowCountForVar <- plyr::ddply(df, .(df$groupingVar, df$varToCount), nrow)

### drop_na: Remove rows which have NAs in one (key) variable
dfRmNa <- drop_na(df, "Var")

### filter Variable on Value
df <- filter(df, df$\`Variable Name\` == "Value")
df <- filter(df, !grepl('ID1|ID2|ID3', idVar))
d.filt <- filter(d, d$Gene == "GoI")
  t.test(d.filt$IC50~d.filt$Mutated)

### Consolidate Variable Values
df$\`Consolidated Vars\` <- ifelse((df$"Var to Consolidate" == "high") | (df$"Var to Consolidate" == "very high"), "Responding Patient", df$"Var to Consolidate")

### grep: Remove data
df <- filter(df, !grepl('ID1|ID2|ID3',idVar))

### group_by: Summarise with group_by
df <- df %>% 
  group_by(groupVar) %>% 
  summarise_each(funs(min(resultVar, na.rm = TRUE))) 

### gsub: Remove commas, AKA Replace commas with nothing
df$\`Some Variable\` <- gsub(",", "", df$\`Some Variable\`)

### ifelse, is.na: Flag samples without value for variable
df$\`newVariable\` <- ifelse(is.na(df$variable), FALSE, TRUE)

### left_join: Join two dataframes (ie more columns)
df <- left_join(df, altDf, by = c("Var1" = "Var1", "Var2" = "Var2"))

### paste: Create new variable
df$newVar <- paste("Year", df$year, "Month", df$month, "Day", df$\`The Day\`)

### rbind: Adding dataframes together (ie more rows)
dfBound <- rbind(df1, df2)

### read_excel: Read in Excel file
df <- read_excel("/Path/to/file.xlsx")

### select: Parse out columns of interest
dfSvelte <- select(dfSvelte, 1:42,45)
df <- df[,c("Col 1", "Col 2", "Col 3")]

### separate: Splitting a variable column
df <- separate(df, \`Var Name\`, c("Token 1", "Token 2", "Token 3"), sep = "_")

### separate_rows: Separate delimited in several columns into separate rows and fill other variables
dfSplit <- separate_rows(df, delimVar1, delimVar2, delimVar3, delimVar4, sep =  ";", convert = FALSE)

### sort: UNIX-like (not R, use bash engine) by column (k, man sort)
sort -k1,1 /Users/jlong/file.txt > /Users/jlong/file.sorted.txt

### spread: Transposing data
dfWide <- dfLong %>% 
  spread(\`Row Name Var\`, \`Result To Spread\`, convert = TRUE)

### substr: Cut up regular values (by fixed width of string)
df$\`The Var\` <- substr(as.character(df$\`The Var\`), index1, index2)

### summarise: aggregates
anotherDf <- df %>%
  group_by(groupVar) %>%
  summarise(df = mean(result))

### t.test: for Gene Mutation of Interest given IC50 scores for cell lines
d.filt <- filter(d, d$Gene == "GoI")
  t.test(d.filt$IC50~d.filt$Mutated)

### unique: Remove duplicates
df <- unique(df)

### write.csv: Write data
write.csv(df, "Filename.csv", row.names=FALSE, na="")












