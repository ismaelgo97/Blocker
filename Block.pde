class Block{
    float posx;
    float posy;
    float ancho=100;
    float alto=30;
    color c;
    boolean alive = true;


    Block(int i, int j){
        posx=i*100;
        posy=j*30;
        c = color(random(1, 255), random(1, 255), random(1, 255));
    }

    Block(int i, int j, float r, float g, float b){
        posx = i*100;
        posy = j*30;
        c = color(r, g, b);
    }

    Block(int i, int j, color c) {
        posx = i*100;
        posy = j*30;
        this.c = c;
    }

    void remove() {
        c = color(0, 0, 0);
    }

    void update(){

    }


    void show(){
        fill(c);
        rect(posx, posy, ancho, alto);
    }
}
