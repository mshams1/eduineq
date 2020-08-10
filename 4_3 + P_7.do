version 13

/* IrEduIneq */
/* che karhayi inja anjam shode? ....................................... */
/* Mahdi Shams */
/* August 01, 2019 */
/* Where it is? dpbx\Shams_Dissertation */
clear all
clear matrix
set more off
set mem 250m
set matsize 11000
set seed 777

cd "C:\Users\Sony\Dropbox\Shams_Dissertation\Sanjesh_Data"
use "concour95_"

keep if tdip   == 94
quietly{
g ln_nkol1_mean = log(nkol1_mean)

************************** VARIABLES ************************** 
*** sahmn ***
quietly tab sahmn,    g(D_sahmn_)

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

quietly tab area,    g(D_area_)

label define area_lab 1 "a1" 2 "a2" 3 "a3" 4 "a4" 5 "a5" 
label values area area_lab


drop D_sahmn_1
drop D_area_1

regress ln_nkol1_mean i.jnc i.D_sahmn_* i.lang i.D_area_*  [fw=pop] if nkol1_mean > 0 & grh    == 1
estadd beta
estimates store model1

regress ln_nkol1_mean i.jnc i.D_sahmn_* i.lang i.D_area_*  [fw=pop] if nkol1_mean > 0 & grh    == 2
estadd beta
estimates store model2

regress ln_nkol1_mean i.jnc i.D_sahmn_* i.lang i.D_area_*  [fw=pop] if nkol1_mean > 0 & grh    == 3
estadd beta
estimates store model3
}

estout model1 model2 model3, stats(N r2 ) cells(b(star fmt(2)) t(par fmt(2))) ///
starlevels(* 0.10 ** 0.05 *** 0.01) drop( 0.D_sahmn_3 0.D_sahmn_4  0.D_area_3 0.D_area_4 0.D_area_5)  
