ArrayList<Carro> carros = new ArrayList();
ArrayList<Carro> majinboo = new ArrayList();
PVector target; 
int lifespan = 200;
int count = 0;
int pop = 60;
int mutationRate = 4;

void setup(){
  size(800, 600);
  createCarros(pop);
  target = new PVector(width/2, 50);
}

void draw() {
  background(51);
  updateCarros();
  ellipse(this.target.x, this.target.y, 40 , 40);
  obstaculo(mouseX, mouseY, 400, 20);
}

void createCarros(int pop) {
  for (int i = 0; i < pop; i++) {
    Carro carro = new Carro(lifespan, null);
    carros.add(carro);
  }
}

void evaluate() {
  float maxFit = 0;
  for (Carro carro: carros) {
    float d = 1/dist(carro.pos.x, carro.pos.y, target.x, target.y);
    if (d > maxFit) {
      maxFit = d;

    }
  }
  
  for (Carro carro: carros) {
    float d = 1/dist(carro.pos.x, carro.pos.y, target.x, target.y);
    if (carro.colidiu) {
      carro.fitness = 0.01;
    } else {
      carro.fitness = d/maxFit;
    }

  }
  for (Carro carro: carros) {
    
    float a = carro.fitness * 100;
    int n = round(map(a, 0, 100, 1, 30));
    for (int i = 0; i < n; i++) {
      majinboo.add(carro);
    }
  }
}

void updateCarros() {
  if (lifespan == count) {
    count = 0;
    evaluate();
    selection();
    majinboo.clear();
  }
  for (Carro c: carros) {
    c.show();
    c.update(count);
  }
  count++;
}

void selection() {
  carros.clear();
  for (int i = 0; i < pop; i++) {
    Carro a = majinboo.get(floor(random(majinboo.size())));
    Carro b = majinboo.get(floor(random(majinboo.size())));
    Carro filho = crossover(a, b);
    filho.dna.mutate(mutationRate);
    carros.add(filho);
  }
}
Carro crossover(Carro a, Carro b){
  ArrayList<PVector> newDna = new ArrayList();
  int mid = floor(random(lifespan));
  for (int i = 0; i < lifespan; i++) {
    if (i < mid) {
      newDna.add(a.dna.vetores.get(i));
    } else {
      newDna.add(b.dna.vetores.get(i));
    }
  }
  return new Carro(lifespan, newDna);
}

void obstaculo(int x, int y, int a, int b) {
  rectMode(CORNER);
  for (Carro carro: carros) {
    if (carro.pos.y >= y && carro.pos.y <= y+b) {
      if (carro.pos.x >= x && carro.pos.x <= x+a) {
        carro.colidiu = true;
        carro.vel.mult(0);
      }
  }
  rect(x, y, a, b);
  }
  
}
