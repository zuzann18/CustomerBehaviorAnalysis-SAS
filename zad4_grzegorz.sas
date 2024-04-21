/*wczoytanie danych */
data abt_sam_beh_train;
	set 'C:\Users\Grzegorz\Desktop\SGH\Podstawowe i zaawansowane programowanie oraz statystyka w SAS\Projekt\abt_sam_beh_train';
run;
data abt_sam_beh_valid;
	set 'C:\Users\Grzegorz\Desktop\SGH\Podstawowe i zaawansowane programowanie oraz statystyka w SAS\Projekt\abt_sam_beh_valid';
run;

/*usuniêcie danych w zbiorze train z brakuj¹cymi wartoœciami f.celu oraz danych agr*  */
data train;
set abt_sam_beh_train(drop= agr: );
if default_cus12 <= .Z then delete;
run;

/*usuniêcie danych w zbiorze valid z brakuj¹cymi wartoœciami f.celu oraz danych agr*  */
data valid;
set abt_sam_beh_valid(drop= agr: );
if default_cus12 <= .Z then delete;
run;

/*zbiór train - liczba obserwacji, mediana, rozstêp miêdzykwartylowy, centyl 25 i 75, min i max */
proc means data=train n median qrange p25 p75 min max STACKODSOUTPUT;
	var _NUMERIC_;
	ods output Summary=Summary_QRange_train;
run;
proc means data=train NMISS;
run;

/*zbiór valid liczba obserwacji, mediana, rozstêp miêdzykwartylowy, centyl 25 i 75*/
proc means data=valid n median qrange p25 p75 min max STACKODSOUTPUT;
	var _NUMERIC_;
	ods output Summary=Summary_QRange_valid;
run;
proc means data=valid NMISS;
run;
/*dodanie dwóch kolumn - Lowerbund i Upperbund [train]*/
data SUMMARY_QRange_train;
	set SUMMARY_QRange_train;
	LowerBound = P25-1.5*QRange;
	UpperBound = P75+1.5*QRange;
run;
/*sortowanie danych [train] na podsatwie rozst. miêdzykwartyl. */
proc sort data=SUMMARY_QRange_train;
	by descending QRange;
run;

/*dodanie dwóch kolumn - Lowerbund i Upperbund [valid]*/
data SUMMARY_QRange_valid;
	set SUMMARY_QRange_valid;
	LowerBound = P25-1.5*QRange;
	UpperBound = P75+1.5*QRange;
run;

/*sortowanie danych [valid] na podsatwie rozst. miêdzykwartyl. */
proc sort data=SUMMARY_QRange_valid;
	by descending QRange;
run;

/*Folder, do którego zostan¹ wygenerowane wyniki */
ods html file="C:\Users\Grzegorz\Desktop\SGH\Podstawowe i zaawansowane programowanie oraz statystyka w SAS\Projekt\wyniki\wynikihtml.html"
gpath="C:\Users\Grzegorz\Desktop\SGH\Podstawowe i zaawansowane programowanie oraz statystyka w SAS\Projekt\wyniki";

title '4. Analiza danych nietypowych';
title;
/*wygenerowanie 20 wartoœci ze zbioru train*/
title 'Zbiór train';
footnote 'Tabela zawieraj¹ca 20 zmiennych ze zbioru abt_sam_beh_train o najwy¿szym rozstêpie miêdzykwartylowym';
proc print data = SUMMARY_QRANGE_TRAIN(obs = 20); 
	run;
title;
footnote;
/*wygenerowanie 20 wartoœci ze zbioru valid*/
title 'Zbiór valid';
footnote 'Tabela zawieraj¹ca 20 zmiennych ze zbioru abt_sam_beh_valid o najwy¿szym rozstêpie miêdzykwartylowym';
proc print data = SUMMARY_QRANGE_VALID(obs = 20); 
	run;
title;
footnote;
/*wykres1 [train]*/
	title 'zbiór train - zmienna app_income (procentowo) ';
proc gchart data=train;
	vbar app_income / type=percent;
	run;
quit;
title;

/*wykres2 [train]*/
title 'zbiór train - zmienna app_income';
proc sgplot data=train;
vbox app_income / boxwidth=0.3;
yaxis grid;
run;
quit;
title;

/*wykres2A [train]*/
title 'zbiór train - zmienna app spendings';
proc sgplot data=train;
vbox app_spendings / boxwidth=0.3;
yaxis grid;
run;
quit;
title;

/*wykres2B [train]*/
title 'zbiór train - zmienna act_cus_seniority';
proc sgplot data=train;
vbox act_cus_seniority / boxwidth=0.3;
yaxis grid;
run;
quit;
title;

/*wykres2C [train]*/
title 'zbiór train - zmienna act_cus_n_loans_hist';
proc sgplot data=train;
vbox act_cus_n_loans_hist / boxwidth=0.3;
yaxis grid;
run;
quit;
title;

