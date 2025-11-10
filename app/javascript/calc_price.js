// app/javascript/calc_price.js
document.addEventListener('turbo:load', setup);
document.addEventListener('DOMContentLoaded', setup);

function setup() {
  const priceInput = document.getElementById('item-price');
  const taxField   = document.getElementById('add-tax-price');
  const profitField= document.getElementById('profit');
  if (!priceInput || !taxField || !profitField) return;

  const update = () => {
    const v = Number(priceInput.value);
    if (Number.isFinite(v)) {
      const fee = Math.floor(v * 0.1);
      const profit = Math.floor(v - fee);
      taxField.textContent = fee >= 0 ? fee : 0;
      profitField.textContent = profit >= 0 ? profit : 0;
    }
  };
  priceInput.addEventListener('input', update);
  update();
}
