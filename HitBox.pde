class HitBox {
    private Point up, down, left, right;
    Point upLeft, upRight;
    Point downLeft, downRight;

    // Hit Sides Code
    static final int HIT      = 0;
    static final int LEFT     = 1;
    static final int RIGHT    = 2;
    static final int TOP      = 3;
    static final int BOTTOM   = 4;

    Point centre;

    // private Vector corner, vertical, horizontal;

    private float w, h;

    HitBox(float w, float h, Point point, int mode) {
        setWidth(w);
        setHeight(h);
        switch (mode) {
            case CENTER:
            case RADIUS:
                update(point);
            break;
            case CORNER:
                update(new Point(point.getX() + getHalfWidth(), point.getY() + getHalfHeight()));
            break;
        }
    }

    HitBox(float w, float h, Point point) {
        this(w, h, point, CORNER);
    }

    float getHalfHeight() {
        return h/2;
    }

    float getHalfWidth() {
        return w/2;
    }

    private void setPoints() {
        up      = new Point(
            centre.getX(), centre.getY() - getHalfHeight()
        );
        down    = new Point(
            centre.getX(), centre.getY() + getHalfHeight()
        );
        left    = new Point(
            centre.getX() - getHalfWidth(), centre.getY()
        );
        right   = new Point(
            centre.getX() + getHalfWidth(), centre.getY()
        );

        // ------------------ //
        upLeft      = new Point(
            left.getX(), up.getY()
        );
        upRight     = new Point(
            right.getX(), up.getY()
        );
        // downLeft    = new Point(
        //     left.getX(), down.getY()
        // );
        // downRight   = new Point(
        //     right.getX(), down.getY()
        // );
        // ------------------ //
    }

    // private void setVectors() {
    //     corner      = new Vector(centre, downRight);
    //     horizontal  = new Vector(centre, right);
    //     vertical    = new Vector(centre, down);
    // }

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

    boolean[] hit(HitBox shape) {
        boolean[] side = new boolean[5];

        // hit  -    left    -    right    -    top    -    bottom
        side[HIT] = side[LEFT] = side[RIGHT] = side[TOP] = side[BOTTOM] = false;

        // temporary variables to set edges for testing
        Point test = upLeft.clone();


        // which edge is closest?
        if (upLeft.getX() < shape.upLeft.getX()) {
            side[LEFT] = true;
            test.setX(shape.upLeft.getX());                                    // test left edge
        } else if (upLeft.getX() > shape.upLeft.getX() + shape.getWidth()) {
            side[RIGHT] = true;
            test.setX(shape.upLeft.getX() + shape.getWidth());                 // right edge
        }
        if (upLeft.getY() < shape.upLeft.getY()) {
            side[TOP] = true;
            test.setY(shape.upLeft.getY());                                    // top edge
        } else if (upLeft.getY() > shape.upLeft.getY() + shape.getHeight()) {
            side[BOTTOM] = true;
            test.setY(shape.upLeft.getY() + shape.getHeight());                // bottom edge
        }

        // get distance from closest edges

        float distance = upLeft.distance(test);

        // if the distance is less than the radius, collision!
        if (distance <= getHalfWidth()) {
            side[HIT] = true;
        }
        return side;
    }

    void update(Point centre) {
        setCentre(centre);
        setPoints();
        // setVectors();
    }
}
