%code {
#include <stdio.h>
#include <string.h>

extern int yylex (void);
void yyerror (const char *s);

int sub_years(int y1, int y2);
}

%code requires {
    struct player {
      char _name [100];
      int _yearCount;
    };
}

%union {
    struct player _player;
    char _gender [100];
    int _year;
    int count;
}

%token TITLE NAME GENDER WIMBLEDON AUSTRALIAN_OPEN THROUGH COMMA
%token <_player> PLAYER_NAME
%token <_gender> PLAYER_GENDER
%token <_year> NUM

%type <_year> year_spec optional_australian_open optional_wimbledon
%type <_player> list_of_players player
%type <count> list_of_years

%define parse.error verbose

%%

input: TITLE list_of_players {
  printf ("Player with most wins at Wimbledon: %s (%d wins)\n",
            $2._name, $2._yearCount);
};

list_of_players: list_of_players player
{
  if ($1._yearCount < $2._yearCount) {
    strcpy($$._name, $2._name);
    $$._yearCount = $2._yearCount;
    $2._yearCount = 0;
  } else {
    strcpy($$._name, $1._name);
    $$._yearCount = $1._yearCount;
    $1._yearCount = 0;
  }
};

list_of_players: /* empty */ { strcpy($$._name, ""); $$._yearCount = -1; };

player: NAME PLAYER_NAME GENDER PLAYER_GENDER
      optional_wimbledon  optional_australian_open { 
          if (strcmp($4, "Man") == 0) {
            strcpy($$._name, $2._name);      
            $$._yearCount = $5;
          } else {
            strcpy($$._name, "");      
            $$._yearCount = -1;
          }
       };
       
optional_wimbledon: WIMBLEDON list_of_years { $$ = $2; } |
                    /* empty */ { $$ = -1; };
optional_australian_open: AUSTRALIAN_OPEN list_of_years { $$ = -1; } |
                         /* empty */ { $$ = -1; };

list_of_years: list_of_years COMMA year_spec { $$ = $1 + $3; };
list_of_years: year_spec { $$ = $1; };

year_spec: NUM { $$ = 1; } | NUM THROUGH NUM { $$ = $3 - $1; };

%%

int main (int argc, char **argv)
{
  extern FILE *yyin;
  if (argc != 2) {
     fprintf (stderr, "Usage: %s <input-file-name>\n", argv[0]);
	 return 1;
  }
  yyin = fopen (argv [1], "r");
  if (yyin == NULL) {
       fprintf (stderr, "failed to open %s\n", argv[1]);
	   return 2;
  }
  
  yyparse ();
  
  fclose (yyin);
  return 0;
}

void yyerror (const char *s)
{
  extern int line;
  fprintf (stderr, "line %d: %s\n", line, s);
}

int sub_years(int y1, int y2) {
  return y2 - y1;
}