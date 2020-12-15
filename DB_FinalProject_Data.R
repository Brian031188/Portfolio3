library(tidyr)

## Scripts to create the data for my sql final project
# country table 
country = c("United States", "Great Britain", "France", "Spain", "Hong Kong")
df = data.frame(country)
write.csv(df, file = "DB_country_data.csv")

# city table
city = c("Chicago", "New York", "Paris", "Westport", "Greenwich", "Omaha", "London")
fk_country_id = c(1, 1, 3, 1, 1, 1, 2)
df = data.frame(city, fk_country_id)
write.csv(df, file = "DB_city_data.csv")

# address table
address = c("1 Glendinning Pl", "800 3rd Ave", "452 5th Ave", "2 Greenwich Plaza", "100 6th Ave",
            "666 5th Ave", "40 W 57th St", "57 E 52nd St", "3555 Farnam St", "131 South Dearborn St")
fk_city_id = c(4, 2, 2, 5, 2, 2, 2, 2, 6, 1)
zipcode = c("06880", "10022", "10018", "06830", "10013", "10103", "10019", "10022", "68131", "60603")
df = data.frame(address, fk_city_id, zipcode)
write.csv(df, file = "DB_address_data.csv")

# investment_firm table
firm_name = c("Bridgewater Associates", "Renaissance Technologies", "Man Group", "AQR Capital Management",
              "Two Sigma Investments", "Millennium Management", "Elliott Management", "BlackRock",
              "Berkshire Hathaway", "Citadel Advisors")
fk_address_id = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
df_investment_firm = data.frame(firm_name, fk_address_id)
write.csv(df_investment_firm, file = "DB_investment_firm_data.csv")

# fund_manager table
fk_firm_id = seq(1, 10, 1)
first_name = c("Bill", "Brian", "Ryan", "Steven", "Matt", "Fujin", 
               "Jesse", "Jane", "Sofia", "Tanya")
last_name = c("Casey", "Forristal", "Papac", "Ruzzini", "Kenyon", 
              "Shimoda", "Ventura", "Doe", "Mae", "Dovidovskaya")
age = c(round(runif(10, 22, 55), 0))
years_of_experience = c(round(runif(10, 2, 10), 0))
df = data.frame(fk_firm_id, first_name, last_name, age, years_of_experience)

fk_firm_id = seq(1, 10, 1)
first_name = c("Bob", "Raymond", "Anthony", "Raynard", "Brendan",
               "Robert", "Beau", "Eric", "Jeremy", "Tom")
last_name = c("Hope", "Sexton", "Cafardi", "Jackson", "Twotones", 
              "Lowski", "Zorgdrager", "Meyers", "McDavitt", "Faulke")
age = c(round(runif(10, 22, 55), 0))
years_of_experience = c(round(runif(10, 2, 10), 0))
df2 = data.frame(fk_firm_id, first_name, last_name, age, years_of_experience)
df_fund_manager = df %>% 
  bind_rows(df2)
write.csv(df_fund_manager, file = "DB_fund_manager_data.csv")

# fund table
fund_id = seq(1, 1000, by = 1)
fk_manager_id = round(runif(1000, 1, 20), 0)
# fund type list
fund_type_list = c("fixed income", "equity", "index", "money market", "specialty")
fund_type = round(runif(1000, 1, 4), 0)
amount = round(rnorm(1000, 2, 0.65), 2)

df_fund = data.frame(fund_id, fk_manager_id, fund_type, amount)
df_fund = df_fund %>% 
  mutate(fund_type = ifelse(fund_type == 1, "fixed income", 
                            ifelse(fund_type == 2, "equity", 
                                   ifelse(fund_type == 3,"money market", "specialty"))))
write.csv(df_fund, file = "DB_fund_data.csv")

# decision_rule table
name = c("High Low", "Fastest Gains", "Cowboy", "No Losers", "Buy Buy Buy", 
         "Pure Alpha", "Beta", "Gains", "Rich Guy", "Bliss")
type = c("High Risk", "High Risk", "High Risk", "Medium Risk", "Medium Risk",
         "Medium Risk", "Medium Risk", "Low Risk", "Low Risk", "Low Risk")

decision_rule = data.frame(name, type)
write.csv(decision_rule, "DB_decision_rule.csv")

# factor table
factor_type = c("Twitter_Sentiment", "Facebook_Sentiment", "News Articles", "Television Reports", "Print Article", "Survey Responses")
influence_weight = c(1/6, 1/6, 1/6, 1/6, 1/6, 1/6)
df = data.frame(factor_type, influence_weight)
write.csv(df, "DB_factor_data.csv")

# decision_factor table
fk_decision_rule_id = round(runif(10000, 1, 10), 0)
fk_factor_id = round(runif(10000, 1,6), 0)
week = round(runif(10000, 1, 52), 0)
df = data.frame(fk_decision_rule_id, fk_factor_id, week)
write.csv(df, "DB_decision_factor_data.csv")

# performance table
set.seed(1)
week = seq(1, 52, by = 1)
decision_to_fund = round(runif(1000, 1, 10), 0)
df2 = data.frame(fund_id = seq(1, 1000, 1), decision_to_fund)
df = expand_grid(week, fund_id)
df3 = df %>% 
  left_join(df2, by = "fund_id")
df3 = df3 %>% 
  mutate(weekly_return = round(rnorm(dim(df3)[1], 0.03, 0.1), 3))
df3 = df3 %>% 
  rename(fk_fund_id = fund_id) %>% 
  rename(fk_decision_id = decision_to_fund)
write.csv(df3, "DB_performance.csv")

df3 %>% 
  filter(fk_fund_id == 3)
