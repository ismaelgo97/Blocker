class Ball extends Point {

    HitBox hb;
    Vector vector;
    Velocity velo;
    int posMode = CENTER;

    private final float diameter = 20;

    Ball() {
        super(width/2, height - 80);
        hb = new HitBox(diameter, diameter, this, posMode);
        restore();
    }

    private void initPos() {
        setX(width/2); setY(height - 80);
    }

    private void initVector() {
        vector = new Vector(random(1, -1), -1);
    }

    private void initVelocity() {
        velo = new Velocity(6, 6);
    }

    float getRadius() {
        return diameter / 2;
    }

    private boolean isTouchingLine(Line line) {
        boolean[] touched = this.hb.hit(line.hb);
        return touched[HitBox.HIT] && touched[HitBox.TOP];
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
        move(vector.getX()*velo.getXVelocity(), vector.getY()*velo.getYVelocity());
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
        initVelocity();
    }

    void show(){
        fill(0);
        ellipseMode(posMode);
        ellipse(getX(), getY(), diameter, diameter);
    }
}
