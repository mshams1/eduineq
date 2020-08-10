version 13
quietly{
//capture log close
//log using "C:\Users\Sony\Drop sdbox\Shams_Dissertation\....smcl", replace
/* IrEduIneq */
/* che karhayi inja anjam shode? newyetike by jnc
                                 weight = aw */
/* Mahdi Shams */
/* August  03, 2019 */
/* Where it is? dpbx\Shams_Dissertation */
clear all
set more off
cd "C:\Users\Sony\Dropbox\Shams_Dissertation\Sanjesh_Data"
use "concour95_"

keep if nkol1_mean > 0
keep if tdip == 94
*** lang ***
g       lang = 0
replace lang = 1 if opish_name == "azar_E"   | opish_name == "azar_W"      | opish_name == "ardebil" | opish_name == "zanjan" | ///
                    opish_name == "lorestan" | opish_name == "chaharmahal" | opish_name == "kohkiluyeh" | ///
                    opish_name == "kordestan"| opish_name == "kermanshah"  | opish_name == "ilam"       | ///
                    opish_name == "sistan" |   ///
                    opish_name == "khuzestan"| opish_name == "khorasan_N" | opish_name == "hamedan"

label define lang_lab 0 "farsi" 1 "not_farsi" 
label values lang lang_lab

*** area ***
g       area = .
replace area = 1 if opish_name == "tehran"    | opish_name == "semnan"    | opish_name == "qazvin"         | opish_name == "qom"        | opish_name == "alborz"
replace area = 2 if opish_name == "esfahan"   | opish_name == "fars"      | opish_name == "bushehr"        | opish_name == "chaharmahal"| opish_name == "hormozgan"| opish_name == "kohkiluyeh"            
replace area = 3 if opish_name == "azar_E"    | opish_name == "azar_W"    | opish_name == "ardebil"        | opish_name == "zanjan"     | opish_name == "gilan"    | opish_name == "kordestan" |opish_name == "mazandaran" | opish_name == "golestan" 
replace area = 4 if opish_name == "kermanshah"| opish_name == "ilam"      | opish_name == "lorestan"       | opish_name == "hamedan"    | opish_name == "markazi"  | opish_name == "khuzestan"                 
replace area = 5 if opish_name == "khorasan_N"| opish_name == "khorasan_S"| opish_name == "khorasan_razavi"| opish_name == "kerman"     | opish_name == "yazd"     | opish_name == "sistan"           

label define area_lab 1 "a1" 2 "a2" 3 "a3" 4 "a4" 5 "a5" 
label values area area_lab



forvalues num2 = 1/3{

local diplom = `num2'+9

noisily di "grh == `num2' & no_dip == `diplom'"	
quietly summ pop if grh == `num2' & no_dip == `diplom'
scalar tot_pop = r(sum)

g popshare=. 
forvalues num = 0/1{
quietly summ pop if jnc == `num' & grh == `num2' & no_dip == `diplom' ,detail
replace popshare   = r(sum)/tot_pop    if jnc == `num'
}
noisily tabdisp jnc, cell(popshare) center format(%9.2f)
drop popshare 

g popshare=. 
forvalues num = 1/4{
quietly summ pop if sahmn == `num' & grh == `num2' & no_dip == `diplom' ,detail
replace popshare   = r(sum)/tot_pop    if sahmn == `num' 
}
noisily tabdisp sahmn, cell(popshare) center format(%9.2f)
drop popshare

g popshare=. 
forvalues num = 0/1{
quietly summ pop if lang == `num' & grh == `num2' & no_dip == `diplom',detail
replace popshare   = r(sum)/tot_pop    if lang == `num' 
}
noisily tabdisp lang, cell(popshare) center format(%9.2f)
drop popshare

g popshare=. 
forvalues num = 1/5{
quietly summ pop if area == `num' & grh == `num2' & no_dip == `diplom' ,detail
replace popshare   = r(sum)/tot_pop    if area == `num' 
}
noisily tabdisp area, cell(popshare) center format(%9.2f)
drop popshare

noisily di tot_pop
}
