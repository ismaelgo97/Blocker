class Vector extends Coordinate {

    private float mod;
    private Point a, b;

    Vector(float x, float y) {
        super(x, y);
    }

    Vector(Point a, Point b) {
        super(b.getX() - a.getX(), b.getY() - a.getY());
        mod = abs(a.distance(b));
    }

    Vector(Point o, float angle, float modulus) {
        super((modulus * cos(angle)) - o.getX(), (modulus * sin(angle)) - o.getY());
    }

    float getLength() {
        return mod;
    }

    Point getOrigin() {
        return a;
    }

    Point getEnd() {
        return b;
    }

    float getAngle(Vector v) {
        return acos(cos(scalarMult(v) / (getLength() * v.getLength())));
    }

    private float scalarMult(Vector v) {
        return (getOrigin().getX() * getEnd().getX())
             + (v.getOrigin().getY() * v.getEnd().getY());
    }

    private float vectorialMult(Vector v) {
        return 0;
    }

    void changeWayX() {
        setX(getX() * -1);
    }

    void changeWayY() {
        setY(getY() * -1);
    }
}
