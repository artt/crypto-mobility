import delimited "raw/governance.csv", clear varnames(1) numericcols(5) rowrange(:7705)
drop ïcountryname
rename countrycode country_code
drop seriesname
drop if substr(seriescode, -3, 3) != "EST"
replace seriescode = substr(seriescode, 1, 2)
replace seriescode = "corruption_control" if seriescode == "CC"
replace seriescode = "gov_effectiveness" if seriescode == "GE"
replace seriescode = "political_stability" if seriescode == "PV"
replace seriescode = "reg_quality" if seriescode == "RQ"
replace seriescode = "rule_of_law" if seriescode == "RL"
replace seriescode = "voice_accountability" if seriescode == "VA"
rename yr2020 v_
reshape wide v_, i(country_code) j(seriescode) string
rename v_* *

la var country_code "Country code"
la var corruption_control "Control of corruption"
la var gov_effectiveness "Government effectiveness"
la var political_stability "Political stability"
la var reg_quality "Regulatory quality"
la var rule_of_law "Rule of law"
la var voice_accountability "Voice and accountability"

save "processed/governance.dta", replace
