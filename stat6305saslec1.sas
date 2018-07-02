/*
1.	After running the pilot study, the researchers conduct a 
study involving 100 students. Twenty-five students were randomly 
assigned to each of the four methods of instruction:
no instruction (control), piano lessons, computer video games, 
or instructor. The data are given in the attached excel sheet.

a.	Conduct an analysis of variance and summarize your results 
in an ANOVA table. 

b. Test the research hypothesis that there is a difference in 
mean effectiveness of the methods of instruction. Use a=0.05.

c. Apply a multiple comparison procedure to determine pairwise 
differences in the three methods. Use a=0.05.

d. Was there significant evidence that all three methods of 
instruction produced higher mean reasoning scores than the 
mean reasoning score for the control?

e. Error assumption

•	Was there significant evidence of a violation of the 
normality condition?

•	Was there significant evidence that the variance in 
reasoning scores was different for the three methods and the control?

*/

data one;
input student control piano computer instructor;
cards;
1	-3.4	-0.2	7.7	12.0
2	-2.8	5.2	5.5	4.1
3	2.2	6.6	-0.8	5.9
4	-0.8	5.2	7.4	13.5
5	2.8	-0.6	0.1	7.5
6	-5.9	5.4	11.7	9.3
7	7.8	3.1	1.2	7.1
8	-3.5	6.5	3.8	-0.9
9	2.9	2.4	5.1	8.3
10	1.9	6.2	4.3	9.8
11	-0.2	7.9	3.9	11.1
12	1.5	7.9	6.9	4.9
13	0.4	6.6	2.8	5.8
14	-0.5	0.2	5.4	2.8
15	1.1	1.9	2.5	12.0
16	5.3	1.3	5.2	8.6
17	-4.0	1.8	3.1	2.0
18	-1.3	3.1	6.6	5.9
19	2.6	1.4	0.2	5.6
20	-0.9	2.1	7.1	11.6
21	-0.6	6.6	9.2	7.8
22	-5.0	7.0	3.0	7.2
23	2.4	-0.7	2.3	8.3
24	-0.1	4.1	10.2	6.5
25	-4.7	3.8	4.7	8.3
run;
proc print data=one;
run;
data two; set one;
method="Control"; Y=control; output;
method="Piano"; Y=piano; output;
method="Computer"; Y=computer; output;
method="Instructor"; Y=instructor; output;
keep Y method;
run;
proc print data=two;
run;
proc glm data=two;
class method; *for variable method X as a categorical variable 
(factor);
model Y=method;
*means method / lsd; *performs pairwise t-tests;
*means method / dunnett ('Control'); *tests all means against control;
*means method/ hovtest=levene; *tests homogeneity of variance for 
the factor method;
*output out=resids r=res; *for the test of normality;
run;
quit;
proc univariate normal plot data=resids;
/*Tells SAS to run tests of normality and give a QQ-plot */;
var res;
run;

/*
Answers: 
b) The p-value of the model is <.0001. We reject the null hypothesis.

c) Results from lsd show that none of the pairs are 
significantly different.

d) Results from Dunnett show that yes, the treatment means were 
higher than the control.

e) Results from Levene's test show variances are equal.

f) Results from normality test show that assumption is met.
*/



data paint;
input section p1 p2 p3 p4 Mean;
cards;
1 28 35 27 21 27.75
2 21 36 25 18 25
3 26 38 27 17 27
4 16 25 22 18 20.25
run;
data Paintreal;
input Y X$;
cards;
28 1
21 2
26 3
16 4
35 1
36 2
38 3
25 4
27 1
25 2
27 3
22 4
21 1
18 2
17 3
18 4
run;
proc glm data=Paintreal;
class X; *for variable method X as a categorical variable (factor);
model Y=X;
means X / lsd;
run;
