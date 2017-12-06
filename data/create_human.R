library(GGally)
library(ggplot2)
library(tidyr)
library(dplyr)
library(MASS)
library(corrplot)
library(stringr)

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")


#structure and dimensions of the data “Human development”

str(hd)
colnames(hd)
dim(hd)


#structure and dimensions of the data “Gender inequality” 

str(gii)
colnames(gii)
dim(gii)


#HDI Rank -> HDI_R

#Country -> Country

#Human Development Index (HDI) -> HDI

#Life Expectancy at Birth -> Life.Exp

#Expected Years of Education -> Edu.Exp

#Mean Years of Education -> MYE

#Gross National Income (GNI) per Capita -> GNI

#GNI per Capita Rank Minus HDI Rank -> GNIR_M_HDAI



# Health and knowledge






# Empowerment






#"Edu2.FM" = Edu2.F / Edu2.M
#"Labo.FM" = Labo2.F / Labo2.M

colnames(hd)<-c("HDI_R","Country", "HDI", "LEB", "EYE", "MYE", "GNI_pCapita", "GNIR_M_HDAI")

#GII.Rank -> GII_R                                 
#Country -> Country                                  
#Gender.Inequality.Index..GII. ->   GII            
#Maternal.Mortality.Ratio  -> Mat.Mor              
#Adolescent.Birth.Rate  -> Ado.Birth                
#Percent.Representation.in.Parliament    -> Parli.F
#Population.with.Secondary.Education..Female.  -> Edu2.F
#Population.with.Secondary.Education..Male.  -> Edu2.M
#Labour.Force.Participation.Rate..Female.   -> Labo.F
#Labour.Force.Participation.Rate..Male.    -> Labo.M



colnames(gii)<-c("GII_R", "Country", "GII", "Mat_Mor", "Ados_BR", "Parli_pcnt", "Edu2_F", "Edu2_M", "LFPR_F", "LFPR_M")

gii <- mutate(gii, Edu_R = Edu2_F / Edu2_M)
gii <- mutate(gii, Lab_R = LFPR_F / LFPR_M)

human <- inner_join(gii,hd, by="Country")

head(human)
dim(human)

write.table(human, "data/human.csv",sep="\t")

#I have finshed the last week data wrangling exerices. In the wrangling process, I have given short column name by myself. In order to follow the exercise,
#I prefer to use the link given in the exercises (http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt).

human <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)

#head(human)
#remove commas

human_no_commas <- mutate(human, GNI = str_replace(GNI, pattern=",", replace ="")%>%as.numeric)

#head(human_mutat)

keep_columns= c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")


human_no_NA <-dplyr::select(human_no_commas, one_of(keep_columns)) %>% filter(complete.cases(.)==TRUE)

human_analysis_ready <- human_no_NA[1:(nrow(human_no_NA) - 7), ]

rownames(human_analysis_ready)<-human_analysis_ready$Country
  
human_analysis_ready <- human_analysis_ready[-1]


write.table(human_analysis_ready, "data/human.csv",sep="\t")





