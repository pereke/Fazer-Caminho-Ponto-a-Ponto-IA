class Populacao{
  Agente[] agentes;
  int size = 0;
  
  Populacao(int size) {
    this.size = size;
    agentes = new Agente[size];
    for (int i = 0; i< size; i++) {
      agentes[i] = new Agente();
    }
  }
  
  void show(){
    fill(0, 255, 0);
    for(int i= 0; i < size; i++){
      ellipse(agentes[i].pos.x, agentes[i].pos.y, 8, 8);
    }
  }
  
  void move(){
      for(int i= 0; i < size; i++){
        agentes[i].move();
      }
  }
  
  boolean finalizou(){
    for(int i= 0; i < size; i++){
      if (!(agentes[i].acertou || agentes[i].morto)){
        return false;
      }
    }
    return true;
  }
  
  void proxGeracao(){
    calcFitness();
    print("calculou o fitness \n");
    Agente[] agentesNovos = new Agente[size];
    print("criou o agente novo \n");
    for(int i= 0; i < size; i++){
      agentesNovos[i] = new Agente();
      Movimentos m = new Movimentos(1000);
      for (int j= 0; j < 1000; j++){
        m.direcao[j] = selecionaPai().mov.direcao[j].copy();
      }
      agentesNovos[i].mov = m;
      agentesNovos[i] = mutacao(agentesNovos[i]);
    }
    print("cabo o role \n");
    agentes = agentesNovos;
    
  }
  
  void calcFitness(){
    for(int i= 0; i < size; i++){
      agentes[i].calcFitness();
    }
  
  }
  
  Agente selecionaPai (){
    Agente escolhido = agentes[int(random(size))];
    int index = 0;
    for(int i= 0; i < 7; i++){
      index = int(random(size));
      if(agentes[index].fitness > escolhido.fitness){
        escolhido = agentes[index];
      }
    }
    return  escolhido;
  }
  
  Agente mutacao(Agente pai){
    Agente novoA = pai;
    for (int i = 0; i < pai.qtdMovs; i++){
      int muta = int(random(200));
      if(muta < 1){
        float randomAngle = random(2*PI);
        novoA.mov.direcao[i] =  PVector.fromAngle(randomAngle);
        novoA.mov.direcao[i].x += novoA.mov.dicx;
        novoA.mov.direcao[i].y += novoA.mov.dicy;
        novoA.mov.direcao[i].x *= 8;
        novoA.mov.direcao[i].y *= 8;
      }
    }
    return novoA;
  }
}
