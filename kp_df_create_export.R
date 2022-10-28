library(tidyverse)
library(gagglr)

#clean
comm_tx_excl <- data.frame(im = c(84207, 84207, 84207, 84207,81737, 81759, 70212,70212,70212,70212, 81436), 
                           note = c("Exclude TX_NEW_VERIFY", 
                                      "Exclude TX_NEW_VERIFY",
                                      "Exclude TX_NEW_VERIFY",
                                      "Exclude TX_NEW_VERIFY",
                                      "Exclude TX_NEW_VERIFY",
                                      "Exclude TX_NEW_VERIFY",
                                      "Exclude TX_NEW",
                                      "Exclude TX_NEW",
                                      "Exclude TX_NEW",
                                      "Exclude TX_NEW",
                                      "Exclude TX_NEW_VERIFY"),
                           year = c(2020, 2021, 2022, 2023, 2022, 2022, 2020, 2021, 2022, 2023, 2022)) %>% 
  mutate( fy = str_replace(as.character(year), "^20(?=[0-9]{2})", "FY"),
          disaggregate = "Keypop",
          population = "KP",
          action = str_extract(string = note, "^.+(?=\\s)"), #find characters from start of field, until a space
          indicator = str_extract(string = note, "(?<=\\s).+$")) # find characters after space, until the end of the field

tx_curr_lag2_excl <- data.frame(im = c(17318, 81211, 81211, 81282, 18518, 18518, 85069, 85069, 83017),
                                year= c(2022, 2021, 2022, 2022, 2021, 2022, 2021, 2022, 2022),
                                release = c("", "", "", "", "", "", "", "", "v1."),
                                note  = c("", "", "", "", "", "", "", "", "only missing in pre-clean data")) %>%
  mutate(action = "exclude",
         indicator = "TX_CURR_Lag2",
         action_alternate = "Multiply VLC from All People by proxy VL denominator (TX_CURR_Lag2) to estimate values",
         fy = str_replace(as.character(year), "^20(?=[0-9]{2})", "FY"),
         disaggregate = "Keypop",
         population = "KP")

#Export
comm_tx_excl %>% write_csv("Dataout/kp_community_treatment_reference_table.csv")
tx_curr_lag2_excl %>% write_csv("Dataout/kp_tx_curr_lag2_reference_table.csv")




