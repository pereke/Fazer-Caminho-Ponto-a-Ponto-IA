// Váriaveis relativas ao algoritmo genético
int tamanhoPopulacao = 1500;
int qtdMovimentosASeremRealizados = 1000;
int qtdMaximaGeracoes = 80;
int geracoesParaContagem = 10;
int geracoesSemMudancaParada = 10;
//-------------------------------------------
Populacao pop;
PVector objetivo;
int geracao = 0;
int numPassos[];
boolean primeiroAcertou = false;
boolean pontoParada = false;
int diferenca = -1;
int contagemParaFinalizar = 0;
int qtdObstaculos = 3;
int obstaculos[][] = new int[qtdObstaculos][4];

void setup() {
  //fullScreen();
  size(1366, 768);
  background(255);
  frameRate(144);
  pop = new Populacao();  
  print(width/3);
  objetivo = new PVector(width/2, 40);
  numPassos = new int[5];
  for(int i = 0; i < 5; i++){
    numPassos[i] = 0;
  }
  // Obstáculos
  obstaculos[0][0] = width / 3; // Coordenada X do retângulo
  obstaculos[0][1] = 300; // Coordenada Y do retângulo
  obstaculos[0][2] = 456; // Tamanho em X do retângulo
  obstaculos[0][3] = 10; // Tamanho em Y do retângulo
  
  obstaculos[1][0] = 50; // Coordenada X do retângulo
  obstaculos[1][1] = 500; // Coordenada Y do retângulo
  obstaculos[1][2] = 300; // Tamanho em X do retângulo
  obstaculos[1][3] = 15; // Tamanho em Y do retângulo
  
  obstaculos[2][0] = 950; // Coordenada X do retângulo
  obstaculos[2][1] = 500; // Coordenada Y do retângulo
  obstaculos[2][2] = 300; // Tamanho em X do retângulo
  obstaculos[2][3] = 15; // Tamanho em Y do retângulo
}

void draw() {
  if (pop.finalizou()) {
    // Critérios de parada
    if (geracao > geracoesParaContagem) {
      if (geracao > qtdMaximaGeracoes) {
        noLoop(); // Para de chamar a função draw
        println("Critério de parada atingido! Se passaram " + qtdMaximaGeracoes + " gerações.");
        println("Número mínimo de passos para se tentar chegar ao objetivo: ", min(numPassos));
        return;
      }
      // Só começará a contar a diferença após a geração 5
      diferenca = max(numPassos) - min(numPassos);
      if (diferenca == 0) {
        //println("Contagem para finalizar: ", contagemParaFinalizar + 1);
        if (contagemParaFinalizar == geracoesSemMudancaParada) {
           noLoop(); // Para de chamar a função draw
           println("Critério de parada atingido! Se passaram 5 gerações sem melhora no número de passos.");
           println("Número mínimo de passos para se tentar chegar ao objetivo: ", min(numPassos));
           return;
        }
        contagemParaFinalizar++;
      } else {
        if (contagemParaFinalizar > 0) {
          // Houve uma melhora, então a contagem é zerada
          contagemParaFinalizar = 0;
        }
      } 
    }
    // Próxima geração
    println("Fim da geração " + geracao);
    numPassos[geracao % 5] = qtdMovimentosASeremRealizados;
    print(numPassos[0], numPassos[1], numPassos[2], numPassos[3], numPassos[4]);
    pop.proxGeracao();
    println("\n---------------------------------------");
  } else {
    // Desenhando os cromossomos
    background(255);
    fill(255, 0, 0);
    ellipse(objetivo.x, objetivo.y, 10, 10);
    pop.draw();
  }
  // Desenhando os obstáculos
  fill(0, 0, 0);
  for (int i = 0; i < qtdObstaculos; i++) {
    rect(obstaculos[i][0], obstaculos[i][1], obstaculos[i][2], obstaculos[i][3]);
  }
}
