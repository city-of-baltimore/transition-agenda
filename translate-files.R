library(tidyverse)

pg1 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Actions")
static_es <- read_excel("data/translations/static_translations.xlsx", sheet = "es")
static_fr <- read_excel("data/translations/static_translations.xlsx", sheet = "fr")
static_ko <- read_excel("data/translations/static_translations.xlsx", sheet = "ko")
static_zh <- read_excel("data/translations/static_translations.xlsx", sheet = "zh")

pg1trans <- function(arg1,arg2){
  cbind(
    (pg1 %>%
       select(c(2:5)) %>%
       gather() %>%
       select(lan1 = 2)),
    (pg1 %>%
       select(c(arg1:arg2)) %>%
       gather() %>%
       select(lan2 = 2))
  ) %>%
    unique()
}

translation_es <- pg1trans(7,10) %>%
  mutate('en' = lan1,
         'es' = lan2) %>%
  select(-c(1,2)) %>%
  rbind(.,static_es) %>%
  write.csv(file = "data/translations/translation_es.csv",row.names = F)

translation_fr <- pg1trans(11,14) %>%
mutate('en' = lan1,
       'fr' = lan2) %>%
  select(-c(1,2)) %>%
  rbind(.,static_fr) %>%
  write.csv(file = "data/translations/translation_fr.csv",row.names = F)

translation_ko <- pg1trans(15,18) %>%
mutate('en' = lan1,
       'ko' = lan2) %>%
  select(-c(1,2)) %>%
  rbind(.,static_ko) %>%
  write.csv(file = "data/translations/translation_ko.csv",row.names = F)

translation_zh <- pg1trans(19,22) %>%
  mutate('en' = lan1,
         'zh' = lan2) %>%
  select(-c(1,2)) %>%
  rbind(.,static_zh) %>%
  write.csv(file = "data/translations/translation_zh.csv",row.names = F)


