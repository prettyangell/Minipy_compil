%{
#include <stdlib.h>
#include <stdio.h>
#include "syntaxique.tab.h"
extern int ligne,colonne;
extern YYSTYPE yylval;
%}

%option noyywrap
lettreMin [a-z]
lettreMaj [A-Z]
chiffre [0-9]
tab \t
vide \t+
space " "
saute_ligne \n+
commentaire #.*\n

bool "true"|"false"
int_signe "\-"([1-9]{chiffre}*)
int_nsigne ([1-9]{chiffre}*|0)
float_signe {int_signe}\.{int_nsigne}
float_nsigne {int_nsigne}\.{int_nsigne}
idf {lettreMaj}{lettreMin}*{chiffre}*{lettreMin}*
char "\'.\'"
const {float_signe}|{float_nsigne}|{int_signe}|{int_nsigne}
TAB   \[{int_nsigne}\]


egal "=="
sup ">"
inf "<"
inf_eql "<="
sup_eql ">="
not_eql "!="

affectation "="

and "and"
or "or"
not "not"

add "+"
sub "-"
mult "*"
div "/"

vg ","
paropen "\("
parclose "\)"
curlopen "\{"
curlclose "\}"
apostrophe "'"
squaropen "\["
squarclose "\]"

Varint "int"
Varfloat "float"
Varbool "bool"
Varchar "char"
Varconst "const"

if "if"
else "else"
for "for"
while "while"
in "in"
inrange "inrange"


%%
LIST_DEC               {colonne+=yyleng; return mc_LIST_DEC;}
LIST_INST              {colonne+=yyleng; return mc_LIST_INST;}
LIST_IDF               {colonne+=yyleng; return mc_LIST_IDF;}                
DEC_VAR                {colonne+=yyleng; return mc_DEC_VAR;}
TYPE_VAR               {colonne+=yyleng; return mc_TYPE_VAR;}
VAL                    {colonne+=yyleng; return mc_VAL;}
DEC_TAB                {colonne+=yyleng; return mc_DEC_TAB;}
AFFICTATION            {colonne+=yyleng; return mc_AFFICTATION;}
EXPRESSION             {colonne+=yyleng; return mc_EXPRESSION;}
EXP_PAR                {colonne+=yyleng; return mc_EXP_PAR;}
EXP_SIMPLE             {colonne+=yyleng; return mc_EXP_SIMPLE;}
OPERANDE               {colonne+=yyleng; return mc_OPERANDE;}
OPERATEUR              {colonne+=yyleng; return mc_OPERATEUR;}
CONDITION              {colonne+=yyleng; return mc_CONDITION;}
IF_SIMPLE              {colonne+=yyleng; return mc_IF_SIMPLE;}
IF_ELSE                {colonne+=yyleng; return mc_IF_ELSE;}
BOUCLE                 {colonne+=yyleng; return mc_BOUCLE;}
BOUCLE_1               {colonne+=yyleng; return mc_BOUCLE_1;}
BOUCLE_2               {colonne+=yyleng; return mc_BOUCLE_2;}
WHILE                  {colonne+=yyleng; return mc_WHILE;}
COND_CASE              {colonne+=yyleng; return mc_COND_CASE;}
OPR_LOGIQUE_COMPARISON {colonne+=yyleng; return mc_OPR_LOGIQUE_COMPARISON;}
OP_COMP                {colonne+=yyleng; return mc_OP_COMP;}
OP_LOG                 {colonne+=yyleng; return mc_OP_LOG;}

