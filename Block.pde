class Block {
    // Rectangle position;
    Point centre;

    Vector corner, vertical, horizontal;

    //
    final float w = 100;
    final float h = 30;

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
        centre = new Point(i * w + w/2, j * h);
        float x = centre.getX();
        float y = centre.getY();

        corner      = new Vector(centre, new Point(x + distFromCentre(w), y + distFromCentre(h)));
        horizontal  = new Vector(centre, new Point(x + w, y));
        vertical    = new Vector(centre, new Point(x, y + h));
    }

    float distFromCentre(float d) {
        return d/2;
    }

    boolean isTop(Ball ball) {

        float d = new Vector(ball.centre, centre).getLength() + ball.getRadius();
        return d <= corner.getLength();

        // return (ball.centre.getX() >= upleft.getX() &&
        //         ball.centre.getX() <= upright.getX())
        //     && (ball.centre.getY() + ball.getRadius() == upleft.getY());
    }

    boolean isBottom(Ball ball) {

        float d = new Vector(ball.centre, centre).getLength() + ball.getRadius();
        return d <= corner.getLength();
        // return (ball.centre.getX() >= downleft.getX() &&
        //         ball.centre.getX() <= downright.getX())
        //     && (ball.centre.getY() - ball.getRadius() == downleft.getY());
    }

    boolean isRight(Ball ball) {

        float d = new Vector(ball.centre, centre).getLength() + ball.getRadius();
        return d <= corner.getLength();

        // return (ball.centre.getY() - ball.getRadius() >=   upright.getY() &&
        //         ball.centre.getY() - ball.getRadius() <= downright.getY())
        //     && (ball.centre.getX() == upright.getX());
    }

    boolean isLeft(Ball ball) {

        float d = new Vector(ball.centre, centre).getLength() + ball.getRadius();
        return d <= corner.getLength();

        // return (ball.centre.getY() + ball.getRadius() >=   upleft.getY() &&
        //         ball.centre.getY() + ball.getRadius() <= downleft.getY())
        //     && (ball.centre.getX() == upleft.getX());
   }

    private boolean isTouched(Ball ball) {
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
        if (isTouched(ball)) {
            player.addPoints();
            alive = false;
        }
    }

    void show(){
        fill(c);
        rectMode(CENTER);
        rect(centre.getX(), centre.getY(), w, h);
    }
}
