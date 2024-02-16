document.addEventListener('turbo:load', () => {
  const plusInput = document.getElementById("plus");

  plusInput.addEventListener("change", () => {
    const inputValue = plusInput.value; // `priceInput` を `plusInput` に修正してください

    const totalValue = document.getElementById("total").innerHTML; // `total` 要素のテキストを取得
    const addTaxDom = document.getElementById("result"); // 表示結果を表示する要素を `result` に修正してください

    const resultValue = Math.floor(inputValue - totalValue);
    addTaxDom.innerHTML = resultValue;
  });
});