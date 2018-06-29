Data one;
input Station$  Intensities;
cards;
1 20
1 1050
1 3200
1 5600
1 50
2 4300
2 70
2 2560
2 3650
2 80
3 100
3 7700
3 8500
3 2960
3 3340
run;
proc glm data=one;
title "This is a fixed effect model"; /*This will add a title to the top of the results viewer*/
class station;
model Intensities=station/solution;
run;
proc glm data=one;
title "This is a random effect model"; /*This will add a title to the top of the results viewer*/
class station;
model Intensities=station/solution;
Random station; /*to make it a random effect model*/
run;
/*Example 2 in lab 5 */
data temp;
do mode = 'I' , 'C', 'S';
DO TEMPERATURE= 1 TO 4;
DO rep= 1 to 2;
input y@@; /*tells SAS its a loop and it needs to keep going back */
output;
end;
end;
end;
cards;
12 16 15 19 31 39 53 55
15 19 17 17 30 34 51 49 
11 17 24 22 33 37 61 67
;
run;
proc glm data=temp;
title "Fixed Effect Model"; 
class mode temperature;
model y=mode|temperature;
run;
quit;
proc glm data=temp;
title "Mixed effect Model"; 
class mode temperature ;
model y=mode|temperature;
random temperature mode*temperature;
run;
proc glm data=temp;
title "Mixed effect Model"; 
class mode temperature ;
model y=mode|temperature;
random temperature mode*temperature/test;
run;

