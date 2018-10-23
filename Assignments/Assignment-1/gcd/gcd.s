	 AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION		 		
        MOV r1,#10 
        MOV r2,#25
loop    CMP r1, r2
        SUBGT r1,r1,r2;//r1=r1-r2 when r1>r2
		SUBLT r2,r2,r1;//r2=r2-r1 when r2>r1
        BNE loop ;//loop breaks when r1==r2 i.e Z==1
stop B stop ; stop program
     ENDFUNC
     END