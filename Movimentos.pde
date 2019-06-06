class Movimentos{
    PVector[] direcao;
    int mov;
    int indice;
    float dicx, dicy;
    
    Movimentos(int size){
      direcao = new PVector[size];
      randomizar();
      indice = 0;
      dicy = random(-1.5, 1.5);
      dicx = random(-2, 2);
    }
    
    void randomizar(){
      for (int i = 0; i< direcao.length; i++) {
        float randomAngle = random(2*PI);
        direcao[i] = PVector.fromAngle(randomAngle);
        direcao[i].x += dicx;
        direcao[i].x += dicx;
        direcao[i].x *= 8;
        direcao[i].y *= 8;
        
      }
    }
    
    

    
}
