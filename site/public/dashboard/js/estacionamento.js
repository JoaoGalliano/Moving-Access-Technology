function atualizacaoPeriodica() {
    obterdados(1);
    obterdados(2);
    obterdados(3);
    obterdados(4);

    function sendData() {
        var http = new XMLHttpRequest();
        http.open('POST', 'http://localhost:3000/api/sendData', false);
        http.send(null);
    }

    setInterval(() => {
        sendData();
    }, 2000);
    setTimeout(atualizacaoPeriodica, 5000);
}

function obterdados(idAquario) {
    fetch(`/medidas/tempo-real/${idAquario}`)
        .then(resposta => {

            if (resposta.ok) {
                resposta.json().then(resposta => {

                    console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);

                    var dados = {
                        temperatura: resposta[0].temperatura,
                    }

                    alertar(resposta[0].temperatura, idAquario);
                });
            } else {

                console.error('Nenhum dado encontrado ou erro na API');
            }
        })
        .catch(function (error) {
            console.error(`Erro na obtenção dos dados do aquario p/ gráfico: ${error.message}`);
        });

}

function alertar(temperatura, idAquario) {
    var limites = {
        muito_quente: 23,
        quente: 22,
        ideal: 20,
        frio: 10,
        muito_frio: 5
    };

    var classe_temperatura = 'cor-alerta';

    if (temperatura >= limites.muito_quente) {
        classe_temperatura = 'cor-alerta perigo-quente';
        console.log("caiu no 1")
    }
    else if (temperatura < limites.muito_quente && temperatura >= limites.quente) {
        classe_temperatura = 'cor-alerta alerta-quente';
        console.log("caiu no 2")
    }
    else if (temperatura < limites.quente && temperatura > limites.frio) {
        classe_temperatura = 'cor-alerta ideal';
        console.log("caiu no 3")
    }
    else if (temperatura <= limites.frio && temperatura > limites.muito_frio) {
        classe_temperatura = 'cor-alerta alerta-frio';
        console.log("caiu no 4")
    }
    else if (temperatura < limites.min_temperatura) {
        classe_temperatura = 'cor-alerta perigo-frio';
        console.log("caiu no 5")
    }

    var card;

    if (idAquario == 1) {
        temp_aquario_1.innerHTML = temperatura + "°C";
        card = card_1
    } else if (idAquario == 2) {
        temp_aquario_2.innerHTML = temperatura + "°C";
        card = card_2
    } else if (idAquario == 3) {
        temp_aquario_3.innerHTML = temperatura + "°C";
        card = card_3
    } else if (idAquario == 4) {
        temp_aquario_4.innerHTML = temperatura + "°C";
        card = card_4
    }

    // alterando
    card.className = classe_temperatura;
}