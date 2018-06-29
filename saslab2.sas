data first; /*SAS LAB 2*/
input Pair Before After;
cards;
1	2.37	2.51
2	3.17	2.65
3	3.07	2.60
4	2.73	2.40
5	3.49	2.31
6	4.35	2.28
7	3.65	0.94
8	3.97	2.21
9	3.21	3.29
10	4.46	1.92
11	3.81	3.38
12	4.55	2.43
13	4.51	1.83
14	3.03	2.63
15	4.47	2.31
16	3.44	1.85
17	3.52	2.92
18	3.05	2.26
19	3.66	3.11
20	3.81	1.90
21	3.13	2.50
22	3.43	3.18
23	3.26	3.24
24	2.85	2.16

run; 
proc print;
run; 
DATA TWO; SET FIRST; /* to creat the blocks*/
length treatment $10;
treatment= "Before"; outcome=Before;output;
treatment="After"; outcome=After;output;
Keep pair treatment outcome;
run;
proc glm data=two;
class treatment pair;
model outcome=treatment pair;
run;
proc ttest data=FIRST; /*to perform a paired t test */
paired Before*After;
run;
DATA FIRST; SET FIRST; /* taking the difference between before and after to do the one sample ttest*/
difference=before-after;
run;
proc ttest data=first; 
var difference;
run;
proc univariate normal plot data=first;
var difference; /* Tells SAS to run tests of Normality */
run; 
/* Shapiro test failed the normality , so lets do the non-parametric test*/
proc glm data=two;
class treatment pair;
Model outcome=treatment pair;
output out=resid r =res;
run;
quit;
proc univariate normal plot data=resid;
var res;
run;
proc sort Data=two; by pair;
proc rank data= two out=tworanks; /*rank the data*/
by pair; var outcome;
run;
proc freq data=two;
/*non paramaetric test of your ANOVA*/
tables pair*treatment*outcome/ cmh2 scores=rank
noprint;
run;
data SECOND; /*SAS LAB 2 - Exercise 2*/
input Driver$ Model$ Blend$ Mileage;
cards;
1 1 A 15.5
2 1 B 16.3
3 1 C 10.5
4 1 D 14.0
1 2 B 33.8
2 2 C 26.4
3 2 D 31.5
4 2 A 34.5
1 3 C 13.7 
2 3 D 19.1
3 3 A 17.5
4 3 B 19.7
1 4 D 29.2
2 4 A 22.5
3 4 B 30.1
4 4 C 21.6
RUN; 
PROC GLM DATA=SECOND;
CLASS DRIVER MODEL BLEND;
MODEL MILEAGE= DRIVER MODEL BLEND;
OUTPUT OUT=RESIDS R=RES;
RUN;
QUIT;
PROC UNIVARIATE NORMAL PLOT;
VAR RES;
RUN;
PROC GLM DATA=SECOND;
CLASS BLEND;
MODEL MILEAGE=BLEND;
MEANS BLEND/ HOVTEST=LAVENE;
RUN;
