class Line {
    // Se va a dejar de usar
    // float a, b;
    // ------ //
    Point pos;
    Point endPos;
    private float w, h;
    private float velocity = 35;


    Line(){
        restore();
    }

    private void defaultSize() {
        w = 100; h = 5;
    }

    private void initPos() {
        pos = new Point(450, 655);
        endPos = new Point(pos.getX() + w, pos.getY());
    }

    private void move(float x) {
        pos.moveX(x);
        endPos.moveX(x);
    }

    void restore() {
        defaultSize();
        initPos();
    }

    float getWidth() {
        return w;
    }

    void update(int k){
        switch(k){
          case 37: if(pos.getX() > 0) move(-1*velocity);
          break;
          case 39: if(pos.getX() < width - w) move(velocity);
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
