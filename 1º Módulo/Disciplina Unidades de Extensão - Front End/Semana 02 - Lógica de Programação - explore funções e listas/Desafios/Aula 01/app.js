let titulo = document.querySelector("h1");
titulo.innerHTML = "Hora do Desafio";

function verificarChute() {
    console.log("O botão foi clicado");
}

function verificarAlerta() {
    alert("Eu amo JS");
}

function verificarPrompt() {
    let cidade = prompt("Diga o nome de uma cidade do Brasil: ");

    alert(`Estive em ${cidade} e lembrei de você.`);
}

function verificarSoma() {
    let numero1 = prompt("Informe um número: ");
    let numero2 = prompt("Informe outro número:");

    let soma = numero1 + numero2;

    alert(`A soma entre ${numero1} e ${numero2} é ${soma}.`)
}