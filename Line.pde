class Line{
    // Se va a dejar de usar
    // float a, b;
    // ------ //
    Point pos;
    private float w, h;


    Line(){
        initPos();
        defaultSize();
    }

    void defaultSize() {
        w = 100; h = 5;
    }

    void initPos() {
        pos = new Point(450, 650);
    }

    void reset() {
        initPos();
    }

    void update(int k){
        switch(k){
          case 37: if(pos.getX()>0) pos.moveX(-10);
          break;
          case 39: if(pos.getX() < width - w) pos.moveX(10);
          break;
          default:
          break;
        }
    }

    void show(){
        fill(255);
        rect(pos.getX(), pos.getY(), w, h);
    }
}
