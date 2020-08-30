## Excercise 2 - Compilation Course

* Presenter: Omri Shapira

Note: There's a Makefile to run all the commands.
I wrote it on macOS so my command for flex and bison are `flex` and `bison`

## Prerequisites
* [bison] version 3.5
* [flex] version 2.6.4
* IDE for your convenience [Visual Studio Code] or [NotePad++]
* C complier like [gcc] [clang]
 
## Running macOS

* run `make` command
OR
* run `flex tennis.lex`
* run `bison -d tennis.y`
* run `gcc -o tennis tennis.tab.c lex.yy.c`
* run `./tennis test_tennis.txt` for the program

## Running Windows

Change `bison` and `flex` commands to how your command line recognizes them 

* run `make` command
OR
* run `win_flex tennis.lex`
* run `win_bison -d tennis.y`
* run `gcc -o tennis tennis.tab.c lex.yy.c`
* run `tennis.exe test_tennis.txt` for the program
