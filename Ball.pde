class Ball extends Point {

    HitBox hb;
    Vector vector;

    private final float diameter = 15;

    float vx = 1;
    float vy = 1;

    Ball() {
        super(width/2, height - 80);
        hb = new HitBox(diameter, diameter, this);
        restore();
    }

    private void initPos() {
        setX(width/2); setY(height - 80);
    }

    private void initVector() {
        vector = new Vector(random(6, -6), -4);
    }

    float getRadius() {
        return diameter / 2;
    }

    private boolean isTouchingLine(Line line) {
        // float p = new Vector(centre, line.pos).getLength() + getRadius();
        // float e = new Vector(centre, line.endPos).getLength() + getRadius();
        // return p;
        return getX() >= line.hb.upleft.getX()
            && getX() <= line.hb.upright.getX()
            && getY() + getRadius() >= line.getY() - line.getHeight();
    }

    private boolean isTouchingTopBorder() {
        return getY() - getRadius() <= 0;
    }

    private boolean isTouchingSideBorders() {
        return getX() - getRadius() <= 0
            || getX() + getRadius() >= width;
    }

    boolean isTouchingDown() {
        return getY() + getRadius() >= height;
    }

    void update() {
        if (isTouchingSideBorders()) {
            vector.changeWayX();
        }
        if (isTouchingTopBorder()) {
            vector.changeWayY();
        }
        move(vector.getX()*vx, vector.getY()*vy);
        hb.update(this);
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
        ellipse(getX(), getY(), diameter, diameter);
    }
}
