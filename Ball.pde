class Ball {
    Point centre;
    // float xl, yl;
    private float radius;
    private float vctx, vcty;
    int vx = 1;
    int vy = 1;

    Ball(){
        initPos();
        initVector();
    }

    private void initPos() {
        radius = 15;
        centre = new Point(500, 640);
    }

    private void initVector() {
        vctx = random(4, -4);
        vcty = -4;
    }

    float getRadius() {
        return radius/2;
    }

    private boolean isTouchingLine(Line line) {
        return this.centre.getX() > line.pos.getX()
            && this.centre.getX() < line.endPos.getX()
            && this.centre.getY() + this.getRadius() > line.pos.getY();
    }

    private boolean isTouchingTopBorder() {
        return this.centre.getY() == 0;
    }

    private boolean isTouchingSideBorders() {
        return this.centre.getX() == 0
            || this.centre.getX() == width;
    }

    private boolean isTouchingBlock(Block block) {
        return false;
    }

    void update() {
        if (isTouchingSideBorders()) {
            vctx *= -1;
        }
        if (isTouchingTopBorder()) {
            vcty *= -1;
        }
        centre.move(vctx*vx, vcty*vy);
    }

    void update(Line line) {
        if (isTouchingLine(line)) {
            vcty *= -1;
        }
        update();
    }

    void update(Block block) {

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
