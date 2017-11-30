library(GGally)
library(ggplot2)
library(tidyr)
library(dplyr)
library(MASS)
library(corrplot)

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

#Life Expectancy at Birth -> LEB

#Expected Years of Education -> EYE

#Mean Years of Education -> MYE

#Gross National Income (GNI) per Capita -> GNI_pCapita

#GNI per Capita Rank Minus HDI Rank -> GNIR_M_HDAI

colnames(hd)<-c("HDI_R","Country", "HDI", "LEB", "EYE", "MYE", "GNI_pCapita", "GNIR_M_HDAI")

#GII.Rank -> GII_R                                 
#Country -> Country                                  
#Gender.Inequality.Index..GII. ->   GII            
#Maternal.Mortality.Ratio  -> Mat_Mor                  
#Adolescent.Birth.Rate  -> Ados_BR                    
#Percent.Representation.in.Parliament    ->    Parli_pcnt
#Population.with.Secondary.Education..Female.  -> Edu2_F
#Population.with.Secondary.Education..Male.  -> Edu2_M
#Labour.Force.Participation.Rate..Female.   -> LFPR_F
#Labour.Force.Participation.Rate..Male.    -> LFPR_M 


colnames(gii)<-c("GII_R", "Country", "GII", "Mat_Mor", "Ados_BR", "Parli_pcnt", "Edu2_F", "Edu2_M", "LFPR_F", "LFPR_M")

gii <- mutate(gii, Edu_R = Edu2_F / Edu2_M)
gii <- mutate(gii, Lab_R = LFPR_F / LFPR_M)

human <- inner_join(gii,hd, by="Country")

head(human)
dim(human)

write.table(human, "data/human.csv")
