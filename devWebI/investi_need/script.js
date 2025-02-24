// script.js

// Example script for index.html
document.addEventListener('DOMContentLoaded', function() {
    console.log('Index page loaded');
    // Add your index page specific scripts here
});

// Example script for other pages
document.addEventListener('DOMContentLoaded', function() {
    console.log('Other page loaded');
    // Add your other page specific scripts here
});

// Define a função calcular()
function calcular() {
    // Obtém o valor do campo de entrada de texto com o id "valor"
    var valor = document.getElementById("valor").value;
    // Obtém o valor do campo de entrada de texto com o id "prazo"
    var prazo = document.getElementById("prazo").value;
    // Obtém o valor do campo de entrada de texto com o id "rendimento"
    var rendimento = document.getElementById("rendimento").value;
    // Calcula o rendimento
    var resultado = valor * prazo * rendimento;
    // Exibe o resultado no campo de entrada de texto com o id "rendimento"
    document.getElementById("rendimento").value = resultado;
}
