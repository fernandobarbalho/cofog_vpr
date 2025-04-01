library(readxl)
library(tidyverse)



##### Ideias para análises
### Gráficos de sankey
### PCA e cluster entre os diversos países e localizar o grupo do Brasil
### Caracterizar o grupo do Brasil
### Mapas mundi de variáveis selecionadas, principalmente as mais relevantes para o PCA
### usar o pacote do R FMI para fazer o download dos dados


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
      select(esfera, codigo:valor) %>%
      mutate(descricao = str_remove(descricao, "\\d.*/$"))
  })




# Example string
input_string <- "Despesa total3/"

# Remove the trailing pattern starting with a number and ending with /
output_string <- str_remove(input_string, "\\d.*/$")

