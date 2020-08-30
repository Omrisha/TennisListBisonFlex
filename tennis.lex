%{
    #include "tennis.tab.h"
    extern int atoi (const char *);
    extern void exit(int);

    int line = 1;
%}

%option noyywrap

%%
^\*\*[A-Z_ ]*\*\*$  { return TITLE; }
"<name>"            { return NAME; }
\"([^\\"\n]|\\.)*\" { strcpy(yylval._player._name, yytext); return PLAYER_NAME; }
"<gender>"          { return GENDER; }
"Man"|"Woman"       { strcpy(yylval._gender, yytext); return PLAYER_GENDER; }
"<Wimbledon>"       { return WIMBLEDON; }
"<Australian Open>" { return AUSTRALIAN_OPEN; }
[0-9]+              { yylval._year = atoi(yytext); return NUM; }

[\t ]+              /* skip white space */
\n                  { line++; }

"-"                 { return THROUGH; }
","                 { return COMMA; }

.                   { fprintf (stderr, "line %d: unrecognized token %c\n",
                               line, yytext[0]);  
                       exit(1); }
%%