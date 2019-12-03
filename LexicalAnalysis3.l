%{
#include "SyntaxAnalysis.tab.h"
#include "stdio.h"
#include "string.h"
int yycolumn=1;
#define YY_USER_ACTION yylloc.first_line=yylloc.last_line=yylineno; \
yylloc.first_column=yycolumn;	yylloc.last_column=yycolumn+yyleng-1; yycolumn+=yyleng;
typedef union 
{
	int type_int;
	float type_float;
	char type_char;
	char type_id[32];
	struct node *ptr;
} YYLVAL;

#define YYSTYPE YYLVAL

int yywrap();
void annotation();
int main();
%}


%option yylineno


id [A-Za-z][A-Za-z0-9]*
int 0|[1-9][0-9]*
float ([0-9]*\.[0-9]+)|([0-9]+\.)
char [A-Z]|[a-z]|"!"|"@"|"#"|"$"|"%"|"^"|"&"|"*"|"("|")"|"_"|"-"|"+"|"="|"\\"|"{"|"}"|"["|"]"|":"|";"|"'"|"<"|">"|","|"."|"?"|"/"|"~"|"`"


%%

{int}        {yylval.type_int=atoi(yytext); return INT;}
{float}      {yylval.type_float=atof(yytext); return FLOAT;}
"'"{char}"'" {yylval.type_char=yytext[1]; return CHAR;}
"int"        {strcpy(yylval.type_id, yytext);return TYPE;}
"float"      {strcpy(yylval.type_id, yytext);return TYPE;}
"char"       {strcpy(yylval.type_id, yytext);return TYPE;}

"return"     {return RETURN;}
"if"         {return IF;}
"else"       {return ELSE;}
"while"      {return WHILE;}
"for"		 {return FOR;}



{id}       {
			strcpy(yylval.type_id,  yytext);
			return ID;
			}


";"			{
			
			return SEMI;
			}

","			{
			
			return COMMA;
			}

">"|"<"|">="|"<="|"=="|"!=" {
							strcpy(yylval.type_id, yytext);
							return RELOP;
							}

"="			{
			
			return ASSIGNOP;
			}

"+"			{
			
			return PLUS;
			}

"++"        {
			
			return SELFPLUS;
			}

"-"			{
			
			return MINUS;
			}

"--"        {
			
			return SLEFMINUS;
			}

"*"			{
			
			return STAR;
			}

"/"			{
			
			return DIV;
			}

"!"			{
			
			return NOT;
			}
"&&"        {
			
			return AND;
			}
"||"        {
			
			return OR;
			}
			
"("			{
			
			return LP;
			}

")"			{
			
			return RP;
			}

"{"			{
			
			return LC;
			}

"}"			{
			
			return RC;
			}

"["         {
			
			return LB;
			}

"]"         {
			
			return RB;
			}

"/*"        annotation();

"//"[^\n]*\n  ;

[\r\t]     {;}
" "		   {;}
[\n]        {yycolumn=1;}  

.			{printf("Error type A :Unknown character \"%s\"\n\t at Line %d\n",yytext,yylineno);}
%%



int yywrap()
{
	return 1;
}

void annotation()
{
	char c=0,c1=0;
	printf("annotation: ");
loop:
	
	
	 while ((c = input()) != '*' && c != 0)
	 {
		putchar(c); 
	 }
        
    if ((c1 = input()) != '/' && c != 0)
    {
        unput(c1);
        goto loop;
    }
}

/*
int main(int argc, char** argv){
	if(argc > 1)
	{
		if(!(yyin = fopen(argv[1], "r")))
		{
			perror(argv[1]);
			return 1;
		}
	}
	while(yylex() != 0);
	return 0;
}
*/