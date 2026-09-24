%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *mensaje);
%}

%union {
    double numero;
}

%token <numero> NUMERO

/*
   La suma y la resta se evaluan
   de derecha a izquierda.
*/
%right '+' '-'

/*
   La multiplicacion y division
   siguen teniendo mayor precedencia.
*/
%left '*' '/'

%type <numero> expresion

%%

entrada:
      /* entrada vacia */
    | entrada linea
    ;

linea:
      '\n'
    | expresion '\n'
      {
          /* Mostramos el resultado final */
          printf("Resultado: %.2f\n", $1);
      }
    ;

expresion:
      NUMERO
      {
          $$ = $1;
      }

    | expresion '+' expresion
      {
          $$ = $1 + $3;
      }

    | expresion '-' expresion
      {
          $$ = $1 - $3;
      }

    | expresion '*' expresion
      {
          $$ = $1 * $3;
      }

    | expresion '/' expresion
      {
          if ($3 == 0) {
              printf("Error: no se puede dividir entre cero\n");
              $$ = 0;
          } else {
              $$ = $1 / $3;
          }
      }

    | '(' expresion ')'
      {
          $$ = $2;
      }
    ;

%%

void yyerror(const char *mensaje) {
    printf("Error de sintaxis: %s\n", mensaje);
}

int main() {
    printf("Calculadora con asociatividad por la derecha\n");
    printf("Operadores disponibles: + - * /\n");
    printf("Escribe una operacion y presiona Enter\n\n");

    yyparse();

    return 0;
}
