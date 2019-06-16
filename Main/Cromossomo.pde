class Cromossomo {
    PVector pos;
    PVector posAnterior[];
    PVector vel;
    PVector acc;
    Movimentos mov;
    boolean acertou, parado, melhorGeracaoAnterior, primeiro;
    float fitness;

    Cromossomo() {
      pos = new PVector(width / 2, height - 40);
      acc = new PVector(0, 0);
      mov = new Movimentos();
      posAnterior = new PVector[qtdMovimentosASeremRealizados];
      for (int i = 0; i < qtdMovimentosASeremRealizados; i++) {
        posAnterior[i] = new PVector();
      }
      acertou = false;
      parado = false;
      primeiro = false;
      melhorGeracaoAnterior = false;
    }
    
    Cromossomo(Cromossomo pai) {
      pos = new PVector(width / 2, height - 40);
      acc = new PVector(0, 0);
      posAnterior = new PVector[qtdMovimentosASeremRealizados];
      acertou = false;
      parado = false;
      primeiro = false;
      melhorGeracaoAnterior = false;
      mov = new Movimentos();
      for (int i = 0; i < qtdMovimentosASeremRealizados; i++) {
        posAnterior[i] = new PVector();
        mov.movimento[i] = pai.mov.movimento[i];
      }
    }
    
    void draw() {
      fill(255, 255, 0);
      if (melhorGeracaoAnterior) {
        int i = 0;
        print(mov.indice + " - ");
        for (; i < mov.indice - 1; i++ ) {
          line(posAnterior[i].x, posAnterior[i].y, posAnterior[i + 1].x, posAnterior[i + 1].y);
        }
        line(posAnterior[i].x, posAnterior[i].y, pos.x, pos.y);
        fill(255, 0, 225);
      }
      ellipse(pos.x, pos.y, 8, 8);
    }
    
    void movimentar() {
      if (mov.indice < qtdMovimentosASeremRealizados && !parado) {
        posAnterior[mov.indice].x = pos.x;
        posAnterior[mov.indice].y = pos.y;
        acc.add(mov.movimento[mov.indice]);
        acc.limit(7);
        pos.add(acc);
        mov.indice++;
      } else {
       parado = true; 
      }

      // Se bateu nas etremidade da janela ele não se moverá
      if (pos.x < 2|| pos.y < 2 || pos.x > width-2 || pos.y > height -2) {
        parado = true;
        mov.indice = qtdMovimentosASeremRealizados;
      }

      // Se bateu no obstáculo ele não se moverá
      for (int i = 0; i < qtdObstaculos; i++) {
        if (pos.x > obstaculos[i][0] && pos.x < (obstaculos[i][0] +  obstaculos[i][2]) && pos.y > obstaculos[i][1] && pos.y < (obstaculos[i][1] + obstaculos[i][3])) {
          parado = true;
        }
      }

      // Se chegou ao objetivo
      if ((dist(pos.x, pos.y, objetivo.x, objetivo.y) < 5) && !acertou) {
        // Se foi o primeiro a chegar o objetivo
        if (!primeiroAcertou) {
          primeiroAcertou = true;
          primeiro = true;
          // A quantidade de movimentos agora será limitada ao número de movimentos deste cromossomo
          qtdMovimentosASeremRealizados = mov.indice;
        }
        acertou = true;
        parado = true;
      }
    }
    
    void calcFitness() {
      if (acertou) {
        fitness = float(1) / (mov.indice);
      } else {
        //if (parado) {
        //  fitness = 1 / ( 1000 / mov.indice * dist(pos.x, pos.y, objetivo.x, objetivo.y));
        //} else {
          fitness = 1 / ((dist(pos.x, pos.y, objetivo.x, objetivo.y)*dist(pos.x, pos.y, objetivo.x, objetivo.y)) + mov.indice);
        //}  
      }
    }

}
