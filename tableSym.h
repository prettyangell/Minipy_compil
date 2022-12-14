#include<stdlib.h>
#include<stdio.h>
#include<string.h>

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

     //La fonction Rechercher permet de verifier si l'entiti exicte deja
void rechercher(char entite[],char code[],char type[],float val,int y){
int i,j;
switch (y){
  
  case 0: /*verifier si la case dans la tables des IDF est libre*/
  for(int i=0;((i<700)&&(tab[i].state==1))&&(strcmp(entite,tab[i].name)!=0);i++)
      if((i<700)&&(strcmp(entite,tab[i].name)!=0))
      insertion(entite,code,type,val,i,0);
       else
         printf("entité existe déjà\n");  
  break;

  case 1:/*verifier si la case dans la tables des mots clés est libre*/
for(int i=0;((i<40)&&(tab[i].state==1))&&(strcmp(entite,tabM[i].name)!=0);i++)
      if((i<40)&&(strcmp(entite,tabM[i].name)!=0)) 
      insertion(entite,code,type,val,i,2);
       else
         printf("entité existe déjà\n");  
  break;

  case 2:/*verifier si la case dans la tables des séparateurs est libre*/
for(int i=0;((i<40)&&(tab[i].state==1))&&(strcmp(entite,tab[i].name)!=0);i++)
      if((i<40)&&(strcmp(entite,tab[i].name)!=0))
      insertion(entite,code,type,val,i,1);
       else
         printf("entité existe déjà\n");  
  break;
}
}

 //L'affichage du contenue de la Ts
void afficher(){
int i=0;
printf("/***************Table des symboles IDF*************/\n");
printf("____________________________________________________________________\n");
printf("\t| Nom_Entite |  Code_Entite | Type_Entite | Val_Entite\n");
printf("____________________________________________________________________\n");
for(i=0;i<700;i++)
{
    if(tab[i].state==1)
      {
        printf("\t|%22s |%15s | %12s  | %12f |\n",tab[i].name,tab[i].code,tab[i].type,tab[i].val);
      }
}

printf("\n/================================Table des symboles mots clés================================\n");
printf("_________________________________________\n");
printf("\t| NomEntite       |  CodeEntite | \n");
printf("_________________________________________\n");
for(i=0;i<40;i++)
    if(tabM[i].state==1)
      {
        printf("\t|%10s |%12s | \n",tabM[i].name,tabM[i].type );
      }


printf("\n/================================Table des symboles séparateurs================================\n");
printf("___________________________________\n");
printf("\t| NomEntite |  CodeEntite | \n");
printf("___________________________________\n");
for(i=0;i<40;i++)
    if(tabS[i].state==1)
      {
        printf("\t|%10s |%12s | \n",tabS[i].name,tabS[i].type );
      }
 }
 /**********************PARTIE DES FONCTION*****************************/
 //recuperer la position d'un entier
 int Position(char entite[])
{
  int i=0;
  while(i<700){
  if (strcmp(entite,tab[i].name)==0) 
  return i;
  i++;
  }
  return -1;
}

int doubleDeclaration(char entite[])
{
  int position=Position(entite);
  if(strcmp(tab[position].type,"")==0) 
  return 0;
  else 
  return -1;
}
//returner le type d'un entier
char* Get_TypeEn(char entite[])
{
  int position=Position(entite);
  return tab[position].type;
}

//returner la valeur 
float donneVAL(char entite[])
{
  int i=Position(entite);
  return tab[i].val;
}

void insererTYPE(char entite[], char type[])
{
int position=Position(entite);
  if(position!=-1){ 
    strcpy(tab[position].type,type); }
  
}

void insererVAL(char entite[], float val)
{
  int position=Position(entite);
  if(position!=-1)  { tab[position].val=val; }
}

int fonc_accept(char a [],char b [])
{
  int i=Position(b);
  if(i!=-1)
    {
    if(a[0]=='$')
       {
         if(strcmp(tab[i].type,"INTEGER")!=0)
         {
           return -1;
         }
         else
         {
          return 0;
         }
          
       }  
  
  if(a[0]=='%')
       {
         if(strcmp(tab[i].type,"REAL")!=0)
         {
           return -1;
         }
         else
         {return 0;}
          
       }
     
  if(a[0]=='#')
       {
         if(strcmp(tab[i].type,"STRING")!=0)
         {
          return -1;
         }
         else
         {return 0;}
         
       }
  
  if(a[0]=='&')
       {
         if(strcmp(tab[i].type,"CHAR")!=0)
         {
           return -1;
         }
         else
         {return 0;}
     }
      
}
  else
{
return -1;}

}

/*int Atoi(char *t){
    int r;
    char *y;
    int ee;
    y=malloc(strlen(t)*sizeof(char));
    strcpy(y,t);
    if(y[0]=='('){
        for(ee=0;ee<strlen(t);ee++){
            y[ee]=y[ee+1];
                 r=atoi(y);};
    }else{
        r=atoi(y);}
        free(y);
    return(r);
}

float Atof(char* t){
    float r;
    int ee;
    char* y; 
    y=(char*)malloc(strlen(t));
    strcpy(y,t);
    if(y[0]=='('){
        for(ee=0;ee<strlen(t);ee++){
            y[ee]=y[ee+1];
                 r=atof(y);};
    }else{
        r=atof(y);}
        free(y);
    return(r);
}*/