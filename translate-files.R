library(tidyverse)

pg1 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Actions")

translation_es <- data.frame(
  do.call(cbind,list(pg1$Committee,pg1$Action,pg1$`Parties Responsible`,pg1$Progress)))

  
  

cbind(pg1$Sp_Committee,pg1$Sp_Action,pg1$Sp_Agencies,pg1$Sp_Status)