class Line extends Point {

    HitBox hb;
    Velocity velocity;

    Line() {
        super(width/2, height - 65);
        setX(width/2); setY(height - 65);
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

    void update(int k){
        switch(k){
          case 37:
          if(hb.upleft.getX() > 0)
            move(-1*velocity.getXVelocity());
          break;
          case 39:
          if(hb.upright.getX() < width)
            move(velocity.getXVelocity());
          break;
          default:
          break;
        }
        hb.update(this);
    }

    void update() {
        if (getX() > 0 + hb.getWidth()/2 && getX() < width - hb.getWidth()/2)
            moveTo(mouseX);

        hb.update(this);
    }

    void show(){
        fill(255);
        rectMode(CENTER);
        rect(getX(), getY(), getWidth(), getHeight());
    }
}
