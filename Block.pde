class Block{
    float posx ;
    float posy;
    float ancho=100;
    float alto=30;
    float r, g, b;
    boolean alive = true;


    Block(int i, int j){
        posx=i*100;
        posy=j*30;
        r=random(1, 255);
        g=random(1, 255);
        b=random(1, 255);
    }

    Block(int i, int j, float rr, float gg, float bb){
        posx=i*100;
        posy=j*30;
        r=rr;
        g=gg;
        b=bb;
    }

    void update(){

    }


    void show(){
        fill(r,g,b);
        rect(posx, posy, ancho, alto);
    }
}
