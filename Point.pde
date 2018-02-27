class Point extends Coordinate {
    Point(float x, float y) {
        super(x, y);
    }

    float distance(Point b) {
        return sqrt(pow(b.getX() - this.getX(), 2) + pow(b.getY() - this.getY(), 2));
    }
}
