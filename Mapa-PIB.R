# Remover objetos
rm(list = ls())

# Selecionar um ano entre 2002 e 2018
# Selecionar um estado
#------------
Ano = '2017'
Estado = 'MG'
# -----------

# Pacotes
library(readr)
library(geobr)
library(ggplot2)
library(dplyr)

# Importar dados
PIB <- read_delim("PIB.csv", ";", escape_double = FALSE, 
                  locale = locale(encoding = "WINDOWS-1252"), 
                  trim_ws = TRUE)

# Impoertar dados 
Municipios = read_municipality() %>% 
  filter(abbrev_state == Estado)

# Unir tabelas
Tabela <- inner_join(Municipios, PIB, Ano, by = c('name_muni', 'abbrev_state')) %>% 
  filter(abbrev_state == Estado)

# Seleção de dados
Selecao <- Tabela %>% select(abbrev_state, name_muni, Ano)

# Converter coluna do PIB em número e para Mil Reais
Selecao[[Ano]] <- as.double(Selecao[[Ano]]) / 1000

# Mapa
print(
ggplot() +
  geom_sf(data = Selecao, aes(fill = Selecao[[Ano]]))+
  labs(title = "PIB Municipal (Mil Reais)", 
       subtitle = paste('Ano: ', as.character(Ano))) +
  scale_fill_distiller(palette = "Blues", name = "") +
  theme_minimal()+
  theme(axis.title=element_blank(),
                 axis.text=element_blank(),
                 axis.ticks=element_blank()))




