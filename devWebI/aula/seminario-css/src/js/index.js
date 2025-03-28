const inputs = document.querySelectorAll("input[name='unit']");
const box = document.getElementById("box");

inputs.forEach((input) => {
  input.addEventListener("change", () => {
    aplicarUnidade(input.value);
  });
});

function aplicarUnidade(unidade) {
  const tamanho = "10" + unidade;

  box.style.width = tamanho;
  box.style.height = tamanho;
  box.textContent = `Unidade Atual: ${tamanho}`;
}
