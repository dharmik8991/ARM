#include "TM4C123GH6PM.h"
void printMsg(const int a)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "%x", a);
	 ptr = Msg;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   }
}

void printnewLine()
{
	char ptr_n[5]="\n";
	ITM_SendChar(*ptr_n);
	return;
}
