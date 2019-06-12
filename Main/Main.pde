Populacao pop;
PVector objetivo;
int tamanho = 1500;
int qtdMovimentosASeremRealizados = 1000;
int geracao = 0;
int cromossomosNoObjetivo = 0;
boolean primeiroAcertou = false;
int numPassos[];
boolean pontoParada = false;
int sumDif = 21;

void setup() {
  //fullScreen();
  size(1366, 768);
  background(255);
  frameRate(144);
  pop = new Populacao();  
  objetivo = new PVector(width/2, 40);
  numPassos = new int[5];
  for(int i = 0; i < 5; i++){
    numPassos[i] = 0;
  }
}


void draw() {
  if (geracao>4){
    sumDif=max(numPassos)-min(numPassos);
  }
  if (sumDif > 3){
    if (pop.finalizou()) {
      
      println("Fim da geração " + geracao);
      cromossomosNoObjetivo = pop.cromossomosNoObjetivo();
      println("Cromossomos que atigiram o objetivo: " + cromossomosNoObjetivo);
      numPassos[geracao%5] = qtdMovimentosASeremRealizados;
      print(numPassos[0], numPassos[1], numPassos[2], numPassos[3], numPassos[4]);
      pop.proxGeracao();
      println("---------------------------------------");
    } else {
      background(255);
      fill(255, 0, 0);
      ellipse(objetivo.x, objetivo.y, 10, 10);
      pop.move();
      pop.show();
    }
    fill(0, 0, 255);
    rect(width/3, 300, 600, 10);
  }
  
}
