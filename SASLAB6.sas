/*Lab 5 */
data tablets;
do site = 1 to 2;
do batches = 1 to 3;
do tablets = 1 to 5;
input y;
output;
end;
end;
end;
cards;
5.03
5.10
5.25
4.98
5.05
4.64
4.73
4.82
4.95
5.06
5.10
5.15
5.20
5.08
5.14
5.05
4.96
5.12
5.12
5.05
5.46
5.15
5.18
5.18
5.11
4.90
4.95
4.86
4.86
5.07

;
run;
proc glm data = tablets; /*Nested model */
class site batches;
model y=site batches(site);
random batches(site)/test; /*if you dont put /test it would not get a correct F test*/
title " Mixed effect nested model, major effect is fixed, minor effect is random";
run;
quit;
proc glm data = tablets; /*Nested model */
class site batches;
model y=site batches(site)/E1;/*E1 gives you type 1 ss instead of type 3 - if you dont, you will get type3, and we prefer type 3 */
random batches(site); /*if you dont put /test it would not get a correct F test*/
title " Mixed effect nested model, major effect is fixed, minor effect is random";
run;
quit;
proc nested data = tablets; /*you can also use nested isntead of glm, you wont need the model section anymore, calculate correct F test, no /TEST is needed to be added */
class site batches;
var y;
title " Mixed effect nested model, major effect is fixed, minor effect is random";
run;
quit;
data glass;
DO head= 1 TO 4;
do machine = 'A' , 'B', 'C', 'D' , "E";
DO rep= 1 to 4;
input y@@; /*tells SAS its a loop and it needs to keep going back */
output;
end;
end;
end;
cards;
6 13 1 7 10 2 4 0 0 10 8 7 11 5 1 0 1 6 3 3
2 3 10 4 9 1 1 3 0 11 5 2 0 10 8 8 4 7 0 7
0 9 0 7 7 1 7 4 5 6 0 5 6 8 9 6 7 0 2 4
8 8 6 9 12 10 9 1 5 7 7 4 4 3 4 5 9 3 2 0

;
run;

proc nested data = glass; /*you can also use nested isntead of glm, you wont need the model section anymore, calculate correct F test, no /TEST is needed to be added */
class machine head;
var y;
title " Mixed effect nested model, major effect is fixed, minor effect is random";
run;
quit;
proc glm data = glass; /*Nested model */
class machine head;
model y= machine head(machine);
random head(machine/test; /*if you dont put /test it would not get a correct F test*/
title " Mixed effect nested model, major effect is fixed, minor effect is random";
run;
quit;
