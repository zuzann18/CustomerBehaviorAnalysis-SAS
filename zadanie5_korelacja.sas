LIBNAME projekt base "C:\Users\Dell\Desktop\Projekt";

/*³adowanie zbioru z brakami*/

proc import file ="C:\Users\Dell\Desktop\raport-SAS.xlsx"
    out=work.braki
	dbms=xlsx;
run;

proc sql;
create table braki_drop as
select nazwa from braki
where proc_braki_train >= 0.6 and proc_braki_valid >= 0.6;
quit;

proc sql noprint;
select nazwa into :todrop separated by ' '
from braki_drop;
quit;

/*usuwamy zmienne gdzie braki wynosz¹ ponad 60%*/
data projekt.valid;
set projekt.abt_sam_beh_valid;
drop &todrop;
run;

/*tworzenie nowych kolumn - zmiana ze zmiennych opisowych na numeryczne*/
/* wyrzucamy obserwacje gdzie mamy brakuj¹ce wartoœci funkcji celu  */
/* wyrzucamy obserwacje "i." -> inne przypadki"*/
/* wyrzucamy inne funkcje celu*/
/*wyrzucamy zmienne act_ które posiadaj¹ takie same wartoœci*/
/*wyrzucamy zmienne agreguj¹ce*/

data projekt.valid;
    set projekt.valid(drop= act_Cmax_Days act_Cmax_Due act_CMin_Days act_CMin_Due);
	app_num_job_code = input(app_char_job_code,8.);
	app_num_mar_stat = input(app_char_marital_status,8.);
	app_num_city = input(app_char_city,8.);
	app_num_hstat = input(app_char_home_status,8.);
	app_num_cars = input(app_char_cars,8.);
	if default_cus12 <= .Z then delete;
	if default_cus12 <= .i then delete;
	drop default_cus3 default_cus6 default_cus9;
	drop agr:;
run;


/*zamiana zmiennych opisowych na rangi*/

/*Zmienna app_char_job_code - 4*/
/*app_char_marital_status - 2*/
/*app_char_city -4*/
/*app_char_home_status-3*/
/*app_char_cars-2*/


proc sql;
	update projekt.valid
	set app_num_job_code = 0
	where app_char_job_code ="Contract";

	update projekt.valid
	set app_num_job_code = 1
	where app_char_job_code ="Owner company";

	update projekt.valid
	set app_num_job_code = 2
	where app_char_job_code ="Permanent";

	update projekt.valid
	set app_num_job_code = 3
	where app_char_job_code ="Retired";

	update projekt.valid
	set app_num_mar_stat = 0
	where app_char_marital_status ="Maried";

	update projekt.valid
	set app_num_mar_stat = 1
	where app_char_marital_status ="Single";

	update projekt.valid
	set app_num_city = 0
	where app_char_city ="Big";

	update projekt.valid
	set app_num_city = 1
	where app_char_city ="Large";

	update projekt.valid
	set app_num_city = 2
	where app_char_city ="Medium";

	update projekt.valid
	set app_num_city = 3
	where app_char_city ="Small";

	update projekt.valid
	set app_num_hstat = 0
	where app_char_home_status ="Owner";

	update projekt.valid
	set app_num_hstat = 1
	where app_char_home_status ="Rental";

	update projekt.valid
	set app_num_hstat = 2
	where app_char_home_status ="With parents";

	update projekt.valid
	set app_num_cars = 0
	where app_char_cars ="No";

	update projekt.valid
	set app_num_cars = 1
	where app_char_cars ="Owner";

	alter table projekt.valid drop app_char_job_code;
	alter table projekt.valid drop app_char_marital_status;
	alter table projekt.valid drop app_char_city;
	alter table projekt.valid drop app_char_home_status;
	alter table projekt.valid drop app_char_cars;

quit;

/*korelacja - 4 rodzaje zmiennych: app,ags,agr i act*/

proc corr data=projekt.valid out=project_app ;
var default_cus12;
with app:;
run;

proc corr data=projekt.valid out=project_act;
var default_cus12;
with act:;
run;

proc corr data=projekt.valid out=project_ags;
var default_cus12;
with ags:;
run;

/*zamiana nazwy na name i type - czasami ze znakiem "_" wychodz¹ b³êdy*/

DATA projekt.act;
	SET work.PROJECT_ACT;
		rename _NAME_=name _type_=type;
RUN;

/*zmiana d³ugoœci kolumny na równe - wtedy mo¿na po³¹czyæ w jedn¹ */


data projekt.act ;
  length name $30 ;
  set projekt.act ;
  format _character_;
