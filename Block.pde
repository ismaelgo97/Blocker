class Block extends Point {

    HitBox hb;
    color c;
    boolean alive = true;

    Block(int i, int j, float w, float h) {
        super(i * w + w/2, j * h);
        hb = new HitBox(w, h, this);
        c = color(random(1, 255), random(1, 255), random(1, 255));
    }

    Block(int i, int j, float w, float h, float r, float g, float b){
        super(i * w + w/2, j * h);
        hb = new HitBox(w, h, this);
        c = color(r, g, b);
    }

    Block(int i, int j, float w, float h, color c) {
        super(i * w + w/2, j * h);
        hb = new HitBox(w, h, this);
        this.c = c;
    }

    float getDistanceFrom(Ball ball) {
        return hb.getDistance(ball.hb) - ball.hb.getWidth()/2;
    }

    boolean isTop(Ball ball) {
        return getDistanceFrom(ball) <= hb.vertical.getLength();

        // return (ball.centre.getX() >= upleft.getX() &&
        //         ball.centre.getX() <= upright.getX())
        //     && (ball.centre.getY() + ball.getRadius() == upleft.getY());
    }

    boolean isBottom(Ball ball) {
        return getDistanceFrom(ball) <= hb.vertical.getLength();
        // return (ball.centre.getX() >= downleft.getX() &&
        //         ball.centre.getX() <= downright.getX())
        //     && (ball.centre.getY() - ball.getRadius() == downleft.getY());
    }

    boolean isRight(Ball ball) {
        // System.out.println(getDistanceFrom(ball) + " " + hb.horizontal.getLength());
        return getDistanceFrom(ball) <= hb.horizontal.getLength();
        // && (ball.centre.getY() - ball.getRadius() >=   upright.getY() &&
        //     ball.centre.getY() - ball.getRadius() <= downright.getY());

        // return (ball.centre.getY() - ball.getRadius() >=   upright.getY() &&
        //         ball.centre.getY() - ball.getRadius() <= downright.getY())
        //     && (ball.centre.getX() == upright.getX());
    }

    boolean isLeft(Ball ball) {
        return getDistanceFrom(ball) <= hb.horizontal.getLength();
        // && (ball.centre.getY() + ball.getRadius() >=   upleft.getY() &&
        //     ball.centre.getY() + ball.getRadius() <= downleft.getY());

        // return (ball.centre.getY() + ball.getRadius() >=   upleft.getY() &&
        //         ball.centre.getY() + ball.getRadius() <= downleft.getY())
        //     && (ball.centre.getX() == upleft.getX());
   }

    private boolean isTouchedBy(Ball ball) {
        boolean touched = false;
        if (isTop(ball) || isBottom(ball)) {
            ball.vector.changeWayY();
            touched = true;
        } else if (isLeft(ball) || isRight(ball)) {
            ball.vector.changeWayX();
            touched = true;
        }
        return touched;
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
        rectMode(CENTER);
        rect(getX(), getY(), hb.getWidth(), hb.getHeight());
    }
}
