class Movimentos {
    PVector[] movimento;
    int indice;
    
    Movimentos() {
      movimento = new PVector[qtdMovimentosASeremRealizados];

      // Criando cada movimento
      for (int i = 0; i < qtdMovimentosASeremRealizados; i++) {
        float randomAngle = random(2 * PI);
        movimento[i] = PVector.fromAngle(randomAngle);
      }

      indice = 0;
    }
    
}
