class Populacao {
  Cromossomo[] cromossomos;
  
  Populacao() {
    cromossomos = new Cromossomo[tamanhoPopulacao];
    for (int i = 0; i < tamanhoPopulacao; i++) {
      cromossomos[i] = new Cromossomo();
    }
  }
  
  void draw() {
    for (int i= 0; i < tamanhoPopulacao; i++) {
      cromossomos[i].movimentar();
      cromossomos[i].draw();
    }
  }
  
  boolean finalizou() {
    for (int i= 0; i < tamanhoPopulacao; i++) {
      if (!(cromossomos[i].acertou || cromossomos[i].parado)) {
        return false;
      }
    }
    return true;
  }
  
  void proxGeracao() {
    geracao++;
    
    // Calculo do fitness de cada cromossomo
    for (int i= 0; i < tamanhoPopulacao; i++) {
      cromossomos[i].calcFitness();
    }
    
    // Criação da nova população
    Cromossomo[] cromossomosNovos = new Cromossomo[tamanhoPopulacao];
    
    float melhorFitness = 0;
    int indiceMelhorFitness = 0;
    // Criação de cada novo cromossomo
    for (int i= 0; i < tamanhoPopulacao; i++) {
      if (cromossomos[i].fitness > melhorFitness) {
        melhorFitness = cromossomos[i].fitness; 
        indiceMelhorFitness = i;
      }
      Cromossomo pai = selecionaPai();
      cromossomosNovos[i] = mutacao(pai);
    }
    
    // Pegando o melhor cromossomo da geração anterior
    Cromossomo melhorDaGeracao = new Cromossomo(cromossomos[indiceMelhorFitness]);
    melhorDaGeracao.melhorGeracaoAnterior = true;
    
    // Adiciona o melhor da geração anterior na nova população
    // Ele irá entrar no lugar de um cromossomo aleatório
    cromossomosNovos[int(random(tamanhoPopulacao))] = melhorDaGeracao;
    
    // Substituindo a população anterior
    cromossomos = cromossomosNovos;
    primeiroAcertou = false;
  }
  
  Cromossomo selecionaPai() {
    Cromossomo escolhido1 = cromossomos[int(random(tamanhoPopulacao))];
    Cromossomo escolhido2 = cromossomos[int(random(tamanhoPopulacao))];
    
    if (escolhido1.fitness > escolhido2.fitness) {
      return escolhido1;
    }
    return escolhido2;
  }
  
  Cromossomo mutacao(Cromossomo pai) {
    Cromossomo cromossomoNovo =  new Cromossomo(pai);
    for (int i = 0; i < qtdMovimentosASeremRealizados; i++) {
      int resultado = int(random(200)); //0.5%
      if (resultado == 0) {
        float randomAngle = random(2 * PI);
        cromossomoNovo.mov.movimento[i] = PVector.fromAngle(randomAngle);
      }
    }
    return cromossomoNovo;
  }
}