run;

DATA projekt.app;
	SET work.PROJECT_app;
		rename _NAME_=name _type_=type;
RUN;

data projekt.app ;
  length name $30 ;
  set projekt.app ;
  format _character_;
run;

DATA projekt.ags;
	SET work.PROJECT_ags;
		rename _NAME_=name _type_=type;
RUN;

data projekt.ags ;
  length name $30 ;
  set projekt.ags ;
  format _character_;
run;

/*dodawanie kolejnych wierszy do jednej tabeli*/

proc append base=projekt.valid_corr
	data= projekt.act;
run;

proc append base=projekt.valid_corr
	data= projekt.ags;
run;

proc append base=projekt.valid_corr
	data= projekt.app;
run;

/*usuwanie zbêdnych wierszy*/

proc sql;
	delete from projekt.valid_corr
	where type ="N" or type="MEAN" or type="STD";
quit;

proc sql;
	delete from projekt.valid_corr
	where default_cus12 is missing;
quit;

/*ustalenie formatu - tabela czêstoœci */

proc format;
	value MyFormat
	low - -0.30 = "do -0,30"
	-0.30 - -0.20 ="od -0,30 do -0,20"
	-0.20 - -0.10 ="od -0,20 do - 0,10"
	-0.10 - 0.00 = "od -0,10 do 0,00 "
	0.00 - 0.10 ="od 0,00 do 0,10"
	0.10 - 0.20 ="od 0,10 do 0,20"
	0.20 - 0.30 ="od 0,20 do 0,30"
	0.30 - 0.40 ="od 0,30 do 0,40"
	0.40-high = "od 0,40 ";
run;

/*kszta³towanie siê wspó³czynnika korelacji na zbiorze valid*/

proc freq data=projekt.valid_corr ;
	tables default_cus12 / out=projekt.count_corr;
	format default_cus12 MyFormat.;
run;

ods graphics /height=500px width=800px;
proc sgplot data=projekt.count_corr;
  hbarparm category=default_cus12 response=count;
  xaxis grid;
  yaxis labelpos=top;
run;

/* Korelacja silna ujemnie dla: od -1 do -0,5;
   Korelacja silna dodatnie dla: od 0,5 do 1;   */

data projekt.zmienne_istotne;
	set projekt.valid_corr;
	where default_cus12 > 0.40;
	keep name default_cus12;
run;

/*wspó³zale¿noœæ zmiennych istotnych*/

proc sql;
    create table projekt.valid_zm_ist_corr as
        select act_cus_dueutl,
			   act_state_1_CMax_Due,
			   act_state_1_CMin_Due,
			   ags3_Pctl75_CMax_Due,
			   ags3_Pctl95_CMax_Due,
		   	   ags3_Mean_CMax_Due,
			   ags3_Max_CMax_Due,
			   ags3_Sum_CMax_Due,
			   ags3_Pctl75_CMin_Due,
			   ags3_Pctl95_CMin_Due,
			   ags3_Mean_CMin_Due,
			   ags3_Max_CMin_Due,
			   ags3_Sum_CMin_Due,
			   ags3_n_cus_arrears
        from projekt.valid;
quit;


proc corr data= projekt.valid_zm_ist_corr;
run;


/*zbiór train*/

/*usuwamy zmienne gdzie braki wynosz¹ ponad 60%*/
data projekt.train;
set projekt.abt_sam_beh_train;
drop &todrop;
run;


data projekt.train;
    set projekt.train(drop= act_Cmax_Days act_Cmax_Due act_CMin_Days act_CMin_Due);
	app_num_job_code = input(app_char_job_code,8.);
	app_num_mar_stat = input(app_char_marital_status,8.);
	app_num_city = input(app_char_city,8.);
	app_num_hstat = input(app_char_home_status,8.);
	app_num_cars = input(app_char_cars,8.);
	if default_cus12 <= .Z then delete;
	if default_cus12 <= .i then delete;
	drop default_cus3 default_cus6 default_cus9;
	drop agr:;
run;


/*zamiana zmiennych opisowych na rangi*/

/*Zmienna app_char_job_code - 4*/
/*app_char_marital_status - 2*/
/*app_char_city -4*/
/*app_char_home_status-3*/
/*app_char_cars-2*/


