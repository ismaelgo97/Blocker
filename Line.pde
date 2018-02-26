class Line {
    // Se va a dejar de usar
    // float a, b;
    // ------ //
    Point pos;
    Point endPos;
    private float w, h;


    Line(){
        initPos();
        defaultSize();
    }

    private void defaultSize() {
        w = 100; h = 5;
    }

    private void initPos() {
        pos = new Point(450, 650);
        endPos = new Point(pos.getX() + w, pos.getY());
    }

    private void move(int x) {
        pos.moveX(x);
        endPos.moveX(x);
    }

    void restore() {
        initPos();
    }

    float getWidth() {
        return w;
    }

    void update(int k){
        switch(k){
          case 37: if(pos.getX() > 0) move(-10);
          break;
          case 39: if(pos.getX() < width - w) move(10);
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
