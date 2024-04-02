// Crie uma função que calcule o índice de massa corporal (IMC) de uma pessoa, a partir de sua altura, em metros, e peso, em quilogramas, que serão recebidos como parâmetro.

function calcularIMC(peso, altura) {
    let imc = peso / (altura * altura);
    return imc.toFixed(2);
}

let imc = calcularIMC(54, 1.71);

console.log(`O índice de massa corporal é ${imc}.`);