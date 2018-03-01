class HitBox {
    private Point up, down, left, right;
    Point upleft, upright, downleft, downright;

    Point centre;

    private Vector corner, vertical, horizontal;

    private float w, h;

    HitBox(float w, float h, Point centre) {
        setWidth(w);
        setHeight(h);
        update(centre);
    }

    private void setPoints() {
        up      = new Point(
            centre.getX(), centre.getY() - getHeight()/2
        );
        down    = new Point(
            centre.getX(), centre.getY() + getHeight()/2
        );
        left    = new Point(
            centre.getX() - getWidth()/2, centre.getY()
        );
        right   = new Point(
            centre.getX() + getWidth()/2, centre.getY()
        );

        // ------------------ //
        upleft      = new Point(
            left.getX(), up.getY()
        );
        upright     = new Point(
            right.getX(), up.getY()
        );
        downleft    = new Point(
            left.getX(), down.getY()
        );
        downright   = new Point(
            right.getX(), down.getY()
        );
        // ------------------ //
    }

    private void setVectors() {
        corner      = new Vector(centre, downright);
        horizontal  = new Vector(centre, right);
        vertical    = new Vector(centre, down);
    }

    float getWidth() {
        return w;
    }

    float getHeight() {
        return h;
    }

    void setWidth(float w) {
        this.w = w;
    }

    void setHeight(float h) {
        this.h = h;
    }

    void setCentre(Point centre) {
        this.centre = centre;
    }

    float getDistance(HitBox hb) {
        return new Vector(centre, hb.centre).getLength();
    }

    void update(Point centre) {
        setCentre(centre);
        setPoints();
        setVectors();
    }
}
