%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
int yylex();
void yyerror(char*);

int dec=0;
int hex=0;
double stp=0.0;
double std=0.0;
int hexadecimalToDecimal(char hexVal[]);
void decToHexa(int n);
%}

%start S
%type <vName> DEC
%token <vName> DECVAL
%type <vName> HEX
%token <vName> HEXVAL
%type <vName> STP
%token <vName> STPVAL
%type <vName> STD
%token <vName> STDVAL
%token ENDL

%union {
    char* vName;
};

%%
S : DEC S
  |HEX S
  |STP S
  |STD S
  | /*nic*/
  ;
  
DEC : DEC DECVAL { dec+= atoi($2); }
    | DECVAL { dec+= atoi($1); }
	| DECVAL ENDL { dec+= atoi($1); printf("Suma calkowitych to: %u \n",dec); dec=0;}
    ;
	
HEX : HEX HEXVAL {hex +=hexadecimalToDecimal($2);}
    | HEXVAL {hex +=hexadecimalToDecimal($1);}
	| HEXVAL ENDL {hex +=hexadecimalToDecimal($1); printf("Suma szesnastkowych to: 0x%X \n",hex); hex=0;}
	;
	
STP : STP STPVAL { stp+= atof($2); }
	| STPVAL { stp+= atof($1); }
	| STPVAL ENDL {stp+= atof($1); printf("Suma staloprzecinkowych to: %f \n",stp); stp=0.0;}
	;

STD : STD STDVAL { std+= atof($2); }
	| STDVAL { std+= atof($1); }
	| STDVAL ENDL {std+= atof($1); printf("Suma staloprzecinkowych z dopelnieniem to: %f \n",std); std=0.0;}
	;

%%
int main()
{
	yyparse();
}
void yyerror(char* str)
{
	printf("%s",str);
}
int yywrap()
{
	return 0;
}
int hexadecimalToDecimal(char hexVal[]) 
{    
    int len = strlen(hexVal); 
      
    // Initializing base value to 1, i.e 16^0 
    int base = 1; 
      
    int dec_val = 0; 
      
    // Extracting characters as digits from last character 
    for (int i=len-1; i>=0; i--) 
    {    
        // if character lies in '0'-'9', converting  
        // it to integral 0-9 by subtracting 48 from 
        // ASCII value. 
        if (hexVal[i]>='0' && hexVal[i]<='9') 
        { 
            dec_val += (hexVal[i] - 48)*base; 
                  
            // incrementing base by power 
            base = base * 16; 
        } 
  
        // if character lies in 'A'-'F' , converting  
        // it to integral 10 - 15 by subtracting 55  
        // from ASCII value 
        else if (hexVal[i]>='A' && hexVal[i]<='F') 
        { 
            dec_val += (hexVal[i] - 55)*base; 
          
            // incrementing base by power 
            base = base*16; 
        } 
    } 
      
    return dec_val; 
} 
void decToHexa(int n) 
{    
    // char array to store hexadecimal number 
    char hexaDeciNum[100]; 
      
    // counter for hexadecimal number array 
    int i = 0; 
    while(n!=0) 
    {    
        // temporary variable to store remainder 
        int temp  = 0; 
          
        // storing remainder in temp variable. 
        temp = n % 16; 
          
        // check if temp < 10 
        if(temp < 10) 
        { 
            hexaDeciNum[i] = temp + 48; 
            i++; 
        } 
        else
        { 
            hexaDeciNum[i] = temp + 55; 
            i++; 
        } 
          
        n = n/16; 
    } 
      
    // printing hexadecimal number array in reverse order 
    for(int j=i-1; j>=0; j--) 
        printf("%x",hexaDeciNum[j]); 
} 