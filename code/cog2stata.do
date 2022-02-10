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
