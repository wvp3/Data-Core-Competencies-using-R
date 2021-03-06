
#___________________________________________________________________________
#~~~~~~~~~~~      _____   _             _       _            ~~~~~~~~~~~~~~~
#~~~~~~~~~~~     |  __ \ | |           (_)     (_)           ~~~~~~~~~~~~~~~ 
#~~~~~~~~~~~    | |__) || |_ _ __ __ _ _ _ __  _ _ __   __ _ ~~~~~~~~~~~~~~~
#~~~~~~~~~~~   |  _  / | __| '__/ _` | | '_ \| | '_ \ / _` | ~~~~~~~~~~~~~~~
#~~~~~~~~~~~  | | \ \ | |_| | | (_| | | | | | | | | | (_| |  ~~~~~~~~~~~~~~~
#~~~~~~~~~~~ |_|  \_\ \__|_|  \__,_|_|_| |_|_|_| |_|\__, |   ~~~~~~~~~~~~~~~
#~~~~~~~~~~~      ______                             __/ |   ~~~~~~~~~~~~~~~
#~~~~~~~~~~~     |______|                           |___/    ~~~~~~~~~~~~~~~
#___________________________________________________________________________


#-------------------------------------------------------
# ---- (1) Importing CSV datafile using Base R (Slide )----- 
#--------------------------------------------------------
# function used is 'read.csv' with arguements (file path and/or name), 
# reads in csv file named "ex1_data.csv", and
    # stores dataset as an object 'msd' 
msd <- read.csv("./RawData/ex1_data.csv")
#object <- function(relative file path/filename.csv)
#-------------------------------------------------------


#-------------------------------------------------------
# ---- (2) Importing TXT datafile (Slide )----- 
#--------------------------------------------------------
# One can import .txt files using base R, but not the best
txt_df <- read.table("./RawData/ex1_txtdata.txt", header = T)

# Check your data types
sapply(txt_df, class)


# Using packages for efficient data import
 # *More about packages: https://www.datacamp.com/community/tutorials/r-packages-guide
# install.packages("readr")
library(readr)

# Importing .txt file using 'readr' package
pkg_df <- readr::read_tsv("./RawData/ex1_txtdata.txt")

# Check your data types
sapply(pkg_df, class)


# # Pulling dataset from GitHub
# df <- readr::read_tsv("https://raw.githubusercontent.com/ICPI/TrainingDataset/master/Output/ICPI_MER_Structured_TRAINING_Dataset_PSNU_IM_FY17-18_20180515_v1_1.txt")
  
  
# Specifying the type of each variable being pulled in
#             "c" = character 
#             "i" = integer 
#             "n" = number 
#             "d" = double (includes decimals)
#             "l" = logical 
#             "D" = date 
#             "T" = date time 
#             "t" = time 
#             "?" = guess

pkg_df2 <- read_tsv(file = "./RawData/ex1_txtdata.txt", 
                    col_types = cols(MechanismID        = "c",
                                     AgeAsEntered       = "c",            
                                     AgeFine            = "c",     
                                     AgeSemiFine        = "c",    
                                     AgeCoarse          = "c",      
                                     Sex                = "c",     
                                     resultStatus       = "c",     
                                     otherDisaggregate  = "c",     
                                     coarseDisaggregate = "c",     
                                     FY2017_TARGETS     = "d",
                                     FY2017Q1           = "d",      
                                     FY2017Q2           = "d",      
                                     FY2017Q3           = "d",      
                                     FY2017Q4           = "d",      
                                     FY2017APR          = "d",
                                     FY2018Q1           = "d",
                                     FY2018Q2           = "d",
                                     FY2018_TARGETS     = "d",
                                     FY2019_TARGETS     = "d"))

# checking a single variable class
class(pkg_df2$indicator)
# Check your data classes for all variables
sapply(pkg_df2, class)

## checking multiple variable types??
#-------------------------------------------------------


#-------------------------------------------------------
# ---- (3) Ways to View your dataset(s) (Slide )----- 
#--------------------------------------------------------
View(pkg_df2)
names(pkg_df2)
# Looking at only top few rows 
  # [ ] let you index your data frame.
  # The first element is for rows and second for columns
  # leaving any element blank selects all (rows or columns)
View(pkg_df2[1:20, ])  # selects rows 1 to 20, and all columns
View(pkg_df2[1:20, 1:3]) # selects rows 1 to 20 and columns 1 to 3
#-------------------------------------------------------


#-------------------------------------------------------
# ---- (4) Exploring your dataset (Slide )----- 
#--------------------------------------------------------

# Exploring your data 
  # frequencies (categorical variables) which as stored as factors and 
  #  distributions (numeric variables) such as mean, median, range, etc
  #     mean,median,25th and 75th quartiles,min,max
summary(pkg_df2)

# For character data whether a factor or just plain character
  # One can use the table function in base R
# Looking at categories in the SNUPrioritization
table(pkg_df2$SNUPrioritization)  # count of rows with that category
table(pkg_df2$OperatingUnit)
table(pkg_df2$SNU1)


