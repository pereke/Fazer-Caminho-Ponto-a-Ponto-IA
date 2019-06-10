class Cromossomo {
    PVector pos;
    PVector vel;
    PVector acc;
    Movimentos mov;
    boolean acertou, parado;
    float fitness;

    Cromossomo() {
      pos = new PVector(width/2, height - 40);
      mov = new Movimentos();
      acertou = false;
      parado = false;
    }
    
    Cromossomo(Cromossomo pai) {
      pos = new PVector(width/2, height - 40);
      acertou = false;
      parado = false;
      mov = new Movimentos();
      for (int i = 0; i < qtdMovimentosASeremRealizados; i++) {
         mov.movimento[i] = pai.mov.movimento[i];
      }
    }
    
    void show() {
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    }
    
    void move() {
      if (mov.indice < qtdMovimentosASeremRealizados && !parado){
        pos.add(mov.movimento[mov.indice]);
        mov.indice++;
      } else {
       parado = true; 
      }
      if ((dist(pos.x, pos.y, objetivo.x, objetivo.y) < 5) && !acertou) {
        acertou = true;
        parado = true;
      }
    }
    
    void calcFitness() {
      if (acertou){
        fitness = float(1000)/(mov.indice);
      }else{
        fitness = 1000/(mov.indice * dist(pos.x, pos.y, objetivo.x, objetivo.y));
      }
    }

}
