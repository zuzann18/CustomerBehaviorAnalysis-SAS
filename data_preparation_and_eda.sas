data train;
set 'C:\Users\zuzan\Desktop\sgh\SAAS\SAS\projekt\abt_sam_beh_train.sas7bdat';
run;

data valid;
set 'C:\Users\zuzan\Desktop\sgh\SAAS\SAS\projekt\abt_sam_beh_valid.sas7bdat';
run;


proc contents data=train directory details;
title 'Train - Overview';
run;

proc freq data=train;
title "Podgląd zmiennych tekstowych w zbiorze train";
table app_char_cars app_char_city app_char_home_status app_char_job_code app_char_marital_status /nocum;
run;

data tr2;
set train;
keep period cid default:;
run;

proc sql;
select count(distinct period)
from tr2;
quit;

proc sql;
select distinct default_cus3, default_cus6, default_cus9, default_cus12
from tr2;
quit;

/*znakowanie "I" jako braków danych*/
data tr3;
set tr2;
if strip(default_cus3) = "I" then default_cus3=.;
if strip(default_cus6) = "I" then default_cus6=.;
if strip(default_cus9) = "I" then default_cus9=.;
if strip(default_cus12) = "I" then default_cus12=.;
run;

/* sprawdzenie charakterystycznych zmiennych - tekstowych oraz zmiennej reprezentującej wiek*/
data tra1;
set train;
keep act_cus_loan_number act_age app:;
run;

proc univariate data=tra1;
histogram act_age/normal;
run; 

proc freq data=tra1;
table act_cus_loan_number /nocum;
run;

proc univariate data=tra1;
var app_income app_number_of_children app_spendings;
histogram app_income app_number_of_children app_spendings /normal;
run; 

proc means data=tra1 n nmiss mean std;
   var act_age app_income app_number_of_children app_spendings;
output out=tra_stat;
run;


/*VALID*/


proc contents data=valid directory details;
title 'Valid - Overview';
run;

proc freq data=valid;
title "Podgląd zmiennych tekstowych w zbiorze valid";
table app_char_cars app_char_city app_char_home_status app_char_job_code app_char_marital_status /nocum;
run;

data val2;
set valid;
keep period cid default:;
run;

proc sql;
select count(distinct period)
from val2;
quit;

proc sql;
select distinct default_cus3, default_cus6, default_cus9, default_cus12
from val2;
quit;

/*znakowanie "I" jako braków danych*/
data val3;
set val2;
if strip(default_cus3) = "I" then default_cus3=.;
if strip(default_cus6) = "I" then default_cus6=.;
if strip(default_cus9) = "I" then default_cus9=.;
if strip(default_cus12) = "I" then default_cus12=.;
run;

/* sprawdzenie charakterystycznych zmiennych - tekstowych oraz zmiennej reprrzentującej wiek*/
data val1;
set valid;
keep act_cus_loan_number act_age app:;
run;

proc freq data=val1;
table act_cus_loan_number /nocum;
run;

/*sprawdzenie rozkładu zmiennej wieku*/
proc univariate data=val1;
histogram act_age/normal;
run;  /* nie ma zmiennych odbiegających od spodziewanego wieku */


/*sprawdzamy rozkład pozostałych charakterystycznych zmiennych*/
proc univariate data=val1;
var app_income app_number_of_children app_spendings;
histogram app_income app_number_of_children app_spendings /normal;
run; 

proc means data=val1 n nmiss mean std;
   var act_age app_income app_number_of_children app_spendings;
output out=val_stat;
run;



