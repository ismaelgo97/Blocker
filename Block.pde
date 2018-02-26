class Block{
    Point pos;
    float w = 100;
    float h = 30;
    color c;
    boolean alive = true;


    Block(int i, int j) {
        initPos(i, j);
        c = color(random(1, 255), random(1, 255), random(1, 255));
    }

    Block(int i, int j, float r, float g, float b){
        initPos(i, j);
        c = color(r, g, b);
    }

    Block(int i, int j, color c) {
        initPos(i, j);
        this.c = c;
    }

    void initPos(int i, int j) {
        pos = new Point(i * w, j * h);
    }

    void remove() {
        c = color(0, 0, 0);
    }

    void update(){

    }


    void show(){
        fill(c);
        rect(pos.getX(), pos.getY(), w, h);
    }
}
