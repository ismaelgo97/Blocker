class Line extends Point {

    HitBox hb;
    Velocity velocity;
    int posMode = CENTER;

    Line() {
        super(width/2, height - 65);
        velocity = new Velocity(35, 0);
        hb = new HitBox(100, 10, this);
        restore();
    }

    private void initPos() {
        setX(width/2); setY(height - 65);
        hb.update(this);
    }

    private void move(float x) {
        moveX(x);
    }

    private void moveTo(float x) {
        setX(x);
    }

    void restore() {
        initPos();
    }

    float getWidth() {
        return hb.getWidth();
    }

    float getHeight() {
        return hb.getHeight();
    }

    void update(int keyC){
        switch(keyC){
          case 37:
          if(hb.upLeft.getX() > 0)
            move(-1*velocity.getXVelocity());
          break;
          case 39:
          if(hb.upRight.getX() < width)
            move(velocity.getXVelocity());
          break;
          default:
          break;
        }
        hb.update(this);
    }

    void update() {
        if (getX() > 0 + hb.getHalfWidth() && getX() < width - hb.getHalfWidth())
            moveTo(mouseX);

        hb.update(this);
    }

    void show(){
        fill(0);
        rectMode(posMode);
        rect(getX(), getY(), getWidth(), getHeight());
    }
}