/*%let outlie_vars =   						 period*/
/*											 act_state_16_CMin_Due*/
/*                                             act_state_18_CMin_Due*/
/*                                             act_state_19_CMin_Due*/
/*                                             act_state_17_CMin_Due*/
/*                                             act_state_15_CMin_Due*/
/*                                             act_state_20_CMin_Due*/
/*                                             act_state_14_CMin_Due*/
/*                                             act_state_21_CMin_Due*/
/*                                             act_cus_n_statB  */
/*                                             act_state_13_CMin_Due  */
/*                                             act_state_16_CMax_Due  */
/*                                             act_state_15_CMax_Due  */
/*                                             act_state_14_CMax_Due   */
/*                                             act_state_17_CMax_Due   */
/*                                             act_state_12_CMin_Due   */
/*                                             act_state_13_CMax_Due   */
/*                                             act_state_18_CMax_Due*/
/*                                             act_state_22_CMin_Due  */
/*                                             act_state_12_CMax_Due   */
/*                                             act_state_19_CMax_Due   */
/*                                             act_state_11_CMax_Due  */
/*                                             act_state_11_CMin_Due   */
/*                                             act_state_10_CMax_Due   */
/*                                             act_state_20_CMax_Due   */
/*                                             act_state_10_CMin_Due   */
/*                                             act_state_9_CMax_Due    */
/*                                             act_state_23_CMin_Due  */
/*                                             act_state_9_CMin_Due   */
/*                                             act_state_8_CMax_Due     */
/*                                             act_state_21_CMax_Due  */
/*                                             act_state_7_CMax_Due*/
/*                                             act_state_8_CMin_Due  */
/*                                             act_state_6_CMax_Due   */
/*                                             act_state_22_CMax_Due*/
/*                                             act_state_24_CMin_Due*/
/*                                             act_state_7_CMin_Due  */
/*                                             act_state_5_CMax_Due   */
/*                                             act_cus_n_statC     */
/*                                             act_state_6_CMin_Due  */
/*                                             act_state_23_CMax_Due   */
/*                                             act_state_4_CMax_Due    */
/*                                             act_state_5_CMin_Due  */
/*                                             act_state_25_CMin_Due  */
/*                                             act_state_36_CMin_Due  */
/*                                             act_state_3_CMax_Due   */
/*                                             act_state_4_CMin_Due   */
/*                                             act_state_35_CMin_Due*/
/*                                             act_state_33_CMin_Due   */
/*                                             act_state_32_CMin_Due  */
/*                                             act_state_24_CMax_Due  */
/*                                             act_state_31_CMin_Due   */
/*                                             act_state_34_CMin_Due   */
/*                                             act_state_30_CMin_Due  */
/*                                             act_state_26_CMin_Due */
/*                                             act_state_29_CMin_Due */
/*                                             act_state_27_CMin_Due   */
/*                                             act_state_28_CMin_Due  */
/*                                             act_state_3_CMin_Due  */
/*                                             act_state_2_CMax_Due  */
/*                                             act_state_2_CMin_Due  */
/*                                             act_CMin_Due         */
/*                                             act_state_1_CMin_Due   */
/*                                             act_state_25_CMax_Due */
/*                                             act_cus_dueutl      */
/*                                             act_CMax_Due        */
/*                                             act_state_1_CMax_Due  */
/*                                             act_state_36_CMax_Due*/
/*                                             act_cus_seniority     */
/*                                             app_spendings           */
/*                                             act_cus_n_loans_hist   */
/*																	;*/
/**/
/*data tr_per;*/
/*set train;*/
/*keep &outlie_vars.;*/
/*run;*/



/*TRAIN*/

filename remove temp;

data abc;
 file remove;
 if 0 then set train;
 length varname $32;
do until (varname='varname');
  call vnext(varname);
  if index(varname,'Ciev') then put varname;  /*zapis nazw zmiennych do tymczasowego pliku*/
  if index(varname,'Cncr') then put varname; 
  if index(varname,'arrears') then put varname; 
end; 
run;

