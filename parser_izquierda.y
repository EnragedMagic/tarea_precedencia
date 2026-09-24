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
   La suma y la resta tienen menor precedencia.
   Se evaluan de izquierda a derecha.
*/
%left '+' '-'

/*
   La multiplicacion y la division tienen mayor precedencia.
   Tambien se evaluan de izquierda a derecha.
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
          /* Un numero conserva su valor */
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
          /* Evitamos dividir entre cero */
          if ($3 == 0) {
              printf("Error: no se puede dividir entre cero\n");
              $$ = 0;
          } else {
              $$ = $1 / $3;
          }
      }

    | '(' expresion ')'
      {
          /* Los parentesis cambian el orden normal */
          $$ = $2;
      }
    ;

%%

void yyerror(const char *mensaje) {
    printf("Error de sintaxis: %s\n", mensaje);
}

int main() {
    printf("Calculadora con asociatividad por la izquierda\n");
    printf("Operadores disponibles: + - * /\n");
    printf("Escribe una operacion y presiona Enter\n\n");

    yyparse();

    return 0;
}
