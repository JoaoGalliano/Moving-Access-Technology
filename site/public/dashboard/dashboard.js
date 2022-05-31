// ================================== CONFIGURANDO CHART JS ===========================================-->
// const labels2 = [
//   'Segunda-feira',
//   'Terça-feira',
//   'Quarta-feira',
//   'Quinta-feira',
//   'Sexta-feira',
//   'Sábado',
//   'Domingo',
// ];

// const data2 = {
//   labels: labels2,
//   datasets: [{
//     label: 'Fluxo de Carros',
//     backgroundColor: '#FF4000',
//     borderColor: '#FF4000',
//     data: [340, 180, 210, 150, 190, 360, 100],
//   }]
// };

// const labels = [
//   '12:00',
//   '12:30',
//   '15:00',
//   '17:00',
//   '13:10',
//   '13:40',
// ];

// const data = {
//   labels: labels,
//   datasets: [{
//     label: 'Vagas Ocupadas',
//     backgroundColor: '#FF4000',
//     borderColor: '#FF4000',
//     data: [60, 50, 100, 38, 64, 20],
//   }]
// };

// const config = {
//   type: 'line',
//   data: data,
//   options: {}
// };

// const config2 = {
//   type: 'bar',
//   data: data2,
//   options: {}
// };

// const myChart2 = new Chart(
//   document.getElementById('myChart2'),
//   config2
// );

// const myChart = new Chart(
//   document.getElementById('myChart'),
//   config
// );


// <!--================================== SCRIPT DO GRÁFICO ===========================================-->
let proximaAtualizacao;

// window.onload = obterDadosGrafico(1);
function obterDadosGrafico(idAquario) {

    if (proximaAtualizacao != undefined) {
        clearTimeout(proximaAtualizacao);
    }

    fetch(`/medidas/ultimas/${idAquario}`, { cache: 'no-store' }).then(function (response) {
        if (response.ok) {
            response.json().then(function (resposta) {
                console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);
                resposta.reverse();

                plotarGrafico(resposta, idAquario);
            });
        } else {
            console.error('Nenhum dado encontrado ou erro na API');
        }
    })
        .catch(function (error) {
            console.error(`Erro na obtenção dos dados p/ gráfico: ${error.message}`);
        });
}

// Esta função *plotarGrafico* usa os dados capturados na função anterior para criar o gráfico
// Configura o gráfico (cores, tipo, etc), materializa-o na página e, 
// A função *plotarGrafico* também invoca a função *atualizarGrafico*
function plotarGrafico(resposta, idAquario) {
    console.log('iniciando plotagem do gráfico...');

    var dados = {
        labels: [],
        datasets: [
            {
                yAxisID: 'y-chave',
                label: 'Chave',
                borderColor: '#FFF',
                backgroundColor: '#32b9cd8f',
                fill: true,
                data: []
            }
        ]
    };

    for (i = 0; i < resposta.length; i++) {
        var registro = resposta[i];
        dados.labels.push(registro.momento_grafico);
        dados.datasets[0].data.push(registro.chave);
    }

    console.log(JSON.stringify(dados));

    var ctx = canvas_grafico.getContext('2d');
    window.grafico_linha = Chart.Line(ctx, {
        data: dados,
        options: {
            responsive: true,
            animation: { duration: 1000 },
            hoverMode: 'index',
            stacked: false,
            title: {
                display: false,
                text: 'Dados capturados'
            },
            scales: {
                yAxes: [
                    {
                        type: 'linear',
                        display: true,
                        position: 'left',
                        id: 'y-chave',
                        ticks: {
                            beginAtZero: true,
                            max: 1000,
                            min: 0
                        }
                    }],
            }
        }
    });

    setTimeout(() => atualizarGrafico(idAquario, dados), 2000);
}


// Esta função *atualizarGrafico* atualiza o gráfico que foi renderizado na página,
// buscando a última medida inserida em tabela contendo as capturas, 

//     Se quiser alterar a busca, ajuste as regras de negócio em src/controllers
//     Para ajustar o "select", ajuste o comando sql em src/models
function atualizarGrafico(idAquario, dados) {

    fetch(`/medidas/tempo-real/${idAquario}`, { cache: 'no-store' }).then(function (response) {
        if (response.ok) {
            response.json().then(function (novoRegistro) {

                console.log(`Dados recebidos: ${JSON.stringify(novoRegistro)}`);
                console.log(`Dados atuais do gráfico: ${dados}`);

                // tirando e colocando valores no gráfico
                dados.labels.shift(); // apagar o primeiro
                dados.labels.push(novoRegistro[0].momento_grafico); // incluir um novo momento

                dados.datasets[0].data.shift();  // apagar o primeiro de temperatura
                dados.datasets[0].data.push(novoRegistro[0].chave); // incluir uma nova medida de temperatura

                window.grafico_linha.update();

                for (let contador = 1; contador < 600; contador++) {


                    if (novoRegistro[0].chave <= 300) {
                        span_analytics.innerHTML = `<span style="color: red;">Crítico</span>`
                    }
                    else if (novoRegistro[0].chave > 300 && novoRegistro[0].chave <= 500) {
                        span_analytics.innerHTML = `<span style="color: yellow;">Cuidado</span>`
                    }
                    else if (novoRegistro[0].chave > 500 && novoRegistro[0].chave <= 750) {
                        span_analytics.innerHTML = `<span style="color: green;">Ideal</span>`
                    }
                    else if (novoRegistro[0].chave > 750 && novoRegistro[0].chave <= 1000) {
                        span_analytics.innerHTML = `<span style="color: purple;">Lotação</span>`
                    }

                }

                // Altere aqui o valor em ms se quiser que o gráfico atualize mais rápido ou mais devagar
                proximaAtualizacao = setTimeout(() => atualizarGrafico(idAquario, dados), 2000);
            });
        } else {
            console.error('Nenhum dado encontrado ou erro na API');
            // Altere aqui o valor em ms se quiser que o gráfico atualize mais rápido ou mais devagar
            proximaAtualizacao = setTimeout(() => atualizarGrafico(idAquario, dados), 2000);
        }
    })
        .catch(function (error) {
            console.error(`Erro na obtenção dos dados p/ gráfico: ${error.message}`);
        });
}