%{
#include <stdio.h>
#include <stdlib.h>
#include "minipy.tab.h"
extern YYSTYPE yylval;
extern int ligne=1 ,colonne=1;

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
List_Dec  {colonne+=yyleng; return mc_List_Dec;}
List_Inst {colonne+=yyleng; return mc_List_Inst;}
Dec_Var   {colonne+=yyleng; return mc_Dec_Var;}
Type_Var  {colonne+=yyleng; return mc_Type_Var;}
Val       {colonne+=yyleng; return mc_Val;}
Dec_Tab   {colonne+=yyleng; return mc_Dec_Tab;}
{Varconst} {printf ("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_varconst}
{Varint} {printf ("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_varint}
{Varfloat} {printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_varfloat}
{Varbool} {printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_varbool}
{Varchar} {printf("%s est un mot cle \n",yytext);colonne+=yyleng;return mc_varchar} 
{if} {printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_if}
{else} {printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_else}
{for} {printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_for}
{while} {printf("%s est un mot cle\n",yytext);colonne+=yyleng;return mc_while} 
{inrange} {printf("%s est unm mot cle\n",yytext);colonne+=yyleng;return mc_inrange}
taille  {printf ("la taille de tab est ===> %s \n", yytext);return mc_taille;}

{idf}          {if(yyleng<=8){
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

{int_nsigne}   {if(yytext>=0 && yytext<=32767){
	            yylval.entier=yytext;
            	printf("%s est un entier positive\n", yytext);
                colonne+=yyleng;
                }
            else{
            	printf("Erreur lexicale: ligne %d , colonne %d\n",ligne,colonne);
            	printf("[%s] depasement de taille d'un entier\n",yytext);
                return error;
                }
             return mc_int_nsigne; 
			}

{int_signe}     {if(yytext>=-32768 && yytext<=-1){
                    yylval.entier=yytext;                          
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

{float_nsigne}  {yylval.real=yytext;
                printf ("%s est un reel positive \n", yytext);
                colonne+=yyleng; 
                return mc_float_nsigne;
                }

{float_signe}   {yylval.real=yytext;  
                    printf ("(%s) est une entier negative \n", yytext);
                    colonne+=yyleng; 
                    int x=strlen(yytext)-2;
                    int i=1,z=1;
                    if(yytext[i]!='-'){
                        i=2;  
                        z=2;
                    }
                    while(i<=x){
                       cst[i-z]=yytext[i];
                       i++;
                    }
                    yylval.real=cst;
                    strcpy(cst,"                ");
                    colonne+=yyleng;
                    return mc_float_signe; 
                    }
        
{bool} {printf("%s est un boolean\n",yytext);colonne+=yyleng;return mc_bool;}
{char} {printf("%s est un charactere\n",yytext);colonne+=yyleng;return mc_char;}
{not} {printf("%s est un operateur logique\n",yytext);colonne+=yyleng;return mc_not;}
{and} {printf("%s est un operateur logique\n",yytext);colonne+=yyleng;return mc_and;}
{or} {printf("%s est un operateur logique\n",yytext);colonne+=yyleng;return mc_or;}
{egal} {printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_egal;}
{sup} {printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_sup}
{inf} {printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_inf}
{sup_eql} {printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_sup_eql}
{inf_eql} {printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_inf_eql}
{not_eql} {printf("%s est un operateur de comparaison\n",yytext);colonne+=yyleng;return mc_not_eql}
{add} {printf("%s est un separateur\n",yytext);colonne++;return mc_add}
{div} {printf("%s est un separateur\n",yytext);colonne++;return mc_div}
{sub} {printf("%s est un separateur\n",yytext);colonne++;return mc_sub}
{mult} {printf("%s est un separateur\n",yytext);colonne++;return mc_mult}
":" {printf("%s est un separateur\n",yytext);colonne++;return mc_point}
{affectation} {printf("une affectation\t");colonne++;return mc_aff}
{squarclose} {printf("%s est un separateur\n",yytext);colonne++;return mc_sqcl}
{squaropen} {printf("%s est un separateur\n",yytext);colonne++;return mc_sqop}
{parclose} {printf("%s est un separateur\n",yytext);colonne++;return mc_prcl}
{paropen} {printf("%s est un separateur\n",yytext);colonne++;return mc_prop}
{curlclose} {printf("%s est un separateur\n",yytext);colonne++;return mc_curcl}
{curlopen} {printf("%s est un separateur\n",yytext);colonne++;return mc_curop}
{vg} {printf("%s est un separateur\n",yytext);colonne++;return mc_vg}
{commentaire} {printf(" commentaire\n");ligne++;colonne=0;return mc_comm}
{saute_ligne} {printf(" saute ligne\n");ligne++;colonne=0;return mc_saut}
. {printf ("erreur lexicale ligne %d, colonne %d\n",ligne,colonne);}
%%

//int main(){
   // yyin=fopen("input.txt","r");
   // yylex();
   //fclose(yyin);
   //return 0;

//}
