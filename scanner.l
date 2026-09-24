%{
#include "parser.tab.h"
#include <stdlib.h>
%}

ESPACIO     [ \t]+
NUMERO      [0-9]+(\.[0-9]+)?

%%

{NUMERO} {
    /* Convertimos el numero escrito a un valor numerico */
    yylval.numero = atof(yytext);
    return NUMERO;
}

"+" {
    return '+';
}

"-" {
    return '-';
}

"*" {
    return '*';
}

"/" {
    return '/';
}

"(" {
    return '(';
}

")" {
    return ')';
}

\n {
    /* El Enter indica que la operacion termino */
    return '\n';
}

{ESPACIO} {
    /* Los espacios no afectan la operacion */
}

. {
    /* Si aparece otro caracter se devuelve tal como fue escrito */
    return yytext[0];
}

%%

int yywrap() {
    return 1;
}