proc freq data=train;
table 
act3_n_cind_arrears
act6_n_cind_arrears
act9_n_cind_arrears
act12_n_cind_arrears
act15_n_cind_arrears
act18_n_cind_arrears
act21_n_cind_arrears
act24_n_cind_arrears
act27_n_cind_arrears
act30_n_cind_arrears
act33_n_cind_arrears
act36_n_cind_arrears
act_state_1_Cncr
act_state_2_Cncr
act_state_3_Cncr
act_state_4_Cncr
act_state_5_Cncr
act_state_6_Cncr
act_state_7_Cncr
act_state_8_Cncr
act_state_9_Cncr
act_state_10_Cncr
act_state_11_Cncr
act_state_12_Cncr
act_state_13_Cncr
act_state_14_Cncr
act_state_15_Cncr
act_state_16_Cncr
act_state_17_Cncr
act_state_18_Cncr
act_state_19_Cncr
act_state_20_Cncr
act_state_21_Cncr
act_state_22_Cncr
act_state_23_Cncr
act_state_24_Cncr
act_state_25_Cncr
act_state_26_Cncr
act_state_27_Cncr
act_state_28_Cncr
act_state_29_Cncr
act_state_30_Cncr
act_state_31_Cncr
act_state_32_Cncr
act_state_33_Cncr
act_state_34_Cncr
act_state_35_Cncr
act_state_36_Cncr
act_Cncr
act3_Cncr_taken
act3_Ciev_work
act3_Ciev_health
act3_Ciev_family
act3_Ciev_home
act3_Ciev_all
act6_Cncr_taken
act6_Ciev_work
act6_Ciev_health
act6_Ciev_family
act6_Ciev_home
act6_Ciev_all
act9_Cncr_taken
act9_Ciev_work
act9_Ciev_health
act9_Ciev_family
act9_Ciev_home
act9_Ciev_all
act12_Cncr_taken
act12_Ciev_work
act12_Ciev_health
act12_Ciev_family
act12_Ciev_home
act12_Ciev_all
act15_Cncr_taken
act15_Ciev_work
act15_Ciev_health
act15_Ciev_family
act15_Ciev_home
act15_Ciev_all
act18_Cncr_taken
act18_Ciev_work
act18_Ciev_health
act18_Ciev_family
act18_Ciev_home
act18_Ciev_all
act21_Cncr_taken
act21_Ciev_work
act21_Ciev_health
act21_Ciev_family
act21_Ciev_home
act21_Ciev_all
act24_Cncr_taken
act24_Ciev_work
act24_Ciev_health
act24_Ciev_family
act24_Ciev_home
act24_Ciev_all
act27_Cncr_taken
act27_Ciev_work
act27_Ciev_health
act27_Ciev_family
act27_Ciev_home
act27_Ciev_all
act30_Cncr_taken
act30_Ciev_work
act30_Ciev_health
act30_Ciev_family
act30_Ciev_home
act30_Ciev_all
act33_Cncr_taken
act33_Ciev_work
act33_Ciev_health
act33_Ciev_family
act33_Ciev_home
act33_Ciev_all
act36_Cncr_taken
act36_Ciev_work
act36_Ciev_health
act36_Ciev_family
act36_Ciev_home
act36_Ciev_all /nocum;
run;

data train2;
set train;
drop %include remove;; 
run;

proc means data=train2 range qrange var std cv;
title "Współczynnik zmienności w zbiorze train";
output out= train_CV cv=;
run;

data cv;
set train_cv;
STAT= "Coef_Var";
nobs=_FREQ_;
drop _FREQ_ _TYPE_;
run;

proc transpose data=cv out=cv_T;
var _all_;
id STAT;
run;

/* oznaczenie zmiennych o bardzo dużej zmienności */
data cv2;
set cv_T (rename=(_NAME_=variable));
CV=input(coef_var,best.);
if variable ^="nobs" then do;
if CV > 100 then a=1;else a=0;
end;
if variable = "STAT" then delete;
drop coef_var;
proc sort; by descending CV;
run;

/* obliczenie liczby zmiennych o CV > 100 */
proc sql;
select sum(a)INTO: sumt
from cv2;
quit; 

%macro suma;

/* jaką część zbioru stanowią zmiennej o bardzo dużym zróżnicowaniu? */
data cv3;
set cv2;
if variable = "nobs" then do;
out_var=&sumt./cv;
out_var_perc = input(out_var*100,4.2)||"%";
end;
run;

%mend;

%suma;

/* liczba zmiennych w zbiorze*/
/*proc sql;*/
/*select count (variable)*/
/*from cv4;*/
/*quit;*/


/*VALID*/

filename remove temp;

data abc;
 file remove;
 if 0 then set valid;
 length varname $32;
do until (varname='varname');
  call vnext(varname);
  if index(varname,'Ciev') then put varname; 
  if index(varname,'Cncr') then put varname; 
  if index(varname,'arrears') then put varname; 
end; 
run;

