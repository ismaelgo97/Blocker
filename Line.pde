class Line {
    Point pos;
    Point endPos;
    Point centre;
    private float w, h;
    private float velocity = 35;

    Line(){
        restore();
    }

    private void defaultSize() {
        w = 100; h = 5;
    }

    private void initPos() {
        centre = new Point(width/2, 655);
        pos = new Point(centre.getX() - w/2, centre.getX());
        endPos = new Point(centre.getX() + w/2, centre.getY());
    }

    private void move(float x) {
        centre.moveX(x);
        pos.moveX(x);
        endPos.moveX(x);
    }

    private void moveTo(float x) {
        centre.setX(x);
        pos.setX(x);
        endPos.setX(x + w);
    }

    void restore() {
        defaultSize();
        initPos();
    }

    float getWidth() {
        return w;
    }

    float getHeight() {
        return h;
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

    void update() {
        if (pos.getX() > 0 && pos.getX() < width - w) moveTo(mouseX);
    }

    void show(){
        fill(255);
        rectMode(CENTER);
        rect(centre.getX(), centre.getY(), w, h);
    }
}
