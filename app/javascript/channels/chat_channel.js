import consumer from "channels/consumer"

/*
  essa seria uma forma de pegar um id de alguma coisa pelo js por exemplo
  ai eu criaria uma logica pra pegar o id pelo dom por exemplo dentro de uma funcao por exemplo
  //consumer.subscriptions.create( {channel: "ChatChannel", id: produtoId}, {})
  agora se eu for la do lado servidor no channel e usar params[:id] eu consigo ver o id desse produto (no subscribed por exemplo)
  a paritr disso eu poderia fazer consultas no banco por exemplo
*/ 


consumer.subscriptions.create("ChatChannel", { //ChatChannel = nome do meu canal criado. não se atente ao snake_case e sim ao nome dado
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connected")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) { //recebe os dados do servidor apos fazer o broadcast
    // Called when there's incoming data on the websocket for this channel
    const messages = document.querySelector("#messages")
    messages.insertAdjacentHTML("beforeend", `<p>${data.content}</p>`) //data = model Message atributo content. vem la do controlador
    messages.lastElementChild.scrollIntoView({behavior: "smooth"})

    console.log(data)

  },

  rejected(data){
    //poderia acrescentar alguam logica aqui caso a conexão fosse rejeitada (ex: o usuario não esta autenticado por exemplo)
  }
});



//este é o ciclo de importacoes
/*
  1- application importa channels/index.js
  2- index.js importa chat_channel.js e demais canais que eu criar
  3- chat_channel.js e demais canais que eu criar importam consumer
*/