// Crie uma função que mostre na tela a área e o perímetro de uma sala circular, utilizando seu raio que será fornecido como parâmetro. Considere Pi = 3,14.

function calcularAreaEPerimetroCirculo(raio) {
    const pi = 3.14;
    let area = pi * raio * raio;
    let perimetro = 2 * pi * raio;

    console.log(`Área da sala circular: ${area} metros quadrados.`);
    console.log(`Perímetro da sala circular: ${perimetro} metros.`);
}

calcularAreaEPerimetroCirculo(4);