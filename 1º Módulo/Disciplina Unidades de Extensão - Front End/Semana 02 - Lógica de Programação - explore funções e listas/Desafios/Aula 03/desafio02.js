// Crie uma função que calcule o valor do fatorial de um número passado como parâmetro.

function calcularFatorial(numero) {
    if (numero < 0) {
        return "O fatorial de números negativos não está definido.";
    }

    // Caso especial: fatorial de 1 é 1
    if (numero == 0) {
        return 1;
    }

    // Caso especial: fatorial de 1 é 1.
    if (numero == 1) {
        return 1;
    }
    
    // Inicializa o resultado como 1.
    var resultado = 1;
    
    // Calcula o fatorial iterativamente.
    for (var i = 2; i <= numero; i++) {
        resultado *= i;
    }

    return resultado;
}

let fatorial = calcularFatorial(5);

console.log(`O fatorial de 5 é ${fatorial}.`);