class Agente{
    PVector pos;
    PVector vel;
    PVector acc;
    Movimentos mov;
    boolean acertou, morto;
    int qtdMovs = 1000;
    float fitness;
    
    
    Agente() {
      fitness = 0;
      pos = new PVector(width/2, height - 40);
      vel = new PVector(0, 0);
      acc = new PVector(0, 0);
      mov = new Movimentos(qtdMovs);
      qtdMovs--;
      acertou = false;
      morto = false;
    }
    
    void show(){
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    }
    
    void move(){
      if (mov.indice<qtdMovs && !acertou){
        pos.add(mov.direcao[mov.indice]);
        mov.indice++;
      }else{
        morto = true;
      }
      if ((dist(pos.x, pos.y, objetivo.x, objetivo.y) < 5) && !acertou) {//if reached goal
        acertou = true;
      }
    }
    
    void calcFitness(){
      if  (acertou){
        fitness = float(1000)/(mov.indice);
      }else{
        fitness = 1000/(mov.indice * dist(pos.x, pos.y, objetivo.x, objetivo.y));
      }
    }
}
