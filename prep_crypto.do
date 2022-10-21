// use "raw/crypto_2020.dta", clear
// kountry country_code, from(iso2c) to(iso3c)
// drop country country_code ranking_2020
// rename _ISO3C_ country_code
// order country_code, first
// keep country_code index_2020
// rename index_2020 crypto_index

// la var country_code "Country code"
// la var crypto_index "Crypto usage index"

// save "processed/crypto.dta", replace




use "raw/crypto_2021.dta", clear
kountry country_code, from(iso2c) to(iso3c)
drop country country_code ranking
rename _ISO3C_ country_code
order country_code, first
keep country_code index
rename index crypto_index

la var country_code "Country code"
la var crypto_index "Crypto usage index"

save "processed/crypto.dta", replace
