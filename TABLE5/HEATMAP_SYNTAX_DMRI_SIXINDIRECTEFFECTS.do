cd "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\May Baydoun_folder\UK_BIOBANK_PROJECT\UKB_PAPER5_RACESESMRI_SUBCORT_DMRI\MANUSCRIPTS\DMRI\TABLE5"
use SEM_FINDINGS_SIXINDIRECTEFFECTS_FA, clear

**COLLAPSE MEAN ESTIMATES AND VARIANCES**
collapse (mean) *_est percent_mediated_nonwhite z_de_nonwhite z_ie_nonwhite z_te_nonwhite p_de_nonwhite p_ie_nonwhite p_te_nonwhite sd_roi te_nonwhite_st ie_nonwhite_st de_nonwhite_st var* z_ie1_nonwhite z_ie2_nonwhite z_ie3_nonwhite z_ie4_nonwhite z_ie5_nonwhite z_ie6_nonwhite p_ie1_nonwhite p_ie2_nonwhite p_ie3_nonwhite p_ie4_nonwhite p_ie5_nonwhite p_ie6_nonwhite ie1_nonwhite_st ie2_nonwhite_st ie3_nonwhite_st ie4_nonwhite_st ie5_nonwhite_st ie6_nonwhite_st pm1_nonwhite pm2_nonwhite pm3_nonwhite pm4_nonwhite pm5_nonwhite pm6_nonwhite, by(id)

save HEATMAP_DATA_DMRI_SIXIEcollapsed, replace


**GET ROI LABELS AND MERGE THEM WITH COLLAPSED FILE**

use SEM_FINDINGS_SIXINDIRECTEFFECTS_FA, clear
keep  if imputation==1
keep id roi
save ROI_LABELS_ID, replace
sort id
save, replace

use HEATMAP_DATA_DMRI_SIXIEcollapsed
sort id
save, replace

use  ROI_LABELS_ID,clear
merge id using HEATMAP_DATA_DMRI_SIXIEcollapsed
save HEATMAP_DATA_DMRI_SIXIEcollapsedfin, replace

****GENERATE STANDARD ERRORS FROM VARIANCES****
su var_*

foreach x of varlist var_* {
	gen se`x'=sqrt(`x')
}

capture rename sevar* se*

save, replace

****GENERATE Z-SCORE*****
**z_de_nonwhite z_ie_nonwhite z_te_nonwhite z_de_ses z_ie_ses z_te_ses




replace z_de_nonwhite=de_nonwhite_est/se_de_nonwhite
replace z_ie_nonwhite=ie_nonwhite_est/se_ie_nonwhite
replace z_te_nonwhite=te_nonwhite_est/se_te_nonwhite

replace z_ie1_nonwhite=ie1_nonwhite_est/se_ie1_nonwhite
replace z_ie2_nonwhite=ie2_nonwhite_est/se_ie2_nonwhite
replace z_ie3_nonwhite=ie3_nonwhite_est/se_ie3_nonwhite
replace z_ie4_nonwhite=ie4_nonwhite_est/se_ie4_nonwhite
replace z_ie5_nonwhite=ie5_nonwhite_est/se_ie5_nonwhite
replace z_ie6_nonwhite=ie6_nonwhite_est/se_ie6_nonwhite


************GENERATE P-VALUES*******************

replace p_de_nonwhite=2*normal(-abs(z_de_nonwhite))
replace p_ie_nonwhite=2*normal(-abs(z_ie_nonwhite))
replace p_te_nonwhite=2*normal(-abs(z_te_nonwhite))

replace p_ie1_nonwhite=2*normal(-abs(z_ie1_nonwhite))
replace p_ie2_nonwhite=2*normal(-abs(z_ie2_nonwhite))
replace p_ie3_nonwhite=2*normal(-abs(z_ie3_nonwhite))
replace p_ie4_nonwhite=2*normal(-abs(z_ie4_nonwhite))
replace p_ie5_nonwhite=2*normal(-abs(z_ie5_nonwhite))
replace p_ie6_nonwhite=2*normal(-abs(z_ie6_nonwhite))




save, replace


capture log close


***************************HEATMAP*******************************

tab1 roi ie1_nonwhite_st p_ie1_nonwhite ie2_nonwhite_st p_ie2_nonwhite ie3_nonwhite_st p_ie3_nonwhite ie4_nonwhite_st p_ie4_nonwhite ie5_nonwhite_st p_ie5_nonwhite ie6_nonwhite_st p_ie6_nonwhite 

sort id


capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\May Baydoun_folder\UK_BIOBANK_PROJECT\UKB_PAPER5_RACESESMRI_SUBCORT_DMRI\OUTPUT\HEATMAPSIXINDIRECT_FA.smcl"

list roi ie1_nonwhite_st p_ie1_nonwhite ie2_nonwhite_st p_ie2_nonwhite ie3_nonwhite_st p_ie3_nonwhite ie4_nonwhite_st p_ie4_nonwhite ie5_nonwhite_st p_ie5_nonwhite ie6_nonwhite_st p_ie6_nonwhite 

capture log close

capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\May Baydoun_folder\UK_BIOBANK_PROJECT\UKB_PAPER5_RACESESMRI_SUBCORT_DMRI\OUTPUT\TABLE5_DMRI.smcl"

use HEATMAP_DATA_DMRI_SIXIEcollapsedfin,clear

list roi sd_roi ie1_nonwhite_est se_ie1_nonwhite p_ie1_nonwhite  ie2_nonwhite_est se_ie2_nonwhite p_ie2_nonwhite ie3_nonwhite_est se_ie3_nonwhite p_ie3_nonwhite ie4_nonwhite_est se_ie4_nonwhite p_ie4_nonwhite ie5_nonwhite_est se_ie5_nonwhite p_ie5_nonwhite ie6_nonwhite_est se_ie6_nonwhite p_ie6_nonwhite  

save, replace
     