proc sql;
	update projekt.train
	set app_num_job_code = 0
	where app_char_job_code ="Contract";

	update projekt.train
	set app_num_job_code = 1
	where app_char_job_code ="Owner company";

	update projekt.train
	set app_num_job_code = 2
	where app_char_job_code ="Permanent";

	update projekt.train
	set app_num_job_code = 3
	where app_char_job_code ="Retired";

	update projekt.train
	set app_num_mar_stat = 0
	where app_char_marital_status ="Maried";

	update projekt.train
	set app_num_mar_stat = 1
	where app_char_marital_status ="Single";

	update projekt.train
	set app_num_city = 0
	where app_char_city ="Big";

	update projekt.train
	set app_num_city = 1
	where app_char_city ="Large";

	update projekt.train
	set app_num_city = 2
	where app_char_city ="Medium";

	update projekt.train
	set app_num_city = 3
	where app_char_city ="Small";

	update projekt.train
	set app_num_hstat = 0
	where app_char_home_status ="Owner";

	update projekt.train
	set app_num_hstat = 1
	where app_char_home_status ="Rental";

	update projekt.train
	set app_num_hstat = 2
	where app_char_home_status ="With parents";

	update projekt.train
	set app_num_cars = 0
	where app_char_cars ="No";

	update projekt.train
	set app_num_cars = 1
	where app_char_cars ="Owner";

	alter table projekt.train drop app_char_job_code;
	alter table projekt.train drop app_char_marital_status;
	alter table projekt.train drop app_char_city;
	alter table projekt.train drop app_char_home_status;
	alter table projekt.train drop app_char_cars;

quit;


proc corr data=projekt.train out=project_app_train;
var default_cus12;
with app:;
run;

proc corr data=projekt.train out=project_act_train ;
var default_cus12;
with act:;
run;


proc corr data=projekt.train out=project_ags_train;
var default_cus12;
with ags:;
run;

/*zamiana nazwy na name i type - czasami ze znakiem "_" wychodz¹ b³êdy*/

DATA projekt.act_train;
	SET work.PROJECT_ACT_train;
		rename _NAME_=name _type_=type;
RUN;

/*zmiana d³ugoœci kolumny na równe - wtedy mo¿na po³¹czyæ w jedn¹ */


data projekt.act_train ;
  length name $30 ;
  set projekt.act_train ;
  format _character_;
run;

DATA projekt.app_train;
	SET work.PROJECT_app_train;
		rename _NAME_=name _type_=type;
RUN;

data projekt.app_train ;
  length name $30 ;
  set projekt.app_train ;
  format _character_;
run;

DATA projekt.ags_train;
	SET work.PROJECT_ags_train;
		rename _NAME_=name _type_=type;
RUN;

data projekt.ags_train ;
  length name $30 ;
  set projekt.ags_train ;
  format _character_;
run;

/*dodawanie kolejnych wierszy do jednej tabeli*/

proc append base=projekt.train_corr
	data= projekt.act_train;
run;

proc append base=projekt.train_corr
	data= projekt.ags_train;
run;

proc append base=projekt.train_corr
	data= projekt.app_train;
run;

/*usuwanie zbêdnych wierszy*/

proc sql;
	delete from projekt.train_corr
	where type ="N" or type="MEAN" or type="STD";
run;

proc sql;
	delete from projekt.train_corr
	where default_cus12 is missing;
quit;

/*kszta³towanie siê wspó³czynnika korelacji na zbiorze train*/

proc freq data=projekt.train_corr ;
	tables default_cus12 / out=projekt.count_corr_train;
	format default_cus12 MyFormat.;
run;

ods graphics /height=500px width=800px;
proc sgplot data=projekt.count_corr_train;
  hbarparm category=default_cus12 response=count;
  xaxis grid;
  yaxis labelpos=top;
run;

/* Korelacja silna ujemnie dla: od -1 do -0,5;
   Korelacja silna dodatnie dla: od 0,5 do 1;   */

data projekt.zmienne_istotne_train;
	set projekt.train_corr;
	where default_cus12 > 0.40;
	keep name default_cus12;
run;

/*wspó³zale¿noœæ zmiennych istotnych*/

proc sql;
    create table projekt.train_zm_ist_corr as
        select act_cus_dueutl,act_state_1_CMax_Due,
act_state_1_CMin_Due,
ags3_Pctl75_CMax_Due,
ags3_Pctl95_CMax_Due,
ags3_Mean_CMax_Due,
ags3_Max_CMax_Due,
ags3_Sum_CMax_Due,
ags3_Pctl75_CMin_Due,
ags3_Pctl95_CMin_Due,
ags3_Mean_CMin_Due,
ags3_Max_CMin_Due,
ags3_Sum_CMin_Due,
ags3_n_cus_arrears
        from projekt.train;
quit;

proc corr data= projekt.train_zm_ist_corr;
run;
