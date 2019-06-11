class Cromossomo {
    PVector pos;
    PVector vel;
    PVector acc;
    Movimentos mov;
    boolean acertou, parado;
    float fitness;

    Cromossomo() {
      pos = new PVector(width/2, height - 40);
      acc = new PVector(0, 0);
      mov = new Movimentos();
      acertou = false;
      parado = false;
    }
    
    Cromossomo(Cromossomo pai) {
      pos = new PVector(width/2, height - 40);
      acc = new PVector(0, 0);
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
        acc.add(mov.movimento[mov.indice]);
        acc.limit(7);
        pos.add(acc);
        mov.indice++;
      } else {
       parado = true; 
      }
      if (pos.x< 2|| pos.y<2 || pos.x>width-2 || pos.y>height -2) {//if near the edges of the window then kill it 
        parado = true;
        mov.indice = qtdMovimentosASeremRealizados*2;
      }
      if (pos.x< width/3+600 && pos.y < 312 && pos.x > width/3 && pos.y > 302) {//if hit obstacle
        parado = true;
        mov.indice = qtdMovimentosASeremRealizados*2;
      }
      if ((dist(pos.x, pos.y, objetivo.x, objetivo.y) < 5) && !acertou) {
        if  (!primeiroAcertou){
          primeiroAcertou = true;
          qtdMovimentosASeremRealizados = mov.indice;
        }
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
