class Ball {
    Point centre;
    // float xl, yl;
    private float radius;
    Vector vector;
    float vx = 1;
    float vy = 1;

    Ball(){
        restore();
    }

    private void initPos() {
        radius = 15;
        centre = new Point(500, 640);
    }

    private void initVector() {
        vector = new Vector(random(2, -2), -1);
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

    boolean isTouchingDown() {
        return this.centre.getY() == height;
    }

    void update() {
        if (isTouchingSideBorders()) {
            vector.changeWayX();
        }
        if (isTouchingTopBorder()) {
            vector.changeWayY();
        }
        centre.move(vector.getX()*vx, vector.getY()*vy);
    }

    void update(Line line) {
        if (isTouchingLine(line)) {
            vector.changeWayY();
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