# Creating cross-tabulations
table(pkg_df2$SNU1, pkg_df2$OperatingUnit)
# Viewing it within R Studio
View(table(pkg_df2$SNU1, pkg_df2$OperatingUnit))

# using the 'knitr' package
library(knitr)
table(pkg_df2$SNU1, pkg_df2$OperatingUnit) %>%
  kable() 
#-------------------------------------------------------


#-------------------------------------------------------
# ---- (5) Cleaning your data (Slide )----- 
# ----     ɒƚɒb ɿuoʏ ǫᴎiᴎɒɘ|Ɔ
#--------------------------------------------------------
  # Removing values with 'NA' 
    # reading in the dataset with NA values in Sex
na_df <- read_tsv(file="./RawData/na_data.txt", 
                  col_types = cols(MechanismID        = "c",
                                     AgeAsEntered       = "c",            
                                     AgeFine            = "c",     
                                     AgeSemiFine        = "c",    
                                     AgeCoarse          = "c",      
                                     Sex                = "c",     
                                     resultStatus       = "c",     
                                     otherDisaggregate  = "c",     
                                     coarseDisaggregate = "c",     
                                     FY2017_TARGETS     = "d",
                                     FY2017Q1           = "d",      
                                     FY2017Q2           = "d",      
                                     FY2017Q3           = "d",      
                                     FY2017Q4           = "d",      
                                     FY2017APR          = "d",
                                     FY2018Q1           = "d",
                                     FY2018Q2           = "d",
                                     FY2018_TARGETS     = "d",
                                     FY2019_TARGETS     = "d"))


# Checking the data 
table(na_df$Sex, exclude=NULL)

# Creating multiple versions of this dataset to try
  # 3 different methods
na_df1 <- na_df 
na_df2 <- na_df

# Removing N/A or other undesireable values and convert to 
  # True missing, or blank ""
na_df1$Sex[na_df1$Sex=="N/A"] <- NA
table(na_df1$Sex, exclude=NULL)  # True missing

na_df2$Sex[na_df2$Sex=="N/A"] <- ""
table(na_df2$Sex, exclude=NULL)  # Blanks 
#-------------------------------------------------------


#-------------------------------------------------------
# ---- (6) Filtering your data (Slide )----- 
# Ref: https://www.statmethods.net/management/subset.html
#--------------------------------------------------------
 # filtering for one Indicator
hts <- na_df1[na_df1$indicator=="HTS_TST", ]
htstx <- na_df1[na_df1$indicator=="HTS_TST"| na_df1$indicator=="TX_NEW", ]  # using OR |
htstx2 <- na_df1[na_df1$indicator %in% c("HTS_TST", "TX_NEW"), ]  #Using %in% operator
# checking
table(na_df1$indicator)  #data with all indicators
table(hts$indicator)  #data with only HTS_TST
table(htstx$indicator)  #data with only HTS_TST and TX_NEW
table(htstx2$indicator)  #data with only HTS_TST and TX_NEW
 
# selecting variables
geo_df <- na_df1[c("OperatingUnit", "SNU1", "PSNU")]

# combination of subsetting rows and columns
westo_df <- na_df1[na_df1$OperatingUnit=="Westeros", c("SNU1", "PSNU")]

# Unique combinations of row variables 
 #(example below shows unique SNU1-PSNU combinations)
unique(westo_df)


 ## Note: Vectors in R 'c' stands for combine (Slide ___)
geo_vector <- c("OperatingUnit", "SNU1", "PSNU")
geo_vector

# selecting variables
geo_df1 <- na_df1[geo_vector]


 # Using the 'Subset' function to select MCAD age bands excluding Unknown
mcad_df <- subset(na_df1, 
                  isMCAD == "Y" & AgeCoarse %in% c("<15", "15+"), 
                  select=Region:FY2017APR)
 # checking
table(mcad_df$AgeCoarse)


# Using the "tidyr" package
library(tidyr)

# Filtering for HTS_TST and TX_NEW total numerator values for Westeros and it's PSNUs
westo_dfx <- na_df1 %>%  #Piping %>% takes object/dataset to next step 
  # filtering for OperatingUnit Westeros
  filter(OperatingUnit=="Westeros" &
           indicator %in% c("HTS_TST", "TX_NEW") &
           standardizedDisaggregate == "Total Numerator") %>% 
  # selecting columns 3 columns only, and FY2017APR values
  select(OperatingUnit, SNU1, PSNU, FY2017APR)

#-------------------------------------------------------


#-------------------------------------------------------
# ---- (7) Exporting your data (Slide )----- 
# ref: https://www.statmethods.net/input/exportingdata.html
#--------------------------------------------------------
 # exporting to csv
write.csv(mcad_df, "./Output/exported_data.csv")
write.csv(mcad_df, "./Output/exported_data_v2.csv", row.names = F)  # removing serial nos.

 # exporting to txt
write.table(mcad_df, "./Output/exp_txt_data.txt", row.names = F, sep="\t")


# # exporting to Excel
# library(xlsx)
# write.xlsx(mcad_df, "./RawData/exp_Excel_data.xlsx")
#-------------------------------------------------------







