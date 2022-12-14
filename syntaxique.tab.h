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
     DisAcc = 258,
     mc_LIST_DEC = 259,
     mc_LIST_INST = 260,
     mc_LIST_IDF = 261,
     mc_DEC_VAR = 262,
     mc_DEC_TAB = 263,
     mc_VAL = 264,
     mc_AFFICTATION = 265,
     mc_EXPRESSION = 266,
     mc_EXP_PAR = 267,
     mc_TYPE_VAR = 268,
     mc_OP_COMP = 269,
     mc_OP_LOG = 270,
     mc_OPR_LOGIQUE_COMPARISON = 271,
     mc_COND_CASE = 272,
     mc_CONDITION = 273,
     mc_IF_ELSE = 274,
     mc_IF_SIMPLE = 275,
     mc_BOUCLE = 276,
     mc_OPERANDE = 277,
     mc_OPERATEUR = 278,
     mc_EXP_SIMPLE = 279,
     mc_idf = 280,
     mc_int_signe = 281,
     mc_int_nsigne = 282,
     mc_char = 283,
     mc_float_signe = 284,
     mc_float_nsigne = 285,
     mc_bool = 286,
     mc_const = 287,
     mc_var = 288,
     mc_point = 289,
     mc_vg = 290,
     mc_comm = 291,
     mc_saut = 292,
     mc_curop = 293,
     mc_curcl = 294,
     mc_sqcl = 295,
     mc_sqop = 296,
     mc_prcl = 297,
     mc_prop = 298,
     mc_sup = 299,
     mc_inf = 300,
     mc_inf_eql = 301,
     mc_sup_eql = 302,
     mc_not_eql = 303,
     mc_eql = 304,
     mc_aff = 305,
     mc_else = 306,
     mc_while = 307,
     mc_inrange = 308,
     mc_if = 309,
     mc_for = 310,
     mc_varint = 311,
     mc_varfloat = 312,
     mc_varchar = 313,
     mc_varbool = 314,
     mc_varconst = 315,
     mc_add = 316,
     mc_div = 317,
     mc_sub = 318,
     mc_mult = 319,
     mc_not = 320,
     mc_and = 321,
     mc_or = 322,
     mc_in = 323,
     mc_TAB = 324,
     mc_WHILE = 325,
     mc_BOUCLE_1 = 326,
     mc_BOUCLE_2 = 327
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1685 of yacc.c  */
#line 19 "syntaxique.y"
 
   int entier;
   float real;
   char* str;



/* Line 1685 of yacc.c  */
#line 131 "syntaxique.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


