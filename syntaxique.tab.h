/* A Bison parser, made by GNU Bison 2.4.2.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2006, 2009-2010 Free Software
   Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     mc_LIST_DEC = 258,
     mc_LIST_INST = 259,
     mc_LIST_IDF = 260,
     mc_DEC_VAR = 261,
     mc_DEC_TAB = 262,
     mc_VAL = 263,
     mc_AFFICTATION = 264,
     mc_EXPRESSION = 265,
     mc_EXP_PAR = 266,
     mc_TYPE_VAR = 267,
     mc_OP_COMP = 268,
     mc_OP_LOG = 269,
     mc_OPR_LOGIQUE_COMPARISON = 270,
     mc_COND_CASE = 271,
     mc_CONDITION = 272,
     mc_IF_ELSE = 273,
     mc_IF_SIMPLE = 274,
     mc_BOUCLE = 275,
     mc_OPERANDE = 276,
     mc_OPERATEUR = 277,
     mc_EXP_SIMPLE = 278,
     mc_idf = 279,
     mc_int_signe = 280,
     mc_int_nsigne = 281,
     mc_char = 282,
     mc_float_signe = 283,
     mc_float_nsigne = 284,
     mc_bool = 285,
     mc_const = 286,
     mc_var = 287,
     mc_point = 288,
     mc_vg = 289,
     mc_comm = 290,
     mc_saut = 291,
     mc_curop = 292,
     mc_curcl = 293,
     mc_sqcl = 294,
     mc_sqop = 295,
     mc_prcl = 296,
     mc_prop = 297,
     mc_sup = 298,
     mc_inf = 299,
     mc_inf_eql = 300,
     mc_sup_eql = 301,
     mc_not_eql = 302,
     mc_eql = 303,
     mc_aff = 304,
     mc_else = 305,
     mc_while = 306,
     mc_inrange = 307,
     mc_if = 308,
     mc_for = 309,
     mc_varint = 310,
     mc_varfloat = 311,
     mc_varchar = 312,
     mc_varbool = 313,
     mc_varconst = 314,
     mc_add = 315,
     mc_div = 316,
     mc_sub = 317,
     mc_mult = 318,
     mc_not = 319,
     mc_and = 320,
     mc_or = 321,
     mc_in = 322,
     mc_WHILE = 323,
     mc_BOUCLE_1 = 324,
     mc_BOUCLE_2 = 325
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1685 of yacc.c  */
#line 12 "syntaxique.y"
 
   int entier;
   float real;
   char* str;



/* Line 1685 of yacc.c  */
#line 129 "syntaxique.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


