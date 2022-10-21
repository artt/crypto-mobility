// servers

import delimited "raw/servers.csv", varnames(4) clear
keep countrycode v65
rename countrycode country_code
rename v65 servers
la var country_code "Country code"
la var servers "Secure internet servers per 1M population"
save "processed/servers.dta", replace


// cb_branches

import delimited "raw/cb_branches.csv", varnames(4) clear
keep countrycode v65
rename countrycode country_code
rename v65 cb_branches
la var country_code "Country code"
la var cb_branches "Commercial bank branches per 100K population"
save "processed/cb_branches.dta", replace


// remittances

import delimited "raw/remittances.csv", varnames(4) clear
keep countrycode v62-v64
egen remittances = rowmean(v62-v64)
drop v*
rename countrycode country_code
la var country_code "Country code"
la var remittances "Average remittances per GDP, 2017–19"
save "processed/remittances.dta", replace


// gdp per cap

import delimited "raw/gdp_per_cap.csv", varnames(4) clear
keep countrycode v65
rename countrycode country_code
rename v65 gdp_per_cap
la var country_code "Country code"
la var gdp_per_cap "GDP per capita, constant PPP"
save "processed/gdp_per_cap.dta", replace
