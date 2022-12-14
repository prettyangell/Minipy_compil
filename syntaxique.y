%{
#include <stdlib.h> 
#include <string.h>
#include <stdio.h>
void intitialisation();
void afficher();
int doubleDeclaration();
void insererTYPE();
int colonne=1,ligne=1;
char saveType[50];
char saveopr[5];
int yylex(void);
int yyerror(char *msg);
%}



%union 
{ 
   int entier;
   float real;
   char* str;
}
%token  DisAcc mc_LIST_DEC mc_LIST_INST mc_LIST_IDF mc_DEC_VAR mc_DEC_TAB mc_VAL mc_AFFICTATION mc_EXPRESSION mc_EXP_PAR mc_TYPE_VAR mc_OP_COMP mc_OP_LOG mc_OPR_LOGIQUE_COMPARISON mc_COND_CASE mc_CONDITION mc_IF_ELSE mc_IF_SIMPLE mc_BOUCLE mc_OPERANDE mc_OPERATEUR mc_EXP_SIMPLE  <str>mc_idf <entier>mc_int_signe <entier>mc_int_nsigne <str>mc_char <real>mc_float_signe <real>mc_float_nsigne mc_bool mc_const mc_var mc_point mc_vg mc_comm mc_saut mc_curop mc_curcl mc_sqcl mc_sqop mc_prcl mc_prop mc_sup mc_inf mc_inf_eql mc_sup_eql mc_not_eql mc_eql mc_aff mc_else mc_while mc_inrange mc_if mc_for mc_varint mc_varfloat mc_varchar mc_varbool mc_varconst mc_add mc_div mc_sub mc_mult mc_not mc_and mc_or mc_in mc_TAB mc_WHILE mc_BOUCLE_1 mc_BOUCLE_2

%left mc_sup mc_sup_eql mc_eql mc_not_eql mc_inf_eql mc_inf 
%left mc_add mc_sub 
%left mc_mult mc_div

%start S

%%
S:LIST_DEC LIST_INST 
   {   
    printf("\n\n===========================Programme--Syntaxiquement--Correct=============================\n\n");
    YYACCEPT;
   }
;
//*****************DECLARATION***************//
LIST_DEC:DEC_VAR LIST_DEC
        |DEC_VAR mc_saut
        |DEC_TAB LIST_DEC
        |DEC_TAB mc_saut
;
         //declaration simple//
DEC_VAR:TYPE_VAR LIST_IDF
       |mc_idf mc_aff VAL mc_saut 
       {if(doubleDeclaration($1)==0)
            insererTYPE($1,saveType);
            else  
                printf("\nErreur semantique: Double declaration de {{%s}} a la ligne [%d] et a la colonne [%d]\n\n",$1,ligne,colonne);
        }
;
         //declaration tab//
DEC_TAB:TYPE_VAR mc_idf mc_sqop mc_int_nsigne mc_sqcl
;

LIST_IDF:mc_idf mc_vg LIST_IDF
         {if(doubleDeclaration($1)==0)
            insererTYPE($1,saveType);
            else  
                printf("\nErreur semantique: Double declaration de {{%s}} a la ligne [%d] et a la colonne [%d]\n\n",$1,ligne,colonne);
         }
        |mc_idf mc_saut
        {if(doubleDeclaration($1)==0)
            insererTYPE($1,saveType);
            else  
                printf("\nErreur semantique: Double declaration de {{%s}} a la ligne [%d] et a la colonne [%d]\n\n",$1,ligne,colonne);
        }
;
VAL:mc_float_signe
   |mc_float_nsigne
   |mc_int_nsigne
   |mc_int_signe
   |mc_char
;
TYPE_VAR:mc_varint   {strcpy(saveType,"INT");}
        |mc_varfloat {strcpy(saveType,"FLOAT");}
        |mc_varbool  {strcpy(saveType,"BOOL");}
        |mc_varconst {strcpy(saveType,"CONST");}
;
//************Instruction*******************//
LIST_INST:AFFICTATION mc_saut LIST_INST
         |EXPRESSION mc_saut LIST_INST
         |CONDITION LIST_INST
         |BOUCLE
         |WHILE
         |mc_saut
