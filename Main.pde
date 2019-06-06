Populacao p;
PVector objetivo;
int tamanho;


void setup() {
  //fullScreen();
  tamanho = 1500;
  size(1366, 768);
  background(255);
  frameRate(144);
  p = new Populacao(tamanho);  
  objetivo = new PVector(width/2, 40);
}



void draw() {
  if (p.finalizou()){
    print("entrou na prox geracao \n");
    p.proxGeracao();
  }else{
    background(255);
    fill(255, 0, 0);
    ellipse(objetivo.x, objetivo.y, 10, 10);
    p.move();
    p.show();
  }

}
