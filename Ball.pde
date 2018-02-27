class Ball {
    Point centre;
    // float xl, yl;
    private float diameter;
    Vector vector;
    float vx = 1;
    float vy = 1;

    Ball(){
        restore();
    }

    private void initPos() {
        diameter = 15;
        centre = new Point(500, 640);
    }

    private void initVector() {
        vector = new Vector(random(4, -4), -4);
    }

    float getRadius() {
        return diameter/2;
    }

    private boolean isTouchingLine(Line line) {
        // float p = new Vector(centre, line.pos).getLength() + getRadius();
        // float e = new Vector(centre, line.endPos).getLength() + getRadius();
        // return p;
        return this.centre.getX() - getRadius() > line.pos.getX()
            && this.centre.getX() + getRadius() < line.endPos.getX()
            && this.centre.getY() == line.pos.getY();
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
        ellipse(centre.getX(), centre.getY(), diameter, diameter);
    }
}