;
 //AFFICTATION//
AFFICTATION:mc_idf mc_aff 
          {if(doubleDeclaration($1)==0)
                  insererTYPE($1,saveType);
            else  
                printf("\nErreur semantique: Double declaration de {{%s}} a la ligne [%d] et a la colonne [%d]\n\n",$1,ligne,colonne);
          }
;
EXPRESSION:EXP_SIMPLE 
          |EXP_PAR
;

EXP_SIMPLE:OPERANDE OPERATEUR OPERANDE
          |OPERANDE OPERATEUR EXP_SIMPLE
          |OPERANDE OPERATEUR EXP_PAR
          |mc_char 'c'
;

EXP_PAR:mc_prop EXP_SIMPLE mc_prcl 
       |mc_prop EXP_PAR mc_prcl 
       |mc_prop EXP_SIMPLE mc_prcl OPERATEUR EXPRESSION
       |mc_prop EXP_SIMPLE mc_prcl OPERATEUR OPERANDE
       |mc_prop EXP_PAR mc_prcl OPERATEUR EXP_PAR
       |mc_prop EXP_PAR mc_prcl OPERATEUR OPERANDE
       |mc_prop EXP_PAR mc_prcl OPERATEUR EXP_SIMPLE
;
OPERANDE:mc_float_signe
        |mc_float_nsigne
        |mc_int_nsigne
        |mc_int_signe
        |mc_idf
        {if(doubleDeclaration($1)==0)
         insererTYPE($1,saveType);
            else  
                printf("\nErreur semantique: Double declaration de {{%s}} a la ligne [%d] et a la colonne [%d]\n\n",$1,ligne,colonne);
        }
;

OPERATEUR:mc_add {strcpy(saveopr,"+");}
         |mc_div {strcpy(saveopr,"/");}
         |mc_sub {strcpy(saveopr,"-");}
         |mc_mult {strcpy(saveopr,"*");}
;
             //CONDITIONS
CONDITION:IF_SIMPLE
        |IF_ELSE
;
//IF//
IF_SIMPLE:mc_if mc_prop COND_CASE mc_prcl mc_point mc_saut TAIL
;

IF_ELSE:mc_if mc_prop COND_CASE mc_prcl mc_point mc_saut TAIL mc_else mc_point mc_saut TAIL LIST_INST mc_saut mc_saut TAIL
;

TAIL: TAIL TB LIST_INST
    |TB LIST_INST
;	

TB:mc_TAB
	|TB mc_TAB
;	
COND_CASE:EXP_SIMPLE OPR_LOGIQUE_COMPARISON EXP_SIMPLE
         |OPERANDE OPR_LOGIQUE_COMPARISON OPERANDE
         |mc_prop COND_CASE mc_prcl OPR_LOGIQUE_COMPARISON mc_prop COND_CASE mc_prcl
         |mc_prop COND_CASE mc_prcl OPR_LOGIQUE_COMPARISON COND_CASE 
         |mc_not COND_CASE
;

OPR_LOGIQUE_COMPARISON:OP_LOG
                      |OP_COMP
;

OP_LOG:mc_and
      |mc_or
      |mc_not
;

OP_COMP:mc_sup 
       |mc_inf
       |mc_inf_eql
       |mc_sup_eql
       |mc_not_eql 
       |mc_eql
;
BOUCLE:BOUCLE_1
      |BOUCLE_2
;   

BOUCLE_1:mc_for mc_idf mc_inrange mc_prop OPERANDE mc_vg OPERANDE mc_prcl mc_point LIST_INST
;
BOUCLE_2:mc_for mc_idf mc_in mc_TAB LIST_INST
;
                //WHILE//
WHILE:mc_while mc_prop COND_CASE mc_prcl mc_point mc_saut 
;

%%
int main(){

afficher();
return 0;
}
int yyerror(char *msg){
    printf ("\n Erreur Syntaxique a ligne %d a colonne %d \n",ligne,colonne); 
    return 0;
}