proc freq data=valid;
table 
act3_n_cind_arrears
act6_n_cind_arrears
act9_n_cind_arrears
act12_n_cind_arrears
act15_n_cind_arrears
act18_n_cind_arrears
act21_n_cind_arrears
act24_n_cind_arrears
act27_n_cind_arrears
act30_n_cind_arrears
act33_n_cind_arrears
act36_n_cind_arrears
act_state_1_Cncr
act_state_2_Cncr
act_state_3_Cncr
act_state_4_Cncr
act_state_5_Cncr
act_state_6_Cncr
act_state_7_Cncr
act_state_8_Cncr
act_state_9_Cncr
act_state_10_Cncr
act_state_11_Cncr
act_state_12_Cncr
act_state_13_Cncr
act_state_14_Cncr
act_state_15_Cncr
act_state_16_Cncr
act_state_17_Cncr
act_state_18_Cncr
act_state_19_Cncr
act_state_20_Cncr
act_state_21_Cncr
act_state_22_Cncr
act_state_23_Cncr
act_state_24_Cncr
act_state_25_Cncr
act_state_26_Cncr
act_state_27_Cncr
act_state_28_Cncr
act_state_29_Cncr
act_state_30_Cncr
act_state_31_Cncr
act_state_32_Cncr
act_state_33_Cncr
act_state_34_Cncr
act_state_35_Cncr
act_state_36_Cncr
act_Cncr
act3_Cncr_taken
act3_Ciev_work
act3_Ciev_health
act3_Ciev_family
act3_Ciev_home
act3_Ciev_all
act6_Cncr_taken
act6_Ciev_work
act6_Ciev_health
act6_Ciev_family
act6_Ciev_home
act6_Ciev_all
act9_Cncr_taken
act9_Ciev_work
act9_Ciev_health
act9_Ciev_family
act9_Ciev_home
act9_Ciev_all
act12_Cncr_taken
act12_Ciev_work
act12_Ciev_health
act12_Ciev_family
act12_Ciev_home
act12_Ciev_all
act15_Cncr_taken
act15_Ciev_work
act15_Ciev_health
act15_Ciev_family
act15_Ciev_home
act15_Ciev_all
act18_Cncr_taken
act18_Ciev_work
act18_Ciev_health
act18_Ciev_family
act18_Ciev_home
act18_Ciev_all
act21_Cncr_taken
act21_Ciev_work
act21_Ciev_health
act21_Ciev_family
act21_Ciev_home
act21_Ciev_all
act24_Cncr_taken
act24_Ciev_work
act24_Ciev_health
act24_Ciev_family
act24_Ciev_home
act24_Ciev_all
act27_Cncr_taken
act27_Ciev_work
act27_Ciev_health
act27_Ciev_family
act27_Ciev_home
act27_Ciev_all
act30_Cncr_taken
act30_Ciev_work
act30_Ciev_health
act30_Ciev_family
act30_Ciev_home
act30_Ciev_all
act33_Cncr_taken
act33_Ciev_work
act33_Ciev_health
act33_Ciev_family
act33_Ciev_home
act33_Ciev_all
act36_Cncr_taken
act36_Ciev_work
act36_Ciev_health
act36_Ciev_family
act36_Ciev_home
act36_Ciev_all /nocum;
run;

data valid2;
set valid;
drop %include remove;; 
run;

proc means data=valid range qrange var std cv;
title "Współczynnik zmienności w zbiorze valid";
output out= valid_CV cv=;
run;

data cvv;
set valid_cv;
STAT= "Coef_Var";
nobs=_FREQ_;
drop _FREQ_ _TYPE_;
run;

proc sql;
select nobs INTO: nobs_v
from cvv;
quit; 

proc transpose data=cvv out=cvv_T;
var _all_;
id STAT;
run;

data cvv2;
set cvv_T (rename=(_NAME_=variable));
CV_v=input(coef_var,best.);
if variable ^="nobs" then do;
if CV_v > 100 then av=1;else av=0;
end;
if variable = "STAT" then delete;
drop coef_var;
proc sort; by descending CV_v;
run;

/*obliczenie liczby zmiennych o dużym zróżnicowaniu*/
proc sql;
select sum(av) INTO: sumv
from cvv2;
quit; 

%macro suma;

data cvv3;
set cvv2;
if variable = "nobs" then do;
out_var=&sumv./&nobs_v.;
out_var_perc = input(out_var*100,4.2)||"%";
end;
run;

%mend;

%suma;

/*proc sql;*/
/*select count (variable)*/
/*from cvv3;*/
/*quit;*/


/* TRAIN vs VALID*/

