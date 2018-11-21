      area     appcode, CODE, READONLY
	 IMPORT printMsg             
	 export __main	
	 ENTRY 
__main  function		 
     VMOV.F32 S7,#1;//incrementer
	 B MAIN
	 
SIG	 VMOV.F32 s1,#1;//sigmoid subroutine
	 VMOV.F32 s2,#1;//i
	 VMOV.F32 s4,#1;
	 VMOV.F32 r2,s1;
loop VDIV.F32 s3,s0,s2;//finding x/i
	 VMUL.F32 s4,s4,s3;//finding x^i/i=(x^i-1/(i-1))*i/n
	 VADD.F32 s1,s1,s4;//s1(before)=1+x+...+x^i-1/(i-1) 
	 VADD.F32 s2,s2,S7;
	 VMOV.F32 r1,s1;
	 CMP r1,r2;
	 MOVNE r2,r1;
	 BNE loop;
	 VADD.F32 S8,S1,s7;
	 VDIV.F32 S9,S1,S8;
	 BX lr;
MAIN VMOV.F32 s11,#1;//A
	 VMOV.F32 s12,#1;//B
	 VMOV.F32 s13,#1;//C
	 VMOV.F32 s14,#1;//bias

	 VLDR.F32 s15,=2;//weight A
	 VLDR.F32 s16,=2;//weight B
	 VLDR.F32 s17,=2;//weight C
	 VLDR.F32 s18,=-5;//weight bias
	 
	 VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 VCVTR.S32.F32 s9,s9;
	 VMOV.F32 r0,s9;
	 BL printMsg;	 

	 ;OR GATE
	 VLDR.F32 s15,=2;//weight A
	 VLDR.F32 s16,=2;//weight B
	 VLDR.F32 s17,=2;//weight C
	 VLDR.F32 s18,=-1;//weight bias
	 
	 VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 VCVTR.S32.F32 s9,s9;
	 VMOV.F32 r0,s9;
	 BL printMsg;
	 
	 ;NOT GATE
	 VLDR.F32 s15,=-2;//weight A
	 VLDR.F32 s18,=1;//weight bias
	 
	 VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 VCVTR.S32.F32 s9,s9;
	 VMOV.F32 r0,s9;
	 BL printMsg;
 	 
	;XOR GATE
	 VLDR.F32 s15, =-2.0
     VLDR.F32 s16, =2.0
     VLDR.F32 s17, =-2.0
     VLDR.F32 s18, =-1.0
   
     VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 VCVTR.S32.F32 s9,s9;
     VCVT.F32.S32 s20,s9;

     VLDR.F32 s15, =2.0
	 VLDR.F32 s16, =-2.0
	 VLDR.F32 s17, =-2.0
     VLDR.F32 s18, =-1.0
	 
	 VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 VCVTR.S32.F32 s9,s9;
     VCVT.F32.S32 s21,s9;
   
     VLDR.F32 s15, =-2.0
     VLDR.F32 s16, =-2.0
     VLDR.F32 s17, =2.0
     VLDR.F32 s18, =-1.0
   
     VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 VCVTR.S32.F32 s9,s9;
     VCVT.F32.S32 s22,s9;
   
     VLDR.F32 s15, =2.0
     VLDR.F32 s16, =2.0
     VLDR.F32 s17, =2.0
     VLDR.F32 s18, =-5.0
   
     VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 VCVTR.S32.F32 s9,s9;
     VCVT.F32.S32 s23,s9;
   
     VLDR.F32 s15, =2.0
     VLDR.F32 s16, =2.0
     VLDR.F32 s17, =2.0
     VLDR.F32 s18, =2.0
     VLDR.F32 s19, =-1.0
   
     VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S20,S15;
	 VFMA.F32 S0,S21,S16;
	 VFMA.F32 S0,S22,S17;
	 VFMA.F32 S0,S23,S18;
	 VFMA.F32 s0,s14,s19;
	 BL SIG
	 VCVTR.S32.F32 s9,s9;
     VMOV.F32 r0,s9
     BL printMsg
   
	 
	 ;XNOR GATE
	 VLDR.F32 s15, =2.0
     VLDR.F32 s16, =-2.0
     VLDR.F32 s17, =2.0
     VLDR.F32 s18, =1.0
   
     VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 VCVTR.S32.F32 s9,s9;
     VCVT.F32.S32 s20,s9;

     VLDR.F32 s15, =-2.0
	 VLDR.F32 s16, =2.0
	 VLDR.F32 s17, =2.0
     VLDR.F32 s18, =1.0
	 
	 VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 VCVTR.S32.F32 s9,s9;
     VCVT.F32.S32 s21,s9;
   
     VLDR.F32 s15, =2.0
     VLDR.F32 s16, =2.0
     VLDR.F32 s17, =-2.0
     VLDR.F32 s18, =1.0
   
     VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 VCVTR.S32.F32 s9,s9;
     VCVT.F32.S32 s22,s9;
   
     VLDR.F32 s15, =-2.0
     VLDR.F32 s16, =-2.0
     VLDR.F32 s17, =-2.0
     VLDR.F32 s18, =5.0
   
     VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 VCVTR.S32.F32 s9,s9;
     VCVT.F32.S32 s23,s9;
   
     VLDR.F32 s15, =2.0
     VLDR.F32 s16, =2.0
     VLDR.F32 s17, =2.0
     VLDR.F32 s18, =2.0
     VLDR.F32 s19, =-7.0
   
     VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S20,S15;
	 VFMA.F32 S0,S21,S16;
	 VFMA.F32 S0,S22,S17;
	 VFMA.F32 S0,S23,S18;
	 VFMA.F32 s0,s14,s19;
	 BL SIG
	 VCVTR.S32.F32 s9,s9;
     VMOV.F32 r0,s9
     BL printMsg
	 
	 ;NAND GATE
	 VLDR.F32 s15,=-2;//weight A
	 VLDR.F32 s16,=-2;//weight B
	 VLDR.F32 s17,=-2;//weight C
	 VLDR.F32 s18,=5;//weight bias
	 
	 VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 VCVTR.S32.F32 s9,s9;
	 VMOV.F32 r0,s9;
	 BL printMsg; 
	 
	 ;NOR GATE
	 VLDR.F32 s15,=-2;//weight A
	 VLDR.F32 s16,=-2;//weight B
	 VLDR.F32 s17,=-2;//weight C
	 VLDR.F32 s18,=1;//weight bias
	 
	 VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG	;
	 VCVTR.S32.F32 s9,s9;
	 VMOV.F32 r0,s9;
     BL printMsg;
	 	 
fullstop    B  fullstop ; stop program	   
     endfunc
     end
