import delimited /Users/artt/GitHub/crypto/raw/WEOOct2022all.csv, encoding(utf8) clear varnames(1) numericcols(10/57) rowrange(:8625)
keep if weosubjectcode == "LP" | weosubjectcode == "PCPIPCH"
keep iso weosubjectcode v41-v50
egen v = rowmean(v41-v50) if weosubjectcode == "PCPIPCH"
replace v = v50 if weosubjectcode == "LP"
drop v41-v50
reshape wide v, i(iso) j(weosubjectcode) string
rename iso country_code
rename vLP population
rename vPCPIPCH inflation
la var country_code "Country code"
la var population "Population"
la var inflation "Average CPI inflation 2011–2020"
save "processed/weo.dta", replace
