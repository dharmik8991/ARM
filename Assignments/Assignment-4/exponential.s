	 AREA    appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION		 		
     VLDR.F32 s0,=10;//x value in e^x
	 VMOV.F32 s1,#1;//output
	 VMOV.F32 s2,#1;//i
	 VMOV.F32 s4,#1;
	 VMOV.F32 S7,#1;//incrementer
	 VMOV.F32 r2,s1;
	 ;implementing
	 ;a=1
	 ;for(i=1;i<=N;i++)
	 ;{
	 ;	c=x/i
	 ;	b=x^(i-1)/(i-1)
	 ;  a=a+b*c
	 ;}
loop VDIV.F32 s3,s0,s2;//finding x/i
	 VMUL.F32 s4,s4,s3;//finding x^i/i=(x^i-1/(i-1))*i/n
	 VADD.F32 s1,s1,s4;//s1(before)=1+x+...+x^i-1/(i-1) 
	 VADD.F32 s2,s2,S7;
	 VMOV.F32 r1,s1;
	 CMP r1,r2;
	 MOVNE r2,r1;
	 BNE loop;
stop B stop ; stop program
     ENDFUNC
     END