class Block {
    Point pos;
    Point endPos;
    float w = 100;
    float h = 30;
    color c;
    boolean alive = true;


    Block(int i, int j) {
        initPos(i, j);
        c = color(random(1, 255), random(1, 255), random(1, 255));
    }

    Block(int i, int j, float r, float g, float b){
        initPos(i, j);
        c = color(r, g, b);
    }

    Block(int i, int j, color c) {
        initPos(i, j);
        this.c = c;
    }

    void initPos(int i, int j) {
        pos = new Point(i * w, j * h);
        endPos = new Point(pos.getX() + w, pos.getY());
    }

    private boolean isTouched(Ball ball) {
        if (ball.pos.getX() > pos.getX() && ball.pos.getX() < endPos.getX() && pos.getY() + h == ball.pos.getY()) {
            return true;
        } else {
            return false;
        }
    }

    boolean isAlive() {
        return alive;
    }

    private void remove() {
        alive = false;
        c = color(0, 0, 0);
    }

    void update(Ball ball){
        if (isTouched(ball)) {
            remove();
        }
    }


    void show(){
        fill(c);
        rect(pos.getX(), pos.getY(), w, h);
    }
}
