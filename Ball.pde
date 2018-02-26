class Ball {
    Point pos;
    // float xl, yl;
    private float radius;
    private float vctx, vcty;
    int vx = 1;
    int vy = 1;

    Ball(){
        initPos();
        initVector();
    }

    private void initPos() {
        radius = 15;
        pos = new Point(500, 640);
    }

    private void initVector() {
        vctx = random(4, -4);
        vcty = -4;
    }

    void update(Line line){
        if (pos.getX() > line.pos.getX() && pos.getX() < line.endPos.getX() && (pos.getY() + radius/2) > line.pos.getY()) {
            vcty *= -1;
        }

        if(pos.getY() == 0){
            vcty *= -1;
        }

        if(pos.getX() == 0 || pos.getX() == width){
            vctx *= -1;
        }

        pos.move(vctx*vx, vcty*vy);
    }

    void restore(){
        initPos();
        initVector();
    }

    void show(){
        fill(255);
        ellipseMode(CENTER);
        ellipse(pos.getX(), pos.getY(), radius, radius);
    }
}
