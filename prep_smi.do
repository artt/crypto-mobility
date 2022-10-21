// process smi data from raw

set more off
use "raw/smi.dta", clear
rename index country_code
la var country_code "Country code"
la var smi "Social mobility index"
save "processed/smi.dta", replace
