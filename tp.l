%{
    #include <stdio.h>
    #include <stdlib.h>
    int ligne=1 ,colonne=1;
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
{Varint}  {printf ("%s est un mot cle\n",yytext);colonne+=yyleng;}
{Varfloat} {printf("%s est un mot cle\n",yytext);colonne+=yyleng;}
{Varbool} {printf("%s est un mot cle\n",yytext);colonne+=yyleng;}
{Varchar} {printf("%s est un mot cle \n",yytext);colonne+=yyleng;} 
{if} {printf("%s est un mot cle\n",yytext);colonne+=yyleng;}
{else} {printf("%s est un mot cle\n",yytext);colonne+=yyleng;}
{for} {printf("%s est un mot cle\n",yytext);colonne+=yyleng;}
{while} {printf("%s est un mot cle\n",yytext);colonne+=yyleng;} 
{inrange} {printf("%s est unm mot cle\n",yytext);}
{idf} {if(yyleng<=8){printf("%s est un idf\n",yytext); colonne+=yyleng;} else{printf("error\n");}}
{int} {printf("%s est un entier\n",yytext);colonne+=yyleng;}
{float} {printf("%s est un reel\n",yytext);colonne+=yyleng;}
{bool} {printf("%s est un boolean\n",yytext);colonne+=yyleng;}
{op} {printf ("%s est un operateur arithmetique\n",yytext); colonne+=yyleng;}
{not} {printf("%s est un operateur logique\n",yytext);colonne+=yyleng;}
{and} {printf("%s est un operateur logique\n",yytext);colonne+=yyleng;}
{or} {printf("%s est un operateur logique\n",yytext);colonne+=yyleng;}
{comp} {printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;}
":" {printf("%s est un separateur\n",yytext);colonne++;}
{affectation} {printf("une affectation\t");colonne++;}
{squarclose} {printf("%s est un separateur\n",yytext);colonne++;}
{squaropen} {printf("%s est un separateur\n",yytext);colonne++;}
{parclose} {printf("%s est un separateur\n",yytext);colonne++;}
{paropen} {printf("%s est un separateur\n",yytext);colonne++;}
{curlclose} {printf("%s est un separateur\n",yytext);colonne++;}
{curlopen} {printf("%s est un separateur\n",yytext);colonne++;}
{vg} {printf("%s est un separateur\n",yytext);colonne++;}
{commentaire} {printf(" commentaire\n");ligne++;colonne=0;}
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