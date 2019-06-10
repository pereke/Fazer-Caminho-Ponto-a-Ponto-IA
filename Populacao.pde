class Populacao {
  Cromossomo[] cromossomos;
  
  Populacao() {
    cromossomos = new Cromossomo[tamanho];
    for (int i = 0; i < tamanho; i++) {
      cromossomos[i] = new Cromossomo();
    }
  }
  
  void show() {
    fill(255, 255, 0);
    for (int i= 0; i < tamanho; i++) {
      ellipse(cromossomos[i].pos.x, cromossomos[i].pos.y, 8, 8);
    }
  }
  
  void move() {
      for (int i= 0; i < tamanho; i++) {
        cromossomos[i].move();
      }
  }
  
  boolean finalizou() {
    for (int i= 0; i < tamanho; i++) {
      if (!(cromossomos[i].acertou || cromossomos[i].parado)) {
        return false;
      }
    }
    return true;
  }
  
  int cromossomosNoObjetivo() {
    int cromossomosNoObjetivo = 0;
    for (int i= 0; i < tamanho; i++) {
      if (cromossomos[i].acertou) {
        cromossomosNoObjetivo++;
      }
    }
    return cromossomosNoObjetivo;
  }
  
  void proxGeracao() {
    geracao++;
    
    // Calculo do fitness de cada cromossomo
    for (int i= 0; i < tamanho; i++) {
      cromossomos[i].calcFitness();
    }
    
    // Criação da nova população
    Cromossomo[] cromossomosNovos = new Cromossomo[tamanho];
    
    // Criação de cada novo cromossomo
    for (int i= 0; i < tamanho; i++) {
      Cromossomo pai = selecionaPai();
      cromossomosNovos[i] = mutacao(pai);
    }
    
    // Substituindo a população anterior
    cromossomos = cromossomosNovos;
  }
  
  Cromossomo selecionaPai() {
    Cromossomo escolhido1 = cromossomos[int(random(tamanho))];
    Cromossomo escolhido2 = cromossomos[int(random(tamanho))];
    
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
        cromossomoNovo.mov.movimento[i].x *= 8;
        cromossomoNovo.mov.movimento[i].y *= 8;
      }
    }
    return cromossomoNovo;
  }
}
