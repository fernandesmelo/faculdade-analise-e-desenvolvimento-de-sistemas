// Crie uma função que mostre na tela a tabuada de um número dado como parâmetro.

function exibirTabuada(numero) {
    console.log(`Tabuada do ${numero}:`)

    for (let i = 1; i <= 10; i++) {
        let resultado = numero * i;
        console.log(`${numero} x ${i} = ${resultado}`)
    }
}

exibirTabuada(7);