class HitBox {
    private Point up, down, left, right;
    Point upleft, upright, downleft, downright;

    static final int HIT      = 0;
    static final int LEFT     = 1;
    static final int RIGHT    = 2;
    static final int TOP      = 3;
    static final int BOTTOM   = 4;

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
        // r(t) = min(R, w*abs(sec(t)), h*abs(csc(t))
        return new Vector(centre, hb.centre).getLength();
    }

    boolean[] hit(HitBox shape) {
        boolean[] side = new boolean[5];

        // hit  -    left    -    right    -    top    -    bottom
        side[HIT] = side[LEFT] = side[RIGHT] = side[TOP] = side[BOTTOM] = false;

        // temporary variables to set edges for testing
        float testX = centre.getX();
        float testY = centre.getY();

        // which edge is closest?
        if (centre.getX() < shape.centre.getX()) {
            side[LEFT] = true;
            testX = shape.centre.getX();                                    // test left edge
        } else if (centre.getX() > shape.centre.getX() + shape.getWidth()) {
            side[RIGHT] = true;
            testX = shape.centre.getX() + shape.getWidth();                 // right edge
        }
        if (centre.getY() < shape.centre.getY()) {
            side[TOP] = true;
            testY = shape.centre.getY();                                    // top edge
        } else if (centre.getY() > shape.centre.getY() + shape.getHeight()) {
            side[BOTTOM] = true;
            testY = shape.centre.getY() + shape.getHeight();                // bottom edge
        }

        // get distance from closest edges
        float distX = centre.getX() - testX;
        float distY = centre.getY() - testY;
        float distance = sqrt( (distX*distX) + (distY*distY) );

        // if the distance is less than the radius, collision!
        if (distance <= getWidth()/2) {
            side[HIT] = true;
        }
        return side;
    }

    void update(Point centre) {
        setCentre(centre);
        setPoints();
        setVectors();
    }
}
