# Precedencia y Asociatividad con Flex y Bison

Este proyecto muestra el funcionamiento de la precedencia y la asociatividad de operadores utilizando una calculadora hecha con Flex y Bison.

La calculadora permite utilizar:

- Suma `+`
- Resta `-`
- Multiplicacion `*`
- Division `/`
- Parentesis

## Asociatividad por la izquierda

En el archivo `parser_izquierda.y` se utiliza:

```c
%left '+' '-'
%left '*' '/'
```

Esto indica que los operadores con la misma precedencia se evaluan de izquierda a derecha.

Ejemplo:

```text
10 - 5 - 2
```

La operacion se interpreta como:

```text
(10 - 5) - 2
```

Primero se realiza:

```text
10 - 5 = 5
```

Luego:

```text
5 - 2 = 3
```

Resultado:

```text
3
```

## Asociatividad por la derecha

En el archivo `parser_derecha.y` se cambia la asociatividad de la suma y la resta utilizando:

```c
%right '+' '-'
%left '*' '/'
```

Esto hace que los operadores `+` y `-` se evaluen de derecha a izquierda cuando tienen la misma precedencia.

Ejemplo:

```text
10 - 5 - 2
```

Ahora la operacion se interpreta como:

```text
10 - (5 - 2)
```

Primero se realiza:

```text
5 - 2 = 3
```

Luego:

```text
10 - 3 = 7
```

Resultado:

```text
7
```

## Precedencia de operadores

La multiplicacion y la division tienen mayor precedencia que la suma y la resta.

Esto se define colocando:

```c
%left '+' '-'
%left '*' '/'
```

Bison asigna mayor precedencia a las declaraciones que aparecen despues.

Por esta razon, `*` y `/` se evaluan antes que `+` y `-`.

### Ejemplo con multiplicacion

```text
2 + 3 * 4
```

Primero se realiza:

```text
3 * 4 = 12
```

Luego:

```text
2 + 12 = 14
```

Resultado:

```text
14
```

### Ejemplo con division

```text
20 - 8 / 2
```

Primero se realiza:

```text
8 / 2 = 4
```

Luego:

```text
20 - 4 = 16
```

Resultado:

```text
16
```

## Uso de parentesis

La calculadora tambien permite utilizar parentesis para cambiar el orden normal de las operaciones.

Ejemplo:

```text
(2 + 3) * 4
```

Primero se realiza:

```text
2 + 3 = 5
```

Luego:

```text
5 * 4 = 20
```

Resultado:

```text
20
```

## Archivos del proyecto

El proyecto contiene los siguientes archivos:

- `scanner.l`: contiene el analizador lexico realizado con Flex.
- `parser_izquierda.y`: contiene la gramatica con asociatividad por la izquierda.
- `parser_derecha.y`: contiene la gramatica con asociatividad por la derecha.
- `README.md`: contiene la explicacion del proyecto.
- `.gitignore`: evita subir archivos generados automaticamente.

## Compilacion

### Version con asociatividad por la izquierda

Primero se copia el parser de izquierda:

```bash
cp parser_izquierda.y parser.y
```

Luego se generan los archivos de Bison:

```bash
bison -d parser.y
```

Se genera el archivo de Flex:

```bash
flex scanner.l
```

Se compila el programa:

```bash
gcc parser.tab.c lex.yy.c -o calculadora_izquierda -lfl
```

Finalmente se ejecuta:

```bash
./calculadora_izquierda
```

### Version con asociatividad por la derecha

Primero se copia el parser de derecha:

```bash
cp parser_derecha.y parser.y
```

Luego se generan nuevamente los archivos:

```bash
bison -d parser.y
flex scanner.l
```

Se compila:

```bash
gcc parser.tab.c lex.yy.c -o calculadora_derecha -lfl
```

Finalmente se ejecuta:

```bash
./calculadora_derecha
```

## Pruebas realizadas

Algunas de las operaciones utilizadas para comprobar el funcionamiento fueron:

```text
10 - 5 - 2
2 + 3 * 4
20 - 8 / 2
(2 + 3) * 4
```

Con asociatividad por la izquierda:

```text
10 - 5 - 2 = 3
```

Con asociatividad por la derecha:

```text
10 - 5 - 2 = 7
```

Para comprobar la precedencia:

```text
2 + 3 * 4 = 14
20 - 8 / 2 = 16
```

Y utilizando parentesis:

```text
(2 + 3) * 4 = 20
```

## Conclusion

Con esta practica se pudo observar la diferencia entre precedencia y asociatividad.

La precedencia define que operador debe ejecutarse primero dentro de una expresion. En este caso, la multiplicacion y la division tienen mayor prioridad que la suma y la resta.

La asociatividad define el orden en el que se evaluan operadores que tienen la misma precedencia. Al utilizar asociatividad por la izquierda, la expresion se resuelve comenzando desde la izquierda. Al utilizar asociatividad por la derecha, la misma expresion se empieza a resolver desde la derecha.

Las pruebas realizadas permiten observar que cambiar la asociatividad puede producir resultados diferentes aun utilizando exactamente la misma expresion.
