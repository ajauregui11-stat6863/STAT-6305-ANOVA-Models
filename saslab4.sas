data one;
input Trt Rep Initial Final;
cards;
1 1 27.2 32.6
1 2 32.0 36.6
1 3 33.0 37.7
1 4 26.8 31.0
2 1 28.6 33.8
2 2 26.8 31.7
2 3 26.5 30.7
2 4 26.8 30.4
3 1 28.6 35.2
3 2 22.4 29.1
3 3 23.2 28.9
3 4 24.4 30.2
4 1 29.3 35.0
4 2 21.8 27.0
4 3 30.3 36.4
4 4 24.3 30.5
5 1 20.4 24.6
5 2 19.6 23.4
5 3 25.1 30.3
5 4 18.1 21.8
run;
proc plot data=one; /*to create the plot */
plot final*initial; /* y * x */
run;
quit;

proc plot data=one; /*to create the plot */
plot final*initial= Trt; /* tell SAS to separate it by the treatment*/
run;
quit;
proc glm data=one;
class trt;
model initial final = trt;
run;
/*ANCOVA */
PROC GLM DATA=ONE;
CLASS TRT;
MODEL FINAL=INITIAL TRT;
RUN;
PROC GLM DATA=ONE; /*TO TEST THE BETA 2*/
CLASS TRT;
MODEL FINAL= TRT INITIAL INITIAL*INITIAL;
RUN;
QUIT;
PROC GLM DATA=ONE; /* PART E OF THE LAB */
CLASS TRT;
MODEL FINAL=INITIAL TRT /SOLUTION;
RUN;

proc glm order= data data=one; /*part f of the lab */
class trt;
model final = trt initial;
contrast'control vs. treatment' trt -1 -1 -1 -1 4;
contrast 'botton vs. top' trt 1 -1 1 -1 0;
contrast 'cool vs. hot' trt 1 1 -1 -1  0;
run;

PROC GLM DATA=ONE; /* test for homogenity of slopes */
CLASS TRT;
MODEL FINAL=trt INITIAL TRT*initial ;
RUN;

/*check for model assumptions - equal variance assumption for ANCOVA model*/

data one; set one;
final_adj=final - 1.083179819 * (initial-25.76);
run;
proc glm data=one; /*equal variances assumption for ANCOVA */
title 'homogeneity of variances';
class trt;
model final_adj=trt;
means trt/hovtest=levene;
run;
quit;
proc means data=one; /* how to get 25.76 */
var initial;
run;