proc sql;
create table trval as
select a.*, b.cv_v, b.av
from cv2 a JOIN cvv2 b
on a.variable=b.variable;
quit;

data alls check;
set trval;
if a=av then flag=1; else flag=0;
if flag=1 then output alls;
if flag=0 then output check; /*różnice między zróżnicowaniem zmiennych na dwóch zbiorach: brak */
run;


/* lista zmiennych mało zróżnicowanych na obu zbiorach */
proc sql;
select variable, CV, CV_v from alls
where flag=1 and a=0
order by CV desc;
quit;

/* lista zmiennych bardzo zróżnicowanych na obu zbiorach */
proc sql;
select variable, CV, CV_v from alls
where flag=1 and a=1
order by CV desc;
quit;

******************************checks;

%let keepvars = 
                                             act_state_16_CMin_Due
                                             act_state_18_CMin_Due
                                             act_state_19_CMin_Due
                                             act_state_17_CMin_Due
                                             act_state_15_CMin_Due
                                             act_state_20_CMin_Due
                                             act_state_14_CMin_Due
                                             act_state_21_CMin_Due
                                             act_cus_n_statB  
                                             act_state_13_CMin_Due  
                                             act_state_16_CMax_Due  
                                             act_state_15_CMax_Due  
                                             act_state_14_CMax_Due   
                                             act_state_17_CMax_Due   
                                             act_state_12_CMin_Due   
                                             act_state_13_CMax_Due   
                                             act_state_18_CMax_Due
                                             act_state_22_CMin_Due  
                                             act_state_12_CMax_Due   
                                             act_state_19_CMax_Due   
                                             act_state_11_CMax_Due  
                                             act_state_11_CMin_Due   
                                             act_state_10_CMax_Due   
                                             act_state_20_CMax_Due   
                                             act_state_10_CMin_Due   
                                             act_state_9_CMax_Due    
                                             act_state_23_CMin_Due  
                                             act_state_9_CMin_Due   
                                             act_state_8_CMax_Due     
                                             act_state_21_CMax_Due  
                                             act_state_7_CMax_Due
                                             act_state_8_CMin_Due  
                                             act_state_6_CMax_Due   
                                             act_state_22_CMax_Due
                                             act_state_24_CMin_Due
                                             act_state_7_CMin_Due  
                                             act_state_5_CMax_Due   
                                             act_cus_n_statC     
                                             act_state_6_CMin_Due  
                                             act_state_23_CMax_Due   
                                             act_state_4_CMax_Due    
                                             act_state_5_CMin_Due  
                                             act_state_25_CMin_Due  
                                             act_state_36_CMin_Due  
                                             act_state_3_CMax_Due   
                                             act_state_4_CMin_Due   
                                             act_state_35_CMin_Due
                                             act_state_33_CMin_Due   
                                             act_state_32_CMin_Due  
                                             act_state_24_CMax_Due  
                                             act_state_31_CMin_Due   
                                             act_state_34_CMin_Due   
                                             act_state_30_CMin_Due  
                                             act_state_26_CMin_Due 
                                             act_state_29_CMin_Due 
                                             act_state_27_CMin_Due   
                                             act_state_28_CMin_Due  
                                             act_state_3_CMin_Due  
                                             act_state_2_CMax_Due  
                                             act_state_2_CMin_Due  
                                             act_CMin_Due         
                                             act_state_1_CMin_Due   
                                             act_state_25_CMax_Due 
                                             act_cus_dueutl      
                                             act_CMax_Due        
                                             act_state_1_CMax_Due  
                                             act_state_36_CMax_Due  
                                             act_state_35_CMax_Due
                                             act_state_34_CMax_Due   
                                             act_state_26_CMax_Due  
                                             act_state_33_CMax_Due   
                                             act_state_29_CMax_Due   
                                             act_state_32_CMax_Due  
                                             act_state_31_CMax_Due 
                                             act_state_30_CMax_Due   
                                             act_state_28_CMax_Due   
                                             act_state_27_CMax_Due
                                             act_cus_seniority     
                                             app_spendings           
                                             act_cus_n_loans_hist   
																	;

/*TRAIN*/

data train_outliers;
set train;
keep &keepvars.;
run;

proc means data=train_outliers mean std noprint;
var &keepvars.;
output out=trout_stat (drop=_FREQ_ _TYPE_);
run;

