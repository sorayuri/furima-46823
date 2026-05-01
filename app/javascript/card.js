const pay = () => {
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

   numberElement.mount('#number-form');
   expiryElement.mount('#expiry-form');
   cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');

  form.addEventListener("submit", (e) => {
    e.preventDefault();

     payjp.createToken(numberElement).then(function (response) {
       if (response.error) {
        console.log(response.error);
        return;
       }

       const token = response.id;
       const tokenInput = document.createElement("input");
       tokenInput.type = "hidden";
       tokenInput.name = "order_address[token]";
       tokenInput.value = token;

       form.appendChild(tokenInput);
       form.submit();
    });
   });
  };


  window.addEventListener("load", pay);
  window.addEventListener("render", pay);