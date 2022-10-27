%{
    #include <stdio.h>
    #include <stdlib.h>
    //void erreur(char* nError);
    int ligne=1 ,colonne=0,nb=0;
    void init(int a);
%}

%option noyywrap

lettre [a-z]
lettremaj [A-Z]
chiffre [0-9]
idf {lettremaj}{lettre}*{chiffre}*{lettre}*
entier {chiffre}+
%%
"int"  {printf ("%s est un mot cle\n",yytext);colonne+=yyleng;init(nb);}
"float" {printf("%s est un mot cle\n",yytext);colonne+=yyleng;init(nb);}
"char" {printf("%s est un mot cle\n",yytext);colonne+=yyleng;init(nb);}
"bool" {printf("%s est un mot cle \n",yytext);colonne+=yyleng;init(nb);}  
"if" {printf("%s est un mot cle\n",yytext);colonne+=yyleng;init(nb);}
"else" {printf("%s est un mot cle\n",yytext);colonne+=yyleng;init(nb);}
"for" {printf("%s est un mot cle\n",yytext);colonne+=yyleng;}
"in range" {printf("%s est unm mot cle\n",yytext);}
"#" {printf("un debut de commentaire ");ligne++;colonne=0;};
"while" {printf("%s est un mot cle\n",yytext);colonne+=yyleng;init(nb);}  
{idf} {if(yyleng<=8){printf("%s est un idf\n",yytext); colonne+=yyleng;init(nb);} else{printf("idf too long");}}
{entier} {printf("%s est un entier++++\n",yytext); colonne+=yyleng;init(nb);}
"+" {printf ("additon\n"); colonne+=yyleng;init(nb);}
"-" {printf ("soustraction\n"); colonne+=yyleng;init(nb);}
"*" {printf ("multiplication\n"); colonne+=yyleng;init(nb);}
"/" {printf ("division\n"); colonne+=yyleng;init(nb);}
"=" {printf ("egalité\n"); colonne+=yyleng;init(nb);}
":" {printf("un separateur\n");colonne++;}
"and" {printf("operateur logique and\n");colonne+=yyleng;init(nb);}
"or" {printf("operateur logique or\n");colonne+=yyleng;init(nb);}
"not" {printf("operateur logique not\n");colonne+=yyleng;init(nb);}
">" {printf("superieur\n");colonne+=yyleng;init(nb);}
"<" {printf("inferieur\n");colonne+=yyleng;init(nb);}
">=" {printf("superieur ou egale\n");colonne=yyleng;init(nb);}
"<=" {printf("inferieur ou egale\n");colonne+=yyleng;init(nb);}
"!=" {printf("different\n");colonne+=yyleng;init(nb);}
"\n" {ligne++; init(colonne);init(nb);}
" " {colonne++;nb++;if(nb==4){printf("!\n");}}
. {printf ("erreur lexicale ligne %d, colonne %d\n",ligne,colonne);}
%%



int main(){
    yyin=fopen("input.txt","r");
    yylex();
    fclose(yyin);
    return 0;
}
/*void erreur(char* nError){
    switch (nError) {
        case ("idf too long"):
            printf("the idf is too long");
            break;
        default:
            printf ("erreur lexicale ligne %d, colonne %d\n",ligne,colonne);
    }
}*/

void init(int a){
    a=0;
}