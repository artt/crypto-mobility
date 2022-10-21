use "raw/kaopen_2020.dta", clear
rename ccode country_code
keep if year == 2020
keep country_code kaopen
la var country_code "Country code"
save "processed/kaopen.dta", replace
