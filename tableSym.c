#include<stdlib.h>
#include<stdio.h>


 //Definition des structures de données
typedef struct {
    int state;
    char name[20]; //nom d'entitie
    char code[20]; //tab,const,var simple..
    char type[20]; //type d'entitie 
    float val;
}element;//TS de const et var

typedef struct{
    int state;
    char name[20]; //nom d'entitie
    char type[20]; //type d'entitie 
}elt; //TS de separateur et mot cles

element tab[700];
elt tabS[40],tabM[40];

//initialisation de l'état des cases des tables des symbloles
void intitialisation(){
    int i;
    for(i=0;i<700;i++){
    tab[i].state=0;
    }
    for(i=0;i<40;i++){
        tabS[i].state=0;
        tabM[i].state=0;
    }
}

     //La fonction Rechercher permet de verifier si l'entiti exicte deja
void rechercher(char entite[], char code[],char type[],float val,int y){
int i,j;
switch (y){
  case 0: /*verifier si la case dans la tables des IDF est libre*/
  for(int i=0;((i<700)&&(tab[i].state==1))&&(strcmp(entite,tab[i].name)!=0);i++)
      if((i<700)&&(strcmp(entite,tab[i].name)!=0))
        {
      inserer(entite,code,type,val,i,0);
         } 
  break;
  case 1:/*verifier si la case dans la tables des mots clés est libre*/
for(int i=0;((i<40)&&(tab[i].state==1))&&(strcmp(entite,tabM[i].name)!=0);i++)
      if((i<40)&&(strcmp(entite,tabM[i].name)!=0))
        {
      inserer(entite,code,type,val,i,0);
         } 
  break;
  case 2:/*verifier si la case dans la tables des séparateurs est libre*/
for(int i=0;((i<40)&&(tab[i].state==1))&&(strcmp(entite,tab[i].name)!=0);i++)
      if((i<40)&&(strcmp(entite,tab[i].name)!=0))
        {
      inserer(entite,code,type,val,i,0);
         } 
  break;

}
}

//insertion des entititées lexicales dans Ts
void insertion(char entite[], char code[],char type[],float val,int i,int y){
switch (y)
{
 case 0:/*insertion dans la table des IDF et CONST*/
    tab[i].state=1;
    strcpy(tab[i].name,entite);//copier contune de entitie dans tab 
    strcpy(tab[i].code,code);
    strcpy(tab[i].type,type);
    tab[i].val=val;
break;

case 1:/*insertion dans la table des mots clés*/
    tabM[i].state=1;
    strcpy(tabM[i].name,entite);
    strcpy(tabM[i].type,code);
break;

case 2:/*insertion dans la table des séparateurs*/
    tabS[i].state=1;
    strcpy(tabS[i].name,entite);
    strcpy(tabS[i].type,code);
break;
}
}
 //L'affichage du contenue de la Ts
 void afficher(){

printf("/***************Table des symboles IDF*************/\n");
printf("____________________________________________________________________\n");
printf("\t| Nom_Entite |  Code_Entite | Type_Entite | Val_Entite\n");
printf("____________________________________________________________________\n");



printf("\n/================================Table des symboles mots clés================================\n");
printf("_________________________________________\n");
printf("\t| NomEntite       |  CodeEntite | \n");
printf("_________________________________________\n");


printf("\n/================================Table des symboles séparateurs================================\n");
printf("___________________________________\n");
printf("\t| NomEntite |  CodeEntite | \n");
printf("___________________________________\n");

 }
