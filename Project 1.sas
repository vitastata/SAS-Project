/* Project 1 */
/* Vitastata Sharma */
/********************************************************************************************/

/* FACTOR ANALYSIS*/

/********************************************************************************************/

libname mylib "/home/vitastasharma110/";
filename project1 "/home/vitastasharma110/project1_data_25.csv";
/*Import file*/
data mylib.project2;  
    drop PBEVE_Index;                                           
    infile project1 dlm=','  Firstobs= 9;
    input PBEVE_Index    PCOCO_USD 	PCOFFOTM_USD    PROIL_USD    PCOPP_USD 
    PCOTTIND_USD    PFISH_USD   PHIDE_USD    PIORECR_USD    PLAMB_USD    PLEAD_USD  
    PNICK_USD  POILAPSP_USD    POILDUB_USD  POLVOIL_USD    PORANG_USD  PPORK_USD  
    PPOULT_USD  PSALM_USD  PSAWMAL_USD  PSAWORE_USD  PSHRI_USD	  PSMEA_USD  	
    PURAN_USD 	PWHEAMT_USD  PZINC_USD   ; 
    run;
   
  
proc print data= mylib.project2 ;
run;

/********************************************************************************************/
/*Determining Missing Values In The Dataset*/

proc means data= mylib.project2 n nmiss;
	title "Missing Values Report";
run;
title;

/*Result: No missing values in the data-set*/
/********************************************************************************************/
/* Stardardizing the Data */
proc standard data=mylib.project2 out=mylib.standard mean=0 std=1;
	var _numeric_;
run;

proc means data=mylib.standard nmiss mean std maxdec= 0;
	title "Report After Data Standardization";
run;
title;

/********************************************************************************************/
/* Without rotation*/

ods graphics on;
PROC FACTOR DATA= mylib.standard 
    	    METHOD=PRINCIPAL
   	    Reorder 
   	    Corr
   	    plot= all;
   	    VAR PCOCO_USD--PZINC_USD;
   TITLE "Factor Analysis Without Rotation";
RUN;
ods graphics off;

/*Analysis- Number of Factors= 4*/

/********************************************************************************************/
/* With Rotation*/
/********************************************************************************************/
/*Orthogonal Rotation*/
/* Rotation- VARIMAX*/
ods graphics on;
PROC FACTOR DATA= mylib.standard
            METHOD=PRINCIPAL
            ROTATE= VARIMAX reorder
            Corr
            plot = SCREE
            PRIORS=ONE
            NFACTORS= 4 OUT=mylib.rotated;
            VAR PCOCO_USD--PZINC_USD;
   TITLE "Factor Analysis With Rotation = VARIMAX";
RUN;
ods graphics off;

/* Rotation- 2*/
ods graphics on;
PROC FACTOR DATA= mylib.standard
            METHOD=PRINCIPAL
	    ROTATE=EQUAMAX reorder
	    Corr
            plots=SCREE
            PRIORS=ONE
            NFACTORS= 4 OUT=mylib.rotated2;
            VAR PCOCO_USD--PZINC_USD;
   TITLE "Factor Analysis With Rotation = EQUAMAX";
RUN;
ods graphics off;
/********************************************************************************************/
/* Rotation- 3 */
/* Oblique Rotations-In oblique rotations the new axes are free to take any position in the factor space, but the degree of correlation allowed among factors is, 
in general, small because two highly correlated factors are better interpreted as only one factor. Oblique rotations, therefore, relax the orthogonality constraint 
in order to gain simplicity in the interpretation*/

ods graphics on;
PROC FACTOR DATA= mylib.standard 
	    METHOD=PRINCIPAL 
            rotate= promax reorder
            Corr
            plots=SCREE
            PRIORS=ONE
            NFACTORS= 4 OUT=mylib.rotated3;
            VAR PCOCO_USD--PZINC_USD;
   TITLE "Factor Analysis With Rotation = PROMAX ";
RUN;
ods graphics off;

/********************************************************************************************/
