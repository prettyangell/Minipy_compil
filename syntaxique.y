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
%token mc_List_Dec mc_List_Inst mc_Dec_Tab 
%token <str>mc_idf <entier>mc_int_signe <entier>mc_int_nsigne <str>mc_char <real>mc_float_signe
%token <real>mc_float_nsigne mc_bool mc_const mc_var 
%token mc_point mc_vg mc_comm  mc_saut mc_curop mc_curcl mc_sqcl mc_sqop mc_prcl mc_prop 
%token mc_sup mc_inf mc_inf_eql mc_sup_eql mc_not_eql mc_eql
%token mc_aff mc_else mc_while mc_inrange mc_if mc_for
%token mc_varint mc_varfloat mc_varchar mc_varbool mc_varconst 
%token mc_add mc_div mc_sub mc_mult
%token mc_not mc_and mc_or mc_taille

%start S

%%
S:List_Dec List_Inst {printf("programme syntaxiquement correct");YYACCEPT;}

List_Dec:Dec_Var List_Dec
        |Dec_Var
        |Dec_Tab List_Dec
        |Dec_Tab

Dec_Var:Type_Var List_Idf //int x
       |mc_idf mc_eql Val //x=5
       
Dec_Tab:Type_Var mc_idf mc_sqop mc_taille mc_sqcl

List_Idf:mc_idf mc_vg List_Idf
        |mc_idf mc_saut
        
Val:mc_float_signe
   |mc_float_nsigne
   |mc_int_nsigne
   |mc_int_signe
   |mc_char
   
Type_Var:mc_varint   {strcpy(sauvType,"INT");}
        |mc_varfloat {strcpy(sauvType,"FLOAT");}
        |mc_varbool  {strcpy(sauvType,"BOOL");}
        |mc_varconst {strcpy(sauvType,"CONST");}
%%
main(){
yyparse();
}
yywrap()
{}

