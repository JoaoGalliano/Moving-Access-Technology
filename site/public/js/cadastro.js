function cadastrar() {
    aguardar();

    //Recupere o valor da nova input pelo nome do id
    // Agora vá para o método fetch logo abaixo
    var nomeVar = nome_input.value;
    var emailVar = email_input.value;
    var senhaVar = senha_input.value;
    var confirmacaoSenhaVar = confirmacao_senha_input.value;


    // Validações:
    // Campos vazios
    if (nomeVar == "" || emailVar == "" || senhaVar == "" || confirmacaoSenhaVar == "") {
        cardErro.style.display = "block"
        mensagem_erro.innerHTML = "Preencha todos os campos para prosseguir!";

        finalizarAguardar();
        return false;
    }
    else {
        setInterval(sumirMensagem, 5000)
    }

    // Nome numérico
    var nome = Number(nomeVar);

    if (!isNaN(nome)) {
        cardErro.style.display = "block"
        mensagem_erro.innerHTML = "Nome não pode ser numérico, digite seu nome novamente";

        finalizarAguardar();
        return false;
    }
    else {
        setInterval(sumirMensagem, 5000)
    }

    // Senha com 8 caracteres
    // var regex = /^(?=(?:.?[A-Z]){1})(?=(?:.?[0-9]){1})(?=(?:.?[!@#$%()+^&}{:;?.]){1})(?!.\s)[0-9a-zA-Z!@#$%;(){}+^&]*$/;

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

    // Campo confirmacaoSenha igual ao de senha
    if (senhaVar != confirmacaoSenhaVar) {
        cardErro.style.display = "block"
        mensagem_erro.innerHTML = "As senhas inseridas devem ser iguais para prosseguir!";
        finalizarAguardar();
        return false;
    }
    else {
        setInterval(sumirMensagem, 5000)
    }


    // Enviando o valor da nova input
    fetch("/usuarios/cadastrar", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            // crie um atributo que recebe o valor recuperado aqui
            // Agora vá para o arquivo routes/usuario.js
            nomeServer: nomeVar,
            emailServer: emailVar,
            senhaServer: senhaVar
        })
    }).then(function (resposta) {

        console.log("resposta: ", resposta);

        if (resposta.ok) {
            cardErro.style.display = "block";

            mensagem_erro.innerHTML = "Cadastro realizado com sucesso! Redirecionando para tela de Login...";

            setTimeout(() => {
                window.location = "login.html";
            }, "2000")

            limparFormulario();
            finalizarAguardar();
        } else {
            throw ("Houve um erro ao tentar realizar o cadastro!");
        }
    }).catch(function (resposta) {
        console.log(`#ERRO: ${resposta}`);
        finalizarAguardar();
    });

    cadastrar_empresa();
    return false;
}

//cadastrar_empresa
function cadastrar_empresa(){

    var cnpjVar = cnpj_input.value;
    var empresaVar = empresa_input.value;

    // Enviando o valor da nova input
    fetch("/usuarios/cadastrar_empresa", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            // crie um atributo que recebe o valor recuperado aqui
            // Agora vá para o arquivo routes/usuario.js
            cnpjServer: cnpjVar,
            empresaServer: empresaVar
        })
    }).then(function (resposta) {

        console.log("resposta: ", resposta);

        if (resposta.ok) {
            cardErro.style.display = "block"

            mensagem_erro.innerHTML = "Cadastro realizado com sucesso! Redirecionando para tela de Login...";

            setTimeout(() => {
                window.location = "login.html";
            }, "2000")

            limparFormulario();
            finalizarAguardar();
        } else {
            throw ("Houve um erro ao tentar realizar o cadastro!");
        }
    }).catch(function (resposta) {
        console.log(`#ERRO: ${resposta}`);
        finalizarAguardar();
    });

    return false;
}

function sumirMensagem() {
    cardErro.style.display = "none"
}