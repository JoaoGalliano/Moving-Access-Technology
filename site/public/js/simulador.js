function calcular() {
    var aluguel = Number(ipt_aluguel.value) * 3
    var vagas = Number(ipt_vagas.value)
    var preco = Number(ipt_preco.value)
    var horas = Number(ipt_horas.value)
    var lucro_50 = (preco * vagas * horas) * 0.5
    var lucro_50_solucao = lucro_50 * 1.2
    var conta = preco * vagas


    principal.style.display = "none"
    all_opt.style.display = "block";
    opt_vagas_vazias.innerHTML = `${vagas}`
    opt_lucro_dono.innerHTML = `R$ ${((lucro_50 * 30) - (aluguel)).toFixed(2)}`
    opt_lucro_dono_solucao.innerHTML = `R$ ${(((lucro_50_solucao) * 30) - (aluguel)).toFixed(2)}`
    opt_lucro_50.innerHTML = `R$ ${((lucro_50) * 30).toFixed(2)}`
    opt_lucro_50_solucao.innerHTML = `R$ ${((lucro_50_solucao) * 30).toFixed(2)}`
}
function voltar() {
    principal.style.display = "block"
    all_opt.style.display = "none"
}