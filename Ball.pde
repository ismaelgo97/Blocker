class Ball {
    Point pos;
    // float xl, yl;
    float radius;
    float vctx, vcty;
    int vx = 1;
    int vy = 1;

    Ball(){
        initPos();
        initVector();
    }

    void initPos() {
        radius = 15;
        pos = new Point(500, 640);
    }

    void initVector() {
        vctx = random(4, -4);
        vcty = -4;
    }

    void update(Line line){
        if ((pos.getX() > line.pos.getX()
            && pos.getX() < line.pos.getX() + line.getWidth())
            && pos.getY() + radius == line.pos.getY()) {
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
        ellipse(pos.getX(), pos.getY(), radius, radius);
    }
}
