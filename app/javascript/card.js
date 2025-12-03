const pay = () => {
    const publicKey = gon?.public_key
    const form = document.getElementById('charge-form')
    if (!form || !publicKey) return

    const numberForm = document.getElementById('number-form')
    const expiryForm = document.getElementById('expiry-form')
    const cvcForm = document.getElementById('cvc-form')
    if (!numberForm || !expiryForm || !cvcForm) return
    numberForm.innerHTML = ''
    expiryForm.innerHTML = ''
    cvcForm.innerHTML = ''

    const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
    const elements = payjp.elements();
    const numberElement = elements.create('cardNumber');
    const expiryElement = elements.create('cardExpiry');
    const cvcElement = elements.create('cardCvc');

    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');

    form.addEventListener("submit", (e) => {
        e.preventDefault();
        payjp.createToken(numberElement).then(function (response) {
            if (response.error) {
                console.error(response.error.message)
            } else {
                const token = response.id;
                const renderDom = document.getElementById("charge-form");
                const tokenObj = `<input value=${token} name='token' type="hidden">`;
                renderDom.insertAdjacentHTML("beforeend", tokenObj);
            }
            numberElement.clear();
            expiryElement.clear();
            cvcElement.clear();
            document.getElementById("charge-form").submit();
        });
    });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
