/*wczoytanie danych */
data abt_sam_beh_train;
	set 'C:\Users\Grzegorz\Desktop\SGH\Podstawowe i zaawansowane programowanie oraz statystyka w SAS\Projekt\abt_sam_beh_train';
run;
data abt_sam_beh_valid;
	set 'C:\Users\Grzegorz\Desktop\SGH\Podstawowe i zaawansowane programowanie oraz statystyka w SAS\Projekt\abt_sam_beh_valid';
run;

/*usuni�cie danych w zbiorze train z brakuj�cymi warto�ciami f.celu oraz danych agr*  */
data train;
set abt_sam_beh_train(drop= agr: );
if default_cus12 <= .Z then delete;
run;

/*usuni�cie danych w zbiorze valid z brakuj�cymi warto�ciami f.celu oraz danych agr*  */
data valid;
set abt_sam_beh_valid(drop= agr: );
if default_cus12 <= .Z then delete;
run;

/*zbi�r train - liczba obserwacji, mediana, rozst�p mi�dzykwartylowy, centyl 25 i 75, min i max */
proc means data=train n median qrange p25 p75 min max STACKODSOUTPUT;
	var _NUMERIC_;
	ods output Summary=Summary_QRange_train;
run;
proc means data=train NMISS;
run;

/*zbi�r valid liczba obserwacji, mediana, rozst�p mi�dzykwartylowy, centyl 25 i 75*/
proc means data=valid n median qrange p25 p75 min max STACKODSOUTPUT;
	var _NUMERIC_;
	ods output Summary=Summary_QRange_valid;
run;
proc means data=valid NMISS;
run;
/*dodanie dw�ch kolumn - Lowerbund i Upperbund [train]*/
data SUMMARY_QRange_train;
	set SUMMARY_QRange_train;
	LowerBound = P25-1.5*QRange;
	UpperBound = P75+1.5*QRange;
run;
/*sortowanie danych [train] na podsatwie rozst. mi�dzykwartyl. */
proc sort data=SUMMARY_QRange_train;
	by descending QRange;
run;

/*dodanie dw�ch kolumn - Lowerbund i Upperbund [valid]*/
data SUMMARY_QRange_valid;
	set SUMMARY_QRange_valid;
	LowerBound = P25-1.5*QRange;
	UpperBound = P75+1.5*QRange;
run;

/*sortowanie danych [valid] na podsatwie rozst. mi�dzykwartyl. */
proc sort data=SUMMARY_QRange_valid;
	by descending QRange;
run;

/*Folder, do kt�rego zostan� wygenerowane wyniki */
ods html file="C:\Users\Grzegorz\Desktop\SGH\Podstawowe i zaawansowane programowanie oraz statystyka w SAS\Projekt\wyniki\wynikihtml.html"
gpath="C:\Users\Grzegorz\Desktop\SGH\Podstawowe i zaawansowane programowanie oraz statystyka w SAS\Projekt\wyniki";

title '4. Analiza danych nietypowych';
title;
/*wygenerowanie 20 warto�ci ze zbioru train*/
title 'Zbi�r train';
footnote 'Tabela zawieraj�ca 20 zmiennych ze zbioru abt_sam_beh_train o najwy�szym rozst�pie mi�dzykwartylowym';
proc print data = SUMMARY_QRANGE_TRAIN(obs = 20); 
	run;
title;
footnote;
/*wygenerowanie 20 warto�ci ze zbioru valid*/
title 'Zbi�r valid';
footnote 'Tabela zawieraj�ca 20 zmiennych ze zbioru abt_sam_beh_valid o najwy�szym rozst�pie mi�dzykwartylowym';
proc print data = SUMMARY_QRANGE_VALID(obs = 20); 
	run;
title;
footnote;
/*wykres1 [train]*/
	title 'zbi�r train - zmienna app_income (procentowo) ';
proc gchart data=train;
	vbar app_income / type=percent;
	run;
quit;
title;

/*wykres2 [train]*/
title 'zbi�r train - zmienna app_income';
proc sgplot data=train;
vbox app_income / boxwidth=0.3;
yaxis grid;
run;
quit;
title;

/*wykres2A [train]*/
title 'zbi�r train - zmienna app spendings';
proc sgplot data=train;
vbox app_spendings / boxwidth=0.3;
yaxis grid;
run;
quit;
title;

/*wykres2B [train]*/
title 'zbi�r train - zmienna act_cus_seniority';
proc sgplot data=train;
vbox act_cus_seniority / boxwidth=0.3;
yaxis grid;
run;
quit;
title;

/*wykres2C [train]*/
title 'zbi�r train - zmienna act_cus_n_loans_hist';
proc sgplot data=train;
vbox act_cus_n_loans_hist / boxwidth=0.3;
yaxis grid;
run;
quit;
title;

