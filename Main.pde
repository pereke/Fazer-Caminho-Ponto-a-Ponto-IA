Populacao pop;
PVector objetivo;
int tamanho = 1500;
int qtdMovimentosASeremRealizados = 1000;
int geracao = 0;
int cromossomosNoObjetivo = 0;


void setup() {
  //fullScreen();
  size(1366, 768);
  background(255);
  frameRate(144);
  pop = new Populacao();  
  objetivo = new PVector(width/2, 40);
}


void draw() {
  if (pop.finalizou()) {
    println("Fim da geração " + geracao);
    cromossomosNoObjetivo = pop.cromossomosNoObjetivo();
    println("Cromossomos que atigiram o objetivo: " + cromossomosNoObjetivo);
    pop.proxGeracao();
    println("---------------------------------------");
  } else {
    background(255);
    fill(255, 0, 0);
    ellipse(objetivo.x, objetivo.y, 10, 10);
    pop.move();
    pop.show();
  }
}