/*wykres3 [train]*/
title 'zbiór train - ags36_Sum_CMax_Days';
proc sgplot data=train;
vbox ags36_Sum_CMax_Days / boxwidth=0.3;
yaxis grid;
run;
quit;
title;

/*wykres4 [train]*/
title 'zbiór train - Wykres zale¿noœci wieku od dochodu';
proc gplot data=train;
	plot act_age*app_income / href=5308;
run;
quit;
title;

/*wykres5 [train]*/
title 'zbiór train - zale¿noœæ wydatków i dochodu';
proc gplot data=train;
	plot app_spendings*app_income;
run;
quit;
title;

/*wykres6 [train]*/
title 'zbiór train - Wykres zale¿noœci zmiennej ags36_Sum_CMax_Days i dochodu';
proc gplot data=train;
	plot ags36_Sum_CMax_Days*app_income;
run;
quit;
title;


/*wykres7 [train]*/
title 'zbiór train - Wykres zale¿noœci wp³aconych rat i dochodu';
proc gplot data=train;
	plot act_cus_pins*app_income;
run;
quit;
title;


/*wykres8 [train]*/
title 'zbiór train - Wykres zale¿noœci dochodu i liczby miesiêcy, które up³ynê³y od wziêcia pierwszego kredytu';
proc gplot data=train;
	plot app_income*act_cus_seniority;
run;
quit;
title;

/*wykres9 [train]*/
title 'zbiór train - Wykres zale¿noœci app_spendings od act_cus_seniority';
proc gplot data=train;
	plot app_spendings*act_cus_seniority;
run;
quit;
title;

/*wykres9 [train]*/
title 'zbiór train - Wykres zmiennej act_age';
proc sgplot data=train;
vbox act_age / boxwidth=0.4;
yaxis grid;
run;
quit;
title;
/*test
data train;
	set train;
	yr= YEAR(period);
run;

proc gplot data=train;
	plot act_cus_seniority*yr;
run;
quit;
title;
*/

/*Poni¿ej wykresy dla zbioru valid */

/*wykres1 [valid]*/
title 'zbiór valid - zmienna app_income (procentowo) ';
proc gchart data=valid;
	vbar app_income / type=percent;
	run;
quit;
title;

/*wykres2 [valid]*/
title 'zbiór valid - zmienna app_income';
proc sgplot data=valid;
vbox app_income / boxwidth=0.4;
yaxis grid;
run;
quit;
title;

/*wykres2A [valid]*/
title 'zbiór valid - zmienna app spendings';
proc sgplot data=valid;
vbox app_spendings / boxwidth=0.4;
yaxis grid;
run;
quit;
title;

/*wykres2B [valid]*/
title 'zbiór valid - zmienna act_cus_seniority';
proc sgplot data=valid;
vbox act_cus_seniority / boxwidth=0.4;
yaxis grid;
run;
quit;
title;

/*wykres2C [valid]*/
title 'zbiór valid - zmienna act_cus_n_loans_hist';
proc sgplot data=valid;
vbox act_cus_n_loans_hist / boxwidth=0.4;
yaxis grid;
run;
quit;
title;

/*wykres3 [valid]*/
title 'zbiór valid - ags36_Sum_CMax_Days';
proc sgplot data=valid;
vbox ags36_Sum_CMax_Days / boxwidth=0.4;
yaxis grid;
run;
quit;
title;

/*wykres4 [valid]*/
title 'zbiór valid -zale¿noœæ wieku od dochodu';
proc gplot data=valid;
	plot act_age*app_income / href=5308;
run;
quit;
title;

/*wykres5 [valid]*/
title 'zbiór valid - zale¿noœæ wydatków i dochodu';
proc gplot data=valid;
	plot app_spendings*app_income;
run;
quit;
title;

/*wykres6 [valid]*/
title 'zbiór valid - Wykres zale¿noœci zmiennej ags36_Sum_CMax_Days i dochodu';
proc gplot data=valid;
	plot ags36_Sum_CMax_Days*app_income;
run;
quit;
title;


/*wykres7 [valid]*/
title 'zbiór valid - Wykres zale¿noœci wp³aconych rat i dochodu';
proc gplot data=valid;
	plot act_cus_pins*app_income;
run;
quit;
title;


/*wykres8 [valid]*/
title 'zbiór valid - Wykres zale¿noœci dochodu i liczby miesiêcy, które up³ynê³y od wziêcia pierwszego kredytu';
proc gplot data=valid;
	plot app_income*act_cus_seniority;
run;
quit;
title;

/*wykres9 [valid]*/
title 'zbiór valid - Wykres zale¿noœci app_spendings od act_cus_seniority';
proc gplot data=valid;
	plot app_spendings*act_cus_seniority;
run;
quit;
title;

/*wykres9 [valid]*/
title 'zbiór valid - Wykres zmiennej act_age';
proc sgplot data=valid;
vbox act_age / boxwidth=0.4;
yaxis grid;
run;
quit;
title;


ods html close;

