class Ball {
    Point centre;
    // float xl, yl;
    private float radius;
    private float vctx, vcty;
    int vx = 1;
    int vy = 1;

    Ball(){
        restore();
    }

    private void initPos() {
        radius = 15;
        centre = new Point(width/2), 640);
    }

    private void initVector() {
        vctx = random(4, -4);
        vcty = -4;
    }

    void changeWayX() {
        vctx *= -1;
    }

    void changeWayY() {
        vcty *= -1;
    }


    float getRadius() {
        return radius;
    }

    private boolean isTouchingLine(Line line) {
        return this.centre.getX() - radius > line.pos.getX()
            && this.centre.getX() + radius < line.endPos.getX()
            && this.centre.getY() + radius > line.pos.getY();
    }

    private boolean isTouchingTopBorder() {
        return this.centre.getY() == 0;
    }

    private boolean isTouchingSideBorders() {
        return this.centre.getX() == 0
            || this.centre.getX() == width;
    }

    void update() {
        if (isTouchingSideBorders()) {
            changeWayX();
        }
        if (isTouchingTopBorder()) {
            changeWayY();
        }
        centre.move(vctx*vx, vcty*vy);
    }

    void update(Line line) {
        if (isTouchingLine(line)) {
            changeWayY();
        }
        update();
    }

    void restore(){
        initPos();
        initVector();
    }

    void show(){
        fill(255);
        ellipseMode(CENTER);
        ellipse(centre.getX(), centre.getY(), radius, radius);
    }
}
