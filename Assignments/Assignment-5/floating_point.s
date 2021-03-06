      area     appcode, CODE, READONLY
	 IMPORT printMsg   
	 IMPORT printnewLine
	 export __main	
	 ENTRY 
__main  function		 
	 VMOV.F32 S7,#1;//incrementer
	 MOV R7,#2;
	 B MAIN

PRIN ADD R8,R8,#1;
	 SDIV R6,R8,R7;
	 MUL R5,R6,R7;//FINDING MODULO
	 SUB R8,R8,R5;
	 
	 ADD R9,R9,R6;
	 SDIV R6,R9,R7;
	 MUL R5,R6,R7;
	 SUB R9,R9,R5;
	 
	 ADD R10,R10,R6;
	 SDIV R6,R10,R7;
	 MUL R5,R6,R7;
	 SUB R10,R10,R5;
	 VMOV.F32 S11,R8;
	 VMOV.F32 S12,R9;
	 VMOV.F32 S13,R10;
	 VCVT.F32.U32 s11,S11;//A
	 VCVT.F32.U32 s12,S12;//B
	 VCVT.F32.U32 s13,S13;//C
	 
	 BX lr
	 
SIG	 VMOV.F32 s1,#1;//sigmoid subroutine
	 VMOV.F32 s2,#1;//i
	 VMOV.F32 s4,#1;
	 VMOV.F32 R2,s1;
loop VDIV.F32 s3,s0,s2;//finding x/i
	 VMUL.F32 s4,s4,s3;//finding x^i/i=(x^i-1/(i-1))*i/n
	 VADD.F32 s1,s1,s4;//s1(before)=1+x+...+x^i-1/(i-1) 
	 VADD.F32 s2,s2,S7;
	 VMOV.F32 R1,s1;
	 CMP R1,R2;
	 MOVNE R2,R1;
	 BNE loop;
	 VADD.F32 S8,S1,s7;
	 VDIV.F32 S9,S1,S8;
	 BX lr
	 
	 
RESET MOV R0,#0;
	  MOV R8,#0;
	  MOV R9,#0;
	  MOV R10,#0;
	  MOV R6,#0;
	  VMOV.F32 s11,R8;
	  VMOV.F32 S12,R9;
	  VMOV.F32 S13,R10;
	  BX lr
	  
MAIN BL RESET
	 VMOV.F32 s14,#1;//bias
	 ;AND GATE
	 VLDR.F32 s15,=2;//weight A
	 VLDR.F32 s16,=2;//weight B
	 VLDR.F32 s17,=2;//weight C
	 VLDR.F32 s18,=-5;//weight bias
	 
AND_L VLDR.F32 S0,=0;//OUTPUT
	  VFMA.F32 S0,S11,S15;
	  VFMA.F32 S0,S12,S16;
	  VFMA.F32 S0,S13,S17;
	  VFMA.F32 S0,S14,S18;
	  BL SIG
	  MOV R0,R8;
	 
	 BL printMsg;
	 MOV R0,R9;
	 BL printMsg;
	 MOV R0,R10;
	 BL printMsg;
	 VCVTR.U32.F32 S9,S9;
	 VMOV.F32 R0,S9;
	 BL printMsg;
	 BL printnewLine;
	 BL PRIN
	  CMP R6,#1;
	  BNE AND_L;
	  BL printnewLine;
	  BL RESET
	  
	 ;OR GATE
OR_L	 VLDR.F32 s15,=2;//weight A
		 VLDR.F32 s16,=2;//weight B
		 VLDR.F32 s17,=2;//weight C
		 VLDR.F32 s18,=-1;//weight bias
	 
	 VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 MOV R0,R8;
	 
	 BL printMsg;
	 MOV R0,R9;
	 BL printMsg;
	 MOV R0,R10;
	 BL printMsg;
	 VCVTR.U32.F32 S9,S9;
	 VMOV.F32 R0,S9;
	 BL printMsg;
	  BL printnewLine;
	  BL PRIN
	 CMP R6,#1;
	 BNE OR_L;
	  BL printnewLine;
	 BL RESET
	 
	 ;NOT GATE
	VLDR.F32 s15,=-2;//weight A
	 VLDR.F32 s18,=1;//weight bias
	 
NOT_L	 VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 MOV R0,R8;
	 BL printMsg;
	 VCVTR.U32.F32 S9,S9;
	 VMOV.F32 R0,S9;
	 BL printMsg;
	 BL printnewLine;
	 ADD R8,R8,#1;
	 CMP R8,#2;
	 BNE NOT_L;
	  BL printnewLine;
	 BL RESET
	 	 
	;XOR GATE
XOR_L	  VLDR.F32 s15, =-2.0
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
	 MOV R0,R8;
	 
	 BL printMsg;
	 MOV R0,R9;
	 BL printMsg;
	 MOV R0,R10;
	 BL printMsg;
	 VCVTR.U32.F32 S9,S9;
	 VMOV.F32 R0,S9;
	 BL printMsg;
	  BL printnewLine;
	 BL PRIN
	 CMP R6,#1;
	 BNE XOR_L;
	 BL printnewLine;
	 BL RESET
	 
	 ;XNOR GATE
XNOR_L VLDR.F32 s15, =2.0
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
	 MOV R0,R8;
	 
	 BL printMsg;
	 MOV R0,R9;
	 BL printMsg;
	 MOV R0,R10;
	 BL printMsg;
	 VCVTR.U32.F32 S9,S9;
	 VMOV.F32 R0,S9;
	 BL printMsg;
	 BL printnewLine;
	 BL PRIN
	 CMP R6,#1;
	 BNE XNOR_L;
	  BL printnewLine;
	 BL RESET
	 
	 ;NAND GATE
	 VLDR.F32 s15,=-2;//weight A
	 VLDR.F32 s16,=-2;//weight B
	 VLDR.F32 s17,=-2;//weight C
	 VLDR.F32 s18,=5;//weight bias
	 
NAND_L	 VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 MOV R0,R8;
	 
	 BL printMsg;
	 MOV R0,R9;
	 BL printMsg;
	 MOV R0,R10;
	 BL printMsg;
	 VCVTR.U32.F32 S9,S9;
	 VMOV.F32 R0,S9;
	 BL printMsg;
	 BL printnewLine;
	  BL PRIN
	 CMP R6,#1;
	 BNE NAND_L;
	  BL printnewLine;
	 BL RESET
	 
	 ;NOR GATE
NOR_L	 VLDR.F32 s15,=-2;//weight A
	 VLDR.F32 s16,=-2;//weight B
	 VLDR.F32 s17,=-2;//weight C
	 VLDR.F32 s18,=1;//weight bias
	 
	 VLDR.F32 S0,=0;//OUTPUT
	 VFMA.F32 S0,S11,S15;
	 VFMA.F32 S0,S12,S16;
	 VFMA.F32 S0,S13,S17;
	 VFMA.F32 S0,S14,S18;
	 BL SIG
	 MOV R0,R8;
	 
	 BL printMsg;
	 MOV R0,R9;
	 BL printMsg;
	 MOV R0,R10;
	 BL printMsg;
	 VCVTR.U32.F32 S9,S9;
	 VMOV.F32 R0,S9;
	 BL printMsg;
	 BL printnewLine;
	  BL PRIN
	 CMP R6,#1;
	 BNE NOR_L;
fullstop    B  fullstop ; stop program	   
     endfunc
     end
