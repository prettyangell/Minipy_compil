%{
#include <stdlib.h>
#include <stdio.h>
#include<string.h>
#include "syntaxique.tab.h"
#include "tableSym.h"
extern int ligne,colonne;
char cst2[20];
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
DisAcc  (#|$|&|%)

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
LIST_DEC               {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_LIST_DEC;}
LIST_INST              {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_LIST_INST;}
LIST_IDF               {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_LIST_IDF;}                
DEC_VAR                {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_DEC_VAR;}
TYPE_VAR               {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_TYPE_VAR;}
VAL                    {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_VAL;}
DEC_TAB                {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_DEC_TAB;}
AFFICTATION            {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_AFFICTATION;}
EXPRESSION             {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_EXPRESSION;}
EXP_PAR                {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_EXP_PAR;}
EXP_SIMPLE             {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_EXP_SIMPLE;}
OPERANDE               {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_OPERANDE;}
OPERATEUR              {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_OPERATEUR;}
CONDITION              {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_CONDITION;}
IF_SIMPLE              {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_IF_SIMPLE;}
IF_ELSE                {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_IF_ELSE;}
BOUCLE                 {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_BOUCLE;}
BOUCLE_1               {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_BOUCLE_1;}
BOUCLE_2               {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_BOUCLE_2;}
WHILE                  {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_WHILE;}
COND_CASE              {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_COND_CASE;}
OPR_LOGIQUE_COMPARISON {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_OPR_LOGIQUE_COMPARISON;}
OP_COMP                {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_OP_COMP;}
OP_LOG                 {rechercher (yytext," ","Mot cle",0, 1);colonne+=yyleng; return mc_OP_LOG;}

{TAB}         {rechercher (yytext," ","Mot cle",0, 1);printf ("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_TAB;}
{Varconst}    {rechercher (yytext," ","Mot cle",0, 1);printf ("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_varconst;}
{Varint}      {rechercher (yytext," ","Mot cle",0, 1);printf ("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_varint;}
{Varfloat}    {rechercher (yytext," ","Mot cle",0, 1);printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_varfloat;}
{Varbool}     {rechercher (yytext," ","Mot cle",0, 1);printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_varbool;}
{Varchar}     {rechercher (yytext," ","Mot cle",0, 1);printf("%s est un mot cle \n",yytext);colonne+=yyleng;return mc_varchar;} 
{if}          {rechercher (yytext," ","Mot cle",0, 1);printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_if;}
{else}        {rechercher (yytext," ","Mot cle",0, 1);printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_else;}
{for}         {rechercher (yytext," ","Mot cle",0, 1);printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_for;}
{while}       {rechercher (yytext," ","Mot cle",0, 1);printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_while;} 
{inrange}     {rechercher (yytext," ","Mot cle",0, 1);printf("%s est unm mot cle\n",yytext);colonne+=yyleng;return mc_inrange;}
{in}          {rechercher (yytext," ","Mot cle",0, 1);printf("%s est unm mot cle\n",yytext);colonne+=yyleng;return mc_in;}
{bool}        {rechercher (yytext," ","Mot cle",0, 1);printf("%s est un boolean\n",yytext);colonne+=yyleng;return mc_bool;}
{char}        {rechercher (yytext," ","Mot cle",0, 1);yylval.str=strdup(yytext);printf("%s est un charactere\n",yytext);colonne+=yyleng;return mc_char;}
{idf}         {if(yyleng<=8){
                yylval.str=strdup(yytext); //strdup pour prendre la valeur de pointeur exp:x=5 donc yytext=x
                printf("%s est un idf\n",yytext);
                rechercher (yytext," ","IDF",0, 0);
                colonne+=yyleng;
                }
                else{
                printf("Erreur lexicale: ligne %d , colonne %d\n",ligne,colonne);
            	printf("[%s] depasement de taille d'un idf\n",yytext);
                }
                return mc_idf;
              }

{int_nsigne}   {
	        if((atoi(yytext)>=0) && (atoi(yytext)<=32767)){
	        	yylval.entier=atoi(yytext);
            	printf ("%s l'entite est une entier no signe\n", yytext);
                rechercher (yytext,"int_nsigne","INT",atoi(yytext),0);
                }
            else{
            	printf("Erreur lexicale: ligne %d , colonne %d\n",ligne,colonne);
            	printf("[%s]depacement de taille\n",yytext); 
             
                }
			 colonne+=yyleng;
            return mc_int_nsigne; 
			} 
		      

{int_signe}   {if((atoi(yytext)>=-32768) && (atoi(yytext)<=32767)){                          
                printf ("l'entite reconnue est ===> %s \n", yytext);
                rechercher (yytext,"cINTEGER_s","INT",atoi(yytext), 0) ;
                }
            
            else{
                
                printf("Erreur lexicale: ligne %d , colonne %d\n",ligne,colonne);
                printf("INTEGER exceeding the maximum defined size [%s]\n",yytext);
               
                }
             
                int x=strlen(yytext)-2;
            int i=1;
            int z=1;
            if(yytext[i]!='-')
            {
                i=2;  
                z=2;
            }
            while( i<=x )
            {
                cst2[i-z]=yytext[i];
                i++;
            }
                yylval.entier=atoi(cst2);
                strcpy(cst2,"                ");
                colonne= colonne+ strlen(yytext);
                return mc_int_signe;
                }

{float_nsigne} {yylval.real=atof(yytext);
                printf ("%s est un reel positive \n", yytext);
                rechercher (yytext,"float_nsigne","FLOAT",atof(yytext),0);
                colonne+=yyleng; 
                return mc_float_nsigne;
                }

{float_signe}  {yylval.real=atof(yytext);
               rechercher(yytext,"float_signe","FLOAT",atof(yytext), 0);
               colonne = colonne +strlen(yytext); 
               printf ("l'entite reconnue est ===> %s \n", yytext);
              int x=strlen(yytext)-2;
              int i=1;
              int z=1;
             if(yytext[i]!='-')
            {
                i=2;  
                z=2;
            }
            while( i<=x )
            {
                cst2[i-z]=yytext[i];
                i++;
            }
                yylval.real=atoi(cst2);
                strcpy(cst2,"                ");
                colonne= colonne+ strlen(yytext);
                    return mc_float_signe; 
              }
        
{not}         {rechercher (yytext,"Separateur",0,0,2);printf("%s est un operateur logique\n",yytext);colonne+=yyleng;return mc_not;}
{and}         {rechercher (yytext,"Separateur",0,0,2);printf("%s est un operateur logique\n",yytext);colonne+=yyleng;return mc_and;}
{or}          {rechercher (yytext,"Separateur",0,0,2);printf("%s est un operateur logique\n",yytext);colonne+=yyleng;return mc_or;}
{egal}        {rechercher (yytext,"Separateur",0,0,2);printf("%s est un operateur de comparaison\n",yytext);colonne++;return mc_eql;}
{sup}         {rechercher (yytext,"Separateur",0,0,2);printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_sup;}
{inf}         {rechercher (yytext,"Separateur",0,0,2);printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_inf;}
{sup_eql}     {rechercher (yytext,"Separateur",0,0,2);printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_sup_eql;}
{inf_eql}     {rechercher (yytext,"Separateur",0,0,2);printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_inf_eql;}
{not_eql}     {rechercher (yytext,"Separateur",0,0,2);printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_not_eql;}
{add}         {rechercher (yytext,"Separateur",0,0,2);printf("%s est un separateur\n",yytext);colonne++;return mc_add;}
{div}         {rechercher (yytext,"Separateur",0,0,2);printf("%s est un separateur\n",yytext);colonne++;return mc_div;}
{sub}         {rechercher (yytext,"Separateur",0,0,2);printf("%s est un separateur\n",yytext);colonne++;return mc_sub;}
{mult}        {rechercher (yytext,"Separateur",0,0,2);printf("%s est un separateur\n",yytext);colonne++;return mc_mult;}
{affectation} {rechercher (yytext,"Separateur",0,0,2);printf("une affectation\t");colonne++;return mc_aff;}
{squarclose}  {rechercher (yytext,"Separateur",0,0,2);printf("%s est un separateur\n",yytext);colonne++;return mc_sqcl;}
{squaropen}   {rechercher (yytext,"Separateur",0,0,2);printf("%s est un separateur\n",yytext);colonne++;return mc_sqop;}
{parclose}    {rechercher (yytext,"Separateur",0,0,2);printf("%s est un separateur\n",yytext);colonne++;return mc_prcl;}
{paropen}     {rechercher (yytext,"Separateur",0,0,2);printf("%s est un separateur\n",yytext);colonne++;return mc_prop;}
{curlclose}   {rechercher (yytext,"Separateur",0,0,2);printf("%s est un separateur\n",yytext);colonne++;return mc_curcl;}
{curlopen}    {rechercher (yytext,"Separateur",0,0,2);printf("%s est un separateur\n",yytext);colonne++;return mc_curop;}
{vg}          {rechercher (yytext,"Separateur",0,0,2);printf("%s est un separateur\n",yytext);colonne++;return mc_vg;}
{commentaire} {printf(" commentaire\n");ligne++;colonne=0;return mc_comm;}
{saute_ligne} {printf(" saute ligne\n");ligne++;colonne=0;return mc_saut;}
{DisAcc}       {yylval.str=strdup(yytext); return DisAcc;}
":"           {rechercher (yytext,"Separateur",0,0,2);printf("%s est un separateur\n",yytext);colonne++;return mc_point;}
. {printf ("erreur lexicale ligne %d, colonne %d\n",ligne,colonne);}
%%

//int main(){
   // yyin=fopen("input.txt","r");
   // yylex();
    //fclose(yyin);
    //return 0;

//}