alert("Bem-vindo ao jogo de número secreto!");

let numeroSecreto = 29;

let chute = prompt("Escolha um número entre 1 e 30:")

if (numeroSecreto == chute) {
    alert("Isso aí! Você descobriu o número secreto é " +  numeroSecreto);
} else {
    alert("Você errou :(");
}