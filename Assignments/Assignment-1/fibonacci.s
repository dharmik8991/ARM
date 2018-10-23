	 AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION		 		
        MOV r0,#6;//Number for which factorial to be found
		MOV r1,#0;//Fib(0)
		MOV r2,#1;//Fib(1)
		CMP r0,#2;//checking for Fib(0) and Fib(1)
		MOVLT r3,r0;//Fib(0)=0 and Fib(1)=1
		BLT stop
loop	CMP r0,#1;
		ADDNE r3,r1,r2;//computing the existing value i.e Fib(n)=Fib(n-1)+Fib(n-2)
		MOVNE r1,r2;//storing 2nd last computed value
		MOVNE r2,r3;//storing last computed value
		SUBNE r0,r0,#1;//i=i-1
		BNE loop;//Output is stored in r3
stop B stop ; stop program
     ENDFUNC
     END