{TAB}         {printf ("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_TAB;}
{Varconst}    {printf ("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_varconst;}
{Varint}      {printf ("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_varint;}
{Varfloat}    {printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_varfloat;}
{Varbool}     {printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_varbool;}
{Varchar}     {printf("%s est un mot cle \n",yytext);colonne+=yyleng;return mc_varchar;} 
{if}          {printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_if;}
{else}        {printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_else;}
{for}         {printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_for;}
{while}       {printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_while;} 
{inrange}     {printf("%s est unm mot cle\n",yytext);colonne+=yyleng;return mc_inrange;}
{in}          {printf("%s est unm mot cle\n",yytext);colonne+=yyleng;return mc_in;}
{idf}         {if(yyleng<=8){
                yylval.str=strdup(yytext); 
                printf("%s est un idf\n",yytext);
                colonne+=yyleng;
                }
                else{
                printf("Erreur lexicale: ligne %d , colonne %d\n",ligne,colonne);
            	printf("[%s] depasement de taille d'un idf\n",yytext);
                }
                return mc_idf;
              }

{int_nsigne}   {
	        if((Atoi_v2(yytext)>=0) && (Atoi_v2(yytext)<=32767)){
	        	yylval.entier=Atoi_v2(yytext);
            	printf ("%s l'entite est une entier no signe\n", yytext);
                
                }
            else{
            	printf("Erreur lexicale: ligne %d , colonne %d\n",ligne,colonne);
            	printf("[%s]depacement de taille\n",yytext); return error;
                }
			 colonne+=yyleng;
            return mc_int_nsigne; 
			} 
		      

{int_signe}   {if((Atoi_v2(yytext)>=-32768) && (Atoi_v2(yytext)<=-1)){
                    yylval.entier=Atoi_v2(yytext);                          
                    printf ("(%s)est un entier negative\n", yytext);
                    colonne+=yyleng;
                }
                else{
                    printf("Erreur lexicale: ligne %d , colonne %d\n",ligne,colonne);
                    printf("[%s] depassement de taile d'un entier negative\n",yytext);
                    return error;
                    }
                
                return mc_int_signe;
                }

{float_nsigne} {yylval.real=Atoi_v2(yytext);
                printf ("%s est un reel positive \n", yytext);
                colonne+=yyleng; 
                return mc_float_nsigne;
                }

{float_signe}  {//yylval.real=yytext;  
                    printf ("(%s) est une entier negative \n", yytext);
                    colonne+=yyleng; 
                    /*int x=strlen(yytext)-2; 
                    int i=1,z=1;
                    if(yytext[i]!='-'){ 
                        i=2;  
                        z=2;
                    }
                    while(i<=x){ -160
                       cst[i-z]=yytext[i];
                       i++;
                    }
                    yylval.real=cst;
                    strcpy(stc,"                ");
                    colonne+=yyleng;*/
                    return mc_float_signe; 
                    }
        
{bool}        {printf("%s est un boolean\n",yytext);colonne+=yyleng;return mc_bool;}
{char}        {printf("%s est un charactere\n",yytext);colonne+=yyleng;return mc_char;}
{not}         {printf("%s est un operateur logique\n",yytext);colonne+=yyleng;return mc_not;}
{and}         {printf("%s est un operateur logique\n",yytext);colonne+=yyleng;return mc_and;}
{or}          {printf("%s est un operateur logique\n",yytext);colonne+=yyleng;return mc_or;}
{egal}        {printf("%s est un operateur de comparaison\n",yytext);colonne++;return mc_eql;}
{sup}         {printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_sup;}
{inf}         {printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_inf;}
{sup_eql}     {printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_sup_eql;}
{inf_eql}     {printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_inf_eql;}
{not_eql}     {printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_not_eql;}
{add}         {printf("%s est un separateur\n",yytext);colonne++;return mc_add;}
{div}         {printf("%s est un separateur\n",yytext);colonne++;return mc_div;}
{sub}         {printf("%s est un separateur\n",yytext);colonne++;return mc_sub;}
{mult}        {printf("%s est un separateur\n",yytext);colonne++;return mc_mult;}
{affectation} {printf("une affectation\t");colonne++;return mc_aff;}
{squarclose}  {printf("%s est un separateur\n",yytext);colonne++;return mc_sqcl;}
{squaropen}   {printf("%s est un separateur\n",yytext);colonne++;return mc_sqop;}
{parclose}    {printf("%s est un separateur\n",yytext);colonne++;return mc_prcl;}
{paropen}     {printf("%s est un separateur\n",yytext);colonne++;return mc_prop;}
{curlclose}   {printf("%s est un separateur\n",yytext);colonne++;return mc_curcl;}
{curlopen}    {printf("%s est un separateur\n",yytext);colonne++;return mc_curop;}
{vg}          {printf("%s est un separateur\n",yytext);colonne++;return mc_vg;}
{commentaire} {printf(" commentaire\n");ligne++;colonne=0;return mc_comm;}
{saute_ligne} {printf(" saute ligne\n");ligne++;colonne=0;return mc_saut;}
":"           {printf("%s est un separateur\n",yytext);colonne++;return mc_point;}
.             {printf ("erreur lexicale ligne %d, colonne %d\n",ligne,colonne);}
%%

//int main(){
   // yyin=fopen("input.txt","r");
   // yylex();
    //fclose(yyin);
    //return 0;

//}