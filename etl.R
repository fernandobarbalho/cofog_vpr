library(readxl)
library(tidyverse)


esfera_sheet <- tibble(sheet=c("1.2","1.3","1.4","1.5"),
                        esfera = c("Governo Central","Governos Estaduais", "Governos Municipais", "Governo Geral"))


dados_cofog<-
  purrr::map_dfr(1:4, function(indice){
    cofog_gg <- read_excel("COFOG GG.xlsx", sheet = esfera_sheet$sheet[indice], 
                           skip = 2)
    names(cofog_gg)[c(1,2)] <- c("codigo", "descricao")

    esfera<- esfera_sheet$esfera[indice]
    cofog_gg %>%
      pivot_longer(3:16, names_to = "ano", values_to = "valor") %>%
      mutate(ano = as.numeric(ano)) %>%
      mutate(esfera = esfera) %>%
      select(esfera, codigo:valor)
  })