/*wykres3 [train]*/
title 'zbi�r train - ags36_Sum_CMax_Days';
proc sgplot data=train;
vbox ags36_Sum_CMax_Days / boxwidth=0.3;
yaxis grid;
run;
quit;
title;

/*wykres4 [train]*/
title 'zbi�r train - Wykres zale�no�ci wieku od dochodu';
proc gplot data=train;
	plot act_age*app_income / href=5308;
run;
quit;
title;

/*wykres5 [train]*/
title 'zbi�r train - zale�no�� wydatk�w i dochodu';
proc gplot data=train;
	plot app_spendings*app_income;
run;
quit;
title;

/*wykres6 [train]*/
title 'zbi�r train - Wykres zale�no�ci zmiennej ags36_Sum_CMax_Days i dochodu';
proc gplot data=train;
	plot ags36_Sum_CMax_Days*app_income;
run;
quit;
title;


/*wykres7 [train]*/
title 'zbi�r train - Wykres zale�no�ci wp�aconych rat i dochodu';
proc gplot data=train;
	plot act_cus_pins*app_income;
run;
quit;
title;


/*wykres8 [train]*/
title 'zbi�r train - Wykres zale�no�ci dochodu i liczby miesi�cy, kt�re up�yn�y od wzi�cia pierwszego kredytu';
proc gplot data=train;
	plot app_income*act_cus_seniority;
run;
quit;
title;

/*wykres9 [train]*/
title 'zbi�r train - Wykres zale�no�ci app_spendings od act_cus_seniority';
proc gplot data=train;
	plot app_spendings*act_cus_seniority;
run;
quit;
title;

/*wykres9 [train]*/
title 'zbi�r train - Wykres zmiennej act_age';
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

/*Poni�ej wykresy dla zbioru valid */

/*wykres1 [valid]*/
title 'zbi�r valid - zmienna app_income (procentowo) ';
proc gchart data=valid;
	vbar app_income / type=percent;
	run;
quit;
title;

/*wykres2 [valid]*/
title 'zbi�r valid - zmienna app_income';
proc sgplot data=valid;
vbox app_income / boxwidth=0.4;
yaxis grid;
run;
quit;
title;

/*wykres2A [valid]*/
title 'zbi�r valid - zmienna app spendings';
proc sgplot data=valid;
vbox app_spendings / boxwidth=0.4;
yaxis grid;
run;
quit;
title;

/*wykres2B [valid]*/
title 'zbi�r valid - zmienna act_cus_seniority';
proc sgplot data=valid;
vbox act_cus_seniority / boxwidth=0.4;
yaxis grid;
run;
quit;
title;

/*wykres2C [valid]*/
title 'zbi�r valid - zmienna act_cus_n_loans_hist';
proc sgplot data=valid;
vbox act_cus_n_loans_hist / boxwidth=0.4;
yaxis grid;
run;
quit;
title;

/*wykres3 [valid]*/
title 'zbi�r valid - ags36_Sum_CMax_Days';
proc sgplot data=valid;
vbox ags36_Sum_CMax_Days / boxwidth=0.4;
yaxis grid;
run;
quit;
title;

/*wykres4 [valid]*/
title 'zbi�r valid -zale�no�� wieku od dochodu';
proc gplot data=valid;
	plot act_age*app_income / href=5308;
run;
quit;
title;

/*wykres5 [valid]*/
title 'zbi�r valid - zale�no�� wydatk�w i dochodu';
proc gplot data=valid;
	plot app_spendings*app_income;
run;
quit;
title;

/*wykres6 [valid]*/
title 'zbi�r valid - Wykres zale�no�ci zmiennej ags36_Sum_CMax_Days i dochodu';
proc gplot data=valid;
	plot ags36_Sum_CMax_Days*app_income;
run;
quit;
title;


/*wykres7 [valid]*/
title 'zbi�r valid - Wykres zale�no�ci wp�aconych rat i dochodu';
proc gplot data=valid;
	plot act_cus_pins*app_income;
run;
quit;
title;


/*wykres8 [valid]*/
title 'zbi�r valid - Wykres zale�no�ci dochodu i liczby miesi�cy, kt�re up�yn�y od wzi�cia pierwszego kredytu';
proc gplot data=valid;
	plot app_income*act_cus_seniority;
run;
quit;
title;

/*wykres9 [valid]*/
title 'zbi�r valid - Wykres zale�no�ci app_spendings od act_cus_seniority';
proc gplot data=valid;
	plot app_spendings*act_cus_seniority;
run;
quit;
title;

/*wykres9 [valid]*/
title 'zbi�r valid - Wykres zmiennej act_age';
proc sgplot data=valid;
vbox act_age / boxwidth=0.4;
yaxis grid;
run;
quit;
title;


ods html close;

