import java.util.Collections;

class Carro {
  PVector pos = new PVector(width/2, height);
  PVector vel = new PVector();
  PVector acc = new PVector();
  DNA dna;
  float fitness = 0;
  boolean colidiu = false;
  
  public Carro(int lifespan, ArrayList dna) {
    if (dna != null) {
      this.dna = new DNA(lifespan, dna);
    } else {
     this.dna = new DNA(lifespan, null);
    }
  }
  void applyForce(PVector n) {
    this.acc.add(n);
  }
  void update(int count) {
    this.vel.add(acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
    applyForce(this.dna.vetores.get(count));
  }
  
  void show() {
    pushMatrix();
    rectMode(CENTER);
    translate(this.pos.x, this.pos.y);
    rotate(this.vel.heading());
    fill(255, 100);
    noStroke();
    rect(0, 0, 30, 10);
    popMatrix();  
  }
  class DNA {
    ArrayList<PVector> vetores = new ArrayList();
    public DNA(int lifespan, ArrayList dna) {
      if (dna == null) {
        for (int i = 0; i < lifespan; i++) {
          PVector gene = PVector.random2D();
          gene.setMag(0.5);
          vetores.add(gene);
        }
      } else {
          vetores = dna;
      }
    }
    void mutate(int mutationRate) {
      int swaps = 5;
      int a = round(random(100));
      if (a <= mutationRate) {
        for (int i = 0; i < swaps; i++) {
          Collections.swap(vetores, floor(random(lifespan)), floor(random(lifespan)));
        }
      }
    }
    }
  }
