class Coordinate {
    private float x, y;

    Coordinate(float x, float y) {
        this.x = x; this.y = y;
    }

    float getX() {
        return x;
    }

    void setX(float x) {
        this.x = x;
    }

    void moveX(float x) {
        setX(getX() + x);
    }

    float getY() {
        return y;
    }

    void setY(float y) {
        this.y = y;
    }

    void moveY(float y) {
        setY(getY() + y);
    }

    void move(float x, float y) {
        moveX(x);
        moveY(y);
    }
}
