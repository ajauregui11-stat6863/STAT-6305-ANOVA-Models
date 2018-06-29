
data one;
input Diameter Calcium pH@@;
cards;
5.2 100 4
5.9 100 4
6.3 100 4
7.1 100 5
7.4 100 5
7.5 100 5
7.6 100 6 
7.2 100 6
7.4 100 6
7.2 100 7
7.5 100 7
7.2 100 7
7.4 200 4
7 200 4
7.6 200 4
7.4 200 5
7.3 200 5
7.1 200 5
7.6 200 6
7.5 200 6
7.8 200 6
7.4 200 7
7 200 7
6.9 200 7
6.3 300 4
6.7 300 4
6.1 300 4 
7.3 300 5
7.5 300 5
7.2 300 5
7.2 300 6
7.3 300 6
7 300 6
6.8 300 7
6.6 300 7
6.4 300 7
run;
proc glm data=one;
class Calcium pH;
Model diameter= Calcium pH Calcium*pH;
run;
 /*based on these results, there are interactions based on the graph and its not orderly */

proc glm data=one;
class Calcium;
Model diameter= Calcium/solution; /*just to have estimate for the parameter Calcium*/
run;
proc glm data=one;
class Calcium pH;
Model diameter= Calcium pH Calcium*pH/solution;
run; /*see notes under SAS* */

proc glm data=one;
Class calcium ph;
model Diameter= Calcium ph Calcium*pH;
contrast '100 & 200 vs. 300' Calcium 1 1 -2; /* naming the contrasts ' 100 & 200 vs. 300 */
contrast '100 & 200 vs. 300' Calcium -1 -1 2;
run;
 /* above is the contrast statement from part f of exercise 14.23 */
/* we always get the same results, doesnt matter 1 1 -2 or -1 -1 2*/

proc glm data=one;
Class calcium ph;
model Diameter= Calcium ph Calcium*pH;
contrast '100 vs 200 ' Calcium 1 -1 0; /* naming the contrasts ' 100 & 200 vs. 300 */
run;
data two;
input Child A1P1 A2P1 A3P1 A1P2 A2P2 A3P2;
cards;
1 19 19 37 39 30 51 
2 36 35 6 18 47 52 
3 40 22 28 32 6 43
4 30 28 4 22 27 48 
5 4 1 32 16 44 39
6 10 27 16 2 26 33
7 30 27 8 36 33 56
8 5 16 41 43 48 43
9 34 3 29 7 23 40 
10 21 18 18 16 21 51
run;
 data one ; set two;
 length age $15;
 length prod $15;
 age= "5-6 years"; prod="breakfast"; attention_span=A1P1; output;
 age= "7-8 years"; prod="breakfast"; attention_span=A2P1; output;
 age="9-10 years"; prod="breakfast"; attention_span=A3P1; output;
 age= "5-6 years"; prod="video game"; attention_span=A1P2; output;
 age= "7-8 years"; prod="video game"; attention_span=A2P2; output;
 age="9-10 years"; prod="video game"; attention_span=A3P2; output;
 keep child age prod attention_span;
 run; 
 proc sort data=two;
 by age;
 run;
