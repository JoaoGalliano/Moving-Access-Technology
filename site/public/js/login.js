function entrar() {
    aguardar();

    var emailVar = email_input.value;
    var senhaVar = senha_input.value;


    // Validações: 
    // Campos vazios
    if (emailVar == "" || senhaVar == "") {
        cardErro.style.display = "block"
        mensagem_erro.innerHTML = "Preencha todos os campos para prosseguir!";
        finalizarAguardar();
        return false;
    }
    else {
        setInterval(sumirMensagem, 5000)
    }

    // Senha com 8 caracteres
    /*var regex = /^(?=(?:.?[A-Z]){1})(?=(?:.?[0-9]){1})(?=(?:.?[!@#$%()+^&}{:;?.]){1})(?!.\s)[0-9a-zA-Z!@#$%;(){}+^&]*$/;*/

    if (senhaVar.length < 8) {
        cardErro.style.display = "block"
        mensagem_erro.innerHTML = "Senha deve conter no mínimo 8 caracteres";
        finalizarAguardar();
        return false;
    }
    /*else if (!regex.exec(senhaVar)) {
        cardErro.style.display = "block"
        mensagem_erro.innerHTML = "Senha deve conter 1 letra maiúscula, 1 número e 1 caractere especial.";
        finalizarAguardar();
        return false;
    }*/
    else {
        setInterval(sumirMensagem, 5000)
    }

    // Email com @ e .com
    if (emailVar.indexOf("@") == -1 || emailVar.indexOf(".com") == -1) {
        cardErro.style.display = "block"
        mensagem_erro.innerHTML = "Ops, e-mail inválido! Verifique e tente novamente.";
        finalizarAguardar();
        return false;
    }
    else {
        setInterval(sumirMensagem, 5000)
    }


    console.log("FORM LOGIN: ", emailVar);
    console.log("FORM SENHA: ", senhaVar);

    fetch("/usuarios/autenticar", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            emailServer: emailVar,
            senhaServer: senhaVar
        })
    }).then(function (resposta) {
        console.log("ESTOU NO THEN DO entrar()!")

        if (resposta.ok) {
            console.log(resposta);

            resposta.json().then(json => {
                console.log(json);
                console.log(JSON.stringify(json));

                sessionStorage.EMAIL_USUARIO = json.email;
                sessionStorage.NOME_USUARIO = json.nome;
                sessionStorage.ID_USUARIO = json.id;

                setTimeout(function () {
                    window.location = "./dashboard/cards.html";
                }, 1000); // apenas para exibir o loading

            });

        } else {

            console.log("Houve um erro ao tentar realizar o login!");

            resposta.text().then(texto => {
                console.error(texto);
                finalizarAguardar(texto);
            });
        }

    }).catch(function (erro) {
        console.log(erro);
    })

    return false;
}

function sumirMensagem() {
    cardErro.style.display = "none"
}