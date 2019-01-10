%{
#include "string.h"
#include "y.tab.h"
int yyparse();
int yywrap();
%}

%%
[0-9]+ {
yylval.vName = malloc(strlen(yytext));
strcpy(yylval.vName,yytext);
printf("dziesietna: %s \n",yylval.vName);
return DECVAL;
}
0x[A-F[0-9]*]* {
yylval.vName = malloc(strlen(yytext));
strcpy(yylval.vName,yytext);
printf("szestnastkowa: %s \n",yytext);
return HEXVAL;
}
[0-9]+\.[0-9]{2} {
yylval.vName = malloc(strlen(yytext));
strcpy(yylval.vName,yytext);
printf("staloprzecinkowa: %s \n",yylval.vName);
return STPVAL;
}
[0-9]+\.[0-9]+E(\+|\-)[0-9]+ {
yylval.vName = malloc(strlen(yytext));
strcpy(yylval.vName,yytext);
printf("z dopelnieniem: %s \n",yylval.vName);
return STDVAL;
}
[\n] {
	return ENDL;
	}
%%