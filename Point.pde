class Point extends Coordinate {
    Point(float x, float y) {
        super(x, y);
    }

    float distance(Point b) {
        return abs(sqrt(
            (b.getX() - this.getX())
          * (b.getX() - this.getX())
          + (b.getY() - this.getY())
          * (b.getY() - this.getY())
        ));
    }

    Point clone() {
        return new Point(getX(), getY());
    }
}
