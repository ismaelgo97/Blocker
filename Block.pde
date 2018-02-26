class Block{
    float posx;
    float posy;
    float ancho=100;
    float alto=30;
    Color c;
    boolean alive = true;


    Block(int i, int j){
        posx=i*100;
        posy=j*30;
        c = new Color(random(1, 255), random(1, 255), random(1, 255));
    }

    Block(int i, int j, float r, float g, float b){
        posx = i*100;
        posy = j*30;
        c = new Color(r, g, b);
    }

    Block(int i, int j, Color c) {
        posx = i*100;
        posy = j*30;
        this.c = c;
    }

    void remove() {
        c = Colors.Black.getColor();
    }

    void update(){

    }


    void show(){
        fill(c.getR(), c.getG(), c.getB());
        rect(posx, posy, ancho, alto);
    }
}
