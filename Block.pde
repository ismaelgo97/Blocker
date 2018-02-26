class Block {
    // Rectangle position;
    Point pos, endPos;

    // Rectangle Coordinates
    Coordinate upleft, upright, downleft, downright;

    //
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
        pos = upleft = new Point(i * w, j * h);
        endPos = upright = new Point(pos.getX() + w, pos.getY());
        downleft  = new Point(pos.getX()    , pos.getY() + h);
        downright = new Point(pos.getX() + w, pos.getY() + h);
    }

    boolean isTop(Ball ball) {
        return (ball.centre.getX() > upleft.getX() &&
                ball.centre.getX() < upright.getX())
            && (ball.centre.getY() == upleft.getY());
    }

    boolean isBottom(Ball ball) {
        return (ball.centre.getX() > downleft.getX() &&
                ball.centre.getX() < downright.getX())
            && (ball.centre.getY() == downleft.getY());
    }

    boolean isRight(Ball ball) {
        return (ball.centre.getY() >   upright.getY() &&
                ball.centre.getY() < downright.getY())
            && (ball.centre.getX() == upright.getX());
    }

    boolean isLeft(Ball ball) {
        return (ball.centre.getY() >   upleft.getY() &&
                ball.centre.getY() < downleft.getY())
            && (ball.centre.getX() == upleft.getX());
   }

    private boolean isTouched(Ball ball) {
        if (isTop(ball) || isBottom(ball)) {
            ball.changeWayY();
            return true;
        } else if (isLeft(ball) || isRight(ball)) {
            ball.changeWayX();
            return true;
        } else {
            return false;
        }
    }

    boolean isAlive() {
        return alive;
    }

    private void remove() {
        alive = false;
        c = color(0, 0, 0);
    }

    void update(Ball ball){
        if (isTouched(ball)) {
            remove();
        }
    }


    void show(){
        fill(c);
        rect(pos.getX(), pos.getY(), w, h);
    }
}
