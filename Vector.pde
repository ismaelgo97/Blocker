class Vector extends Coordinate {
    Vector(float x, float y) {
        super(x, y);
    }

    Vector(Point a, Point b) {
        super(b.getX() - a.getX(), b.getY() - a.getY());
    }

    Vector(Point o, float angle, float modulus) {
        super((modulus * cos(angle)) - o.getX(), (modulus * sin(angle)) - o.getY());
    }

    void changeWayX() {
        setX(getX() * -1);
    }

    void changeWayY() {
        setY(getY() * -1);
    }
}
