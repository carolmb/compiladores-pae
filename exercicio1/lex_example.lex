%{
	//LIBRARY
    #include "token.c"

    #include <stdlib.h>
    
	//VARIABLES
    int lines = 1;
    int column = 1;

    void yyerror (char *s); 

%}

%{
    
	int baseBlock ( int token_id, const char* name) {
	    
        printf("token_id:%d, name:%s\n", token_id, name);
	    
	    return token_id;
	}
	
%}
%x COMMENT2

LINE            \n

INT_VALUE       [0-9]+
REAL_VALUE      [0-9]+"."[0-9]+

ID              ([_a-zA-Z]+[_a-zA-Z0-9]*)+

/*PRIMITIVE TYPES*/
INT             inteiro
REAL            real

/*KEYWORD*/
VAR             var
TYPE            tipo
IF              se 
THEN            entao 
ELSE            senao 

/*ARITHMETIC OPERATOR*/
SUM             "+"
MINOR           "-"
MULT            "*"
DIVISION        "/"

/*LOGIC OPERATOR*/
NOT             "!"
AND             "&&"
OR              "||"
LESS            "<"
GREATER         ">"
LESSEQ          "<="
GREATEQ         ">="
EQUAL           "=="
NOTEQ           "!="


/*OTHER OPERATOR*/
SEMICOMMA       ";"
COMMA           ","
COLON           ":"
ASSIGN          "="
CASSIGN         ":="

SCOMMENT        \*\*.* 

%%

{LINE}      {
                ++lines;
                column = 1;
            }

%{
    //======================================
    
    //COMMENT
    
    //======================================
%}

{SCOMMENT}  /* eat up one-line comments */


%{
    //======================================
    
    //TYPE
    
    //======================================
%}

{INT}       { return baseBlock ( INT, "INT" ); }

{REAL}      { return baseBlock ( REAL, "REAL" ); }
            

%{
    //======================================
    
    //VALUE
    
    //======================================
%}

{INT_VALUE}		{ return baseBlock ( INT_VALUE, "INT_VALUE" ); }    

{REAL_VALUE}	{ return baseBlock ( REAL_VALUE, "REAL_VALUE" ); }    
    
%{
    //======================================
    
    //KEYWORD
    
    //======================================
%}
			
{VAR}		{ return baseBlock ( VAR, "VAR" ); }    

{TYPE}		{ return baseBlock ( TYPE, "TYPE" ); }    
			
%{
    //======================================
    
    //CONDITIONAL STRUCTURE
    
    //======================================
%}
	
			
{IF}		{ return baseBlock ( IF, "IF" ); } 
			
{THEN}		{ return baseBlock ( THEN, "THEN" ); } 
			
{ELSE}		{ return baseBlock ( ELSE, "ELSE" ); } 
			


%{
    //======================================
    
    //ARITHMETIC OPERATOR 
    
    //======================================
%}

{SUM}		{return yytext[0];} 
 
{MINOR}		{return yytext[0];} 
 
{MULT}		{return yytext[0];} 
 
{DIVISION}	{return yytext[0]; } 

			
%{
    //======================================
    
    //OTHER OPERATOR
    
    //======================================
%}
 
{SEMICOMMA}	{ return yytext[0];} 
 
{COMMA}		{ return yytext[0]; } 
  
{ASSIGN}	{ return yytext[0]; } 
 
{CASSIGN}	{ return baseBlock ( CASSIGN, "CASSIGN" ); } 

{ID}        { return baseBlock ( ID, "ID" ); }

<<EOF>>     { return baseBlock ( FINAL, "FINAL" ); }   

%%

void openFile(int argc, char **argv){
    ++argv, --argc;  /* skip over program name */
	
	if ( argc > 0 ){
	        yyin = fopen( argv[0], "r" );
	}else{
	        yyin = stdin;
    }
}
