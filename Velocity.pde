class Velocity {
    private float x, y;

    Velocity(float x, float y) {
        setVelocity(x, y);
    }

    Velocity() {
        this(1, 1);
    }

    void setVelocity(float x, float y) {
         setXVelocity(x); setYVelocity(y);
    }

    void setXVelocity(float x) {
        this.x = x;
    }

    void setYVelocity(float y) {
        this.y = y;
    }

    float getXVelocity() {
        return x;
    }

    float getYVelocity() {
        return y;
    }

    void faster(float times) {
        setVelocity(x + times, y + times);
    }

    void slower(float times) {
        if (x - times > 0 && y - times > 0)
            setVelocity(x - times, y - times);
    }

    void stop() {
        setVelocity(0, 0);
    }
}
