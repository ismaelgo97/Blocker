enum Colors {
    Red(255, 0, 0),
    Green(0, 255, 0),
    Blue(0, 0, 255),
    White(255, 255, 255),
    Black(0, 0, 0);

    private float r, g, b;

    private Colors(float r, float g, float b) {
        this.r = r; this.g = g; this.b = b;
    }

    Color getColor() {
        return new Color(r, g, b);
    }
}
