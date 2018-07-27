/* Generated Code (IMPORT) */
/* Source File: DelayedFlights.csv */
/* Source Path: /folders/myshortcuts/analytics_project */
/* Code generated on: 5/29/18, 9:11 PM */

%web_drop_table(WORK.IMPORT);
FILENAME REFFILE 'C:\Users\amattur\Desktop\DelayedFlights.csv';;
PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;
data modified;
set import/*(drop=VAR1)*/;
output modified;
Proc means mean std median q1 q3;
proc means nmiss n;
run;
data modified40;
set modified;

if CarrierDelay= . then do;CarrierDelay=3.14159;
end; 
if WeatherDelay= . then do;WeatherDelay=3.14159;
end; 
if NASDelay= . then do;NASDelay=3.14159; 
end; 
if SecurityDelay= . then do;SecurityDelay=3.14159; 
end; 
if LateAircraftDelay= . then do;LateAircraftDelay=3.14159;
end; 
if CRSElapsedTime= . then do;CRSElapsedTime=3.14159; 
end; 
if ActualElapsedTime= . then do;ActualElapsedTime=3.14159;
end; 
if ArrTime= . then do; ArrTime=3.14159;
end; 
if AirTime= . then do; AirTime=3.14159;
end; 
if ArrDelay= . then do; ArrDelay=3.14159;
end; 
if TaxiIn= . then do; TaxiIn=3.14159; 
end; 
if TaxiOut= . then do;TaxiOut=3.14159;
end;
yearnew=mdy(1,1,Year);
length DepTime 4;
DepTime=put(DepTime,z4.);
format DepTime z4.;
/*DepTime=put(input(DepTime,z4.),z6.);*/
length CRSDepTime 4;
CRSDepTime=put(CRSDepTime,z4.);
format CRSDepTime z4.;
/*CRSDepTime=put(input(CRSDepTime,best4.),z4.);*/
length ArrTime 4;
ArrTime=put(ArrTime,z4.);
format ArrTime z4.;
/*ArrTime=put(input(ArrTime,best4.),z4.);*/
length CRSArrTime 4;
CRSArrTime=put(CRSArrTime,z4.);
format CRSArrTime z4.;
/*CRSArrTime=put(input(CRSArrTime,best4.),z4.);*/
format yearnew year4.;
monthnew=mdy(Month,1,1990);
format monthnew month2.;
datenew=mdy(1,DayOfMonth,1990);
format datenew Day2.;
newDepTime=input(cats(DepTime,"00"),hhmmss.);
format newDepTime time6.;
newCRSDepTime=input(cats(CRSDepTime,"00"),hhmmss.);
format newCRSDepTime time6.;
newArrTime=input(cats(ArrTime,"00"),hhmmss.);
format newArrTime time6.;
newCRSArrTime=input(cats(CRSArrTime,"00"),hhmmss.);
format newCRSArrTime time6.;
drop Year Month DayOfMonth DepTime CrsDepTime ArrTime CRSArrTime;
/*If AirTime=3.14159 and ArrDelay=3.14159 then counto='ok'; else counto='not';
If TaxiIn=3.14159 and ArrTime=3.14159 then countt='ok'; else countt='not';
If CarrierDelay=3.14159 and WeatherDelay=3.14159 then counth='ok'; else counth='not';
If AirTime=3.14159 and CarrierDelay=3.14159 and ArrTime=3.14159 then countf='ok'; else countf='not';
run;*/
proc freq data=modified40;
tables UniqueCarrier CancellationCode counto countt counth countf;/*origin dest,tailnum not included*/
proc HPFOREST;
TARGET Cancelled/LEVEL=NOMINAL;
INPUT Cancelled yearnew monthnew DayofWeek Diverted CarrierDelay WeatherDelay
NASDelay SecurityDelay LateAircraftDelay/LEVEL=NOMINAL;
INPUT newDepTime newCRSDepTime newArrTime newCRSArrTime  ActualElapsedTime
CRSElapsedTime AirTime ArrDelay DepDelay Distance TaxiIn TaxiOut/LEVEL=ORDINAL;  
ods output FitStatistics=fitstats;
/*proc data=fitstats score predict;*/
proc factor data=modified40 score outstat=Scores noprint;
var newDepTime newCRSDepTime newArrTime;
run;
proc score data=modified40 score=scores out=new;
var newDepTime newCRSDepTime newArrTime;
id newArrTime;
run;

