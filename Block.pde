class Block extends Point {

    HitBox hb;
    color c;
    int posMode     = CENTER;
    boolean alive   = true;


    Block(int i, int j, float w, float h) {
        this(i, j, w, h, color(random(1, 255), random(1, 255), random(1, 255)));
    }

    Block(int i, int j, float w, float h, float r, float g, float b){
        this(i, j, w, h, color(r, g, b));
    }

    Block(int i, int j, float w, float h, color c) {
        super(i * w + w/2, j * h);
        hb = new HitBox(w, h, this, posMode);
        this.c = c;
    }

    private boolean isTouchedBy(Ball ball) {
        boolean[] touched = ball.hb.hit(this.hb);

        if (touched[HitBox.HIT]) {
            if (touched[HitBox.TOP]  || touched[HitBox.BOTTOM]) {
                ball.vector.changeWayY();
            }
            if (touched[HitBox.LEFT] || touched[HitBox.RIGHT]) {
                ball.vector.changeWayX();
            }
        }
        return touched[HitBox.HIT];
    }

    boolean isAlive() {
        return alive;
    }

    void update(Ball ball, Player player){
        if (isTouchedBy(ball)) {
            player.addPoints();
            alive = false;
        }
    }

    void show(){
        fill(c);
        rectMode(posMode);
        rect(getX(), getY(), hb.getWidth(), hb.getHeight());
    }
}
