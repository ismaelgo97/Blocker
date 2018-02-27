class Ball {
    Point centre;
    // float xl, yl;
    private float diametre;
    Vector vector;
    float vx = 1;
    float vy = 1;

    Ball(){
        restore();
    }

    private void initPos() {
        diametre = 15;
        centre = new Point(500, 640);
    }

    private void initVector() {
        vector = new Vector(random(6, -6), -6);
    }

    float getRadius() {
        return diametre/2;
    }

    private boolean isTouchingLine(Line line) {
        return this.centre.getX() - getRadius() > line.pos.getX()
            && this.centre.getX() + getRadius() < line.endPos.getX()
            && this.centre.getY() + getRadius() > line.pos.getY();
    }

    private boolean isTouchingTopBorder() {
        return this.centre.getY() <= 0;
    }

    private boolean isTouchingSideBorders() {
        return this.centre.getX() <= 0
            || this.centre.getX() >= width;
    }

    boolean isTouchingDown() {
        return this.centre.getY() >= height;
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
        ellipse(centre.getX(), centre.getY(), diametre, diametre);
    }
}
