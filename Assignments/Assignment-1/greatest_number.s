     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION		 		
     MOV R0,#3;//First number
	 MOV R1,#24;//second number
	 MOV R2,#20;//third number
	 CMP R0,R1;//comparing first two register values
	 MOVLT R3,R1;//storing the highest in intermediate register
	 MOVGE R3,R0;
	 CMP R3,R2;//comparing it with the third register 
	 MOVLT R4,R2;//storing the final output
	 MOVGE R4,R3;
stop B stop ; stop program
     ENDFUNC
     END