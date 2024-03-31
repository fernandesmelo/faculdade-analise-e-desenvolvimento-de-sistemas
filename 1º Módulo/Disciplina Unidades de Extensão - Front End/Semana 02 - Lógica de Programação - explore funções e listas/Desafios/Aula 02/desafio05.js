// Criar uma função que recebe dois números como parâmetros e retorna o maior deles.

function maiorNumero(numero1, numero2) {
    if (numero1 > numero2) {
        return numero1;
    } else {
        return numero2;
    }
}

var resultado = maiorNumero(20, 10);

console.log(`O maior número entre 20 e 10 é ${resultado}.`);