proc transpose data=trout_stat out=trout_T;
var _all_;
id _STAT_;
run;

data tra2;
set trout_T (rename=(_NAME_=variable));
if variable="_STAT_" then delete;
N_=input(n,best.);
MIN_=input(min,best.);
MAX_=input(max,best.);
MEAN_=input(mean,best.);
STD_=input(std,best.);
lower = mean_-3*std_;  /*!*/
upper = mean_+3*std_; 
if min > lower and max < upper then flag = "OK";
up_outliers= max_-upper;
low_outliers= min_-lower;  
range= max-min;
drop n min max mean std;
run;

data tra3;
set tra2;
if flag = "OK" then delete;
up_out_perc= round((up_outliers/range) *100,.01); 
low_out_perc= round((low_outliers/range) *100,.01); 
perc_all = 	round(((up_outliers + low_outliers)/range)*100,.01);
run;

proc sql;
select variable, perc_all
from tra3
order by perc_all desc;
quit;


****VALID;


data valid_outliers;
set valid;
keep &keepvars.;
run;

proc means data=valid_outliers mean std noprint;
var &keepvars.;
output out=valout_stat (drop=_FREQ_ _TYPE_);
run;

proc transpose data=valout_stat out=valout_T;
var _all_;
id _STAT_;
run;

data val2;
set valout_T (rename=(_NAME_=variable));
if variable="_STAT_" then delete;
N_=input(n,best.);
MIN_=input(min,best.);
MAX_=input(max,best.);
MEAN_=input(mean,best.);
STD_=input(std,best.);
lower = mean_-3*std_;
upper = mean_+3*std_;
if min > lower and max < upper then flag = "OK";
up_outliers= max_-upper;
low_outliers= min_-lower;
range= max-min;
drop n min max mean std;
run;

data val3;
set val2;
if flag = "OK" then delete;
up_out_perc= round((up_outliers/range) *100,.01); 
low_out_perc= round((low_outliers/range) *100,.01); 
perc_all_v = round(((up_outliers + low_outliers)/range)*100,.01);
run;

proc sql;
select variable, perc_all_v
from val3
order by perc_all_v desc;
quit;


/* TRAIN vs VALID */

/*zmienne, które mają wartości odstając na obu zbiorach*/
proc sql;
create table trval2 as
select a.variable, a.perc_all, b.perc_all_v
from tra3 a JOIN val3 b
on a.variable=b.variable
order by perc_all desc;
quit;
/*procent zmiennych odstających w danej zmiennej jest bardzo podobny dla zbioru train i valid*/


/***************sprawdzenie wybranych zmiennych***********/

/*train*/

data trval3;
set train_outliers;
keep act_state_9_CMin_Due act_state_10_CMin_Due act_state_12_CMin_Due act_state_11_CMin_Due 
	 act_cus_n_loans_hist act_cus_n_statB act_state_27_CMin_Due act_state_34_CMin_Due;
run;

/*sprawdzenie zmiennych o zawartości wartości odstających > 93 % oraz dwóch zmiennych losowo
wybranych o mniej zawartości*/

proc univariate data=trval3;
var _all_;
histogram _ALL_ /normal;
run; 

/*wykres pudełkowy dla zmiennej o najwyższej zawartości obserwacji odstających*/
proc sgplot data=train_outliers;
vbox act_cus_n_statB;
run;


/*valid*/

data trval4;
set valid_outliers;
keep act_state_9_CMin_Due act_state_10_CMin_Due act_state_12_CMin_Due act_state_11_CMin_Due 
	 act_cus_n_loans_hist act_cus_n_statB act_state_27_CMin_Due act_state_34_CMin_Due;
run;

/*sprawdzenie zmiennych o zawartości wartości odstających > 93 % oraz dwóch zmiennych losowo
wybranych o mniej zawartości*/

proc univariate data=trval4;
var _all_;
histogram _ALL_ /normal;
run; 

/*wykres pudełkowy dla zmiennej o najwyższej zawartości obserwacji odstających*/
proc sgplot data=valid_outliers;
vbox act_cus_n_statB;
run;

****************periods;

/*train*/

