use "processed/crypto.dta", clear
// TODO: check if this duplicate removal is correct
drop in 153
drop in 88

foreach v in cb_branches gdp_per_cap governance kaopen remittances servers smi weo {
	qui merge 1:1 country_code using "processed/`v'.dta", nogen
}


// process variables

gen ln_inflation = log(1 + inflation/100)
la var ln_inflation "Log of inflation rate"
gen ln_gdp_per_cap = log(gdp_per_cap)
la var ln_gdp_per_cap "Log of GDP per capita"
gen ln_servers = log(servers)
la var ln_servers "Log of secure internet servers per 1M people"
gen ln_crypto_index = log(1 + crypto_index)
la var ln_crypto_index "Log of crypto usage index"

// keep if crypto_index != . & cb_branches != . & gdp_per_cap != . & kaopen != . & remittances != . & servers != . & smi != . & inflation != .

global vars smi_wage_dist ln_inflation ln_gdp_per_cap kaopen cb_branches remittances ln_servers

// cap graph drop $vars
// foreach v in $vars {
// 	qui graph twoway (lfit ln_crypto_index `v') (scatter ln_crypto_index `v'), name(`v') nodraw
// }

// graph combine smi ln_inflation cb_branches ln_gdp_per_cap kaopen remittances


// summary stats

sum ln_crypto_index $vars


// pairwise correlation check: similar to the paper

pwcorr ln_crypto_index $vars, sig star(0.1)
// still need to do robustness check by removing outliers


// regressions
eststo clear
eststo: reg ln_crypto_index corruption_control smi_wage_dist ln_inflation ln_gdp_per_cap kaopen cb_branches remittances ln_servers
eststo: reg ln_crypto_index corruption_control smi_wage_dist ln_inflation ln_gdp_per_cap cb_branches remittances ln_servers
eststo: reg ln_crypto_index corruption_control smi_wage_dist ln_inflation ln_gdp_per_cap cb_branches ln_servers
eststo: reg ln_crypto_index smi_wage_dist ln_inflation ln_gdp_per_cap cb_branches ln_servers
eststo: reg ln_crypto_index smi_wage_dist ln_inflation ln_gdp_per_cap ln_servers
esttab, ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	stats(r2_a N, fmt(3 0) labels("Adjusted \$ R^2\$" "\$ N\$"))
