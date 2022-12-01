%{
#include <stdlib.h>
#include <stdio.h>
int colonne=1,ligne=1;
%}

%union 
{ 
   int entier;
   float real;
   char* str;
}
%token LIST_DEC LIST_INST DEC_TAB
%token <str>mc_idf <entier>mc_int_signe <entier>mc_int_nsigne <str>mc_char <real>mc_float_signe
%token <real>mc_float_nsigne mc_bool mc_const mc_var 
%token mc_point mc_vg mc_comm  mc_saut mc_curop mc_curcl mc_sqcl mc_sqop mc_prcl mc_prop 
%token mc_sup mc_inf mc_inf_eql mc_sup_eql mc_not_eql mc_eql
%token mc_aff mc_else mc_while mc_inrange mc_if mc_for
%token mc_varint mc_varfloat mc_varchar mc_varbool mc_varconst 
%token mc_add mc_div mc_sub mc_mult
%token mc_not mc_and mc_or

%left mc_sup mc_sup_eql mc_eql mc_not_eql mc_inf_eql mc_inf 
%left mc_add mc_sub 
%left mc_mult mc_div

%start S

%%
S:LIST_DEC LIST_INST {printf("programme syntaxiquement correct");YYACCEPT;}

List_Dec:DEC_VAR 
        |DEC_VAR
        |DEC_TAB LIST_DEC
        |DEC_TAB
;
//declaration d'un variable
Dec_Var:TYPE_VAR LIST_IDF
       |mc_idf mc_aff VAL 
;      
//declaration d'un tableau int T[5]
DEC_TAB:TYPE_VAR mc_idf mc_sqop mc_int_nsigne mc_sqcl;

LIST_IDF:mc_idf mc_vg LIST_IDF
        |mc_idf mc_saut
;

VAL:mc_float_signe
   |mc_float_nsigne
   |mc_int_nsigne
   |mc_int_signe
   |mc_char
;

TYPE_VAR:mc_varint   {strcpy(savType,"INT");}
        |mc_varfloat {strcpy(savType,"FLOAT");}
        |mc_varbool  {strcpy(savType,"BOOL");}
        |mc_varconst {strcpy(savType,"CONST");}
;

//Instruction
LIST_INST:AFFICTATION mc_saut LIST_INST
         |EXPRESSION mc_saut LIST_INST
         |CONDITION LIST_INST
         |CONDITION
         |BOUCLE LIST_INST
         |BOUCLE
         |

;
//exprission 
AFFICTATION:mc_idf mc_aff EXPRESSION //A=x+2

EXPRESSION:EXP_SIMPLE 
          |EXP_PAR
;

EXP_SIMPLE:OPERANDE OPERATEUR OPERANDE
          |OPERANDE OPERATEUR EXP_SIMPLE
          |OPERANDE OPERATEUR EXP_PAR
          |mc_char 'c'
;

Exp_par:mc_prop EXP_SIMPLE mc_prcl 
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
;

OPERATEUR:op_add {strcpy(saveopr,"+");}
         |op_div {strcpy(saveopr,"/");}
         |op_sub {strcpy(saveopr,"-");}
         |op_mul {strcpy(saveopr,"*");}
;
CONDITION:IF_SIMPLE
         |IF_ELSE
;

IF_SIMPLE:mc_if mc_prop COND_CASE mc_prcl mc_point LIST_INST mc_saut
;

|IF_ELSE:mc_if mc_prop COND_CASE mc_prcl mc_point LIST_INST mc_else mc_point LIST_INST mc_saut
;

COND_CASE:EXP_SIMPLE OPR_LOGIQUE_COMPARISON EXP_SIMPLE
         |OPERANDE OPR_LOGIQUE_COMPARISON OPERANDE
         |mc_prop COND_CASE mc_prcl OPR_LOGIQUE_COMPARISON mc_prop COND_CASE mc_prcl
         |mc_prop COND_CASE mc_prcl OPR_LOGIQUE_COMPARISON COND_CASE 
         |mc_prop COND_CASE mc_prcl
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

BOUCLE

%%
main(){
yyparse();
}
yywrap()
{}