/* stworzenie zbioru z wcześniej wybranymi zmiennymi*/
data train_out;
set tra2;
if variable in ("act_state_9_CMin_Due", "act_state_10_CMin_Due", "act_state_12_CMin_Due", "act_state_11_CMin_Due", 
	 "act_cus_n_loans_hist", "act_cus_n_statB", "act_state_27_CMin_Due", "act_state_34_CMin_Due");
run;


/* na podstawie wcześniejszych statystyk zostają wybrane dla powyzszych zmiennych jedynie
wartości odstające*/

%macro outls (varname=, low=, up=);

data tr_&varname.;
set train (keep=period &varname.);
if &low. < &varname. < &up. then &varname.=.;
proc sort; by period;
run;

%mend outls;

%outls(varname=act_state_9_CMin_Due, low=-1.615100381, up= 2.1039610561);
%outls(varname=act_state_10_CMin_Due, low=-1.6371870331, up= 2.120140472);
%outls(varname=act_state_12_CMin_Due, low=-1.745225494, up= 2.2230701227);
%outls(varname=act_state_11_CMin_Due, low=-1.6597981171, up= 2.1339671478);
%outls(varname=act_cus_n_loans_hist, low=-3.968727911, up= 7.825808587);
%outls(varname=act_cus_n_statB, low=-3.67994369, up= 4.6421132178);
%outls(varname=act_state_27_CMin_Due, low=-3.989919392, up= 5.6954283001);
%outls(varname=act_state_34_CMin_Due, low=-3.941978604, up= 5.5788310866);

data tr_per;
merge tr_act_state_9_CMin_Due tr_act_state_10_CMin_Due tr_act_state_12_CMin_Due tr_act_state_11_CMin_Due
	  tr_act_cus_n_loans_hist tr_act_cus_n_statB tr_act_state_27_CMin_Due tr_act_state_34_CMin_Due;
by period;		
if nmiss(act_state_9_CMin_Due, act_state_10_CMin_Due, act_state_12_CMin_Due, act_state_11_CMin_Due,
	 	 act_cus_n_loans_hist, act_cus_n_statB, act_state_27_CMin_Due, act_state_34_CMin_Due)=8 then delete;
run;

/*valid*/

/* stworzenie zbioru z wcześniej wybranymi zmiennymi*/
data valid_out;
set val2;
if variable in ("act_state_9_CMin_Due", "act_state_10_CMin_Due", "act_state_12_CMin_Due", "act_state_11_CMin_Due", 
	 "act_cus_n_loans_hist", "act_cus_n_statB", "act_state_27_CMin_Due", "act_state_34_CMin_Due");
run;

/* na podstawie wcześniejszych statystyk zostają wybrane dla powyzszych zmiennych jedynie
wartości odstające*/

%macro outls (varname=, low=, up=);

data val_&varname.;
set train (keep=period &varname.);
if &low. < &varname. < &up. then &varname.=.;
proc sort; by period;
run;

%mend outls;

%outls(varname=act_state_9_CMin_Due, low=-1.543484014, up=2.0173791162);
%outls(varname=act_state_10_CMin_Due, low=-1.631925037, up=2.107522263);
%outls(varname=act_state_12_CMin_Due, low=-1.824698716, up= 2.3147980955);
%outls(varname=act_state_11_CMin_Due, low=-1.746286819, up=2.2280462161);
%outls(varname=act_cus_n_loans_hist, low=-4.052185192, up= 7.9363005115);
%outls(varname=act_cus_n_statB, low=-3.728193605, up= 4.7045644363);
%outls(varname=act_state_27_CMin_Due, low=-4.016903425, up= 5.7243159028);
%outls(varname=act_state_34_CMin_Due, low=-3.819800039, up=5.3492118033);

data val_per;
merge val_act_state_9_CMin_Due val_act_state_10_CMin_Due val_act_state_12_CMin_Due val_act_state_11_CMin_Due
	  val_act_cus_n_loans_hist val_act_cus_n_statB val_act_state_27_CMin_Due val_act_state_34_CMin_Due;
by period;		
if nmiss(act_state_9_CMin_Due, act_state_10_CMin_Due, act_state_12_CMin_Due, act_state_11_CMin_Due,
	 	 act_cus_n_loans_hist, act_cus_n_statB, act_state_27_CMin_Due, act_state_34_CMin_Due)=8 then delete;
run;	




