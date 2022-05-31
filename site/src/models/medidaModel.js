var database = require("../database/config");

function buscarUltimasMedidas(idAquario, limite_linhas) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top ${limite_linhas}
        state as chave, 
        data,
                        CONVERT(varchar, data, 108) as momento_grafico
                    from dados
                    where fkSensor = 1
                    order by data desc`;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
                        state as chave,
                       hora as momento_grafico
                    from dados
                    where fkSensor = 1
                    order by hora desc limit ${limite_linhas}`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idAquario) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select SUM(state) as chave,
        (select top 1 CONVERT(VARCHAR(11),DATA,108) from dados where fkSensor = 1 order by data desc) as momento_grafico 
            from dados
                where fkSensor = 1`
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select
                        SUM(state) as chave,
                        (select hora from dados where fkSensor = 1 order by hora desc limit 1) as momento_grafico
                        from dados
                        where fkSensor = 1`
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}