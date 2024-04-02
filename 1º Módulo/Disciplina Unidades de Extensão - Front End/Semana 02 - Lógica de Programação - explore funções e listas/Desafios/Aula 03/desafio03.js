// Crie uma função que converte um valor em dólar, passado como parâmetro, e retorna o valor equivalente em reais. Para isso, considere a cotação do dólar igual a R$4,80.

function converteValorEmDolar(valor) {
    let conversaoReal = 4.80 * valor;

    return conversaoReal;
}

let resultado = converteValorEmDolar(100);

console.log(`O valor de US$ 100,00 em reais fica R$ ${resultado.toFixed(2)}.`);
