%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "minipy.tab.h"
    extern YYSTYPE yylval;
    extern int ligne=1 ,colonne=1;
%}

%option noyywrap

lettre [a-z]
lettremaj [A-Z]
chiffre [0-9]
tab \t
vide  \t+
saut_ligne \n+
space " "


bool "true"|"false"
int -?([1-9][0-9]*|0)
float {int}\.[0-9]*[1-9]
idf {lettremaj}{lettre}*{chiffre}*{lettre}*

Varint "int"
Varfloat "float"
Varbool "bool"
Varchar "char"
commentaire #.*\n
affectation "="

comp "=="|"<"|"<="|"!="|">"|">="
and "and"
or "or"
not "not"
op "+"|"-"|"*"|"/"

if "if"
else "else"
for "for"
inrange "in range"
in "in"
while "while"

vg ","
paropen "\("
parclose "\)"
curlopen "\{"
curlclose "\}"
apostrophe "'"
squaropen "\["
squarclose "\]"




%%
{Varint}  {yylval.str=strdup(yytext);colonne+=yyleng;return token_Varint}
{Varfloat} {yylval.str=strdup(yytext);colonne+=yyleng;}
{Varbool} {yylval.str=strdup(yytext);colonne+=yyleng;}
{Varchar} {yylval.str=strdup(yytext);colonne+=yyleng;} 
{if} {yylval.str=strdup(yytext);colonne+=yyleng;}
{else} {yylval.str=strdup(yytext);colonne+=yyleng;}
{for} {yylval.str=strdup(yytext);colonne+=yyleng;}
{while} {yylval.str=strdup(yytext);colonne+=yyleng;} 
{inrange} {yylval.str=strdup(yytext);colonne+=yyleng;}
{idf} {if(yyleng<=8){yylval.str=strdup(yytext); colonne+=yyleng;} else{printf("error\n");}}
{int} {yylval.entier=atoi(yytext);colonne+=yyleng;}
{float} {yylval.float=atof(yytext);colonne+=yyleng;}
{bool} {yylval.str=strdup(yytext);colonne+=yyleng;}
{op} {yylval.str=strdup(yytext); colonne+=yyleng;}
{not} {yylval.str=strdup(yytext);colonne+=yyleng;}
{and} {yylval.str=strdup(yytext);colonne+=yyleng;}
{or} {yylval.str=strdup(yytext);colonne+=yyleng;}
{comp} {yylval.str=strdup(yytext);colonne+=yyleng;}
":" {yylval.str=strdup(yytext);colonne++;}
{affectation} {yylval.str=strdup(yytext);colonne++;}
{squarclose} {yylval.str=strdup(yytext);colonne++;}
{squaropen} {yylval.str=strdup(yytext);colonne++;}
{parclose} {yylval.str=strdup(yytext);colonne++;}
{paropen} {yylval.str=strdup(yytext);colonne++;}
{curlclose} {yylval.str=strdup(yytext);colonne++;}
{curlopen} {yylval.str=strdup(yytext);colonne++;}
{vg} {yylval.str=strdup(yytext);colonne++;}
{commentaire} {ligne++;colonne=0;}
{saut_ligne} {ligne++;colonne=0;}
{space} {colonne++;}
{tab} {colonne+=yyleng;}
{vide} {colonne+=yyleng;}
. {printf ("erreur lexicale ligne %d, colonne %d\n",ligne,colonne);}
%%



int main(){
    yyin=fopen("input.txt","r");
    yylex();
    fclose(yyin);
    return 0;
}