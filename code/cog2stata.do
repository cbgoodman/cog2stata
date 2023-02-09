* ==================================
* TITLE: COG2STATA
* Created: 	2022-02-10
* Modified:	2022-02-10
* ==================================

* Description: This .do file imports the flat Census of Governments data files into Stata

set more off
clear all

* GLOBALS
* The $home directory will need to be changed
global home "~/Dropbox/Data/Census of Governments/cog2stata/"
global raw "${home}rawdata/"
global exports "${home}exports/"


********** 2017 ************
* Import 2017 GID -- CHANGE TO MATCH CENSUS FILE NAMES
infile using "${datadir}cog-pid.dct", using("${datadir}2017_individual_unit_file/Fin_PID_2017.txt") clear

* Saving GID as a temporary file
tempfile gid
save `gid'

* Import 2017 raw data -- CHANGE TO MATCH CENSUS FILE NAMES
infile using "${datadir}cog-pu.dct", using("${datadir}2017_Individual_Unit_File/2017FinEstDAT_06102021modp_pu.txt") clear

* Merge 2017 data with GID
merge m:1 id using `gid', nogen
drop if id == "15107907900000" & imp == ""
drop if id == "39204601600000" & imp == ""
drop if id == "39205300300000" & imp == ""

* Start format
drop imp

* Reshape from long to wide
reshape wide amt, i(id) j(item) string
destring amt*, replace

gen idcensus = substr(id, 1, 9)
gen statecode = substr(id, 1, 2)
gen typecode = substr(id, 3, 1)
gen county = substr(id, 4, 3)

rename id census_id
rename idcensus id
destring id, replace

foreach y of varlist amt* {
	replace `y' = 0 if `y' == .
}
